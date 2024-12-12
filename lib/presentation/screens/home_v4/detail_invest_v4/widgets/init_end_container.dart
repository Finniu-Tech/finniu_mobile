import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/detail_invest_v4/widgets/pay_modal.dart';
import 'package:flutter/material.dart';

class InitEndContainer extends StatelessWidget {
  const InitEndContainer({
    super.key,
    required this.dateStart,
    required this.dateEnd,
    required this.dateRentPay,
    required this.dateCapitalPay,
    required this.isDarkMode,
  });
  final String dateStart;
  final String dateEnd;
  final String dateRentPay;
  final String dateCapitalPay;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    const int backgroudDark = 0xff222222;
    const int backgroudLight = 0xffF8F8F8;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    const int initPointDark = 0xffBDE1FD;
    const int initPointLight = 0xffBDE1FD;
    const int initPointIconDark = 0xffBDE1FD;
    const int initPointIconLight = 0xff0D3A5C;
    const int endPointDark = 0xffDFD7FF;
    const int endPointLight = 0xffDFD7FF;
    const int endPointIconDark = 0xff9C84FE;
    const int endPointIconLight = 0xff9C84FE;

    void onPressed() {
      showPayModal(context);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroudDark)
            : const Color(backgroudLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(initPointDark)
                                    : const Color(initPointLight),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                                color: isDarkMode
                                    ? const Color(initPointIconDark)
                                    : const Color(initPointIconLight),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const TextPoppins(
                              text: "Inicio",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            TextPoppins(
                              text: dateStart,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(endPointDark)
                                    : const Color(endPointLight),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                                color: isDarkMode
                                    ? const Color(endPointIconDark)
                                    : const Color(endPointIconLight),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const TextPoppins(
                              text: "Finaliza",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            TextPoppins(
                              text: dateEnd,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    Icons.help_outline,
                    size: 25,
                    color: isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 5),
                const TextPoppins(
                  text: "Fecha de pago de ",
                  fontSize: 9,
                ),
                const TextPoppins(
                  text: "rentabilidad final",
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextPoppins(
                  text: dateRentPay,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 5),
                const TextPoppins(
                  text: "Fecha de pago de ",
                  fontSize: 9,
                ),
                const TextPoppins(
                  text: "capital",
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextPoppins(
                  text: dateCapitalPay,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
