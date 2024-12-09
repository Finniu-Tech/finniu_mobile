import 'package:flutter/material.dart';

enum DocumentType { contract, tax, report }

class Document {
  final String title;
  final String date;
  final String downloadUrl;
  final DocumentType type;

  Document({
    required this.title,
    required this.date,
    required this.downloadUrl,
    required this.type,
  });

  get getIcon {
    switch (type) {
      case DocumentType.contract:
        return Icons.edit_document;
      case DocumentType.tax:
        return Icons.percent;
      case DocumentType.report:
        return Icons.bar_chart;
    }
  }
}

class UserDocuments {
  final List<Document> contractList;
  final List<Document> taxList;
  final List<Document> reportList;

  UserDocuments({
    required this.contractList,
    required this.taxList,
    required this.reportList,
  });
}
