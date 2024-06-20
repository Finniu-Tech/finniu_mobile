import 'package:formz/formz.dart';

// Define input validation errors
enum DeadlineIdInputError { empty }

// Extend FormzInput and provide the input type and error type.
class DeadlineIdInput extends FormzInput<String, DeadlineIdInputError> {
  // Call super.pure to represent an unmodified form input.
  const DeadlineIdInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DeadlineIdInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  DeadlineIdInputError? validator(String value) {
    return value.isEmpty ? DeadlineIdInputError.empty : null;
  }
}
