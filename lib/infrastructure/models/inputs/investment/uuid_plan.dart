import 'package:formz/formz.dart';

// Define input validation errors
enum PlanIdInputError { empty }

// Extend FormzInput and provide the input type and error type.
class PlanIdInput extends FormzInput<String, PlanIdInputError> {
  // Call super.pure to represent an unmodified form input.
  const PlanIdInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PlanIdInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PlanIdInputError? validator(String value) {
    return value.isEmpty ? PlanIdInputError.empty : null;
  }
}
