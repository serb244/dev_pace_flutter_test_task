import 'package:dev_pace_flutter_test_task/core/constants/app_sizes.dart';
import 'package:dev_pace_flutter_test_task/features/item_list/data/models/item.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: AppSizes.itemHeight,
        color: Colors.amber,
        child: Center(
          child: Text(item.name),
        ));
  }
}
