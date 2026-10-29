import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_app_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_view_body.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      appBar: CheckoutAppBar(),
      body: CheckoutViewBody(),
    );
  }
}
