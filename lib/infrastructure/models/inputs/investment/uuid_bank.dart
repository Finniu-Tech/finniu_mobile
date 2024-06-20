import 'package:formz/formz.dart';

// Define input validation errors
enum BankIdInputError { empty }

// Extend FormzInput and provide the input type and error type.
class BankIdInput extends FormzInput<String, BankIdInputError> {
  // Call super.pure to represent an unmodified form input.
  const BankIdInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const BankIdInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  BankIdInputError? validator(String value) {
    return value.isEmpty ? BankIdInputError.empty : null;
  }
}
