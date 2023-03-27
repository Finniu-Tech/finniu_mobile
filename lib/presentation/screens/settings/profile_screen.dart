import 'dart:io';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/ubigeo.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/ubigeo_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends HookConsumerWidget {
  final fieldValues = <String, dynamic>{
    'names': null,
    'docNumber': null,
    'department': null,
    'district': null,
    'address': null,
    'civilState': null,
  };
  final ImagePicker _picker = ImagePicker();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeProvider = Provider.of<SettingsProvider>(context, listen: false);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final showError = useState(false);
    final namesController = useTextEditingController();
    final docNumberController = useTextEditingController();
    final departmentController = useTextEditingController();
    final provinceController = useTextEditingController();
    final districtController = useTextEditingController();
    final addressController = useTextEditingController();
    final civilStateController = useTextEditingController();

    final regionsFuture = ref.watch(regionsFutureProvider.future);
    final allProvincesFuture = ref.read(provincesFutureProvider.future);
    final provinces = ref.watch(provincesStateNotifier);
    ref.read(districtsFutureProvider.future);
    final districts = ref.watch(districtsStateNotifier);

    final _formKey = GlobalKey<FormState>();

    final percentage = useState(0.0);
    final percentageString = useState('0%');

    final imageFile = useState('');

    String mapControllerKey(String key) {
      if (key == 'names') {
        return namesController.text;
      } else if (key == 'docNumber') {
        return docNumberController.text;
      } else if (key == 'department') {
        return departmentController.text;
      } else if (key == 'province') {
        return provinceController.text;
      } else if (key == 'district') {
        return districtController.text;
      } else if (key == 'address') {
        return addressController.text;
      } else if (key == 'civilState') {
        return civilStateController.text;
      } else {
        return '';
      }
    }

    void _calculatePercentage(String key) {
      fieldValues[key] = mapControllerKey(key);

      // Count the number of non-empty fields
      int count = fieldValues.values
          .where((value) => value != null && value.toString().isNotEmpty)
          .length;

      // Update the progress bar with the percentage of completed fields
      if (count == 0) {
        percentage.value = 0.0;
      } else {
        percentage.value = (count / 6.0);
      }
      percentageString.value = '${(percentage.value * 100).round()}%';
    }

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircularPercentAvatar(
                          percentage: percentage, imageFile: imageFile),
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
                              color: const Color(primaryDark),
                              border: Border.all(
                                width: 4,
                                color: const Color(0xff295984),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // color: Color(primaryDark),
                            child: Center(
                              child: Text(
                                percentageString.value.toString(),
                                // textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 18,
                        bottom: 25,
                        child: InkWell(
                          onTap: () async {
                            Future<XFile?> ximage =
                                _picker.pickImage(source: ImageSource.gallery);
                            imageFile.value =
                                await ximage.then((value) => value!.path);
                            print('image value is ${imageFile.value}');
                          },
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 224,
                  child: Text(
                    'Completa tus datos',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeProvider.isDarkMode
                          ? Color(primaryLight)
                          : Color(primaryDark),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    controller: namesController,
                    key: const Key('names'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //   _calculatePercentage('names', value);
                    //   // namesController.text = value.toString();
                    // },
                    onEditingComplete: () {
                      _calculatePercentage('names');
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
                    key: const Key('docNumber'),
                    controller: docNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      if (value.length != 9) {
                        return 'Tiene que ser de  dígitos';
                      }
                      return null;
                    },
                    // onChanged: (value) {
                    //   _calculatePercentage('docNumber', value);
                    //   // phoneController.text = value;
                    // },
                    onEditingComplete: () {
                      _calculatePercentage('docNumber');
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),

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
                  child: CustomSelectButton(
                    textEditingController: departmentController,
                    labelText: 'Departamento',
                    asyncItems: (String filter) async {
                      final response = await regionsFuture;
                      return response.map((e) => e.name).toList();
                    },
                    callbackOnChange: (value) async {
                      departmentController.text = value;
                      provinceController.text = '';
                      districtController.text = '';
                      final regions = await regionsFuture;
                      final codeRegion =
                          RegionEntity.getCodeFromName(value, regions);

                      print('code region is $codeRegion');
                      ref
                          .read(provincesStateNotifier.notifier)
                          .filterProvinces(codeRegion);
                      _calculatePercentage('department');
                    },
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: CustomSelectButton(
                    textEditingController: provinceController,
                    labelText: 'Provincia',
                    items: provinces.map((e) => e.name).toList(),
                    callbackOnChange: (value) async {
                      districtController.text = '';
                      final allRegions = await regionsFuture;
                      final allProvinces = await allProvincesFuture;
                      final codeRegion = RegionEntity.getCodeFromName(
                        departmentController.text,
                        allRegions,
                      );
                      print('code province is $codeRegion');
                      final codeProvince = ProvinceEntity.getCodeFromName(
                        value,
                        codeRegion,
                        allProvinces,
                      );
                      print('code province is $codeProvince');
                      ref
                          .read(districtsStateNotifier.notifier)
                          .filterDistricts(codeProvince, codeRegion);
                      _calculatePercentage('province');
                      provinceController.text = value;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: CustomSelectButton(
                    textEditingController: districtController,
                    labelText: 'Distrito',
                    items: districts.map((e) => e.name).toList(),
                    callbackOnChange: (value) {
                      _calculatePercentage('district');
                      districtController.text = value;
                    },
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  // height: 38,
                  child: TextFormField(
                    key: const Key('address'),
                    controller: addressController,
                    onChanged: (value) {
                      _calculatePercentage('address');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
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
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: DropdownSearch<String>(
                    selectedItem: civilStateController.text != ''
                        ? civilStateController.text
                        : null,
                    key: const Key('civilState'),
                    onChanged: (value) {
                      civilStateController.text = value.toString();
                      _calculatePercentage('civilState');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Estado civil',
                      ),
                    ),
                    items: ['Soltero', 'Casado', 'Divorciado', 'Viudo'],
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      itemBuilder: (context, item, isSelected) => Container(
                        decoration: BoxDecoration(
                          color: Color(isSelected ? primaryDark : primaryLight),
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
                            color: Color(
                                isSelected ? Colors.white.value : primaryDark),
                            fontWeight: FontWeight.w500,
                          ),
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
                      ),
                    ),
                    dropdownButtonProps: const DropdownButtonProps(
                      color: Color(primaryDark),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
        ),
      ),
    );
  }
}

class CircularPercentAvatar extends ConsumerWidget {
  const CircularPercentAvatar({
    super.key,
    required this.percentage,
    required this.imageFile,
  });

  final ValueNotifier<double> percentage;
  final ValueNotifier<String> imageFile;

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 10.0,
      circularStrokeCap: CircularStrokeCap.round,

      // startAngle: 45.0,
      // header:
      percent: percentage.value,
      center: CircleAvatar(
        radius: 40, // Image radius
        backgroundImage: imageFile.value != ''
            ? FileImage(
                File(imageFile.value),
              )
            : AssetImage(
                "assets/images/avatar_alone.png",
              ) as ImageProvider,
      ),

      progressColor:
          Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
      backgroundColor:
          Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
      // fillColor: Color(primaryLight),
    );
  }
}
