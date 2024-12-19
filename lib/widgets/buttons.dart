import 'package:finniu/infrastructure/models/bottom_menu.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomButton extends ConsumerStatefulWidget {
  final int? colorBackground;
  final int? colorText;
  final String text;
  final String pushName;
  final String? image;
  final double width;
  final double height;
  final Color? imageColor;

  const CustomButton({
    super.key,
    required this.text,
    this.colorBackground,
    this.colorText,
    this.pushName = "",
    this.width = 224,
    this.height = 50,
    this.image,
    this.imageColor,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends ConsumerState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Color colorBackground;
    if (widget.colorBackground == null) {
      colorBackground = Theme.of(context)
          .textButtonTheme
          .style!
          .backgroundColor!
          .resolve({MaterialState.pressed})!;
    } else {
      colorBackground = Color(widget.colorBackground!);
    }

    Color textColor;
    if (widget.colorText == null) {
      textColor = Theme.of(context)
          .textButtonTheme
          .style!
          .foregroundColor!
          .resolve({MaterialState.pressed})!;
    } else {
      textColor = Color(widget.colorText!);
    }

    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(widget.width, widget.height),
        backgroundColor: colorBackground,
        foregroundColor: textColor,
      ),
      onPressed: () {
        if (widget.pushName != "") {
          Navigator.pushNamed(context, widget.pushName);
        }
      },
      child: widget.image != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text),
                const SizedBox(width: 10),
                Image.asset(
                  widget.image!,
                  width: 20,
                  height: 20,
                  color: widget.imageColor,
                ),
              ],
            )
          : Text(widget.text),
    );
  }
}

class CustomReturnButton extends ConsumerWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton({
    super.key,
    this.colorBoxdecoration = primaryDark,
    this.colorIcon = primaryLight,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/v4/home', (route) => false);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(
            currentTheme.isDarkMode ? (primaryLight) : (primaryDark),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Color(
              currentTheme.isDarkMode ? (primaryDark) : (primaryLight),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonRoundedDark extends ConsumerWidget {
  final String? pushName;
  final Color? color;
  final void Function()? onTap;

  const CustomButtonRoundedDark({
    super.key,
    this.pushName = "",
    this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = this.color ?? const Color(primaryDark);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: onTap ??
          () {
            if (pushName != "") {
              Navigator.pushNamed(context, pushName!);
            }
          },

      // onTap: () {
      //   if (pushName != "") {
      //     Navigator.pushNamed(context, pushName);
      //   }

      child: Container(
        margin: const EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 28.67,
        height: 28.67,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.transparent,
          border: Border.all(color: color),
        ),
        child: Center(
          child: Icon(
            size: 20,
            color: color,
            Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarHome extends HookConsumerWidget {
  const BottomNavigationBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: HookBuilder(
        builder: (context) {
          final selectedIndex = ref.watch(navigatorStateProvider);
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(isDarkMode ? primaryLight : primaryDark),
              selectedItemColor: Color(isDarkMode ? primaryDark : primaryLight),
              unselectedItemColor:
                  Color(isDarkMode ? primaryDark : primaryLight)
                      .withOpacity(0.6),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: selectedIndex,
              onTap: (index) {
                ref.read(navigatorStateProvider.notifier).state = index;
                // avoid navigation to the same screen
                if (selectedIndex == index) return;

                _navigate(context, index);
              },
              items: [
                BottomNavigationBarItem(
                  label: BottomMenuEnum().home.label,
                  icon: _buildIcon(
                    BottomMenuEnum().home.icon,
                    context,
                    selectedIndex,
                    BottomMenuEnum().home.index,
                    isDarkMode,
                  ),
                ),
                BottomNavigationBarItem(
                  label: BottomMenuEnum().plans.label,
                  icon: _buildIcon(
                    BottomMenuEnum().plans.icon,
                    context,
                    selectedIndex,
                    BottomMenuEnum().plans.index,
                    isDarkMode,
                  ),
                ),
                BottomNavigationBarItem(
                  label: BottomMenuEnum().investments.label,
                  icon: _buildIcon(
                    BottomMenuEnum().investments.icon,
                    context,
                    selectedIndex,
                    BottomMenuEnum().investments.index,
                    isDarkMode,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home_home', (route) => false);
        break;
      case 1:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/plan_list', (route) => false);
        break;
      case 2:
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/process_investment', (route) => false);
        break;
      default:
    }
  }

  Widget _buildIcon(String imagePath, BuildContext context, int selectedIndex,
      int index, bool isDarkMode) {
    Color iconColor =
        isDarkMode ? const Color(primaryDark) : const Color(primaryLight);
    final isSelected = selectedIndex == index;
    iconColor = isSelected ? iconColor : iconColor.withOpacity(0.6);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Image.asset(
        imagePath,
        width: 30,
        height: 30,
        color: iconColor,
      ),
    );
  }
}
