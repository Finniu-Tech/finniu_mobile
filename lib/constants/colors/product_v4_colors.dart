class ProductV4Colors {
  static const int primaryColor = 0xff0D3A5C;
  static const int primaryColorDark = 0xff0D3A5C;
  static const int primaryColorLight = 0xffA2E6FA;
}

class ProductContainerStyles {
  final bool isSoles;
  final String uuid;
  final String imageProduct;
  final String titleText;
  final String minimumText;
  final String profitabilityText;
  final int backgroundContainerDark;
  final int backgroundContainerLight;
  final int titleDark;
  final int titleLight;
  final int minimumDark;
  final int minimumLight;
  final int profitabilityDark;
  final int profitabilityLight;
  final int buttonBackDark;
  final int buttonBackLight;
  final int buttonTextDark;
  final int buttonTextLight;
  final int textDark;
  final int textLight;

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
    required this.buttonBackDark,
    required this.buttonBackLight,
    required this.buttonTextDark,
    required this.buttonTextLight,
    required this.textDark,
    required this.textLight,
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
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1.000",
  profitabilityText: "19",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: "1",
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
);

final product2 = ProductContainerStyles(
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏡",
  titleText: "Producto de inversión con Garantía Inmobiliaria",
  minimumText: "50.000",
  profitabilityText: "16",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: "2",
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
);
final product3 = ProductContainerStyles(
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1.000",
  profitabilityText: "17",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: false,
  uuid: "3",
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
);
