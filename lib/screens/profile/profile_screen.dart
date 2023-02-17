import 'package:email_validator/email_validator.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isHidden = useState(true);
    final showError = useState(false);
    final nickNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

    final _searchTextController = TextEditingController();
    final _multiKey = GlobalKey<DropdownSearchState<String>>();

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    return CustomScaffoldReturn(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 10.0,
                    // header:
                    percent: 0.5,
                    center: const CircleAvatar(
                      radius: 40, // Image radius
                      backgroundImage:
                          AssetImage("assets/images/avatar_alone.png"),
                    ),
                    progressColor: Color(primaryDark),
                    backgroundColor: Color(primaryLight),
                    // fillColor: Color(primaryLight),
                  ),
                  Positioned(
                    left: -62,
                    top: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 67,
                        height: 35,
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(primaryDark),
                          border: Border.all(
                            width: 4,
                            color: Color(0xff295984),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // color: Color(primaryDark),
                        child: Center(
                          child: Text(
                            '50%',
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Completa tus datos',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.5,
                fontSize: 14,
                color: Color(primaryDark),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  hintText: 'Escriba sus nombre completos',
                  label: Text("Nombres completos"),
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
                    return 'Tiene que ser de  dígitos';
                  }
                  return null;
                },
                onChanged: (value) {
                  // phoneController.text = value;
                },
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'Escriba su documento de indentificación',
                  label: Text("Documento de indentifación"),
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 224,
              height: 39,
              child: DropdownSearch<String>(
                selectedItem: 'Lima',
                items: [
                  'Lima',
                  'Ancash',
                  'Loreto',
                  'Junin',
                  'Callao',
                  'Madre de Dios',
                  'Ica',
                  'Puno',
                  'Arequipa'
                ],
                popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    itemBuilder: (context, item, isSelected) => Container(
                          decoration: BoxDecoration(
                            color:
                                Color(isSelected ? primaryDark : primaryLight),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 15, left: 15),
                          child: Text(
                            item.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(isSelected
                                    ? Colors.white.value
                                    : primaryDark),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                    menuProps: const MenuProps(
                      backgroundColor: Color(primaryLightAlternative),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(primaryDark),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                    ),
                    showSearchBox: true,
                    searchFieldProps: const TextFieldProps(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.search),
                        label: Text('Buscar'),
                      ),
                    )),
                dropdownButtonProps: const DropdownButtonProps(
                  color: Color(primaryDark),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 224,
              height: 38,
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

                decoration: const InputDecoration(
                  hintText: 'Escriba su distrito',
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 38,
                    minWidth: 38,
                  ),
                  label: Text(
                    "Distrito",
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
            const SizedBox(height: 15),
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
                decoration: const InputDecoration(
                  hintText: 'Escriba su dirección de domicilio',
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 38,
                    minWidth: 38,
                  ),
                  label: Text(
                    "Dirección de domicilio",
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
            const SizedBox(height: 15),
            SizedBox(
              width: 224,
              height: 38,
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
                decoration: const InputDecoration(
                  hintText: 'Escriba su estado civil',
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 38,
                    minWidth: 38,
                  ),
                  label: Text(
                    "Estado civil",
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
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const CustomButton(
                  text: 'Guardar',
                  colorBackground: primaryDark,
                  colorText: whiteText,
                  pushName: '/home_home'),
            ),
          ],
        ),
      ),
    );
  }
}
