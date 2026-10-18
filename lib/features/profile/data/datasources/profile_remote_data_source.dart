import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<bool> updateProfile({
    required String name,
    required String phone,
  });

  Future<bool> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await apiConsumer.get(EndPoint.profile);
    return ProfileModel.fromJson(response);
  }

  @override
  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    final response = await apiConsumer.patch(
      EndPoint.profile,
      data: {'name': name, 'phone': phone},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> signOut() async {
    final response = await apiConsumer.post('${EndPoint.profile}/logout');
    return response['success'] ?? true;
  }
}
