import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'sub_models/concierge_liaison_model.dart';
import 'sub_models/user_profile_model.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required UserProfileModel super.user,
    required ConciergeLiaisonModel super.liaison,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'] ?? json['user'] ?? json;
    final Map<String, dynamic> userMap = (data is Map<String, dynamic> && data['user'] is Map<String, dynamic>)
        ? data['user'] as Map<String, dynamic>
        : (data is Map<String, dynamic> ? data : json);

    return ProfileModel(
      user: UserProfileModel.fromJson(userMap),
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
