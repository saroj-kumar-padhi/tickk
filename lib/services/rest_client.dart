import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../models/basicDetailsEdit.dart';
import '../models/isBuyer.dart';
import '../models/newRequrements.dart';
import '../models/sellerNewModel.dart';
import '../models/sellerPandingQueta.dart';

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

  @POST('/selling/store')
  Future<void> setupStrore(@Body() Map<String, dynamic> setupStrore);

  @POST('/sellerNewTab/SellerNewTab/{categories}/{subCategories}')
  Future<void> putRequirementInSellerTab(
    @Path('categories') String categories,
    @Path('subCategories') String subCategories,
  );

  @GET('/postrequirement/mobilenumberPYR/{mobileNumber}')
  Future<RequirementList> getRequirements(
      @Path('mobileNumber') int mobileNumber);

  @DELETE('/postrequirement/deleteRequirement/{mobile}/{RequirementID}')
  Future<void> deleteNewBuyerRequirement(
    @Path('mobile') int mobile,
    @Path('RequirementID') String requirementID,
  );

  @GET('/buyer/BuyerorSeller/{mobileNumber}')
  Future<BuyerResponse> checkBuyerOrSeller(
    @Path('mobileNumber') int mobileNumber,
  );

  @GET('/sellerNewTab/SellerNewTabData/{storeID}')
  Future<SellerResponseModel> fetchNewSeller(
    @Path('storeID') String storeID,
  );

  @GET('/selling/StoreIDbyMobile/{mobileNo}')
  Future<StoreIDbyMobile> checkStoreId(
    @Path('mobileNo') int mobileNo,
  );

  @GET('/pendingQuotes/PendingQuotesData/{storeId}')
  Future<SellerPandingResponseModel> fetchPandingResponseSeller(
    @Path('storeId') String storeId,
  );

  @GET('/buyer/buyerData/{mobileNo}')
  Future<BasicDataModelEdit> fetchBasicDetails(
    @Path('mobileNo') int mobileNo,
  );

  @PUT('/buyer/editProfileData/{mobileNo}')
  Future<void> updateProfileData(
    @Path('mobileNo') int mobileNo,
    @Body() Map<String, dynamic> data,
  );

  @POST('/Inprocess/InProcessBuyerSeller/{storeId}')
  Future<void> sendQuote(
    @Path('storeId') String storeId,
    @Body() Map<String, dynamic> data,
  );
  @POST('/sellerNewTab/SellerExactSimilar')
  Future<void> exactOrSimilar(
    @Body() Map<String, dynamic> data,
  );
}
