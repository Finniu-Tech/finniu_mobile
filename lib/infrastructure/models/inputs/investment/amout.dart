import 'package:formz/formz.dart';

// Define input validation errors
enum AmoutInputError { empty }

// Extend FormzInput and provide the input type and error type.
class AmoutInput extends FormzInput<int, AmoutInputError> {
  // Call super.pure to represent an unmodified form input.
  const AmoutInput.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const AmoutInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == AmoutInputError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  AmoutInputError? validator(int value) {
    if (value.toString().isEmpty ||
        value.toString().trim().isEmpty ||
        value == 0) return AmoutInputError.empty;

    return null;
  }
}
