import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../bloc/item_list_bloc.dart';
import '../widgets/widgets.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  double getLogoWidgetHeight(BuildContext context, int itemsCount) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    final double mainSizeHeight = size.height - statusBarHeight;
    int rowQnt = itemsCount.isOdd ? itemsCount ~/ 2 + 1 : itemsCount ~/ 2;

    double rowsHeight = rowHeight(size) * rowQnt;
    double logoWidgetHeight = mainSizeHeight -
        rowsHeight -
        AppSizes.verticalPadding * 2 -
        AppSizes.itemPadding;
    logoWidgetHeight = logoWidgetHeight > AppSizes.logoMinHeight
        ? logoWidgetHeight + AppSizes.horizontalPadding
        : AppSizes.logoMinHeight;
    return logoWidgetHeight;
  }

  double rowHeight(Size size) =>
      ((size.width - (AppSizes.horizontalPadding * 2 + AppSizes.itemPadding)) /
              AppSizes.crossAxisCount) /
          AppSizes.childAspectRatio +
      AppSizes.itemPadding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc()..add(const ItemListStartEvent()),
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
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          top: state.items.isEmpty
                              ? 0
                              : AppSizes.verticalPadding,
                          bottom: state.items.isEmpty
                              ? 0
                              : AppSizes.verticalPadding,
                        ),
                        sliver: SliverAppBar(
                          backgroundColor: AppColors.background,
                          toolbarHeight:
                              getLogoWidgetHeight(context, state.items.length),
                          title: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SliverPadding(
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: AppSizes.crossAxisCount,
                              childAspectRatio: AppSizes.childAspectRatio,
                              mainAxisSpacing: AppSizes.itemPadding,
                              crossAxisSpacing: AppSizes.itemPadding,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ItemWidget(item: state.items[index]);
                              },
                              childCount: state.items.length,
                            ),
                          ),
                          padding: EdgeInsets.only(
                            bottom:
                                state.items.isEmpty ? 0 : AppSizes.itemPadding,
                          )),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
