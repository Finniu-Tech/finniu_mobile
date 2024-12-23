import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/widget/show_tour_v4.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';

class SeeLaterWidgetV4 extends StatefulWidget {
  const SeeLaterWidgetV4({
    super.key,
  });

  @override
  State<SeeLaterWidgetV4> createState() => _SeeLaterWidgetV4State();
}

class _SeeLaterWidgetV4State extends State<SeeLaterWidgetV4> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Preferences.tourHomeNotifier,
      builder: (context, tourHome, child) {
        return tourHome ? const ShowTourContainerV4() : const SizedBox();
      },
    );
  }
}

class ShowTourContainerV4 extends StatefulWidget {
  const ShowTourContainerV4({
    super.key,
  });

  @override
  State<ShowTourContainerV4> createState() => _ShowTourContainerState();
}

class _ShowTourContainerState extends State<ShowTourContainerV4> {
  final int backgroundColor = 0xff08273F;
  final int textColor = 0xffFFFFFF;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isShow) {
          setState(() {
            isShow = !isShow;
          });
        } else {
          showTourV4(context);
          setState(() {
            isShow = !isShow;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: isShow ? 197 : 70,
        height: 56,
        decoration: BoxDecoration(
          color: Color(backgroundColor),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: ClipRect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              const TextPoppins(
                text: "📲",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                align: TextAlign.center,
              ),
              const SizedBox(width: 10),
              if (isShow)
                Flexible(
                  child: TextPoppins(
                    text: "Conoce lo nuevo",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textLight: textColor,
                    textDark: textColor,
                    align: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
