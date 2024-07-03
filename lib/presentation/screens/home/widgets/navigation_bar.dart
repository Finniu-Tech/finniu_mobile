import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationBarHome extends ConsumerWidget {
  const NavigationBarHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigatorStateProvider);

    void navigate(BuildContext context, int index) {
      switch (index) {
        case 0:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_home', (route) => false);
          break;
        case 1:
          ref.read(navigatorStateProvider.notifier).state = 1;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/plan_list', (route) => false);
          break;
        case 2:
          ref.read(navigatorStateProvider.notifier).state = 2;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/process_investment', (route) => false);
          break;
        default:
          ref.read(navigatorStateProvider.notifier).state = 0;
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home_home', (route) => false);
      }
    }

    return Container(
      height: 95,
      decoration: const BoxDecoration(
        color: Color(backgroundColorNavbar),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(primaryDark),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationButton(
                icon: Icons.home,
                title: 'Home',
                onTap: () => navigate(context, 0),
                isSelected: selectedIndex == 0 ? true : false,
              ),
              NavigationButton(
                icon: Icons.monetization_on_outlined,
                title: 'Planes',
                onTap: () => navigate(context, 1),
                isSelected: selectedIndex == 1 ? true : false,
              ),
              NavigationButton(
                icon: Icons.bar_chart,
                title: 'Invesión',
                onTap: () => navigate(context, 2),
                isSelected: selectedIndex == 2 ? true : false,
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
            ? const Color(backgroundColorNavbar)
            : const Color(primaryDark),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: widget.onTap,
            icon: Column(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? const Color(gradient_primary)
                      : const Color(colorIconlight),
                ),
                widget.isSelected
                    ? Text(
                        widget.title,
                        style: const TextStyle(
                          color: Color(primaryLight),
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
