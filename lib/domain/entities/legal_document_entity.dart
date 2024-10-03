class LegalAcceptance {
  final String termsAndConditions;
  final String privacyPolicy;

  LegalAcceptance({
    required this.termsAndConditions,
    required this.privacyPolicy,
  });

  factory LegalAcceptance.fromJson(Map<String, dynamic> json) {
    return LegalAcceptance(
      termsAndConditions: json['termsAndConditions'] ?? '',
      privacyPolicy: json['privacyPolicy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'termsAndConditions': termsAndConditions,
      'privacyPolicy': privacyPolicy,
    };
  }
}

class SunatDeclaration {
  final String nameFile;
  final String declarationUrl;

  SunatDeclaration({
    required this.nameFile,
    required this.declarationUrl,
  });

  factory SunatDeclaration.fromJson(Map<String, dynamic> json) {
    return SunatDeclaration(
      nameFile: json['nameFile'] ?? '',
      declarationUrl: json['declarationUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameFile': nameFile,
      'declarationUrl': declarationUrl,
    };
  }
}

class UserGetLegalDocuments {
  final LegalAcceptance legalAcceptance;
  final List<SunatDeclaration> sunatDeclarations;

  UserGetLegalDocuments({
    required this.legalAcceptance,
    required this.sunatDeclarations,
  });

  factory UserGetLegalDocuments.fromJson(Map<String, dynamic> json) {
    return UserGetLegalDocuments(
      legalAcceptance: LegalAcceptance.fromJson(json['legalAcceptance']),
      sunatDeclarations: (json['sunatDeclarations'] as List<dynamic>)
          .map((e) => SunatDeclaration.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'legalAcceptance': legalAcceptance.toJson(),
      'sunatDeclarations': sunatDeclarations.map((e) => e.toJson()).toList(),
    };
  }
}
