class ProductV4Colors {
  static const int primaryColor = 0xff0D3A5C;
  static const int primaryColorDark = 0xff0D3A5C;
  static const int primaryColorLight = 0xffA2E6FA;
}

class ProductContainerStyles {
  // Propiedades
  final int backgroundContainerDark;
  final int backgroundContainerLight;
  final String imageProduct;
  final String titleText;
  final String minimumText;
  final String profitabilityText;
  final int titleDark;
  final int titleLight;
  final int minimumDark;
  final int minimumLight;
  final int profitabilityDark;
  final int profitabilityLight;

  // Constructor
  ProductContainerStyles({
    required this.backgroundContainerDark,
    required this.backgroundContainerLight,
    required this.imageProduct,
    required this.titleText,
    required this.minimumText,
    required this.profitabilityText,
    required this.titleDark,
    required this.titleLight,
    required this.minimumDark,
    required this.minimumLight,
    required this.profitabilityDark,
    required this.profitabilityLight,
  });

  get getBackgroundContainerDark => backgroundContainerDark;
  get getBackgroundContainerLight => backgroundContainerLight;
  get getImageProduct => imageProduct;
  get getTitleText => titleText;
  get getTitleDark => titleDark;
  get getTitleLight => titleLight;
  get getMinimumDark => minimumDark;
  get getMinimumLight => minimumLight;
  get getProfitabilityDark => profitabilityDark;
  get getProfitabilityLight => profitabilityLight;
  get getMinimumText => minimumText;
  get getProfitabilityText => profitabilityText;
}
