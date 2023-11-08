// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextStore on TextStoreBase, Store {
  late final _$cardListItemsAtom =
      Atom(name: 'TextStoreBase.cardListItems', context: context);

  @override
  ObservableList<String> get cardListItems {
    _$cardListItemsAtom.reportRead();
    return super.cardListItems;
  }

  @override
  set cardListItems(ObservableList<String> value) {
    _$cardListItemsAtom.reportWrite(value, super.cardListItems, () {
      super.cardListItems = value;
    });
  }

  late final _$loadDataItemAsyncAction =
      AsyncAction('TextStoreBase.loadDataItem', context: context);

  @override
  Future<void> loadDataItem() {
    return _$loadDataItemAsyncAction.run(() => super.loadDataItem());
  }

  late final _$TextStoreBaseActionController =
      ActionController(name: 'TextStoreBase', context: context);

  @override
  void addItem(List<String> newText) {
    final _$actionInfo = _$TextStoreBaseActionController.startAction(
        name: 'TextStoreBase.addItem');
    try {
      return super.addItem(newText);
    } finally {
      _$TextStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(int indexText) {
    final _$actionInfo = _$TextStoreBaseActionController.startAction(
        name: 'TextStoreBase.removeItem');
    try {
      return super.removeItem(indexText);
    } finally {
      _$TextStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editItem(int index, String newText) {
    final _$actionInfo = _$TextStoreBaseActionController.startAction(
        name: 'TextStoreBase.editItem');
    try {
      return super.editItem(index, newText);
    } finally {
      _$TextStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardListItems: ${cardListItems}
    ''';
  }
}
