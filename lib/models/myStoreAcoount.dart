class StoreDetails {
  final Timings timings;
  final SellerLocation sellerLocation;
  final String id;
  final String mobile;
  final String storeID;
  final List<String> addImage;
  final String staredImage;
  final String storeName;
  final List<String> storeCategory;
  final List<String> storeSubCategory;
  final List<String> storeSubSubCategory;
  final List<String> brands;
  final String aboutTheStore;
  final String youtubeLink;
  final String instagarmLink;
  final String websiteLink;
  final List<String> languages;
  final String buildingNo;
  final int pincode;
  final String colonyName;

  final String landmark;
  final int v;

  StoreDetails({
    required this.timings,
    required this.sellerLocation,
    required this.id,
    required this.mobile,
    required this.storeID,
    required this.addImage,
    required this.staredImage,
    required this.storeName,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.brands,
    required this.aboutTheStore,
    required this.youtubeLink,
    required this.instagarmLink,
    required this.languages,
    required this.buildingNo,
    required this.pincode,
    required this.colonyName,
    required this.landmark,
    required this.websiteLink,
    required this.v,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) {
    return StoreDetails(
      timings: Timings.fromJson(json['timings']),
      sellerLocation: SellerLocation.fromJson(json['sellerLocation']),
      id: json['_id'] ?? "",
      mobile: json['mobile'] ?? "",
      storeID: json['StoreID'] ?? "",
      addImage: List<String>.from(json['AddImage'] ?? ""),
      staredImage: json['stared'] ?? "",
      storeName: json['StoreName'] ?? "",
      storeCategory: List<String>.from(json['storeCategory'] ?? []),
      storeSubCategory: List<String>.from(json['storeSubCategory'] ?? []),
      storeSubSubCategory: List<String>.from(json['storeSubSubCategory'] ?? []),
      brands: List<String>.from(json['Brands'] ?? []),
      aboutTheStore: json['About_the_store'] ?? "",
      youtubeLink: json['youtubelink'] ?? "",
      instagarmLink: json['instagarmlink'] ?? "",
      languages: List<String>.from(json['languages'] ?? []),
      buildingNo: json['StreetNo_BuildingName'] ?? "",
      pincode: json['Postcode_ZIP'] ?? -1,
      colonyName: json['StreetName_Area'] ?? "",
      landmark: json['District_City'] ?? "",
      v: json['__v'],
      websiteLink: json['Websitelink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timings': timings.toJson(),
      'sellerLocation': sellerLocation.toJson(),
      '_id': id,
      'mobile': mobile,
      'StoreID': storeID,
      'AddImage': addImage,
      'staredImage': staredImage,
      'StoreName': storeName,
      'storeCategory': storeCategory,
      'storeSubCategory': storeSubCategory,
      'storeSubSubCategory': storeSubSubCategory,
      'Brands': brands,
      'About_the_store': aboutTheStore,
      'youtubelink': youtubeLink,
      'instagarmlink': instagarmLink,
      'languages': languages,
      'BuildingNo': buildingNo,
      'Pincode': pincode,
      'ColonyName': colonyName,
      'Landmark': landmark,
      '__v': v,
    };
  }
}

class Timings {
  final DayTiming sunday;
  final DayTiming monday;
  final DayTiming tuesday;
  final DayTiming wednesday;
  final DayTiming thursday;
  final DayTiming friday;
  final DayTiming saturday;

  Timings({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      sunday: DayTiming.fromJson(json['Sunday']),
      monday: DayTiming.fromJson(json['Monday']),
      tuesday: DayTiming.fromJson(json['Tuesday']),
      wednesday: DayTiming.fromJson(json['Wednesday']),
      thursday: DayTiming.fromJson(json['Thursday']),
      friday: DayTiming.fromJson(json['Friday']),
      saturday: DayTiming.fromJson(json['Saturday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sunday': sunday.toJson(),
      'Monday': monday.toJson(),
      'Tuesday': tuesday.toJson(),
      'Wednesday': wednesday.toJson(),
      'Thursday': thursday.toJson(),
      'Friday': friday.toJson(),
      'Saturday': saturday.toJson(),
    };
  }
}

class DayTiming {
  final String open;
  final String close;
  final String id;

  DayTiming({
    required this.open,
    required this.close,
    required this.id,
  });

  factory DayTiming.fromJson(Map<String, dynamic> json) {
    return DayTiming(
      open: json['open'],
      close: json['close'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'open': open,
      'close': close,
      '_id': id,
    };
  }
}

class SellerLocation {
  final double latitude;
  final double longitude;

  SellerLocation({
    required this.latitude,
    required this.longitude,
  });

  factory SellerLocation.fromJson(Map<String, dynamic> json) {
    return SellerLocation(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
