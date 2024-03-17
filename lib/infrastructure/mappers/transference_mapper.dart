import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:finniu/infrastructure/models/transference_response.dart';

class TransferenceMapper {
  static List<TransferenceEntity> listToEntity(UserGetBoucherResponse response) {
    return response.userGetBouchers
            ?.map(
              (transference) => TransferenceEntity(
                planName: transference.plan?.name ?? '',
                date: transference.dateSended ?? DateTime.now(),
                urlVoucher: transference.boucherImage ?? '',
              ),
            )
            .toList() ??
        [];
  }
}
