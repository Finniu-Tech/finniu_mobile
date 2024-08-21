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
