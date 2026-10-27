import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_nft_certificate_sheet.dart';
import 'package:flutter/material.dart';

class OrderTrackingController {
  const OrderTrackingController();

  void onCallCourier(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Dialing Marcus Vance direct line (+1 555-0192)...',
      type: SnackBarType.success,
    );
  }

  void onMessageCourier(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Opening encrypted thread with Marcus Vance...',
      type: SnackBarType.success,
    );
  }

  void onInspectCertificate(BuildContext context) {
    TrackingNftCertificateSheet.show(context);
  }

  void onDownloadInvoice(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Generating cryptographically signed invoice PDF...',
      type: SnackBarType.info,
    );
  }

  void onConciergeAssist(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Connecting to Aura 24/7 Private Concierge Desk...',
      type: SnackBarType.info,
    );
  }
}
