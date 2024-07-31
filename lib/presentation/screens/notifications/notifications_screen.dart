import 'package:finniu/infrastructure/models/notifications_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: _BodyListView(),
        ),
      ),
    );
  }
}

class _BodyListView extends ConsumerWidget {
  const _BodyListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationsDetail> list = [
      NotificationsDetail(
        textTitle: '¡Ya puedes ver tu inversión!',
        textBody:
            'Tu inversión fue validada exitosamente, ingresa a la App de Finniu para ver más a detalle',
        textDay: 'Hoy',
        icon: Icons.notifications_none_outlined,
      ),
      NotificationsDetail(
        textTitle: '¡Ya puedes ver tu inversión!',
        textBody:
            'Tu inversión fue validada exitosamente, ingresa a la App de Finniu para ver más a detalleaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        textDay: 'Ayer',
        icon: Icons.notifications_none_outlined,
      ),
      NotificationsDetail(
        textTitle: '¡Ya puedes ver tu inversión!aaaassaaaaaaaaaaaaaaaaaaaaa',
        textBody:
            'Tu inversión fue validada exitosamente, ingresa a la App de Finniu para ver más a detalle',
        textDay: '29/07',
        icon: Icons.calendar_today_outlined,
      ),
    ];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _NotificationsColumn(
            textTitle: list[index].textTitle,
            textBody: list[index].textBody,
            textDay: list[index].textDay,
            icon: list[index].icon,
          );
        },
      ),
    );
  }
}

class _NotificationsColumn extends ConsumerWidget {
  const _NotificationsColumn({
    required this.textDay,
    required this.icon,
    required this.textTitle,
    required this.textBody,
  });
  final String textDay;
  final String textTitle;
  final String textBody;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1F1F1F;
    const int backgroundLight = 0xffE3F9FF;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TextPoppins(
          text: textDay,
          fontSize: 16,
          isBold: true,
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
          ),
          width: MediaQuery.of(context).size.width,
          height: 94,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 24,
                color: isDarkMode
                    ? const Color(titleDark)
                    : const Color(titleLight),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPoppins(
                      text: textTitle,
                      fontSize: 16,
                      isBold: true,
                      textDark: titleDark,
                      textLight: titleLight,
                    ),
                    TextPoppins(
                      text: textBody,
                      fontSize: 11,
                      lines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
