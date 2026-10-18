enum MilestoneStatus {
  completed,
  active,
  upcoming,
}

class TrackingMilestoneEntity {
  const TrackingMilestoneEntity({
    required this.id,
    required this.title,
    required this.time,
    required this.description,
    required this.status,
  });

  final String id;
  final String title;
  final String time;
  final String description;
  final MilestoneStatus status;
}
