import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/home/presentation/widgets/home_app_bar.dart';
import 'package:aura/features/home/presentation/widgets/home_notifications_sheet.dart';
import 'package:aura/features/home/presentation/widgets/home_search_bar.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({super.key});

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getDeliveryAddressText() {
    final defaultAddress = UserAddressManager.getDefaultAddress();
    return defaultAddress != null
        ? (defaultAddress.address.isNotEmpty
            ? defaultAddress.address
            : defaultAddress.label)
        : 'Manage delivery';
  }

  void _onLocationTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SavedAddressesBottomSheet(),
    );
  }

  void _onNotificationsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const HomeNotificationsSheet(),
    );
  }

  void _onVoiceSearchTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Voice search is coming soon!',
      type: SnackBarType.info,
    );
  }

  void _onFilterTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Opening filter options...',
      type: SnackBarType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeAppBar(
          deliveryText: _getDeliveryAddressText(),
          onLocationTap: () => _onLocationTap(context),
          onNotificationsTap: () => _onNotificationsTap(context),
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        HomeSearchBar(
          controller: _searchController,
          onVoiceSearchTap: () => _onVoiceSearchTap(context),
          onFilterTap: () => _onFilterTap(context),
        ),
      ],
    );
  }
}
