import 'dart:ui';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/constants/colors/select_bank_account.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ProfModal {
  final String title;
  final String bankTitle;
  final String rent;
  final String rentTitle;
  final String date;
  final String dateTitle;
  final String time;
  final String numberAccount;
  final String downloadVoucher;
  final BankAccount? bankAccount;
  const ProfModal({
    required this.title,
    required this.bankTitle,
    required this.rent,
    required this.rentTitle,
    required this.date,
    required this.dateTitle,
    required this.time,
    required this.numberAccount,
    required this.downloadVoucher,
    required this.bankAccount,
  });
}

void showProfitabilityModal(
  BuildContext context, {
  required ProfModal profModal,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return ProfModalBody(profModal: profModal);
    },
  );
}

class ProfModalBody extends ConsumerWidget {
  const ProfModalBody({
    super.key,
    required this.profModal,
  });
  final ProfModal profModal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;

    void downloadVoucher() {
      if (profModal.downloadVoucher.trim().isEmpty) {
        showSnackBarV2(
            context: context,
            title: "Voucher no disponible",
            message: "Voucher no disponible",
            snackType: SnackType.warning);
      } else {
        Navigator.pushNamed(context, '/v4/push_to_url',
            arguments: profModal.downloadVoucher);
      }
    }

    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;

    void closeModal() => Navigator.pop(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CloseIcon(
              isDarkMode: isDarkMode,
              closeModal: closeModal,
            ),
            TextPoppins(
              text: profModal.title,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              textDark: titleDark,
              textLight: titleLight,
            ),
            RowDate(
              dateTitle: profModal.dateTitle,
              date: profModal.date,
            ),
            const SizedBox(height: 15),
            RowRent(
              rentTitle: profModal.rentTitle,
              rent: profModal.rent,
            ),
            const SizedBox(height: 15),
            profModal.bankAccount != null
                ? TextPoppins(
                    text: profModal.bankTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )
                : const SizedBox(),
            const SizedBox(height: 15),
            profModal.bankAccount != null
                ? BankItemDetail(
                    bankAccount: profModal.bankAccount!,
                  )
                : const SizedBox(),
            const SizedBox(height: 15),
            if (profModal.downloadVoucher != "")
              VouvherContainer(
                rent: profModal.rent,
                numberAccount: profModal.bankAccount?.bankAccount == null
                    ? "************0000"
                    : getMaskedNumber(profModal.bankAccount!.bankAccount),
                time: profModal.time,
                downloadVoucher: downloadVoucher,
              ),
          ],
        ),
      ),
    );
  }
}

class VouvherContainer extends ConsumerWidget {
  const VouvherContainer({
    super.key,
    required this.rent,
    required this.numberAccount,
    required this.time,
    required this.downloadVoucher,
  });
  final String rent;
  final String numberAccount;
  final String time;
  final VoidCallback downloadVoucher;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int titleVoucher = 0xff0D3A5C;
    const int bodyVoucher = 0xffF5F5F5;
    const int titleDark = 0xffFFFFFF;
    const int bodyLight = 0xff000000;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(titleVoucher),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const TextPoppins(
            text: "Voucher del depósito",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textDark: titleDark,
            textLight: titleDark,
          ),
        ),
        GestureDetector(
          onTap: downloadVoucher,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 160,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(bodyVoucher),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextPoppins(
                            text: "Rentabilidad pagada",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                          TextPoppins(
                            text: rent,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextPoppins(
                            text: "Número de cuenta",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                          TextPoppins(
                            text: numberAccount,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextPoppins(
                            text: "Hora de operación",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                          TextPoppins(
                            text: time,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(DocumentsV4.itemButtonLight),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.file_download_outlined,
                                size: 26,
                                color: Color(DocumentsV4.itemButtonIconLight),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextPoppins(
                            text: "Descargar",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textDark: bodyLight,
                            textLight: bodyLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RowRent extends ConsumerWidget {
  const RowRent({
    super.key,
    required this.rent,
    required this.rentTitle,
  });

  final String rent;
  final String rentTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int lineDark = 0xff55B63D;
    const int lineLight = 0xff55B63D;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: isDarkMode ? const Color(lineDark) : const Color(lineLight),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg_icons/status_up.svg',
                    width: 16,
                    height: 16,
                    color: isDarkMode
                        ? const Color(lineDark)
                        : const Color(lineLight),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextPoppins(
                    text: rentTitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextPoppins(
                text: rent,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RowDate extends ConsumerWidget {
  const RowDate({
    super.key,
    required this.date,
    required this.dateTitle,
  });
  final String date;
  final String dateTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int lineDark = 0xffA2E6FA;
    const int lineLight = 0xff0D3A5C;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: isDarkMode ? const Color(lineDark) : const Color(lineLight),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: isDarkMode
                        ? const Color(lineDark)
                        : const Color(lineLight),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextPoppins(
                    text: dateTitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextPoppins(
                text: date,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CloseIcon extends StatelessWidget {
  const CloseIcon({
    super.key,
    required this.isDarkMode,
    required this.closeModal,
  });
  final void Function() closeModal;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: closeModal,
          icon: Transform.rotate(
            angle: math.pi / -4,
            child: Icon(
              Icons.add_circle_outline,
              size: 24,
              color: isDarkMode
                  ? const Color(ActiveModal.iconDark)
                  : const Color(ActiveModal.iconLight),
            ),
          ),
        ),
      ),
    );
  }
}

class BankItemDetail extends ConsumerWidget {
  const BankItemDetail({
    super.key,
    required this.bankAccount,
  });

  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    String getCurrency(String? currency) {
      switch (currency) {
        case "nuevo sol":
          return "Cuenta Soles";
        case "dolar":
          return "Cuenta Dólares";
        default:
          return "Cuenta Soles";
      }
    }

    String getMaskedNumber(String? number) {
      if (number != null && number.length >= 3) {
        String visible = number.substring(number.length - 3);
        return "**********$visible";
      } else {
        return "**********000";
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(SelectBankAccountColors.backgroundSelectDark)
            : const Color(SelectBankAccountColors.backgroundSelectLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              bankAccount.bankLogoUrl ?? "",
              width: 40,
              height: 40,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularLoader(width: 10, height: 10);
                }
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(SelectBankAccountColors.errorDark)
                      : const Color(SelectBankAccountColors.errorLight),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/bank_case_error.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: getCurrency(bankAccount.currency),
                  fontSize: 14,
                  textDark: SelectBankAccountColors.textSelectDark,
                  textLight: SelectBankAccountColors.textSelectLight,
                ),
                TextPoppins(
                  text:
                      "${bankAccount.bankSlug.toUpperCase()} ${getMaskedNumber(bankAccount.bankAccount)}",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textDark: SelectBankAccountColors.textSelectDark,
                  textLight: SelectBankAccountColors.textSelectLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
