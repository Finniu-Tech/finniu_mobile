import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/infrastructure/models/bank_response.dart';

class BankMapper {
  static List<BankEntity> listToEntity(BankResponse responseBanks) {
    return responseBanks.banks!
        .map(
          (bank) => BankEntity(
            uuid: bank.uuid ?? '',
            name: bank.bankName ?? '',
            isActive: bank.isActive ?? false,
            logoUrl: bank.bankLogo ?? '',
            cardImageUrl: bank.bankImageCard ?? '',
          ),
        )
        .toList();
  }
}
