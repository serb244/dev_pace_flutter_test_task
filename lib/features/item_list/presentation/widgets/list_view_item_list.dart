import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../bloc/item_list_bloc.dart';
import 'item_widget.dart';

class ListViewItemList extends StatelessWidget {
  final ItemListLoadedState state;

  const ListViewItemList({super.key, required this.state});

  double getLogoWidgetHeight(
      BuildContext context, int itemsCount, BoxConstraints constraints) {
    final double mainSizeHeight = constraints.maxHeight;
    final int rowQnt = itemsCount.isOdd ? itemsCount ~/ 2 + 1 : itemsCount ~/ 2;
    final double rowHeight = getRowHeight(constraints);
    final double rowsHeight = rowHeight * rowQnt;
    double logoWidgetHeight =
        mainSizeHeight - rowsHeight - AppSizes.verticalPadding;
    logoWidgetHeight = logoWidgetHeight > AppSizes.logoMinHeight
        ? logoWidgetHeight + AppSizes.horizontalPadding
        : AppSizes.logoMinHeight;
    return logoWidgetHeight;
  }

  double getRowHeight(BoxConstraints constraints) =>
      ((constraints.maxWidth - AppSizes.itemPadding) /
              AppSizes.crossAxisCount) /
          AppSizes.childAspectRatio +
      AppSizes.itemPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: state.items.isEmpty ? 0 : AppSizes.itemPadding,
                    ),
                    alignment: Alignment.center,
                    height: getLogoWidgetHeight(
                      context,
                      state.items.length,
                      constraints,
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.only(
                      bottom: state.items.isEmpty ? 0 : AppSizes.itemPadding,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: AppSizes.crossAxisCount,
                      childAspectRatio: AppSizes.childAspectRatio,
                      mainAxisSpacing: AppSizes.itemPadding,
                      crossAxisSpacing: AppSizes.itemPadding,
                    ),
                    itemBuilder: (context, index) => ItemWidget(
                      item: state.items[index],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
