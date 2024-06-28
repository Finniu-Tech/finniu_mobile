import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationBarHome extends ConsumerWidget {
  const NavigationBarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 95,
      decoration: const BoxDecoration(
        color: Color(0xff08273F),
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Color(primaryLight),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff0D3A5C),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationButton(
                icon: Icons.home,
                title: 'Home',
                onTap: () {},
                isSelected: true,
              ),
              NavigationButton(
                icon: Icons.monetization_on_outlined,
                title: 'Home',
                onTap: () {},
                isSelected: false,
              ),
              NavigationButton(
                icon: Icons.bar_chart,
                title: 'Home',
                onTap: () {},
                isSelected: false,
              ),
              const ProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function() onTap;
  final bool isSelected;

  const NavigationButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        color: widget.isSelected
            ? const Color(0xff08273F)
            : const Color(0xff0D3A5C),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Column(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? const Color(0xffA2E6FA)
                      : const Color(0xff4C8DBE),
                ),
                widget.isSelected
                    ? Text(
                        widget.title,
                        style: const TextStyle(
                          color: Color(0xffA2E6FA),
                          fontSize: 9,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
