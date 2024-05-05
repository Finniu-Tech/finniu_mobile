import 'package:finniu/infrastructure/datasources/ubigeo_imp.dart';
import 'package:finniu/infrastructure/repositories/ubigeo_repository_imp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ubigeoRepositoryProvider = Provider<UbigeoRepositoryImp>(
  (ref) => UbigeoRepositoryImp(
    UbigeoDataSourceImp(),
  ),
);
