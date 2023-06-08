import 'dart:developer' as dev;
import 'dart:math';
import 'package:dev_pace_flutter_test_task/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/error.dart';
import '../../data/models/item.dart';

part 'item_list_event.dart';

part 'item_list_state.dart';

List<Item> items = [];
const int dataLoadingDurationMilliseconds = 300;
Future<void> wait() async {
  await Future.delayed(
    const Duration(
      milliseconds: dataLoadingDurationMilliseconds,
    ),
  );
}

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  ItemListBloc() : super(ItemListInitialState()) {
    on<ItemListStartEvent>(_start);
    on<ItemListAddItemEvent>(_addItem);
    on<ItemListRemoveItemEvent>(_removeItem);
    on<ItemListClearItemsEvent>(_clearItems);
  }

  _clearItems(ItemListClearItemsEvent event, emit) async {
    emit(ItemListLoadingState());
    await wait();
    try {
      items.clear();
      emit(ItemListLoadedState(items: items));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }

  _start(ItemListStartEvent event, emit) async {
    emit(ItemListLoadingState());
    await wait();
    try {
      emit(ItemListLoadedState(items: items));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }

  _addItem(ItemListAddItemEvent event, emit) async {
    emit(ItemListLoadingState());
    await wait();
    try {
      if (Random().nextInt(10) > 8) {
        throw Exception('An error occurred');
      }
      items.add(Item('${AppStrings.itemName} ${items.length + 1}'));
      emit(ItemListLoadedState(items: items));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }

  _removeItem(ItemListRemoveItemEvent event, emit) async {
    if (items.isEmpty) {
      return;
    }
    emit(ItemListLoadingState());
    await wait();
    try {
      if (Random().nextInt(10) > 8) {
        throw Exception('An error occurred');
      }
      items.removeLast();
      emit(ItemListLoadedState(items: items));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }
}
