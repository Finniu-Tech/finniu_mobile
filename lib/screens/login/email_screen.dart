import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              // padding: EdgeInsets.all(6),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(primary_dark),
              ),
              child: Center(
                  child: Icon(
                size: 20,
                color: Color(primary_light),
                Icons.arrow_back_ios_new_outlined,
              )),
              // child: GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
            ),
          )),
      body: Center(
        // padding: EdgeInsets.all(10),
        // margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 224,
              height: 143,
              child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/logo_finniu_light.png",
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('¡Bienvenido a Finniu!',
                  style: TextStyle(
                    color: Color(primary_dark),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
            ),
            SizedBox(height: 25),
            Container(
              width: 224,
              // height: 150,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Ingresa a tu cuenta',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    onChanged: (value) {
                      var email = value;
                    },
                    decoration: InputDecoration(hintText: "Correo electrónico"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      var email = value;
                    },
                    decoration: InputDecoration(hintText: "Constraseña"),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login_email');
                    },
                    child: Container(
                      // padding: EdgeInsets.all(5),
                      // width: 230,
                      // height: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(primary_dark),
                      ),
                      child: Center(
                          child: Text(
                        'Ingresar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
