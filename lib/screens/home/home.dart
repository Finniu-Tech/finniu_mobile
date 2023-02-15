import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/screens/home/widgets/cards.dart';
import 'package:finniu/screens/home/widgets/modals.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeStart extends StatelessWidget {
  HomeStart({super.key});
  bool show = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (show) {
      showWelcomeModal(context);
    }
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: Container(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: 111,
              height: 82,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  currentTheme.isDarkMode
                      ? "assets/images/logo_finniu_home_dark.png"
                      : "assets/images/logo_finniu_home.png",
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hola, ${userProvider.nickName}!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                SizedBox(
                  child: Container(
                    width: 24,
                    height: 23.84,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home_notification');
                      },
                      child: Container(
                        child: Icon(
                          CupertinoIcons.bell,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    showSettingsDialog(context);
                  },
                  child: SizedBox(
                    width: 41,
                    height: 43,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset('assets/home/avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Multiplica tu dinero con nosotros!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                ),
              ),
            ),
            const CardTable(),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 2,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(primaryDark),
                      width: 0,
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            Stack(
              children: <Widget>[
                Container(
                  height: 147,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(secondary)
                        : const Color(primaryLight),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 147,
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/home/person.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Simula tu inversión aquí",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(primaryDark),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Descubre como simular el",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(grayText2),
                          ),
                        ),
                        Text(
                          "retorno de tu inversión",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(grayText2),
                          ),
                        ),
                        CustomButtonRoundedDark(
                          pushName: "",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
