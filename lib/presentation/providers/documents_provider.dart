import 'package:finniu/domain/entities/document.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final documentsUser = FutureProvider.autoDispose<UserDocuments?>((ref) async {
  try {
    // final client = ref.watch(gqlClientProvider).value;

    // final result = await client!.query(
    //   QueryOptions(
    //     document: gql(
    //       QueryRepository.userInfoAllInvestment,
    //     ),
    //     fetchPolicy: FetchPolicy.noCache,
    //   ),
    // );
    // final data = result.data?['userInfoAllInvestment'];

    // if (data == null) {
    //   return null;
    // }
    // UserInfoAllInvestment user = UserInfoAllInvestment.fromJson(data);
    await Future.delayed(const Duration(seconds: 2), () {});
    final user = UserDocuments(
      contractList: List.generate(
        5,
        (index) => Document(
          title: '#00134$index',
          date: '01/01/2023',
          downloadUrl: 'https://example.com/contract$index.pdf',
          type: DocumentType.contract,
        ),
      ),
      taxList: List.generate(
        5,
        (index) => Document(
          title: '#00134$index',
          date: '01/01/2023',
          downloadUrl: 'https://example.com/contract$index.pdf',
          type: DocumentType.contract,
        ),
      ),
      reportList: List.generate(
        5,
        (index) => Document(
          title: '#00134$index',
          date: '01/01/2023',
          downloadUrl: 'https://example.com/contract$index.pdf',
          type: DocumentType.contract,
        ),
      ),
    );
    return user;
  } catch (e) {
    print(e);
    return null;
  }
});
