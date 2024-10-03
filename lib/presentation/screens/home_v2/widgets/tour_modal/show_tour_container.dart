import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/show_tour.dart';
import 'package:flutter/material.dart';

class ShowTourContainer extends StatefulWidget {
  const ShowTourContainer({
    super.key,
  });

  @override
  State<ShowTourContainer> createState() => _ShowTourContainerState();
}

class _ShowTourContainerState extends State<ShowTourContainer> {
  final int backgroundColor = 0xff08273F;
  final int textColor = 0xffFFFFFF;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isShow) {
          setState(() {
            isShow = !isShow;
          });
        } else {
          showTourV2(context);
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
                    text: "Conóce lo nuevo",
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
