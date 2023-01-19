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
          leading: Container(
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primary_dark),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back,
                  )),
                ),
              ))),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
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
            Text('¡Bienvenido a Finniu!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(primary_dark),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                )),
            SizedBox(height: 30),
            Text('Ingresa a tu cuenta',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            TextField(
              onChanged: (value) {
                var email = value;
              },
              decoration: InputDecoration(hintText: "Correo electrónico"),
            ),
            Stack(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    var email = value;
                  },
                  decoration: InputDecoration(hintText: "Constraseña"),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // code to toggle obscureText
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login_email');
                },
                child: Container(
                  width: 230,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
