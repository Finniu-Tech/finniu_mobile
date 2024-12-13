class Document {
  final String date;
  final String downloadUrl;

  Document({
    required this.date,
    required this.downloadUrl,
  });
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

  factory UserDocuments.fromJson(Map<String, dynamic> json) {
    final documentation = json['documentationQueries'];

    return UserDocuments(
      contractList: (documentation['contracts'] as List<dynamic>)
          .map((e) => Contrat.fromJson(e))
          .toList(),
      taxList: (documentation['taxes'] as List<dynamic>)
          .map((e) => Taxes.fromJson(e))
          .toList(),
      reportList: (documentation['quarterlyReports'] as List<dynamic>)
          .map((e) => Report.fromJson(e))
          .toList(),
    );
  }
}

class Contrat extends Document {
  Contrat({
    required super.date,
    required super.downloadUrl,
  });

  factory Contrat.fromJson(Map<String, dynamic> json) {
    return Contrat(
      date: json['contractDate'],
      downloadUrl: json['contractUrl'],
    );
  }
}

class Taxes extends Document {
  Taxes({
    required super.date,
    required super.downloadUrl,
  });

  factory Taxes.fromJson(Map<String, dynamic> json) {
    return Taxes(
      date: json['taxDate'],
      downloadUrl: json['taxUrl'],
    );
  }
}

class Report extends Document {
  Report({
    required super.date,
    required super.downloadUrl,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      date: json['reportDate'],
      downloadUrl: json['reportUrl'],
    );
  }
}
