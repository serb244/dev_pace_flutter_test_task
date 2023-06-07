import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_sizes.dart';
import '../bloc/item_list_bloc.dart';

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({
    super.key,
  });
  void _addItem(BuildContext context) {
    context.read<ItemListBloc>().add(const ItemListAddItemEvent());
  }

  void _removeItem(BuildContext context) {
    context.read<ItemListBloc>().add(const ItemListRemoveItemEvent());
  }

  void _clearItems(BuildContext context) {
    context.read<ItemListBloc>().add(const ItemListClearItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addItem(context),
      ),
      const SizedBox(
        height: AppSizes.verticalPadding,
      ),
      FloatingActionButton(
        child: const Icon(Icons.remove),
        onPressed: () => _removeItem(context),
      ),
      const SizedBox(
        height: AppSizes.verticalPadding,
      ),
      FloatingActionButton(
        child: const Icon(Icons.clear),
        onPressed: () => _clearItems(context),
      ),
    ]);
  }
}
