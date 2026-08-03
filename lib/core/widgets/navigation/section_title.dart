import 'package:flutter/material.dart';
import '../../../app/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String tag;
  final String? title;

  const SectionTitle({
    super.key,
    required this.tag,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag.toUpperCase(),
          style: AppTextStyles.caption,
        ),
        if (title != null) ...[
          const SizedBox(height: 6),
          Text(
            title!,
            style: AppTextStyles.displayLarge,
          ),
        ],
      ],
    );
  }
}
