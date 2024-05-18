import 'package:get/get.dart';
import 'package:lastproject/data/api/api_client.dart';
import 'package:lastproject/utils/app_constans.dart';

class PopularRepo extends GetxService {
    final ApiClient apiClient ; 
    PopularRepo({required this.apiClient});
    Future<Response> getPopularProductList() async{
      return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
   }
}