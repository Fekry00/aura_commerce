import 'package:aura/features/home/domain/entities/sub_entities/curated_drop_entity.dart';

class CuratedDropModel extends CuratedDropEntity {
  const CuratedDropModel({
    required super.id,
    required super.label,
    required super.endTime,
  });

  factory CuratedDropModel.fromJson(Map<String, dynamic> json) {
    final rawEndTime = (json['end_time'] ?? json['endTime']) as String?;
    return CuratedDropModel(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? '',
      endTime: rawEndTime != null
          ? DateTime.tryParse(rawEndTime) ??
                DateTime.now().add(const Duration(hours: 8, minutes: 24))
          : DateTime.now().add(const Duration(hours: 8, minutes: 24)),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'label': label, 'end_time': endTime.toIso8601String()};
  }
}
