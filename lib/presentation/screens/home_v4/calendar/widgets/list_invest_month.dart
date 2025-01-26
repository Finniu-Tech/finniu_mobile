import 'package:finniu/presentation/providers/investment_status_report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/tab_payments_widget.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ListInvestMonth extends ConsumerWidget {
  const ListInvestMonth({
    super.key,
    required this.selectedDate,
  });
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(paymentListProvider);

    return paymentsAsync.when(
      data: (payments) {
        final filteredPayments = payments
            .where(
              (payment) =>
                  payment.paymentDate.month == selectedDate.month &&
                  payment.paymentDate.year == selectedDate.year,
            )
            .toList();

        if (filteredPayments.isEmpty) {
          return const Center(
            child: TextPoppins(
              text: "No hay pagos para este mes",
              fontSize: 14,
            ),
          );
        }

        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: filteredPayments.length,
            itemBuilder: (context, index) => ItemCalendar(
              payment: filteredPayments[index],
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: Center(
          child: CircularLoader(width: 50, height: 50),
        ),
      ),
      error: (error, stack) => const SizedBox(),
    );
  }
}

class ItemCalendar extends ConsumerWidget {
  const ItemCalendar({
    super.key,
    required this.payment,
  });

  final PaymentData payment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const numberContainerDark = 0xffA2E6FA;
    const numberContainerLight = 0xffA2E6FA;
    const numberTextDark = 0xff0D3A5C;
    const numberTextLight = 0xff000000;
    const downloadIconDark = 0xff0D3A5C;
    const downloadIconLight = 0xffFFFFFF;
    const downloadDark = 0xffA2E6FA;
    const downloadLight = 0xff0D3A5C;

    const titleColor = 0xff0D3A5C;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? _getBackgroundColor(payment.status, true)
            : _getBackgroundColor(payment.status, false),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 35,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(numberContainerDark)
                      : const Color(numberContainerLight),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: TextPoppins(
                  text: "Operación #${payment.operationCode}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: numberTextDark,
                  textLight: numberTextLight,
                ),
              ),
              if (payment.paymentVoucherUrl?.isNotEmpty ?? false)
                Row(
                  children: [
                    const TextPoppins(text: "Voucher", fontSize: 10),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => _downloadVoucher(payment.paymentVoucherUrl!),
                      child: Container(
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(downloadDark)
                              : const Color(downloadLight),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.file_download_outlined,
                          size: 20,
                          color: isDarkMode
                              ? const Color(downloadIconDark)
                              : const Color(downloadIconLight),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextPoppins(
                      text: _getPaymentTypeIcon(payment.isCapitalPayment),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(width: 10),
                    TextPoppins(
                      text: payment.fundName ?? 'Inversión',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      textLight: titleColor,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildDateSection(payment.paymentDate, isDarkMode),
                    _buildAmountSection(payment, isDarkMode),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(PaymentStatus status, bool isDark) {
    // Implementa la lógica de colores según el status
    switch (status) {
      case PaymentStatus.past:
        return isDark ? const Color(0xFF08273F) : const Color(0xFFEDFBFF);
      case PaymentStatus.recent:
        return isDark ? const Color(0xFF08273F) : const Color(0xFFFFFFFF);
      case PaymentStatus.upcoming:
        return isDark ? const Color(0xFF08273F) : const Color(0xFFE9FAFF);
    }
  }

  String _getPaymentTypeIcon(bool isCapital) {
    return isCapital ? "💰" : "📈";
  }

  Future<void> _downloadVoucher(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'No se pudo abrir el voucher';
      }
    } catch (e) {
      debugPrint('Error al descargar el voucher: $e');
    }
  }
}

Widget _buildDateSection(DateTime date, bool isDarkMode) {
  const dateIconDark = 0xffA2E6FA;
  const dateIconLight = 0xff0D3A5C;
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? const Color(dateIconDark)
                : const Color(dateIconLight),
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 12,
                    color: isDarkMode
                        ? const Color(dateIconDark)
                        : const Color(dateIconLight),
                  ),
                  const SizedBox(width: 5),
                  const TextPoppins(
                    text: "Fecha",
                    fontSize: 10,
                  ),
                ],
              ),
              TextPoppins(
                text: DateFormat('dd MMM, yyyy').format(date),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAmountSection(PaymentData payment, bool isDarkMode) {
  const rentIconDark = 0xffB5FF8A;
  const rentIconLight = 0xff55B63D;
  const rentTextDark = 0xffB5FF8A;
  const rentTextLight = 0xff0D3A5C;
  final formattedAmount = payment.currency == PaymentCurrency.soles
      ? 'S/ ${payment.amount.toStringAsFixed(2)}'
      : '\$ ${payment.amount.toStringAsFixed(2)}';

  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? const Color(rentIconDark)
                : const Color(rentIconLight),
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg_icons/chart_home_icon.svg",
                    width: 15,
                    height: 15,
                    color: isDarkMode
                        ? const Color(rentIconDark)
                        : const Color(rentIconLight),
                  ),
                  const SizedBox(width: 5),
                  TextPoppins(
                    text: payment.isCapitalPayment ? "Capital" : "Rentabilidad",
                    fontSize: 10,
                  ),
                ],
              ),
              TextPoppins(
                text: formattedAmount,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textDark: rentTextDark,
                textLight: rentTextLight,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
