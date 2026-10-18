import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/orders/data/models/order_model.dart';
import 'package:aura/features/orders/data/models/sub_models/courier_liaison_model.dart';
import 'package:aura/features/orders/data/models/sub_models/order_consignment_address_model.dart';
import 'package:aura/features/orders/data/models/sub_models/order_manifest_item_model.dart';
import 'package:aura/features/orders/data/models/sub_models/order_settlement_summary_model.dart';
import 'package:aura/features/orders/data/models/sub_models/order_tracking_model.dart';
import 'package:aura/features/orders/data/models/sub_models/tracking_dispatch_item_model.dart';
import 'package:aura/features/orders/data/models/sub_models/tracking_dossier_model.dart';
import 'package:aura/features/orders/data/models/sub_models/tracking_milestone_model.dart';
import 'package:aura/features/orders/domain/entities/sub_entities/tracking_milestone_entity.dart';

abstract class OrdersLocalDataSource {
  Future<OrderModel> getLastOrderDetails({String? orderId});

  Future<OrderTrackingModel> getLastOrderTracking({String? orderId});

  Future<void> cacheOrder(OrderModel orderToCache);
}

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  const OrdersLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedOrderKey = 'CACHED_ORDER';

  @override
  Future<OrderModel> getLastOrderDetails({String? orderId}) async {
    return _buildDefaultOrder();
  }

  @override
  Future<OrderTrackingModel> getLastOrderTracking({String? orderId}) async {
    return _buildDefaultOrder().tracking as OrderTrackingModel;
  }

  @override
  Future<void> cacheOrder(OrderModel orderToCache) async {
    // await cacheHelper.saveData(key: cachedOrderKey, value: orderToCache.toJson());
  }

  OrderModel _buildDefaultOrder() {
    return const OrderModel(
      orderId: 'AL-984218',
      orderRef: '#AL-98421',
      recipientName: 'Ahmed',
      dispatchSchedule: 'May 16 – 17, 2026',
      manifestItems: [
        OrderManifestItemModel(
          id: '1',
          name: 'Aethel Minimalist ...',
          subtitle: '40mm – Brushed Titanium',
          quantity: 1,
          price: '\$1,450.00',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDD0sbnNVvsv33yBAnoqPB20Vs7jx_Bj8lrn6GPRWyjaiVPYFvMjgfhitJOdJa_e3iNRbQl4cxRWwt0yEj0sLuRq-yCgOIxFtwssw9ylmZNFpkGom4eQiQoQxdrnKt94SI5N-N3yNHthLaG9q0PzQWohNcVO_UcaRu7gqz066HwD0YLLELX7PCOtQL2HXflN219MVpetlDdx8hDSQd4XLoHLMIPXCT0rOP_8dMk6s31A7WaQsGiUdo8',
        ),
        OrderManifestItemModel(
          id: '2',
          name: 'Verona Nappa Hand...',
          subtitle: 'Structured – Forest Green',
          quantity: 1,
          price: '\$890.00',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAC9S5sow3Mq93k0DT7B6_MTu4V_ZluO8KoBzdbylC-FlrceCygBoyXqVaLh6JfBU-pyeiwrmcJuYOUv33Qi-vxd64NW4Bb6qaWPDo5xb06Bsx87XLpj1n7zZ68m9dHzPSkRJZuhYQ9MrISpLwq4IAD3g4T6LcSFG3SLcnzkonYx-jpQBoI_z0j4K6-co3FpCTBnsB9Rkgu4nk89bsIcxRQ2ShVM3j1GIm2s3EwUY-qRLuXXR5OWgzz',
        ),
        OrderManifestItemModel(
          id: '3',
          name: 'Oud & Bergamot Ext...',
          subtitle: 'Flacon – 100ml Pure Essence',
          quantity: 1,
          price: '\$320.00',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAqtKu1r4CebpmbxvF1DkyXyGNKfTabhgzCOJg8lk4E7dL1IS8X6mFcEZU1leREKXX0yqU6Ub3Bsc8ZosCVRhIHPL9yltAz9ddZn00ISNYsCflqb45H-LFn728wZD5bsTXf-DGCA5jqZqVTsJgq7psnSRBCbl9F-tW6hNC5j0j4Mx4gPaI9NmjQCBkMX3nuNndZnGV2j0UwPvsXHkwOcG9Pr5ox-5OxNqyrK4m9jirzKXKfGXKmaNvG',
        ),
      ],
      consignmentAddress: OrderConsignmentAddressModel(
        recipientName: 'Claire Daniels',
        addressType: 'Default: Residence',
        addressLine: '742 Evergreen St, Penthouse B',
        cityStateZip: 'Manhattan, NY 10021',
        phoneNumber: '+1 (212) 555-0198',
        conciergeProtocol:
            'Direct reception sign-off required. White-glove delivery.',
      ),
      settlementSummary: OrderSettlementSummaryModel(
        subtotal: '\$2,660.00',
        itemsCount: 3,
        privilegeDiscount: '-\$266.00',
        privilegeCode: 'WELCOME10 - 10%',
        courierTransitFee: '\$0.00',
        courierBadge: 'VIP COMPLIMENTARY',
        dutiesAndHandling: '\$191.50',
        totalAmountPaid: '\$2,585.50',
        paymentMethod: 'Amex Centurion •••• 1008',
        isEscrowConfirmed: true,
      ),
      tracking: OrderTrackingModel(
        orderId: 'Order #AL-984218',
        totalAmount: '\$2,585.50',
        etaTime: 'Today, Estimated arrival 2:45 PM – 3:15 PM',
        priorityTier: 'Priority Tier I',
        currentMilestoneStep: 4,
        totalMilestoneSteps: 5,
        courier: CourierLiaisonModel(
          name: 'Marcus Vance',
          role: 'Senior Courier Specialist',
          badge: 'Armored Transit Unit #4',
          avatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=300',
          phone: '+1 555-0192',
          securityClearance: 'Level 4 Escort • Biometric Verified',
          protocolNote:
              'Vehicle equipped with dual-compartment biometric lock box.',
        ),
        milestones: [
          TrackingMilestoneModel(
            id: 'm1',
            title: 'Order Placed & Vault Confirmed',
            time: '09:15 AM',
            description:
                'Cryptographic allocation verified at Aura Reserve.',
            status: MilestoneStatus.completed,
          ),
          TrackingMilestoneModel(
            id: 'm2',
            title: 'Artisan Inspection & Packaging',
            time: '11:30 AM',
            description:
                'Sealed with tamper-proof holographic seal #984-NY.',
            status: MilestoneStatus.completed,
          ),
          TrackingMilestoneModel(
            id: 'm3',
            title: 'Dispatched from Manhattan Atelier',
            time: '01:20 PM',
            description:
                'Released into climate-controlled armored custody.',
            status: MilestoneStatus.completed,
          ),
          TrackingMilestoneModel(
            id: 'm4',
            title: 'Out for Courier Delivery',
            time: '02:10 PM',
            description:
                'In transit with Marcus Vance. Approaching Flatiron district.',
            status: MilestoneStatus.active,
          ),
          TrackingMilestoneModel(
            id: 'm5',
            title: 'Arrival & Biometric Sign-off',
            time: 'Est. 03:00 PM',
            description:
                'Recipient verification and white-glove handover.',
            status: MilestoneStatus.upcoming,
          ),
        ],
        dispatchItems: [
          TrackingDispatchItemModel(
            id: 'd1',
            category: 'HAUTE HORLOGERIE',
            title: 'Aethel Chronograph 40...',
            subtitle: 'Brushed Titanium • Serial #AT-092-7489',
            quantity: 'Qty: 01',
            price: '\$1,450.00',
            serialTag: 'N°04',
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDD0sbnNVvsv33yBAnoqPB20Vs7jx_Bj8lrn6GPRWyjaiVPYFvMjgfhitJOdJa_e3iNRbQl4cxRWwt0yEj0sLuRq-yCgOIxFtwssw9ylmZNFpkGom4eQiQoQxdrnKt94SI5N-N3yNHthLaG9q0PzQWohNcVO_UcaRu7gqz066HwD0YLLELX7PCOtQL2HXflN219MVpetlDdx8hDSQd4XLoHLMIPXCT0rOP_8dMk6s31A7WaQsGiUdo8',
            nftCertificateId: '0x71C...B29',
          ),
          TrackingDispatchItemModel(
            id: 'd2',
            category: 'MAISON LEATHER',
            title: 'Verona Nappa Handbag',
            subtitle: 'Forest Green • Hand-stitched Calfsuede',
            quantity: 'Qty: 01',
            price: '\$890.00',
            serialTag: '08',
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAC9S5sow3Mq93k0DT7B6_MTu4V_ZluO8KoBzdbylC-FlrceCygBoyXqVaLh6JfBU-pyeiwrmcJuYOUv33Qi-vxd64NW4Bb6qaWPDo5xb06Bsx87XLpj1n7zZ68m9dHzPSkRJZuhYQ9MrISpLwq4IAD3g4T6LcSFG3SLcnzkonYx-jpQBoI_z0j4K6-co3FpCTBnsB9Rkgu4nk89bsIcxRQ2ShVM3j1GIm2s3EwUY-qRLuXXR5OWgzz',
            nftCertificateId: '0x94B...C12',
          ),
        ],
        dossier: TrackingDossierModel(
          recipientName: 'Claire Daniels',
          recipientAddress:
              '742 Evergreen St, Penthouse B\nManhattan, NY 10021',
          courierService: 'Armored White-Glove Direct Courier',
          insuranceNote:
              'Complimentary VIP Protocol (Insured up to \$50,000)',
          paymentMethod: 'Vault Pay (Amex Centurion)',
          paymentDetails:
              '•••• 1008 • Subtotal incl. \$245.50 State Surcharge',
          paymentBadge: 'PAID',
        ),
      ),
    );
  }
}
