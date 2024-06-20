import 'package:formz/formz.dart';

// Define input validation errors
enum CouponInputError { empty }

// Extend FormzInput and provide the input type and error type.
class CouponInput extends FormzInput<String, CouponInputError> {
  // Call super.pure to represent an unmodified form input.
  const CouponInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CouponInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  CouponInputError? validator(String value) {
    return value.isEmpty ? CouponInputError.empty : null;
  }
}
