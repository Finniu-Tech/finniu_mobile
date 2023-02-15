import 'package:email_validator/email_validator.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/models/user.dart';
import 'package:finniu/providers/auth_provider.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpEmailScreen extends HookWidget {
  const SignUpEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String _password = "";
    final isHidden = useState(true);
    final showError = useState(false);
    final nickNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    final registerMutation = useMutation(
      MutationOptions(
        document: gql(
          MutationRepository.getSignUpMutation(),
        ),
        onCompleted: (dynamic data) {
          print('completedd!!!');
          print(data);
          print('success');
          print(data['registerUser']?['success']);
          if (data != null && data['registerUser']?['success'] == true) {
            print('if zero');
            User? user = ScanUserModel.fromJson(data).registerUser?.user;
            UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
            print('email response');
            print(user?.email);
            print('nickName response');
            print(user?.userProfile?.nickName);
            userProvider.email = user?.email;
            userProvider.firstName = user?.userProfile?.firstName;
            userProvider.lastName = user?.userProfile?.lastName;
            // userProvider.picture = user.picture;
            userProvider.phone = int.parse(user?.userProfile?.phoneNumber ?? '0');
            userProvider.nickName = user?.userProfile?.nickName;
            print(user);

            Navigator.of(context).pushNamed('/on_boarding_start');
          } else {
            print('else zero');
            showError.value = true;
            context.loaderOverlay.hide();
          }
        },
        onError: (dynamic error) {
          print('errorrrr!!!');
          print(error);
          showError.value = true;
          context.loaderOverlay.hide();
        },
      ),
    );

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      themeProvider.isDarkMode ? "assets/images/logo_small_dark.png" : "assets/images/logo_small.png",
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 224,
                  // height: 150,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextPoppins(
                          text: 'Crea tu cuenta en Finniu y guarda tus datos',
                          colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const TextPoppins(
                  text: "Elige tu avatar",
                  colorText: grayText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 224,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 145.0,
                      viewportFraction: 0.8,
                    ),
                    items: [
                      'assets/avatars/avatar_1.png',
                      'assets/avatars/avatar_2.png',
                      'assets/avatars/avatar_3.png',
                      'assets/avatars/avatar_4.png',
                      'assets/avatars/avatar_5.png',
                      'assets/avatars/avatar_6.png',
                      'assets/avatars/avatar_7.png',
                      'assets/avatars/avatar_8.png',
                      'assets/avatars/avatar_9.png',
                      'assets/avatars/avatar_10.png',
                      'assets/avatars/avatar_11.png',
                    ].map((imageRoute) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                imageRoute,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    // controller: nickNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      nickNameController.text = value.toString();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escriba su nombre favorito',
                      label: Text("Nombre favorito"),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      if (value.length != 9) {
                        return 'Tiene que ser de 9 dígitos';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // phoneController.text = value;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: 'Escriba su número telefónico',
                      label: Text("Número telefónico"),
                    ),
                  ),
                  // height: 38,
                  // child: ButtonDecoration(
                  //   textHint: 'Escriba su número telefónico',
                  //   textLabel: "Número telefónico",
                  // ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      if (EmailValidator.validate(value) == false) {
                        return 'Ingrese un correo válido';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // emailController.text = value.toString();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escriba su correo electrónico',
                      label: Text('Correo electrónico'),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  // height: 38,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // passwordController.text = value;
                    },
                    obscureText: isHidden.value, // esto oculta la contrasenia
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Digite su contraseña',
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 38,
                        minWidth: 38,
                      ),
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          isHidden.value ? Icons.visibility : Icons.visibility_off,
                          size: 23.20,
                        ),
                        alignment: Alignment.center,
                        onPressed: () {
                          isHidden.value = !isHidden.value;
                        },
                      ),
                      label: const Text(
                        "Contraseña",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                if (showError.value) ...[
                  const Text(
                    'No se pudo completar el registro',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 5),
                SizedBox(
                  width: 224,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/on_boarding_start');
                      if (formKey.currentState!.validate()) {
                        context.loaderOverlay.show();
                        print('email controller');
                        print(emailController.text);
                        registerMutation.runMutation(
                          {
                            "email": emailController.text,
                            "password": passwordController.text,
                            "phone": int.parse(phoneController.text),
                            "nickname": nickNameController.text,
                          },
                        );
                      }
                    },
                    child: Text('Crear registro'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextPoppins(
                    text: '¿Ya tienes una cuenta creada?',
                    colorText: themeProvider.isDarkMode ? whiteText : blackText,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).backgroundColor,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      foregroundColor: themeProvider.isDarkMode ? const Color(skyBlueText) : const Color(primaryDark),
                    ),
                    child: const Text('Iniciar sesión'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_email');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  // void _togglePasswordView() {
  //   setState(() {
  //     _isHidden = !_isHidden;
  //   });
  // }

