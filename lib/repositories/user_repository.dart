import 'package:first_app/data/api/api_client.dart';
import 'package:first_app/data/local/auth_storage.dart';
import 'package:first_app/dto/user_dto.dart';

class UserRepository {

  final ApiClient client;
  final AuthStorage token;

  UserRepository(this.client, this.token);

  //Me
  Future<UserResponse> getProfileAsync() async {
    final res = await client.get('/me/profile');
    return UserResponse.fromJson(res.data);
  }

}