import 'package:listastic/shared_preferences/service/shared_preferences_service.dart';

Future<String?> getCurrentFirebaseShoppinglist() async {
  final sharedPreferencesService = SharedPreferencesService();

  final shoppinglistId = await sharedPreferencesService.getLatest();

  if (shoppinglistId is String) return shoppinglistId;
}
