import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'Syncfusion PDF Viewer Demo',
//       home: ContractViewPDF(),
//     ),
//   );
// }

class ContractViewPDF extends StatefulWidget {
  const ContractViewPDF({super.key});

  @override
  _PdfPage createState() => _PdfPage();
}

class _PdfPage extends State<ContractViewPDF> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String urlContract = args['contractURL'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(backgroundColorDark),
        title: const Text('Contrato Finniu',
            style: TextStyle(
                color: Color(primaryLight), fontWeight: FontWeight.bold)),
        actions: <Widget>[],
      ),
      body: SfPdfViewer.network(
        urlContract,
        key: _pdfViewerKey,
      ),
    );
  }
}
