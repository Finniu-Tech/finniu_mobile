import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:flutter/material.dart';

List<SnackBarContainerV2> validateInputs({
  required BuildContext context,
  required bool isJointAccount,
  required bool personalAccountDeclaration,
  required TextEditingController accountTypeController,
  required TextEditingController bankController,
  required TextEditingController accountNumberController,
  required TextEditingController cciNumberController,
  required TextEditingController accountNameController,
  required TextEditingController jointHolderNameController,
  required TextEditingController jointHolderLastNameController,
  required TextEditingController jointHolderMothersLastNameController,
  required TextEditingController jointHolderDocTypeController,
  required TextEditingController jointHolderDocNumberController,
}) {
  List<SnackBarContainerV2> result = [];
  if (bankController.text.isEmpty) {
    result.add(
      const SnackBarContainerV2(
        title: "Debe seleccionar un banco",
        message: "Debe seleccionar un banco",
        snackType: SnackType.warning,
      ),
    );
  }
  if (accountTypeController.text.isEmpty) {
    result.add(
      const SnackBarContainerV2(
        title: "Debe seleccionar un tipo de cuenta",
        message: "Debe seleccionar un tipo de cuenta",
        snackType: SnackType.warning,
      ),
    );
  }
  if (accountNumberController.text.isEmpty) {
    result.add(
      const SnackBarContainerV2(
        title: "Debe ingresar un número de cuenta",
        message: "Debe ingresar un número de cuenta",
        snackType: SnackType.warning,
      ),
    );
  }
  if (cciNumberController.text.isEmpty) {
    result.add(
      const SnackBarContainerV2(
        title: "Debe ingresar un número de cuenta interbancaria",
        message: "Debe ingresar un número de cuenta interbancaria",
        snackType: SnackType.warning,
      ),
    );
  }

  if (accountTypeController.text == 'Mancomunada' && isJointAccount == false) {
    result.add(
      const SnackBarContainerV2(
        title: "Debe completar los datos de la cuenta mancomunada",
        message: "Debe completar los datos de la cuenta mancomunada",
        snackType: SnackType.warning,
      ),
    );
  }
  if (isJointAccount) {
    if (jointHolderNameController.text.isEmpty) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe ingresar el nombre del titular",
          message: "Debe ingresar el nombre del titular",
          snackType: SnackType.warning,
        ),
      );
    }
    if (jointHolderLastNameController.text.isEmpty) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe ingresar el apellido paterno del titular",
          message: "Debe ingresar el apellido paterno del titular",
          snackType: SnackType.warning,
        ),
      );
    }
    if (jointHolderMothersLastNameController.text.isEmpty) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe ingresar el apellido materno del titular",
          message: "Debe ingresar el apellido materno del titular",
          snackType: SnackType.warning,
        ),
      );
    }
    if (jointHolderDocTypeController.text.isEmpty) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe seleccionar un tipo de documento",
          message: "Debe seleccionar un tipo de documento",
          snackType: SnackType.warning,
        ),
      );
    }
    if (jointHolderDocNumberController.text.isEmpty) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe ingresar el número de documento",
          message: "Debe ingresar el número de documento",
          snackType: SnackType.warning,
        ),
      );
    }
    if (jointHolderDocTypeController.text == 'DNI' && jointHolderDocNumberController.text.length != 8) {
      result.add(
        const SnackBarContainerV2(
          title: "El DNI debe tener 8 dígitos",
          message: "El DNI debe tener 8 dígitos",
          snackType: SnackType.warning,
        ),
      );
    } else {
      if (jointHolderDocTypeController.text == 'Carnet de Extranjería' &&
          jointHolderDocNumberController.text.length != 20) {
        result.add(
          const SnackBarContainerV2(
            title: "El Carnet de Extranjería debe tener 20 dígitos",
            message: "El Carnet de Extranjería debe tener 20 dígitos",
            snackType: SnackType.warning,
          ),
        );
      }
    }
  }
  if (!isJointAccount) {
    if (!personalAccountDeclaration) {
      result.add(
        const SnackBarContainerV2(
          title: "Debe declarar que es su cuenta personal",
          message: "Debe declarar que es su cuenta personal",
          snackType: SnackType.warning,
        ),
      );
    }
  }

  return result;
}
