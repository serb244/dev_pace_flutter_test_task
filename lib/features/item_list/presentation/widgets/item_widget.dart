import 'package:dev_pace_flutter_test_task/features/item_list/data/models/item.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dark,
            width: AppSizes.borderItemWidth,
          ),
        ),
        child: Center(
          child: Text(
            item.name,
            style: TextStyles.body,
          ),
        ));
  }
}
