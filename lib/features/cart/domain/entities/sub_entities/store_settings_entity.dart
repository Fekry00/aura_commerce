class StoreSettingsEntity {
  const StoreSettingsEntity({
    required this.deliveryFee,
    required this.vatPercentage,
    required this.storeName,
  });

  final double deliveryFee;
  final double vatPercentage;
  final String storeName;
}
