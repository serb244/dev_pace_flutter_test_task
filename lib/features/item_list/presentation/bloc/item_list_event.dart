part of 'item_list_bloc.dart';

abstract class ItemListEvent {
  const ItemListEvent();
}

class ItemListStartEvent extends ItemListEvent {
  const ItemListStartEvent();
}

class ItemListAddItemEvent extends ItemListEvent {
  const ItemListAddItemEvent();
}

class ItemListRemoveItemEvent extends ItemListEvent {
  const ItemListRemoveItemEvent();
}

class ItemListClearItemsEvent extends ItemListEvent {
  const ItemListClearItemsEvent();
}
