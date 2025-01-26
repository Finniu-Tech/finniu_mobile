import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/payment_schedule/widgets/profitability_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showCapitalModal(
  BuildContext context, {
  required ProfModal profModal,
  required bool isPaid,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CapitalModalBody(profModal: profModal, isPaid: isPaid);
    },
  );
}

class CapitalModalBody extends HookConsumerWidget {
  const CapitalModalBody({
    super.key,
    required this.profModal,
    required this.isPaid,
  });
  final bool isPaid;
  final ProfModal profModal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isExpanded = useState(false);

    void downloadVoucher() {
      if (profModal.downloadVoucher.trim().isEmpty) {
        showSnackBarV2(
            context: context,
            title: "Voucher no disponible",
            message: "Voucher no disponible",
            snackType: SnackType.warning);
      } else {
        Navigator.pushNamed(context, '/v4/push_to_url', arguments: profModal.downloadVoucher);
      }
    }

    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    void closeModal() => Navigator.pop(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowDate(
                  dateTitle: profModal.dateTitle,
                  date: profModal.date,
                ),
                isPaid
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          isExpanded.value = !isExpanded.value;
                        },
                        icon: const Icon(Icons.help_outline_outlined),
                      ),
              ],
            ),
            const SizedBox(height: 15),
            isExpanded.value
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextPoppins(
                        text: "¿Cómo saber la fecha del pago de mi capital?",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10),
                      TextPoppins(
                        text:
                            "La fecha del pago del capital se define según el día en que se haya validado la transferencia de su inversión ",
                        fontSize: 11,
                        lines: 4,
                      ),
                      SizedBox(height: 10),
                      DatePay()
                    ],
                  )
                : const SizedBox(),
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

class DatePay extends ConsumerWidget {
  const DatePay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundColorDark = 0xffA2E6FA;
    const backgroundColorLight = 0xff08273F;
    const backgroundDay = 0xffD6F6FF;
    const border = 0xff0D3A5C;
    const text = 0xff000000;
    const titleTableDark = 0xff0D3A5C;
    const titleTableLight = 0xffFFFFFF;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(backgroundColorDark) : const Color(backgroundColorLight),
            border: Border.all(
              width: 1,
              color: const Color(border),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Día de transferencia",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: titleTableDark,
                    textLight: titleTableLight,
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: Color(border),
              ),
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Pago de capital",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: titleTableDark,
                    textLight: titleTableLight,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: Color(backgroundDay)),
          width: double.infinity,
          height: 50,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Día 13 al 27",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: text,
                    textLight: text,
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: Color(border),
              ),
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Día 30",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: text,
                    textLight: text,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Color(border)),
            ),
            color: Color(backgroundDay),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          width: double.infinity,
          height: 50,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Día 28 al 12",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: text,
                    textLight: text,
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: Color(border),
              ),
              Expanded(
                child: Center(
                  child: TextPoppins(
                    text: "Día 15",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: text,
                    textLight: text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
