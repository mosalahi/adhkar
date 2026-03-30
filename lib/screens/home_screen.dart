import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../models/adhkar_model.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AdhkarCategory> _categories = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadAdhkar();
  }

  static const _remoteUrl =
      'https://raw.githubusercontent.com/mosalahi/adhkar/refs/heads/claude/flutter-adhkar-app-cfJOl/assets/data/adhkar.json';

  List<AdhkarCategory> _parseCategories(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    if (jsonData['categories'] is! List) {
      throw const FormatException(
          'بنية JSON غير صالحة: مفتاح categories مفقود أو غير صحيح');
    }
    return (jsonData['categories'] as List<dynamic>)
        .map((item) => AdhkarCategory.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _loadAdhkar() async {
    // 1. Try remote
    try {
      final response =
          await http.get(Uri.parse(_remoteUrl)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final categories = _parseCategories(response.body);
        if (mounted) {
          setState(() {
            _categories = categories;
            _isLoading = false;
          });
        }
        return;
      }
    } catch (e) {
      debugPrint('تعذّر التحميل من الشبكة، جاري استخدام النسخة المحلية: $e');
    }

    // 2. Fallback to local asset
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/adhkar.json');
      final categories = _parseCategories(jsonString);
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
      }
    } on FormatException catch (e) {
      debugPrint('خطأ في تنسيق البيانات: $e');
      if (mounted) setState(() { _isLoading = false; _hasError = true; });
    } catch (e) {
      debugPrint('خطأ غير متوقع في تحميل الأذكار: $e');
      if (mounted) setState(() { _isLoading = false; _hasError = true; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('جامع صحيح الأذكار'),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.golden),
            )
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppColors.golden, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        'تعذّر تحميل البيانات',
                        style: GoogleFonts.tajawal(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _hasError = false;
                          });
                          _loadAdhkar();
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(
                          'إعادة المحاولة',
                          style: GoogleFonts.tajawal(),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _buildCategoryGrid(),
                ),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
            style: GoogleFonts.amiri(
              fontSize: 20,
              color: AppColors.golden,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'أذكار مختارة من صحيح السنة النبوية',
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    if (_categories.isEmpty) {
      return Center(
        child: Text(
          'لا توجد بيانات',
          style: GoogleFonts.tajawal(fontSize: 16),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: _categories[index],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryScreen(category: _categories[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
