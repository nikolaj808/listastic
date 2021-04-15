import 'package:listastic/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<Object> getLatest() async {
    final prefs = await SharedPreferences.getInstance();

    final shoppinglistId = prefs.get(Constants.latestShoppinglistKey) ?? 1;

    return shoppinglistId;
  }

  Future<void> setLatestOffline(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(Constants.latestShoppinglistKey, id);
  }

  Future<void> setLatestOnline(String id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(Constants.latestShoppinglistKey, id);
  }
}
