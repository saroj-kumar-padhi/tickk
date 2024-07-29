import 'package:dekhlo/controllers/flavourController.dart';
import 'package:dekhlo/models/categororiesModel.dart';
import 'package:dekhlo/models/reviewModel.dart';
import 'package:dekhlo/models/sellerProfieModel.dart';
import 'package:dekhlo/models/buyerInprocess.dart';
import 'package:dekhlo/models/buyerdealdoneModel.dart';
import 'package:dekhlo/models/rating_response.dart';
import 'package:dekhlo/models/sellerInprocess.dart';
import 'package:dekhlo/models/selleracceptedTabModel.dart';
import 'package:dekhlo/models/subSubCategory.dart';
import 'package:dekhlo/models/userFcmModel.dart';
import 'package:dekhlo/views/buyer_view/loginPages/login_phone.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../controllers/authController.dart';
import '../controllers/categoriesController.dart';
import '../models/basicDetailsEdit.dart';
import '../models/categoriesBased.dart';
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
import '../utils/components/buyerScreenTiles/send_tile.dart';

part 'rest_client.g.dart';

// @RestApi(baseUrl: 'http://13.201.210.192:3002')
@RestApi(baseUrl: 'http://192.168.1.23:3002')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @PUT('/buyer/signupAllDetails')
  Future<void> postBuyer(
    @Body() Map<String, dynamic> createBuyerRequest,
  );

  @POST('/upload')
  Future<void> postRequirements(
    @Body() FormData createPostRequest,
  );

  @POST('/DeleteAccOTP')
  Future<void> deleteAccoountSemdOtp(
    @Body() Map<String, String> data,
  );

  @POST('/storeSetup')
  Future<void> setupStrore(@Body() FormData setupStrore);

  @POST('/sellerNewTab/SellerNewTab/{categories}/{subCategories}')
  Future<void> putRequirementInSellerTab(
    @Path('categories') String categories,
    @Path('subCategories') String subCategories,
  );

  @GET('/BuyerNewtabGet/{mobileNumber}')
  Future<RequirementList> getRequirements(
      @Path('mobileNumber') int mobileNumber);

  @GET('/postrequirement/countofStores/{cate}')
  Future<CountModel> fetchCategoriesCount(@Path('cate') String cate);

  @GET('/buyer/CheckRegisteredOrNot/{mobileNo}')
  Future<ErrorResponse> checkMobileNumberIfRegistered(
      @Path('mobileNo') String mobileNo);

  @GET('/postrequirement/countofStores/ /{subCat}')
  Future<CountModel> fetchSubCategoriesCount(@Path('subCat') String subCat);

  @GET('/CatSubCategories/AllCategories')
  Future<List<StoreCategory>> getAllCategories();

  @GET('/CatSubCategories/AllStoreCategories')
  Future<List<StoreCategory>> getAllCategoriesStoreSetUp();

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

  @PUT('/buyer/editProfile/{mobileNo}')
  Future<void> editProfile(
    @Path('mobileNo') int mobileNo,
  );

  @POST('/buyerInProcess/buyerLocationnnn/{RequirementID}')
  Future<void> postLoacation(@Path('RequirementID') String RequirementID,
      @Body() Map<String, double> data);

  @GET('/SellerNewTabData/{storeID}')
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

  @PUT('/EditProfile/{mobileNo}')
  Future<void> updateProfileData(
    @Path('mobileNo') int mobileNo,
    @Body() FormData data,
  );

  @GET('/Inprocess/InprocessTabData/{storeID}')
  Future<SellerInprocessResponseModel> sellerInProcess(
    @Path('storeID') String storeID,
  );

  @GET('/BuyerInprocessTabData/{mobileNo}')
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

  @GET('/BuyerDealDoneTabData/{mobileNo}')
  Future<BuyerDealDoneResponse> buyerDealDone(
    @Path('mobileNo') String mobileNo,
  );

  @GET('/BuyerRejectedTabData/{mobileNo}')
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

  @POST('/sellerNewTab/InprocesBuyerSeller/{RequirementID}')
  Future<void> pushtoBuyerInProcessAndSellerInProcess(
    @Path('RequirementID') String RequirementID,
    @Body() Map<String, dynamic> data,
  );

  @POST('/SellerExactSimilarImages')
  Future<void> exactOrSimilar(
    @Body() FormData data,
  );

  @POST('/rejected/rejectedByStore/{storeId}')
  Future<void> rejectBySeller(
    @Path('storeId') String storeId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/buyer/UserLOgout')
  Future<void> Logout(
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

  @POST('/DelAccount/deleteAccOTPvalidation/{mobileNo}/{otp}')
  Future<void> deleteAccountVerifyOTP(
    @Path('mobileNo') String mobileNo,
    @Path('otp') String otp,
  );

  @POST('/DelAccount/ReasonForDelAcc/{mobileNo}')
  Future<void> deleteAccount(
    @Path('mobileNo') String mobileNo,
    @Body() Map<String, dynamic> data,
  );
  @GET('/Dealdonebuyer/AverageOfRating/{storeId}')
  Future<RatingResponse> getStoreRating(@Path('storeId') String storeId);

  @GET('/CatSubCategories/CatwiseSubCat/{categoryName}')
  Future<CategoryResponse> getsubcategorieswithCategories(
      @Path('categoryName') String categoryName);

  @GET('/CatSubCategories/multipleSubCategories/{list}')
  Future<List<CategoryWithSubcategories>> getSetupsubcategorieswithCategories(
      @Path('list') String list);

  @GET('/CatSubCategories/multipleSubSubCategories/{list}')
  Future<List<CategoryGroup>> getSetupsubsubcategorieswithCategories(
      @Path('list') String list);

  @GET('/CatSubCategories/CatSubCatwiseSubSubCat/{cat}/{subCat}')
  Future<YogaStore> getsubSubcategorieswithCategories(
      @Path('cat') String cat, @Path('subCat') String subCat);

  @GET('/Dealdonebuyer/RatingReview/{storeID}')
  Future<List<Review>> getPostedReviewByUsers(@Path('storeID') String storeID);

  @GET('/selling/StoreNameByStoreID/{storeId}')
  Future<StoreName> getStoreNameById(@Path('storeId') String storeId);

  @POST('/SignupOTP')
  Future<void> signUpWithOtp(
    @Body() Map<String, dynamic> data,
  );

  @POST('/LoginOTP')
  Future<void> LoginWithOtp(
    @Body() Map<String, dynamic> data,
  );

  @GET('/buyer/signupdetails/{mobile}/{otp}')
  Future<MessageOTP> verifyPhoneNumber(
      @Path('mobile') String mobile, @Path('otp') int otp);
}
