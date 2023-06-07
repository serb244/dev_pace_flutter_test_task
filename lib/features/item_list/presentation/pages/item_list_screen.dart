import 'package:dev_pace_flutter_test_task/core/constants/assets.dart';
import 'package:dev_pace_flutter_test_task/core/constants/sizes.dart';
import 'package:dev_pace_flutter_test_task/features/item_list/presentation/bloc/item_list_bloc.dart';
import 'package:dev_pace_flutter_test_task/features/item_list/presentation/widgets/item_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/main_floating_action_button.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

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
            }
            if (state is ItemListErrorState) {
              return Center(
                child: Text(state.error.name),
              );
            }
            if (state is ItemListLoadedState) {
              return Column(
                // shrinkWrap: true,
                children: [
                  Expanded(
                    // alignment: Alignment.center,
                    child: Image.asset(AppImages.logo),
                  ),
                  GridView.builder(
                      padding: const EdgeInsets.all(AppSizes.itemPadding),
                      // clipBehavior: Clip.hardEdge,
                      dragStartBehavior: DragStartBehavior.start,
                      physics: const NeverScrollableScrollPhysics(),
                      // key: _textWidgetKey,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // mainAxisExtent: 0,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        // childAspectRatio: 2,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemWidget(item: state.items[index]);
                      })
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
