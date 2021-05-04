class CreateFirebaseShoppinglistFormValidator {
  static String? validateShoppinglistName(String? value) {
    if (value == null) {
      return 'Ikke en gyldig værdi';
    }

    if (value.isEmpty) {
      return 'Du skal indtaste et indkøbsliste navn';
    }

    if (value.length > 25) {
      return 'Indkøbsliste navnet er for langt';
    }
  }
}
