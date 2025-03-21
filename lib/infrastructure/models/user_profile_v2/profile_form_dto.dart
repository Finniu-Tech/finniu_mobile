// ignore_for_file: constant_identifier_names

class DtoRegisterForm {
  final String nickName;
  final String countryPrefix;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final String birthday;
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
    required this.birthday,
  });
  toJson() => {
        "nickName": nickName,
        "countryPrefix": countryPrefix,
        "phoneNumber": phoneNumber,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "acceptTermsConditions": acceptTermsConditions,
        "acceptPrivacyPolicy": acceptPrivacyPolicy,
        "birthday": birthday,
      };
}

class DtoPersonalForm {
  final String firstName;
  final String lastNameFather;
  final String lastNameMother;
  final TypeDocumentEnum documentType;
  final String documentNumber;
  final CivilStatusEnum civilStatus;
  final String? imageProfile;
  final GenderEnum gender;
  final String? birthday;

  DtoPersonalForm({
    required this.firstName,
    required this.lastNameFather,
    required this.lastNameMother,
    required this.documentType,
    required this.documentNumber,
    required this.civilStatus,
    required this.imageProfile,
    required this.gender,
    this.birthday,
  });
}

enum TypeDocumentEnum { DNI, CARNET, OTHERS }

final List<String> documentType = [
  'DNI',
  'Carné de extranjeria',
  'Otro',
];

String getTypeDocumentByUser(String type) {
  switch (type) {
    case 'DNI':
      return "DNI";
    case "CARNET":
      return "Carné de extranjeria";
    case "OTHERS":
      return "Otro";
    case "":
      return "";
    default:
      return "";
  }
}

extension TypeDocumentEnumExtension on TypeDocumentEnum {
  String get name {
    switch (this) {
      case TypeDocumentEnum.DNI:
        return "DNI";
      case TypeDocumentEnum.CARNET:
        return "CARNET";
      case TypeDocumentEnum.OTHERS:
        return "OTHERS";
      default:
        return "OTHERS";
    }
  }
}

TypeDocumentEnum getTypeDocumentEnum(String valor) {
  switch (valor) {
    case 'DNI':
      return TypeDocumentEnum.DNI;
    case 'Carné de extranjeria':
      return TypeDocumentEnum.CARNET;
    case 'Otro':
      return TypeDocumentEnum.OTHERS;
    default:
      return TypeDocumentEnum.OTHERS;
  }
}

enum CivilStatusEnum {
  SINGLE,
  MARRIED,
  DIVORCED,
  WIDOWED,
}

final List<String> maritalStatus = [
  'Soltero',
  'Casado',
  'Divorciado',
  'Viudo',
];

