import 'package:get/get.dart';
import 'package:lastproject/data/api/api_client.dart';
import 'package:lastproject/utils/app_constans.dart';

class RecommandedProductRepo extends GetxService {
    final ApiClient apiClient ; 
    RecommandedProductRepo({required this.apiClient});
    Future<Response> getRecommandedProductList() async{
      return await apiClient.getData("/recommended");
   }
}