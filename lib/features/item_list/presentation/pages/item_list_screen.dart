import 'package:dev_pace_flutter_test_task/core/constants/app_assets.dart';
import 'package:dev_pace_flutter_test_task/core/constants/app_sizes.dart';
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
                return CustomScrollView(
                  reverse: true,
                  slivers: [
                    // SliverAppBar(
                    //   expandedHeight: 600.0,
                    //   flexibleSpace: FlexibleSpaceBar(
                    //     background: Image.asset(
                    //       'assets/images/logo.png',
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 2.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ItemWidget(item: state.items[index]);
                        },
                        childCount: state.items.length,
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: true,
                      child: Center(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        child: Image.asset(AppImages.logo),
                      ),
                    ),
                  ],
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
