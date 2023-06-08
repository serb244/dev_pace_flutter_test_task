import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/items_list_local_data_source.dart';
import '../../data/models/error.dart';
import '../../data/models/item.dart';

part 'item_list_event.dart';

part 'item_list_state.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  ItemListBloc(this.itemsListLocalDataSource) : super(ItemListInitialState()) {
    on<ItemListStartEvent>(_start);
    on<ItemListAddItemEvent>(_addItem);
    on<ItemListRemoveItemEvent>(_removeItem);
  }
  final ItemsListLocalDataSource itemsListLocalDataSource;

  _start(ItemListStartEvent event, emit) async {
    emit(ItemListLoadingState());
    try {
      final itemList = await itemsListLocalDataSource.getItemsList();
      emit(ItemListLoadedState(items: itemList));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }

  _addItem(ItemListAddItemEvent event, emit) async {
    emit(ItemListLoadingState());
    try {
      await itemsListLocalDataSource.addItem();
      final itemList = await itemsListLocalDataSource.getItemsList();
      emit(ItemListLoadedState(items: itemList));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }

  _removeItem(ItemListRemoveItemEvent event, emit) async {
    emit(ItemListLoadingState());
    try {
      await itemsListLocalDataSource.removeItem();
      final itemList = await itemsListLocalDataSource.getItemsList();
      emit(ItemListLoadedState(items: itemList));
    } catch (e) {
      dev.log(e.toString());
      AppError error = AppError(name: e.toString());
      emit(ItemListErrorState(error));
    }
  }
}
