import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/transference_entity.dart';
import 'package:finniu/infrastructure/models/dead_line_response.dart';
import 'package:finniu/infrastructure/models/transference_response.dart';

class TransferenceMapper {
  static List<TransferenceEntity> listToEntity(
      UserGetBoucherResponse response) {
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
  // static List<DeadLineEntity> listToEntity(DeadLineResponse response) {
  //   return response.deadlines!
  //       .map(
  //         (deadLine) => DeadLineEntity(
  //           uuid: deadLine.uuid ?? '',
  //           name: deadLine.name ?? '',
  //           description: deadLine.description ?? '',
  //           value: deadLine.value ?? 0,
  //           isActive: deadLine.isActive ?? false,
  //         ),
  //       )
  //       .toList();
  // }
}
