import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/infrastructure/models/dead_line_response.dart';

class DeadLineMapper {
  static List<DeadLineEntity> listToEntity(DeadLineResponse response) {
    return response.deadlines!
        .map(
          (deadLine) => DeadLineEntity(
            uuid: deadLine.uuid ?? '',
            name: deadLine.name ?? '',
            description: deadLine.description ?? '',
            value: deadLine.value ?? 0,
            isActive: deadLine.isActive ?? false,
          ),
        )
        .toList();
  }
}
