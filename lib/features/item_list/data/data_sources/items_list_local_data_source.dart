import 'dart:math';

import '../../../../core/constants/constants.dart';
import '../models/item.dart';

const int dataLoadingDurationMilliseconds = 300;

class ItemsListLocalDataSource {
  ItemsListLocalDataSource() {
    _itemList = [];
  }

  late List<Item> _itemList;

  Future<List<Item>> getItemsList() async {
    return _itemList;
  }

  Future<void> addItem() async {
    await Future.delayed(
        const Duration(milliseconds: dataLoadingDurationMilliseconds));
    if (Random().nextInt(10) > 8) {
      throw Exception('An error occurred');
    }

    _itemList.add(Item('${AppStrings.itemName} ${_itemList.length + 1}'));
  }

  Future<void> removeItem() async {
    if (_itemList.isEmpty) {
      return;
    }
    await Future.delayed(
        const Duration(milliseconds: dataLoadingDurationMilliseconds));
    if (Random().nextInt(10) > 8) {
      throw Exception('An error occurred');
    } else {
      _itemList.removeLast();
    }
  }
}
