// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginModel {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginModelCopyWith<LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginModelCopyWith<$Res> {
  factory $LoginModelCopyWith(
          LoginModel value, $Res Function(LoginModel) then) =
      _$LoginModelCopyWithImpl<$Res, LoginModel>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginModelCopyWithImpl<$Res, $Val extends LoginModel>
    implements $LoginModelCopyWith<$Res> {
  _$LoginModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginModelCopyWith<$Res>
    implements $LoginModelCopyWith<$Res> {
  factory _$$_LoginModelCopyWith(
          _$_LoginModel value, $Res Function(_$_LoginModel) then) =
      __$$_LoginModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$_LoginModelCopyWithImpl<$Res>
    extends _$LoginModelCopyWithImpl<$Res, _$_LoginModel>
    implements _$$_LoginModelCopyWith<$Res> {
  __$$_LoginModelCopyWithImpl(
      _$_LoginModel _value, $Res Function(_$_LoginModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_LoginModel(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginModel extends _LoginModel {
  const _$_LoginModel({required this.email, required this.password})
      : super._();

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginModel(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginModelCopyWith<_$_LoginModel> get copyWith =>
      __$$_LoginModelCopyWithImpl<_$_LoginModel>(this, _$identity);
}

abstract class _LoginModel extends LoginModel {
  const factory _LoginModel(
      {required final String email,
      required final String password}) = _$_LoginModel;
  const _LoginModel._() : super._();

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginModelCopyWith<_$_LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterUserModel {
  String get nickname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterUserModelCopyWith<RegisterUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterUserModelCopyWith<$Res> {
  factory $RegisterUserModelCopyWith(
          RegisterUserModel value, $Res Function(RegisterUserModel) then) =
      _$RegisterUserModelCopyWithImpl<$Res, RegisterUserModel>;
  @useResult
  $Res call({String nickname, String email, int phone, String password});
}

/// @nodoc
class _$RegisterUserModelCopyWithImpl<$Res, $Val extends RegisterUserModel>
    implements $RegisterUserModelCopyWith<$Res> {
  _$RegisterUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterUserModelCopyWith<$Res>
    implements $RegisterUserModelCopyWith<$Res> {
  factory _$$_RegisterUserModelCopyWith(_$_RegisterUserModel value,
          $Res Function(_$_RegisterUserModel) then) =
      __$$_RegisterUserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nickname, String email, int phone, String password});
}

/// @nodoc
class __$$_RegisterUserModelCopyWithImpl<$Res>
    extends _$RegisterUserModelCopyWithImpl<$Res, _$_RegisterUserModel>
    implements _$$_RegisterUserModelCopyWith<$Res> {
  __$$_RegisterUserModelCopyWithImpl(
      _$_RegisterUserModel _value, $Res Function(_$_RegisterUserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? email = null,
    Object? phone = null,
    Object? password = null,
  }) {
    return _then(_$_RegisterUserModel(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterUserModel extends _RegisterUserModel {
  const _$_RegisterUserModel(
      {required this.nickname,
      required this.email,
      required this.phone,
      required this.password})
      : super._();

  @override
  final String nickname;
  @override
  final String email;
  @override
  final int phone;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterUserModel(nickname: $nickname, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterUserModel &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nickname, email, phone, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterUserModelCopyWith<_$_RegisterUserModel> get copyWith =>
      __$$_RegisterUserModelCopyWithImpl<_$_RegisterUserModel>(
          this, _$identity);
}

abstract class _RegisterUserModel extends RegisterUserModel {
  const factory _RegisterUserModel(
      {required final String nickname,
      required final String email,
      required final int phone,
      required final String password}) = _$_RegisterUserModel;
  const _RegisterUserModel._() : super._();

  @override
  String get nickname;
  @override
  String get email;
  @override
  int get phone;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterUserModelCopyWith<_$_RegisterUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
