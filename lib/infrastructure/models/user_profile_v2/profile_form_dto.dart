// ignore_for_file: constant_identifier_names

class DtoRegisterForm {
  final String nickName;
  final String countryPrefix;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final bool acceptTermsConditions;
  final bool acceptPrivacyPolicy;

  DtoRegisterForm({
    required this.nickName,
    required this.countryPrefix,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.acceptTermsConditions,
    required this.acceptPrivacyPolicy,
  });
}

class DtoPersonalForm {
  final String firstName;
  final String lastNameFather;
  final String lastNameMother;
  final TypeDocumentEnum documentType;
  final String documentNumber;
  final CivilStatusEnum civilStatus;
  final String gender;

  DtoPersonalForm({
    required this.firstName,
    required this.lastNameFather,
    required this.lastNameMother,
    required this.documentType,
    required this.documentNumber,
    required this.civilStatus,
    required this.gender,
  });
}

enum TypeDocumentEnum {
  DNI,
  CARNET_EXTRAJERIA,
}

extension TypeDocumentEnumExtension on TypeDocumentEnum {
  String get name {
    switch (this) {
      case TypeDocumentEnum.DNI:
        return "DNI";
      case TypeDocumentEnum.CARNET_EXTRAJERIA:
        return "CARNET_EXTRAJERIA";
      default:
        return "DNI";
    }
  }
}

TypeDocumentEnum? getTypeDocumentEnum(String valor) {
  switch (valor) {
    case 'DNI':
      return TypeDocumentEnum.DNI;
    case 'Carné de extranjeria':
      return TypeDocumentEnum.CARNET_EXTRAJERIA;
    default:
      return TypeDocumentEnum.DNI;
  }
}

enum CivilStatusEnum {
  SINGLE,
  MARRIED,
  DIVORCED,
  WIDOWED,
}

extension CivilStatusEnumExtension on CivilStatusEnum {
  String get name {
    switch (this) {
      case CivilStatusEnum.SINGLE:
        return "SINGLE";
      case CivilStatusEnum.MARRIED:
        return "MARRIED";
      case CivilStatusEnum.DIVORCED:
        return "DIVORCED";
      case CivilStatusEnum.WIDOWED:
        return "WIDOWED";
      default:
        return "SINGLE";
    }
  }
}

CivilStatusEnum? getCivilStatusEnum(String valor) {
  switch (valor) {
    case 'Soltero':
      return CivilStatusEnum.SINGLE;
    case 'Casado':
      return CivilStatusEnum.MARRIED;
    case 'Divorciado':
      return CivilStatusEnum.DIVORCED;
    case 'Viudo':
      return CivilStatusEnum.WIDOWED;
    default:
      return CivilStatusEnum.SINGLE;
  }
}
