import 'package:shared_preferences/shared_preferences.dart';

const String key = "TODOKEY";

class InfoStorageService {
  setString(List<String> value) async {
    final SharedPreferences sharedStorage =
        await SharedPreferences.getInstance();
    await sharedStorage.setStringList(key, value);
  }

  Future<List<String>> getString() async {
    final SharedPreferences sharedStorage =
        await SharedPreferences.getInstance();
    return sharedStorage.getStringList(key) ?? [];
  }
}
