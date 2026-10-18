class DeliveryMethodEntity {
  const DeliveryMethodEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.eta,
    required this.price,
    this.vipPill,
    this.originalPrice,
    this.subPrice,
    this.isSelected = false,
  });

  final String id;
  final String title;
  final String description;
  final String eta;
  final String price;
  final String? vipPill;
  final String? originalPrice;
  final String? subPrice;
  final bool isSelected;
}
