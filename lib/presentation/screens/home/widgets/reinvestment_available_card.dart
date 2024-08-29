import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/user_notification_provider.dart';
import 'package:finniu/presentation/screens/investment_status/widgets/reinvestment_question_modal.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:finniu/domain/entities/user_notification_entity.dart';

class ReinvestmentSlider extends HookConsumerWidget {
  final bool? isV2;
  const ReinvestmentSlider({super.key, this.isV2});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final asyncNotifications = ref.watch(userNotificationProvider);

    return asyncNotifications.when(
      data: (notifications) {
        if (notifications.isEmpty) {
          return const SizedBox();
        }
        final items = notifications.map((notification) {
          return ReinvestmentAvailableCard(notification: notification, isV2: isV2);
        }).toList();

        return SizedBox(
          height: 150,
          child: Column(
            children: [
              CarouselSlider(
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return item;
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 120,
                  autoPlay: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => {}, // Aquí puedes implementar la lógica para cambiar de slide al tocar un dot
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                            .withOpacity(currentIndex.value == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      // error: (error, stackTrace) => Text('Error: $error' + stackTrace.toString()), //TODO remove this
      error: (error, stack) => Visibility(
        visible: false,
        child: Container(),
      ),
    );
  }
}

class ReinvestmentAvailableCard extends ConsumerWidget {
  final UserNotificationEntity notification;
  final bool? isV2;

  const ReinvestmentAvailableCard({super.key, required this.notification, this.isV2});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 109,
      width: 333,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            notification.gradient?.startColor ?? const Color(0xffffeedd),
            notification.gradient?.endColor ?? const Color(0xffdbf7ff),
          ],
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 67,
            height: 60,
            child: Image.network(notification.imageURL ?? 'assets/home/money_and_dollars.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(primaryDark),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (notification.type == TypeUserNotificationEnum.REINVESTMENT) ...[
            CustomButtonRoundedDark(
              onTap: isV2 == true
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/v2/investment',
                        arguments: {'reinvest': true},
                      );
                    }
                  : () async {
                      {
                        final preInvestmentUUID = notification.metaData?.preinvestmentUUID ?? '';
                        final amount = notification.metaData?.amount ?? 0;
                        final currency = notification.metaData?.currency ?? 'PEN'; //PEN or USD
                        reinvestmentQuestionModal(context, ref, preInvestmentUUID, amount, currency);
                      }
                    },
            ),
          ],
        ],
      ),
    );
  }
}
