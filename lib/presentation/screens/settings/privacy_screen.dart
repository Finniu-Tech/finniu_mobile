import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/datasources/change_password_logued_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/settings/widgets.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final oldPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final isHideOldPassword = useState(true);
    final isHideNewPassword = useState(true);

    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
      hideReturnButton: false,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 700, minWidth: 400, maxHeight: 1000, minHeight: 825),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Image.asset(
                      'assets/privacy/privacy.png',
                    ),
                    // SizedBox(width: 10),
                    Text(
                      "Privacidad",
                      style: TextStyle(
                          fontSize: 24,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 46.48,
                          height: 34.87,
                          decoration: BoxDecoration(
                            color: const Color(primaryDark),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const IconContainer(
                            image: 'assets/privacy/key.png',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contraseñas",
                            style: TextStyle(
                                fontSize: 14,
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(gradient_secondary_option),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Visualizacion de contraseña",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Spacer(),
                      const SizedBox(width: 5),
                      FlutterSwitch(
                        width: 29,
                        height: 16,
                        value: Preferences.isDarkMode,
                        inactiveColor: const Color(primaryDark),
                        activeColor: const Color(primaryLight),
                        inactiveToggleColor: const Color(primaryLight),
                        activeToggleColor: const Color(primaryDark),
                        onToggle: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 184,
                        child: Text(
                          "Mostrar caracteres brevemente mientras escribes",
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(blackText),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Cambio de contraseña",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 241,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: currentTheme.isDarkMode
                          ? const Color(colorblacklight)
                          : const Color(grayText3),
                    ),
                    child: TextFormField(
                      controller: oldPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este dato es requerido';
                        }

                        return null;
                      },
                      // onChanged: (value) {
                      //   // emailController.text = value.toString();
                      // },
                      autocorrect: false,
                      obscureText:
                          isHideOldPassword.value, // esto oculta la contrasenia
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: 'Escriba su contraseña actual',
                        hintStyle: TextStyle(
                          fontSize: 10,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                        ),
                        label: const Text('Contraseña actual'),
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isHideOldPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 23.20,
                          ),
                          alignment: Alignment.center,
                          onPressed: () {
                            isHideOldPassword.value = !isHideOldPassword.value;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 241,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: currentTheme.isDarkMode
                          ? const Color(colorblacklight)
                          : const Color(grayText3),
                    ),
                    child: TextFormField(
                      controller: newPasswordController,
                      obscureText:
                          isHideNewPassword.value, // esto oculta la contrasenia
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este dato es requerido';
                        }
                        return null;
                      },
                      // onChanged: (value) {
                      //   // emailController.text = value.toString();
                      // },
                      decoration: InputDecoration(
                        hintText: 'Escriba su nueva contraseña',
                        hintStyle: TextStyle(
                            fontSize: 10,
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(blackText)),
                        labelText: 'Nueva contraseña',
                        labelStyle: TextStyle(
                          fontSize: 10,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(blackText),
                        ),
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isHideNewPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 23.20,
                          ),
                          alignment: Alignment.center,
                          onPressed: () {
                            isHideNewPassword.value = !isHideNewPassword.value;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextButton(
                    onPressed: () async {
                      if (newPasswordController.text.isEmpty ||
                          oldPasswordController.text.isEmpty) {
                        CustomSnackbar.show(
                          context,
                          'No puede tener campos en blanco',
                          'error',
                        );
                      }
                      final success = await ChangePasswordLoguedDataSourceImp()
                          .changePasswordLogued(
                        client: ref.watch(gqlClientProvider).value!,
                        newPassword: newPasswordController.text,
                        oldPassword: oldPasswordController.text,
                      );
                      if (success) {
                        CustomSnackbar.show(
                          context,
                          'Contraseña cambiada con éxito',
                          'success',
                        );
                      } else {
                        CustomSnackbar.show(
                          context,
                          'No se pudo cambiar la contraseña',
                          'error',
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                    ),
                    child: Text(
                      "Confirmar",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.all(0.0),
                  //     child: Column(children: [

                  // Padding(
                  //   padding: const EdgeInsets.all(22.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: 46.48,
                  //         height: 34.87,
                  //         decoration: BoxDecoration(
                  //           color: Color(primaryDark),
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         child: IconContainer(
                  //           image: 'assets/privacy/lock-circle.png',
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text("Administrador de permisos",
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               color: currentTheme.isDarkMode
                  //                   ? const Color(whiteText)
                  //                   : const Color(blackText),
                  //               fontWeight: FontWeight.bold)),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height: 3,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       bottom: BorderSide(
                  //         color: currentTheme.isDarkMode
                  //             ? const Color(primaryLight)
                  //             : const Color(gradient_secondary_option),
                  //         width: 2,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Permiso de ubicacion actual",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 12,
                  //         color: currentTheme.isDarkMode
                  //             ? const Color(whiteText)
                  //             : const Color(blackText),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 25,
                  //     ),
                  //     const Spacer(),
                  //     const SizedBox(width: 5),
                  //     FlutterSwitch(
                  //       width: 29,
                  //       height: 16,
                  //       value: Preferences.isDarkMode,
                  //       inactiveColor: const Color(primaryDark),
                  //       activeColor: const Color(primaryLight),
                  //       inactiveToggleColor: const Color(primaryLight),
                  //       activeToggleColor: const Color(primaryDark),
                  //       onToggle: (value) {},
                  //     ),
                  //   ],
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,
                  //       width: 184,
                  //       child: Text(
                  //         "Permiso tu ubicacion actual mientras la app esta en uso",
                  //         style: TextStyle(
                  //           fontSize: 10,
                  //           color: currentTheme.isDarkMode
                  //               ? const Color(whiteText)
                  //               : const Color(blackText),
                  //           height: 1.5,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Permiso de acceso a tu galeria",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 12,
                  //         color: currentTheme.isDarkMode
                  //             ? const Color(whiteText)
                  //             : const Color(blackText),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 25,
                  //     ),
                  //     const Spacer(),
                  //     const SizedBox(width: 5),
                  //     FlutterSwitch(
                  //       width: 29,
                  //       height: 16,
                  //       value: Preferences.isDarkMode,
                  //       inactiveColor: const Color(primaryDark),
                  //       activeColor: const Color(primaryLight),
                  //       inactiveToggleColor: const Color(primaryLight),
                  //       activeToggleColor: const Color(primaryDark),
                  //       onToggle: (value) {},
                  //     ),
                  //   ],
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,
                  //       width: 184,
                  //       child: Text(
                  //         "Visualizar directamente tus fotos de tu galeria mientras la app esta en uso ",
                  //         style: TextStyle(
                  //           fontSize: 10,
                  //           color: currentTheme.isDarkMode
                  //               ? const Color(whiteText)
                  //               : const Color(blackText),
                  //           height: 1.5,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Solicitar eliminación de cuenta ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Ten en cuenta que esta solicitud eliminará todos tus datos del sistema",
                        style: TextStyle(
                          fontSize: 10,
                          color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      launch('https://finniu.com/cerrar_cuenta/');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(99,
                            35), // Especifica el ancho y alto deseados del botón
                      ),
                    ),
                    child: const Text(
                      'Eliminar ',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
