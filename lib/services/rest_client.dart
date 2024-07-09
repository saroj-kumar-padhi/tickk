import 'package:dekhlo/models/sellerProfieModel.dart';
import 'package:dekhlo/models/buyerInprocess.dart';
import 'package:dekhlo/models/buyerdealdoneModel.dart';
import 'package:dekhlo/models/rating_response.dart';
import 'package:dekhlo/models/sellerInprocess.dart';
import 'package:dekhlo/models/selleracceptedTabModel.dart';
import 'package:dekhlo/models/userFcmModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../models/basicDetailsEdit.dart';
import '../models/genderFetch.dart';
import '../models/isBuyer.dart';
import '../models/myStoreAcoount.dart';
import '../models/newRequrements.dart';
import '../models/rejectedBySeller.dart';
import '../models/rejected_buyer.dart';
import '../models/sellerDealDone.dart';
import '../models/sellerNewModel.dart';
import '../models/sellerPandingQueta.dart';
import '../models/stores_fcm.dart';

part 'rest_client.g.dart';

// @RestApi(baseUrl: 'http://3.214.24.150:3002')
@RestApi(baseUrl: 'http://192.168.1.35:3002')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/buyer/buyers')
  Future<void> postBuyer(
    @Body() Map<String, dynamic> createBuyerRequest,
  );

  @POST('/requirement')
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

  @GET('/buyer/buyerData/{mobileNumber}')
  Future<User> getProfileDetails(@Path('mobileNumber') int mobileNumber);

  @GET('/buyer/GenderName/{mobileNo}')
  Future<PersonName> getNameAndGender(@Path('mobileNo') int mobileNo);

  @DELETE('/postrequirement/deleteRequirement/{mobile}/{RequirementID}')
  Future<void> deleteNewBuyerRequirement(
    @Path('mobile') int mobile,
    @Path('RequirementID') String requirementID,
  );

  @GET('/buyer/BuyerorSeller/{mobileNumber}')
  Future<BuyerResponse> checkBuyerOrSeller(
    @Path('mobileNumber') int mobileNumber,
  );

  @PUT('/buyer/editProfileData/{mobileNo}')
  Future<void> editProfile(
    @Path('mobileNo') int mobileNo,
  );

  @POST('/buyerInProcess/buyerLocationnnn/{RequirementID}')
  Future<void> postLoacation(@Path('RequirementID') String RequirementID,
      @Body() Map<String, double> data);

  @GET('/selling/requirementbyStore/{storeID}')
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

  @GET('/Inprocess/InprocessTabData/{storeID}')
  Future<SellerInprocessResponseModel> sellerInProcess(
    @Path('storeID') String storeID,
  );

  @GET('/buyerInProcess/BuyerInprocessTabData/{mobileNo}')
  Future<BuyerInprossModel> buyerInProcess(
    @Path('mobileNo') String mobileNo,
  );

  @GET('/buyerInProcess/BuyerInprocessLowQuoteData/{mobileNo}/{requirementId}')
  Future<BuyerInprossModel> sortByPrice(@Path('mobileNo') String mobileNo,
      @Path('requirementId') String requirementId);

  @GET('/buyerInProcess/distanceBetween2locations/{requirementID}')
  Future<BuyerInprossModel> sortByDiatance(
    @Path('requirementID') String requirementID,
  );

  @GET('/Dealdonebuyer/DDmobilewiseData/{mobileNo}')
  Future<BuyerDealDoneResponse> buyerDealDone(
    @Path('mobileNo') String mobileNo,
  );

  @GET('/buyerRejected/RejectedTabData/{mobileNo}')
  Future<List<RejectedItemd>> buyerRejected(@Path('mobileNo') String mobileNo);

  @POST('/buyerInProcess/buyersellerDealDone/RequirementID/StoreID')
  Future<void> moveToDealDone(
    @Path('RequirementID') String RequirementID,
    @Path('StoreID') String StoreID,
    @Body() Map<String, dynamic> data,
  );

  @POST('/Inprocess/InProcessBuyerSeller/{storeId}')
  Future<void> sendQuote(
    @Path('storeId') String storeId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/buyerInProcess/buyerRejectingSeller/{storeID}/{requestId}')
  Future<void> rejectQuote(
    @Path('storeId') String storeId,
    @Path('requestId') String requestId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/sellerNewTab/SellerExactSimilar')
  Future<void> exactOrSimilar(
    @Body() Map<String, dynamic> data,
  );

  @POST('/rejected/rejectedByStore/{storeId}')
  Future<void> rejectBySeller(
    @Path('storeId') String storeId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/buyer/FCMCreation/{mobileNo}')
  Future<void> fcmCreation(
    @Path('mobileNo') String mobileNo,
    @Body() Map<String, dynamic> data,
  );

  @GET('/rejected/rejectedTabData/{storeId}')
  Future<RejectedItemsResponse> rejectedBySeller(
    @Path('storeId') String storeId,
  );
  @GET('/selling/sellerDataByStoreID/{storeId}')
  Future<StoreDetails> fetchStoreDetailsByStoreID(
    @Path('storeId') String storeId,
  );

  @GET('/postrequirement/FCMByRequirementId/{reqId}')
  Future<UserFcmToken> fetchUserFcmbyreqId(
    @Path('reqId') String reqId,
  );

  @GET('/postrequirement/FCMtoken/{category}/{subcategory}')
  Future<MatchingStoresResponse> fechingMachingStores(
    @Path('category') String category,
    @Path('subcategory') String subcategory,
  );

  @GET('/SellerAccepted/AcceptedDataBySeller/{storeId}')
  Future<AcceptSeller> acceptedSellerSide(
    @Path('storeId') String storeId,
  );

  @GET('/SellerDealDone/sellerDealDoneData/{storeId}')
  Future<DealDone> dealDoneSellerSide(
    @Path('storeId') String storeId,
  );

  @POST('/Dealdonebuyer/RequirementReviewRating/{requestId}')
  Future<void> postReviews(
    @Path('requestId') String requestId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/DelAccount/ReasonForDelAcc/{mobileNo}')
  Future<void> deleteAccount(
    @Path('mobileNo') String mobileNo,
    @Body() Map<String, dynamic> data,
  );
  @GET('/Dealdonebuyer/AverageOfRating/{storeId}')
  Future<RatingResponse> getStoreRating(@Path('storeId') String storeId);
}
