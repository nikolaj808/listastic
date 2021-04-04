class CreateItemFormValidator {
  static String? validateItemName(String? value) {
    if (value == null) {
      return 'Ikke en gyldig værdi';
    }

    if (value.isEmpty) {
      return 'Du skal indtaste et vare navn';
    }

    if (value.length > 25) {
      return 'Vare navnet er for langt';
    }
  }

  // TODO: Find a way to display longer error text
  static String? validateQuantity(String? value) {
    final errorText = 'Ugyldig';

    if (value == null) {
      return errorText;
      // return 'Ikke en gyldig værdi';
    }

    if (value.isEmpty) {
      return errorText;
      // return 'Du skal indtaste et antal';
    }

    final parsedValue = int.tryParse(value);

    if (parsedValue == null) {
      return errorText;
      // return 'Ikke en gyldig værdi';
    }

    if (parsedValue <= 0 || parsedValue >= 1000) {
      return errorText;
      // return 'Antallet er for højt';
    }
  }
}
