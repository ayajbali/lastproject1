import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lastproject/data/api/api_client.dart';
import 'package:lastproject/models/sign_up_model.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URL, signUpBody.toJson());
  }

   saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
}