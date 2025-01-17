import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/main.dart';
import 'package:flutter/material.dart';

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
  final int minimunTextColorDark;
  final int minimumTextColorLight;
  final int minimumLightSoles;
  final int minimumTextColorLightSoles;

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
    required this.minimunTextColorDark,
    required this.minimumTextColorLight,
    required this.minimumLightSoles,
    required this.minimumTextColorLightSoles,
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
  get getMinimumDarkColor => minimunTextColorDark;
  get getMinimumLightColor => minimumTextColorLight;
}

final productFixedTerm = ProductContainerStyles(
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1,000.00",
  profitabilityText: "19",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: appConfig.environment == 'production' ? FundUUIDEnum.prodCorporateFund : FundUUIDEnum.qaCorporateFund,
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
  minimunTextColorDark: 0xffFFFFFF,
  minimumTextColorLight: 0xff000000,
  minimumLightSoles: 0xffBBF0FF,
  minimumTextColorLightSoles: 0xff000000,
);

final productRealEstate = ProductContainerStyles(
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏡",
  titleText: "Producto de inversión con Garantía Inmobiliaria",
  minimumText: "50,000.00",
  profitabilityText: "16",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: true,
  uuid: appConfig.environment == 'production' ? FundUUIDEnum.prodInmobiliariaFund : FundUUIDEnum.qaInmobiliariaFund,
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
  minimunTextColorDark: 0xffFFFFFF,
  minimumTextColorLight: 0xff000000,
  minimumLightSoles: 0xffBBF0FF,
  minimumTextColorLightSoles: 0xff000000,
);
final product3 = ProductContainerStyles(
  backgroundContainerDark: 0xff1B1B1B,
  backgroundContainerLight: 0xffE9FAFF,
  imageProduct: "🏢",
  titleText: "Producto de inversión a Plazo Fijo",
  minimumText: "1,000.00",
  profitabilityText: "17",
  titleDark: 0xffFFFFFF,
  titleLight: 0xff0D3A5C,
  minimumDark: 0xff0D3A5C,
  minimumLight: 0xffBBF0FF,
  profitabilityDark: 0xffB5FF8A,
  profitabilityLight: 0xffD2FDBA,
  isSoles: false,
  uuid: appConfig.environment == 'production' ? FundUUIDEnum.prodCorporateFund : FundUUIDEnum.qaCorporateFund,
  buttonBackDark: 0xffA2E6FA,
  buttonBackLight: 0xff0D3A5C,
  buttonTextDark: 0xff0D3A5C,
  buttonTextLight: 0xffFFFFFF,
  textDark: 0xff000000,
  textLight: 0xff000000,
  minimunTextColorDark: 0xffFFFFFF,
  minimumTextColorLight: 0xff000000,
  minimumLightSoles: 0xffBBF0FF,
  minimumTextColorLightSoles: 0xff000000,
);

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

// Para manejar los estilos
class ProductStyle {
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
  final int minimunTextColorDark;
  final int minimumTextColorLight;
  final int minimumLightSoles;
  final int minimumTextColorLightSoles;

  const ProductStyle({
    required this.backgroundContainerDark,
    required this.backgroundContainerLight,
    required this.titleDark,
    required this.titleLight,
    required this.minimumDark,
    required this.minimumLight,
    required this.profitabilityDark,
    required this.profitabilityLight,
    required this.buttonBackDark,
    required this.buttonBackLight,
    required this.buttonTextDark,
    required this.buttonTextLight,
    required this.textDark,
    required this.textLight,
    required this.minimunTextColorDark,
    required this.minimumTextColorLight,
    required this.minimumLightSoles,
    required this.minimumTextColorLightSoles,
  });

  // Estilo por defecto
  static const defaultStyle = ProductStyle(
    backgroundContainerDark: 0xff1B1B1B,
    backgroundContainerLight: 0xffE9FAFF,
    titleDark: 0xffFFFFFF,
    titleLight: 0xff0D3A5C,
    minimumDark: 0xff0D3A5C,
    minimumLight: 0xffBBF0FF,
    profitabilityDark: 0xffB5FF8A,
    profitabilityLight: 0xffD2FDBA,
    buttonBackDark: 0xffA2E6FA,
    buttonBackLight: 0xff0D3A5C,
    buttonTextDark: 0xff0D3A5C,
    buttonTextLight: 0xffFFFFFF,
    textDark: 0xff000000,
    textLight: 0xff000000,
    minimunTextColorDark: 0xffFFFFFF,
    minimumTextColorLight: 0xff000000,
    minimumLightSoles: 0xffBBF0FF,
    minimumTextColorLightSoles: 0xff000000,
  );
}

// Para manejar los datos del producto
class ProductData {
  final String uuid;
  final String imageProduct;
  final String titleText;
  final String? minimumTextPEN;
  final String? minimumTextUSD;
  final String profitabilityText;
  final bool isSoles;
  final ProductStyle style;
  final String? objetiveText;
  final List<FundNetWorthEntity>? netWorths;
  final List<FundFeature>? features;
  final String? assetsUnderManagement;

  const ProductData({
    required this.uuid,
    required this.imageProduct,
    required this.titleText,
    required this.minimumTextPEN,
    required this.minimumTextUSD,
    required this.profitabilityText,
    required this.isSoles,
    required this.objetiveText,
    this.netWorths,
    this.features,
    this.assetsUnderManagement,
    this.style = ProductStyle.defaultStyle,
  });

  // Factory para crear desde FundEntity
  factory ProductData.fromFund(FundEntity fund) {
    return ProductData(
      uuid: fund.uuid,
      imageProduct: fund.iconUrl ?? "🏢", // Emoji por defecto
      titleText: fund.name,
      minimumTextPEN: fund.minAmountInvestmentPEN,
      minimumTextUSD: fund.minAmountInvestmentUSD,
      profitabilityText: fund.lastRentability ?? "0",
      isSoles: fund.minAmountInvestmentPEN != null,
      objetiveText: fund.objectiveText ?? "",
      netWorths: fund.netWorths,
      features: fund.features,
      assetsUnderManagement: fund.assetUnderManagementAmount,
      style: ProductStyle(
        backgroundContainerDark: fund.getHexDetailColorDark(),
        backgroundContainerLight: fund.getHexDetailColorLight(),
        titleDark: 0xffFFFFFF,
        titleLight: 0xff0D3A5C,
        minimumDark: 0xff0D3A5C,
        minimumLight: 0xffBBF0FF,
        profitabilityDark: 0xffB5FF8A,
        profitabilityLight: 0xffD2FDBA,
        buttonBackDark: 0xffA2E6FA,
        buttonBackLight: 0xff0D3A5C,
        buttonTextDark: 0xff0D3A5C,
        buttonTextLight: 0xffFFFFFF,
        textDark: 0xff000000,
        textLight: 0xff000000,
        minimunTextColorDark: 0xffFFFFFF,
        minimumTextColorLight: 0xff000000,
        minimumLightSoles: 0xffBBF0FF,
        minimumTextColorLightSoles: 0xff000000,
      ),
    );
  }
}
