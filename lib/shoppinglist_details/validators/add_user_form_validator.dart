import 'package:email_validator/email_validator.dart';

class AddUserFormValidator {
  static String? validateNewUserEmail(String? value) {
    final notValidMessage = 'Ikke en gyldig email';

    if (value == null) {
      return notValidMessage;
    }

    if (value.isEmpty) {
      return notValidMessage;
    }

    if (!EmailValidator.validate(value)) {
      return notValidMessage;
    }
  }
}
