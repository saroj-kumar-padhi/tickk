import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../models/newRequrements.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://3.214.24.150:3000')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/buyer/buyers')
  Future<void> postBuyer(
    @Body() Map<String, dynamic> createBuyerRequest,
  );

  @POST('/postrequirement/requirement')
  Future<void> postRequirements(
    @Body() Map<String, dynamic> createPostRequest,
  );

  @GET('/postrequirement/mobilenumberPYR/{mobileNumber}')
  Future<RequirementList> getRequirements(
      @Path('mobileNumber') int mobileNumber);
}
