import 'package:finniu/infrastructure/datasources/notifications_datasource_imp.dart';
import 'package:finniu/infrastructure/models/notifications_entity.dart';
import 'package:finniu/main.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/notifications/widgets/app_bar_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffFFFFFF;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
      appBar: const AppBarNotificationsScreen(),
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
    final notificationDataSource = NotificationsDataSource(baseUrl: appConfig.notificationsBaseUrl);
    final userProfile = ref.watch(userProfileNotifierProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      child: FutureBuilder<List<NotificationModel>>(
        future: notificationDataSource.getNotifications(userId: userProfile.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay notificaciones'));
          }

          final notifications = snapshot.data!;
          final groupedNotifications = _groupNotifications(notifications);

          return ListView.builder(
            itemCount: groupedNotifications.length,
            itemBuilder: (context, index) {
              final group = groupedNotifications[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      group.dateLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ...group.notifications
                      .map(
                        (notification) => _NotificationsColumn(
                          textTitle: notification.title,
                          textBody: notification.body,
                          textDay: group.dateLabel,
                          icon: Icons.notifications_none_outlined,
                        ),
                      )
                      .toList(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<NotificationGroup> _groupNotifications(List<NotificationModel> notifications) {
    final now = DateTime.now();
    final groups = <NotificationGroup>[];

    // Ordenar por fecha más reciente
    notifications.sort((a, b) => b.creationDate.compareTo(a.creationDate));

    for (var notification in notifications) {
      final date = notification.creationDate;
      String dateLabel;

      if (date.year == now.year && date.month == now.month && date.day == now.day) {
        dateLabel = 'Hoy';
      } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
        dateLabel = 'Ayer';
      } else {
        dateLabel = DateFormat('dd/MM/yyyy').format(date);
      }

      final existingGroup = groups.firstWhere(
        (group) => group.dateLabel == dateLabel,
        orElse: () {
          final newGroup = NotificationGroup(dateLabel: dateLabel, notifications: []);
          groups.add(newGroup);
          return newGroup;
        },
      );

      existingGroup.notifications.add(notification);
    }

    return groups;
  }
}

class NotificationGroup {
  final String dateLabel;
  final List<NotificationModel> notifications;

  NotificationGroup({required this.dateLabel, required this.notifications});
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
        // const SizedBox(height: 5),
        // TextPoppins(
        //   text: textDay,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w500,
        // ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
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
                color: isDarkMode ? const Color(titleDark) : const Color(titleLight),
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
                      fontWeight: FontWeight.w500,
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
