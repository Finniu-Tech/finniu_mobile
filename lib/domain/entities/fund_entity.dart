class FundTypeEnum {
  static const String aggro = 'agro_real_state_funds';
  static const String corporate = 'corporate_investment_funds';
}

class FundEntity {
  String uuid;
  String name;
  String? iconUrl;
  String? mainImageUrl;
  String? mainImageHorizontalUrl;
  String? backgroundImageUrl;
  String? assetUnderManagementAmount;
  String? hexListColorLight;
  String? hexListColorDark;
  String? hexDetailColorLight;
  String? hexDetailColorDark;

  String? hexDetailColorSecondaryLight;
  String? hexDetailColorSecondaryDark;
  String? fundType;
  String? tagDetailID;
  String? tagBenefitsID;
  String? tagDownloadInfoID;
  String? tagInvestmentButtonID;

  List<FundNetWorthEntity>? netWorths;
  bool? isActive;
  bool? isDelete;
  String? lastRentability;
  String? netWorthAmount;
  String? totalInstallmentsAmount;
  String? moreInfoDownloadUrl;
  String? minAmountInvestmentPEN;
  String? minAmountInvestmentUSD;

  FundEntity({
    required this.uuid,
    required this.name,
    this.iconUrl,
    this.mainImageUrl,
    this.mainImageHorizontalUrl,
    this.backgroundImageUrl,
    this.hexListColorLight,
    this.hexListColorDark,
    this.hexDetailColorLight,
    this.hexDetailColorDark,
    this.hexDetailColorSecondaryLight,
    this.hexDetailColorSecondaryDark,
    this.isActive,
    this.isDelete,
    this.lastRentability,
    this.netWorthAmount,
    this.assetUnderManagementAmount,
    this.netWorths,
    this.fundType,
    this.tagDetailID,
    this.tagBenefitsID,
    this.tagDownloadInfoID,
    this.tagInvestmentButtonID,
    this.totalInstallmentsAmount,
    this.moreInfoDownloadUrl,
    this.minAmountInvestmentPEN,
    this.minAmountInvestmentUSD,
  });

  bool getActive(bool isActive) {
    return isActive && (isDelete == null || !isDelete!);
  }

  int getHexListColorLight() {
    return parseHexColor(hexListColorLight!);
  }

  int getHexListColorDark() {
    return parseHexColor(hexListColorDark!);
  }

  int getHexDetailColorLight() {
    return parseHexColor(hexDetailColorLight!);
  }

  int getHexDetailColorDark() {
    return parseHexColor(hexDetailColorDark!);
  }

  int getHexDetailColorSecondaryLight() {
    return parseHexColor(hexDetailColorSecondaryLight!);
  }

  int getHexDetailColorSecondaryDark() {
    if (hexDetailColorSecondaryDark == null) {
      return parseHexColor(hexDetailColorDark!);
    }
    return parseHexColor(hexDetailColorSecondaryDark!);
  }

  static parseHexColor(String hexColor) {
    // #A2CEFE example of hex color
    //return format: 0xffA2CEFE
    return int.parse('ff${hexColor.substring(1)}', radix: 16);
  }

  static FundEntity fromJson(Map<String, dynamic> data) {
    return FundEntity(
      uuid: data['uuid'],
      name: data['name'],
      iconUrl: data['icon'],
      mainImageUrl: data['mainImageUrl'],
      mainImageHorizontalUrl: data['mainImageHorizontalUrl'],
      backgroundImageUrl: data['backgroundImageUrl'],
      hexListColorLight: data['listBackgroundColorLight'],
      hexListColorDark: data['listBackgroundColorDark'],
      hexDetailColorLight: data['detailBackgroundColorLight'],
      hexDetailColorDark: data['detailBackgroundColorDark'],
      hexDetailColorSecondaryLight: data['detailBackgroundColorSecondaryLight'],
      hexDetailColorSecondaryDark: data['detailBackgroundColorDarkSecondary'],
      tagDetailID: data['tagDetailId'],
      tagBenefitsID: data['tagBenefitsId'],
      tagDownloadInfoID: data['tagDownloadInfoId'],
      tagInvestmentButtonID: data['tagInvestmentButtonId'],
      fundType: data['fundType'],
      isActive: data['isActive'],
      isDelete: data['isDeleted'],
      lastRentability: data['lastRentability'],
      netWorthAmount: data['netWorthAmount'],
      assetUnderManagementAmount: data['assetsUnderManagement'],
      netWorths: FundNetWorthEntity.listFromJson(data['netWorthGraph']),
      totalInstallmentsAmount: data['currentInstallment']?['value'] ?? '0',
      moreInfoDownloadUrl: data['moreInfoDownloadUrl'],
      minAmountInvestmentPEN: data['minAmountInvestmentPen'],
      minAmountInvestmentUSD: data['minAmountInvestmentUsd'],
    );
  }

  static List<FundEntity> listFromJson(List<dynamic> data) {
    return data.map((fund) => FundEntity.fromJson(fund)).toList();
  }
}

class FundNetWorthEntity {
  String date;
  double value;
  FundNetWorthEntity({
    required this.date,
    required this.value,
  });

  static fromJson(Map<String, dynamic> data) {
    return FundNetWorthEntity(
      date: data['date'],
      value: double.parse(data['value']),
    );
  }

  static List<FundNetWorthEntity>? listFromJson(List<dynamic>? data) {
    if (data == null) {
      return null;
    }
    return data.map((netWorth) => FundNetWorthEntity(date: netWorth['date'], value: netWorth['value'])).toList();
  }
}

class FundBenefit {
  String uuid;
  String title;
  String iconUrl;
  String hexBackgroundColorLight;
  String hexBackgroundColorDark;
  bool isActive;
  bool isDelete;

  FundBenefit({
    required this.uuid,
    required this.title,
    required this.iconUrl,
    required this.hexBackgroundColorLight,
    required this.hexBackgroundColorDark,
    required this.isActive,
    required this.isDelete,
  });

  get getHexBackgroundColorLight => parseHexColor(hexBackgroundColorLight);

  get getHexBackgroundColorDark => parseHexColor(hexBackgroundColorDark);

  static int parseHexColor(String hexColor) {
    return int.parse('ff${hexColor.substring(1)}', radix: 16);
  }

  static FundBenefit fromJson(Map<String, dynamic> data) {
    return FundBenefit(
      uuid: data['uuid'],
      title: data['benefitText'],
      iconUrl: data['icon'],
      hexBackgroundColorLight: data['backgroundColorDark'],
      hexBackgroundColorDark: data['backgroundColorLight'],
      isActive: data['isActive'],
      isDelete: data['isDeleted'],
    );
  }

  static List<FundBenefit> listFromJson(List<dynamic> data) {
    return data.map((benefit) => FundBenefit.fromJson(benefit)).toList();
  }
}
