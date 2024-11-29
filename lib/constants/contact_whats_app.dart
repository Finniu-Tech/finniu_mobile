import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

void contactWhatsApp() async {
  var whatsappNumber = "51952484612";
  var whatsappMessage = "Hola";
  var whatsappUrlAndroid = Uri.parse(
    "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(whatsappMessage)}",
  );
  var whatsappUrlIphone =
      Uri.parse("https://wa.me/$whatsappNumber?text=$whatsappMessage");

  if (defaultTargetPlatform == TargetPlatform.android) {
    await launchUrl(whatsappUrlAndroid);
  } else {
    await launchUrl(whatsappUrlIphone);
  }
}
