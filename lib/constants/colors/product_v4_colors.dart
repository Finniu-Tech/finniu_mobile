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
  final bool isSoles;
  final String uuid;

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
    required this.isSoles,
    required this.uuid,
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
  get getIsSoles => isSoles;
}

final product = ProductContainerStyles(
  backgroundContainerDark: 0xffE9FAFF,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1.000",
  profitabilityText: "19",
  titleDark: 0xff0D3A5C,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xffBBF0FF,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffD2FDBA,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: "1",
);
final product2 = ProductContainerStyles(
  backgroundContainerDark: 0xffE9E5FF,
  backgroundContainerLight: 0xffE9E5FF,
  imageProduct: "🏡",
  titleText: "Producto de inversión con Garantía Inmobiliaria",
  minimumText: "50.000",
  profitabilityText: "16",
  titleDark: 0xff0D3A5C,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xffBBF0FF,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffD2FDBA,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: "2",
);
final product3 = ProductContainerStyles(
  backgroundContainerDark: 0xffE9FAFF,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1.000",
  profitabilityText: "17",
  titleDark: 0xff0D3A5C,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xffBBF0FF,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffD2FDBA,
  profitabilityLight: 0xffD2FDBA,
  isSoles: false,
  uuid: "3",
);
