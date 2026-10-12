import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_app_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_bottom_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_delivery_method_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_delivery_notes_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_payment_summary_card.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_privilege_passcode_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_security_assurance.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_shipping_address_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_step_header.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CheckoutBottomBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSpacing.spaceSm),
                    CheckoutStepHeader(),
                    SizedBox(height: AppSpacing.spaceLg),
                    CheckoutShippingAddressSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    CheckoutDeliveryMethodSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    CheckoutDeliveryNotesSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    CheckoutPrivilegePasscodeSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    CheckoutPaymentSummaryCard(),
                    SizedBox(height: AppSpacing.spaceMd),
                    CheckoutSecurityAssurance(),
                    SizedBox(height: AppSpacing.spaceLg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
