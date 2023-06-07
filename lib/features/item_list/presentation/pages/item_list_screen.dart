import 'package:dev_pace_flutter_test_task/core/constants/app_assets.dart';
import 'package:dev_pace_flutter_test_task/core/constants/app_sizes.dart';
import 'package:dev_pace_flutter_test_task/features/item_list/presentation/bloc/item_list_bloc.dart';
import 'package:dev_pace_flutter_test_task/features/item_list/presentation/widgets/item_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/main_floating_action_button.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});
  double getLogoWidgetHeight(BuildContext context, int itemsCount) {
    Size size = MediaQuery.of(context).size;
    // int qnt =
    double logoWidgetHeight = size.height - rowHeight(size);
    return logoWidgetHeight;
  }

  double rowHeight(Size size) =>
      (size.width - AppSizes.horizontalPadding * 3) / 2 +
      AppSizes.horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc()..add(const ItemListStartEvent()),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const MainFloatingActionButton(),
        body: SafeArea(
          child: BlocBuilder<ItemListBloc, ItemListState>(
            builder: (context, state) {
              if (state is ItemListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ItemListErrorState) {
                return Center(
                  child: Text(state.error.name),
                );
              }
              if (state is ItemListLoadedState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding,
                  ),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverAppBar(
                        toolbarHeight:
                            getLogoWidgetHeight(context, state.items.length),
                        title: Center(
                            child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        )),
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: AppSizes.crossAxisCount,
                          childAspectRatio: AppSizes.childAspectRatio,
                          mainAxisSpacing: AppSizes.itemPadding,
                          crossAxisSpacing: AppSizes.itemPadding,
                          // mainAxisExtent: AppSizes.itemHeight,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ItemWidget(item: state.items[index]);
                          },
                          childCount: state.items.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
