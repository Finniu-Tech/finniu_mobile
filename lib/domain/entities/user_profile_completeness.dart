class UserProfileCompleteness {
  final double personalDataComplete;
  final double locationComplete;
  final double occupationComplete;
  final double legalTermsCompleteness;
  final double profileComplete;
  final double completionPercentage;

  UserProfileCompleteness({
    required this.personalDataComplete,
    required this.locationComplete,
    required this.occupationComplete,
    required this.legalTermsCompleteness,
    required this.profileComplete,
    required this.completionPercentage,
  });

  factory UserProfileCompleteness.fromJson(Map<String, dynamic> json) {
    return UserProfileCompleteness(
      personalDataComplete: json['personalDataComplete'],
      locationComplete: json['locationComplete'],
      occupationComplete: json['occupationComplete'],
      legalTermsCompleteness: json['legalTermsCompleteness'],
      profileComplete: json['profileComplete'],
      completionPercentage: json['completionPercentage'],
    );
  }
  bool hasRequiredData() {
    return hasCompletePersonalData() && hasCompleteLegalTerms();
  }

  bool isComplete() {
    return completionPercentage == 100.0;
  }

  bool hasCompletePersonalData() {
    return personalDataComplete == 100.0;
  }

  bool hasCompleteLocation() {
    return locationComplete == 100.0;
  }

  bool hasCompleteOccupation() {
    return occupationComplete == 100.0;
  }

  bool hasCompleteLegalTerms() {
    return legalTermsCompleteness == 100.0;
  }

  bool hasCompleteProfile() {
    return profileComplete == 100.0;
  }

  String? getNextStep() {
    // this function returns the next step to be completed
    if (!hasCompletePersonalData()) {
      return '/v2/form_personal_data';
    }
    if (!hasCompleteLocation()) {
      return '/v2/form_location';
    }
    if (!hasCompleteOccupation()) {
      return '/v2/form_job';
    }

    return null;
  }

  toJson() {
    return {
      'personalDataComplete': personalDataComplete,
      'locationComplete': locationComplete,
      'occupationComplete': occupationComplete,
      'legalTermsCompleteness': legalTermsCompleteness,
      'profileComplete': profileComplete,
      'completionPercentage': completionPercentage,
    };
  }
}
