import 'package:flutter/widgets.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

abstract class TextStyles {
  static const TextStyle body = TextStyle(
    fontSize: AppSizes.itemFontSize,
    fontWeight: FontWeight.w500,
    height: 1.26,
    color: AppColors.textPrimary,
  );
}
