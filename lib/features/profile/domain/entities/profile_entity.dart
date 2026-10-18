import 'sub_entities/concierge_liaison_entity.dart';
import 'sub_entities/user_profile_entity.dart';

class ProfileEntity {
  const ProfileEntity({
    required this.user,
    required this.liaison,
  });

  final UserProfileEntity user;
  final ConciergeLiaisonEntity liaison;
}
