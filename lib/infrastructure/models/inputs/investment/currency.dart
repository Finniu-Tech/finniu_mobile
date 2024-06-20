import 'package:formz/formz.dart';

// Define input validation errors
enum CurrencyInputError { empty }

// Extend FormzInput and provide the input type and error type.
class CurrencyInput extends FormzInput<String, CurrencyInputError> {
  // Call super.pure to represent an unmodified form input.
  const CurrencyInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CurrencyInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  CurrencyInputError? validator(String value) {
    return value.isEmpty ? CurrencyInputError.empty : null;
  }
}
