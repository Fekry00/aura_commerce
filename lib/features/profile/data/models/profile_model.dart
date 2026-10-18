import 'package:aura/features/profile/domain/entities/profile_entity.dart';

import 'sub_models/concierge_liaison_model.dart';
import 'sub_models/user_profile_model.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required UserProfileModel super.user,
    required ConciergeLiaisonModel super.liaison,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: json['user'] is Map<String, dynamic>
          ? UserProfileModel.fromJson(json['user'] as Map<String, dynamic>)
          : const UserProfileModel(
              id: '#AL-98421',
              name: 'Claire Daniels',
              tier: 'Tier 01',
              tierTitle: 'VIP Luminary',
              patronSince: 'Oct 2022',
              avatarUrl:
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
              targetTier: 'TIER 02 SOVEREIGN',
              progress: 0.78,
              spentAmount: '\$12,450 spent',
              remainingToPrivilege: '\$2,550 to Sovereign Privileges',
              deliveredCount: '14',
              curationsCount: '28',
              vaultCredit: '\$450',
            ),
      liaison: json['liaison'] is Map<String, dynamic>
          ? ConciergeLiaisonModel.fromJson(
              json['liaison'] as Map<String, dynamic>,
            )
          : const ConciergeLiaisonModel(
              name: 'Marcus Vance',
              role: 'Dedicated White-Glove Stylist & Courier',
              dispatchStatus: 'Priority Dispatch',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserProfileModel).toJson(),
      'liaison': (liaison as ConciergeLiaisonModel).toJson(),
    };
  }
}
