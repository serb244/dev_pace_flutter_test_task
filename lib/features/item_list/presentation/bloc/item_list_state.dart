part of 'item_list_bloc.dart';

abstract class ItemListState {
  const ItemListState();
}

class ItemListInitialState extends ItemListState {}

class ItemListLoadingState extends ItemListState {}

class ItemListLoadedState extends ItemListState {
  final List<Item> items;

  const ItemListLoadedState({
    required this.items,
  });
}

class ItemListErrorState extends ItemListState {
  final AppError error;

  const ItemListErrorState(this.error);
}