String getCivilStatusByUser(String type) {
  switch (type) {
    case 'SINGLE':
      return "Soltero";
    case "MARRIED":
      return "Casado";
    case "DIVORCED":
      return "Divorciado";
    case "WIDOWED":
      return "Viudo";
    case "":
      return "";
    default:
      return "";
  }
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

class DtoLocationForm {
  final String country;
  final String? region;
  final String? province;
  final String? district;
  final String address;
  final String? extRegion;
  final String? extProvince;
  final String? extDistrict;

  DtoLocationForm({
    required this.country,
    required this.address,
    this.region,
    this.province,
    this.district,
    this.extRegion,
    this.extProvince,
    this.extDistrict,
  });
  toJson() => {
        "country": country,
        "region": region,
        "province": province,
        "district": district,
        "address": address,
        "regionExt": extRegion,
        "provinceExt": extProvince,
        "districtExt": extDistrict,
        // "houseNumber": data.houseNumber,
      };
}

class DtoOccupationForm {
  final String occupation;
  final String companyName;

  DtoOccupationForm({
    required this.occupation,
    required this.companyName,
  });
}

enum LaborSituationEnum {
  EMPLOYED,
  UNEMPLOYED,
  STUDENT,
  RETIRED,
  SELF_EMPLOYED,
  OTHER,
}

String getLaborsStatusEnumByUser(String? valor) {
  switch (valor) {
    case 'Employed':
      return 'Empleado';
    case 'Unemployed':
      return 'Desempleado';
    case 'Student':
      return 'Estudiante';
    case 'Retired':
      return 'Retirado';
    case 'Self-employed':
      return 'Autoempleo';
    case 'Other':
      return 'Otro';
    case "":
      return '';
    default:
      return '';
  }
}

extension LaborSituationEnumExtension on LaborSituationEnum {
  String get name {
    switch (this) {
      case LaborSituationEnum.EMPLOYED:
        return "EMPLOYED";
      case LaborSituationEnum.UNEMPLOYED:
        return "UNEMPLOYED";
      case LaborSituationEnum.STUDENT:
        return "STUDENT";
      case LaborSituationEnum.RETIRED:
        return "RETIRED";
      case LaborSituationEnum.SELF_EMPLOYED:
        return "SELF_EMPLOYED";
      case LaborSituationEnum.OTHER:
        return "OTHER";
      default:
        return "EMPLOYED";
    }
  }
}

LaborSituationEnum? getLaborsStatusEnum(String valor) {
  switch (valor) {
    case 'Empleado':
      return LaborSituationEnum.EMPLOYED;
    case 'Desempleado':
      return LaborSituationEnum.UNEMPLOYED;
    case 'Estudiante':
      return LaborSituationEnum.STUDENT;
    case 'Retirado':
      return LaborSituationEnum.RETIRED;
    case 'Autoempleo':
      return LaborSituationEnum.SELF_EMPLOYED;
    case 'Otro':
      return LaborSituationEnum.OTHER;
    default:
      return LaborSituationEnum.EMPLOYED;
  }
}

enum ServiceTimeEnum {
  LESS_THAN_ONE_YEAR,
  ONE_TO_THREE_YEARS,
  THREE_TO_FIVE_YEARS,
  FIVE_TO_TEN_YEARS,
  MORE_THAN_TEN_YEARS,
}

String getServiceTimeEnumByUser(String? valor) {
  switch (valor) {
    case "Less than 1 year":
      return 'Menos de un año';
    case '1 to 3 years':
      return 'Entre 1 y 3 años';
    case '3 to 5 years':
      return 'Entre 3 y 5 años';
    case '5 to 10 years':
      return 'Entre 5 y 10 años';
    case 'More than 10 years':
      return 'Mas de 10 años';
    default:
      return '';
  }
}

extension ServiceTimeEnumExtension on ServiceTimeEnum {
  String get name {
    switch (this) {
      case ServiceTimeEnum.LESS_THAN_ONE_YEAR:
        return "LESS_THAN_ONE_YEAR";
      case ServiceTimeEnum.ONE_TO_THREE_YEARS:
        return "ONE_TO_THREE_YEARS";
      case ServiceTimeEnum.THREE_TO_FIVE_YEARS:
        return "THREE_TO_FIVE_YEARS";
      case ServiceTimeEnum.FIVE_TO_TEN_YEARS:
        return "FIVE_TO_TEN_YEARS";
      case ServiceTimeEnum.MORE_THAN_TEN_YEARS:
        return "MORE_THAN_TEN_YEARS";
      default:
        return "LESS_THAN_ONE_YEAR";
    }
  }
}

ServiceTimeEnum? getServiceTimeEnum(String valor) {
  switch (valor) {
    case 'Menos de un año':
      return ServiceTimeEnum.LESS_THAN_ONE_YEAR;
    case 'Entre 1 y 3 años':
      return ServiceTimeEnum.ONE_TO_THREE_YEARS;
    case 'Entre 3 y 5 años':
      return ServiceTimeEnum.THREE_TO_FIVE_YEARS;
    case 'Entre 5 y 10 años':
      return ServiceTimeEnum.FIVE_TO_TEN_YEARS;
    case 'Mas de 10 años':
      return ServiceTimeEnum.MORE_THAN_TEN_YEARS;
    default:
      return ServiceTimeEnum.LESS_THAN_ONE_YEAR;
  }
}

class DtoLegalTermsForm {
  final bool isPublicOfficialOrFamily;
  final bool isDirectorOrShareholder10Percent;

  DtoLegalTermsForm({
    required this.isPublicOfficialOrFamily,
    required this.isDirectorOrShareholder10Percent,
  });
}

class DtoAboutMeForm {
  final String imageProfile;
  final String backgroundPhoto;
  final String biography;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String? other;

  DtoAboutMeForm({
    required this.imageProfile,
    required this.backgroundPhoto,
    required this.biography,
    required this.facebook,
    required this.instagram,
    required this.linkedin,
    required this.other,
  });
}

enum GenderEnum {
  MALE,
  FEMALE,
  NON_BINARY,
  OTHER,
  PREFER_NOT_TO_SAY,
}

final List<String> genderType = [
  'Masculino',
  'Femenino',
  "No binario",
  "Otro",
  "Prefiero no decirlo",
];

String getGenderByUser(String type) {
  switch (type) {
    case 'MALE':
      return "Masculino";
    case "FEMALE":
      return "Femenino";
    case "NON_BINARY":
      return "No binario";
    case "OTHER":
      return "Otro";
    case "PREFER_NOT_TO_SAY":
      return "Prefiero no decirlo";

    default:
      return "Otro";
  }
}

extension GenderEnumExtension on GenderEnum {
  String get name {
    switch (this) {
      case GenderEnum.MALE:
        return "MALE";
      case GenderEnum.FEMALE:
        return "FEMALE";
      case GenderEnum.NON_BINARY:
        return "NON_BINARY";
      case GenderEnum.OTHER:
        return "OTHER";
      case GenderEnum.PREFER_NOT_TO_SAY:
        return "PREFER_NOT_TO_SAY";
      default:
        return "OTHER";
    }
  }
}

GenderEnum? getGenderEnum(String valor) {
  switch (valor) {
    case 'Masculino':
      return GenderEnum.MALE;
    case 'Femenino':
      return GenderEnum.FEMALE;
    case 'No binario':
      return GenderEnum.NON_BINARY;
    case 'Otro':
      return GenderEnum.OTHER;
    case 'Prefiero no decirlo':
      return GenderEnum.PREFER_NOT_TO_SAY;
    default:
      return GenderEnum.PREFER_NOT_TO_SAY;
  }
}
