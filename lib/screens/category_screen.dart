import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/adhkar_model.dart';
import '../theme/app_theme.dart';
import 'dhikr_screen.dart';

class CategoryScreen extends StatelessWidget {
  final AdhkarCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          _buildCategoryHeader(),
          Expanded(child: _buildAdhkarList(context)),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
            category.icon,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 8),
          Text(
            category.description,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.golden,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${category.adhkar.length} ذكر',
              style: GoogleFonts.tajawal(
                fontSize: 13,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdhkarList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: category.adhkar.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final dhikr = category.adhkar[index];
        return Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                '${index + 1}',
                style: GoogleFonts.tajawal(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              dhikr.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.amiri(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
            subtitle: dhikr.source != null
                ? Text(
                    dhikr.source!,
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: AppColors.golden,
                    ),
                  )
                : null,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.secondary,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DhikrScreen(
                  dhikr: dhikr,
                  categoryName: category.name,
                  currentIndex: index,
                  totalCount: category.adhkar.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
