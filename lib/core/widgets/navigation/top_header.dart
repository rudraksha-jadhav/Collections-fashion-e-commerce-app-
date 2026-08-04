import 'package:flutter/material.dart';
import '../../../app/theme/app_text_styles.dart';

class TopHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;

  const TopHeader({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leading ?? const SizedBox(width: 40),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headline.copyWith(fontSize: 20),
          ),
        ),
        const SizedBox(width: 8),
        trailing ?? const SizedBox(width: 40),
      ],
    );
  }
}
