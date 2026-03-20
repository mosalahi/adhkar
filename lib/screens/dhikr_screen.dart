import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/adhkar_model.dart';
import '../theme/app_theme.dart';

class DhikrScreen extends StatefulWidget {
  final Dhikr dhikr;
  final String categoryName;
  final int currentIndex;
  final int totalCount;

  const DhikrScreen({
    super.key,
    required this.dhikr,
    required this.categoryName,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  int _counter = 0;

  void _increment() {
    if (_counter < widget.dhikr.count) {
      setState(() => _counter++);
      HapticFeedback.lightImpact();
    }
  }

  void _reset() {
    setState(() => _counter = 0);
  }

  bool get _isDone => _counter >= widget.dhikr.count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: Text(
                '${widget.currentIndex + 1} / ${widget.totalCount}',
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: _buildDhikrCard()),
            const SizedBox(height: 16),
            _buildCounter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDhikrCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dhikr text
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.dhikr.text,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 22,
                  color: AppColors.textPrimary,
                  height: 2.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Divider
          const Divider(color: AppColors.divider, thickness: 1),
          const SizedBox(height: 8),
          // Fadl
          if (widget.dhikr.fadl != null) ...[
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.golden, size: 16),
                const SizedBox(width: 6),
                const Text(
                  'الفضل:',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w700,
                    color: AppColors.golden,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.dhikr.fadl!,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Source
          if (widget.dhikr.source != null)
            Row(
              children: [
                const Icon(Icons.book, color: AppColors.secondary, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.dhikr.source!,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          // Count badge
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'التكرار: ${widget.dhikr.count} مرة',
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return Column(
      children: [
        GestureDetector(
          onTap: _increment,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isDone ? AppColors.golden : AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: (_isDone ? AppColors.golden : AppColors.primary)
                      .withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                _isDone ? '✓' : '$_counter',
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _isDone
              ? 'تمّ الذكر'
              : 'اضغط للتسبيح (${widget.dhikr.count - _counter} متبقي)',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 14,
            color: _isDone ? AppColors.golden : AppColors.textSecondary,
            fontWeight: _isDone ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: _reset,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('إعادة'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            textStyle: const TextStyle(fontFamily: 'Tajawal', fontSize: 13),
          ),
        ),
      ],
    );
  }
}
