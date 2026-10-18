import 'package:aura/features/orders/domain/entities/sub_entities/tracking_milestone_entity.dart';

class TrackingMilestoneModel extends TrackingMilestoneEntity {
  const TrackingMilestoneModel({
    required super.id,
    required super.title,
    required super.time,
    required super.description,
    required super.status,
  });

  factory TrackingMilestoneModel.fromJson(Map<String, dynamic> json) {
    return TrackingMilestoneModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      time: json['time'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: _parseStatus(json['status'] as String?),
    );
  }

  static MilestoneStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return MilestoneStatus.active;
      case 'upcoming':
        return MilestoneStatus.upcoming;
      case 'completed':
      default:
        return MilestoneStatus.completed;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'description': description,
      'status': status.name,
    };
  }
}
