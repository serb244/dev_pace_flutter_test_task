import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/items_list_local_data_source.dart';
import '../bloc/item_list_bloc.dart';
import '../widgets/custom_scroll_view_list.dart';
import '../widgets/layout_builder_list.dart';
import '../widgets/list_view_item_list.dart';
import '../widgets/widgets.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemListBloc(context.read<ItemsListLocalDataSource>())
            ..add(const ItemListStartEvent()),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const MainFloatingActionButton(),
        body: BlocBuilder<ItemListBloc, ItemListState>(
          builder: (context, state) {
            if (state is ItemListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ItemListErrorState) {
              return Center(
                child: Text(state.error.name),
              );
            } else if (state is ItemListLoadedState) {
              return ListViewItemList(state: state);
              // return LayoutBuilderList(state: state);
              // return CustomScrollViewList(state: state);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
