import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../bloc/item_list_bloc.dart';
import 'item_widget.dart';

class CustomScrollViewList extends StatelessWidget {
  final ItemListLoadedState state;
  const CustomScrollViewList({super.key, required this.state});

  double getLogoWidgetHeight(BuildContext context, int itemsCount) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    final double mainSizeHeight = size.height - statusBarHeight;
    final int rowQnt = itemsCount.isOdd ? itemsCount ~/ 2 + 1 : itemsCount ~/ 2;
    final double rowHeight = getRowHeight(size);
    final double rowsHeight = rowHeight * rowQnt;
    double logoWidgetHeight =
        mainSizeHeight - rowsHeight - AppSizes.verticalPadding;
    logoWidgetHeight = logoWidgetHeight > AppSizes.logoMinHeight
        ? logoWidgetHeight + AppSizes.horizontalPadding
        : AppSizes.logoMinHeight;
    return logoWidgetHeight;
  }

  double getRowHeight(Size size) =>
      ((size.width - (AppSizes.horizontalPadding * 2 + AppSizes.itemPadding)) /
              AppSizes.crossAxisCount) /
          AppSizes.childAspectRatio +
      AppSizes.itemPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.zero,
            sliver: SliverAppBar(
              backgroundColor: AppColors.background,
              toolbarHeight: getLogoWidgetHeight(context, state.items.length),
              title: Padding(
                padding: EdgeInsets.only(
                  bottom: state.items.isEmpty ? 0 : AppSizes.verticalPadding,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          SliverPadding(
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                bottom: state.items.isEmpty ? 0 : AppSizes.itemPadding,
              )),
        ],
      ),
    );
  }
}
