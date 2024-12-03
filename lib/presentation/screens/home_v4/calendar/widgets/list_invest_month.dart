import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/calendar/widgets/example.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListInvestMonth extends StatelessWidget {
  const ListInvestMonth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final list = exampleFundItemCalendars;
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => ItemCalendar(
          item: list[index],
        ),
      ),
    );
  }
}

class ItemCalendar extends ConsumerWidget {
  const ItemCalendar({
    super.key,
    required this.item,
  });
  final FundItemCalendar item;
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
    const dateIconDark = 0xffA2E6FA;
    const dateIconLight = 0xff0D3A5C;
    const rentIconDark = 0xffB5FF8A;
    const rentIconLight = 0xff55B63D;
    const rentTextDark = 0xffB5FF8A;
    const rentTextLight = 0xff0D3A5C;
    const titleColor = 0xff0D3A5C;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? Color(item.color.backgroundDark)
            : Color(item.color.backgroundLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 143,
                height: 35,
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
                  text: "Operación #${item.number}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: numberTextDark,
                  textLight: numberTextLight,
                ),
              ),
              if (item.voucherUrl != "")
                Row(
                  children: [
                    const TextPoppins(text: "Voucher", fontSize: 10),
                    const SizedBox(width: 5),
                    Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(downloadDark)
                            : const Color(downloadLight),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
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
                )
              else
                const SizedBox(),
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
                      text: item.color.icon,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(width: 10),
                    TextPoppins(
                      text: item.color.title,
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
                    Expanded(
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
                                  text: item.date,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                                    Icon(
                                      Icons.show_chart_rounded,
                                      size: 12,
                                      color: isDarkMode
                                          ? const Color(rentIconDark)
                                          : const Color(rentIconLight),
                                    ),
                                    const SizedBox(width: 5),
                                    const TextPoppins(
                                      text: "Rentabilidad",
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                                TextPoppins(
                                  text: item.rent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textDark: rentTextDark,
                                  textLight: rentTextLight,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
