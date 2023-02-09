import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/cardtable.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class HomeStart extends StatefulWidget {
  const HomeStart({super.key});

  @override
  State<HomeStart> createState() => _HomeStartState();
}

class _HomeStartState extends State<HomeStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset('assets/images/logo_finniu_home.png'),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Hola,Mari!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(blackText),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              SizedBox(
                child: Container(
                  width: 24,
                  height: 23.84,
                  child: Icon(Icons.notifications_active),
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 41,
                height: 43,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/home/avatar.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Multiplica tu dinero con nosotros!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(primaryDark),
                ),
              ),
            ),
          ),
          CardTable(),
          Container(
              width: 310.0,
              height: 1,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(primaryDark),
                    width: 2,
                  ),
                ),
              )),
        ]),
      )),
    );
  }
}
