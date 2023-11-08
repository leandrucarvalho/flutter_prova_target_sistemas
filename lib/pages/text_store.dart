import 'package:flutter_prova_target_sistemas/service/info_storage.dart';
import 'package:mobx/mobx.dart';

part 'text_store.g.dart';

class TextStore = TextStoreBase with _$TextStore;

abstract class TextStoreBase with Store {
  final InfoStorageService appStorageService;

  TextStoreBase(this.appStorageService);

  @observable
  var cardListItems = ObservableList<String>();

  @action
  void addItem(List<String> newText) {
    cardListItems = newText.asObservable();
    appStorageService.setString(newText);
  }

  @action
  void removeItem(int indexText) {
    cardListItems.removeAt(indexText);
    appStorageService.setString(cardListItems);
  }

  @action
  void editItem(int index, String newText) {
    cardListItems[index] = newText;
    appStorageService.setString(cardListItems);
  }

  @action
  Future<void> loadDataItem() async {
    final data = await appStorageService.getString();
    cardListItems = data.asObservable();
  }
}
