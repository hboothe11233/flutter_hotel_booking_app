// To parse this JSON data, do
//
//     final hotel = hotelFromJson(jsonString);

import 'dart:convert';

Hotel hotelFromJson(String str) => Hotel.fromJson(json.decode(str));

String hotelToJson(Hotel data) => json.encode(data.toJson());

class Hotel {
  List<Filter>? filters;
  int? hotelCount;
  Meta? meta;
  List<HotelElement>? hotels;
  UsedSearchRequest? usedSearchRequest;

  Hotel({
    this.filters,
    this.hotelCount,
    this.meta,
    this.hotels,
    this.usedSearchRequest,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    hotelCount: json["hotel-count"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    hotels: json["hotels"] == null ? [] : List<HotelElement>.from(json["hotels"]!.map((x) => HotelElement.fromJson(x))),
    usedSearchRequest: json["used-search-request"] == null ? null : UsedSearchRequest.fromJson(json["used-search-request"]),
  );

  Map<String, dynamic> toJson() => {
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
    "hotel-count": hotelCount,
    "meta": meta?.toJson(),
    "hotels": hotels == null ? [] : List<dynamic>.from(hotels!.map((x) => x.toJson())),
    "used-search-request": usedSearchRequest?.toJson(),
  };
}

class Filter {
  List<FilterAttribute>? attributes;
  String? category;
  bool? inUse;
  Type? type;
  Range? range;

  Filter({
    this.attributes,
    this.category,
    this.inUse,
    this.type,
    this.range,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    attributes: json["attributes"] == null ? [] : List<FilterAttribute>.from(json["attributes"]!.map((x) => FilterAttribute.fromJson(x))),
    category: json["category"],
    inUse: json["in-use"],
    type: typeValues.map[json["type"]]!,
    range: json["range"] == null ? null : Range.fromJson(json["range"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "category": category,
    "in-use": inUse,
    "type": typeValues.reverse[type],
    "range": range?.toJson(),
  };
}

class FilterAttribute {
  String? attributeIdentifier;
  String? attributeValue;
  bool? inUse;
  bool? isDisabled;
  bool? isPopular;
  int? minPrice;
  int? resultCount;

  FilterAttribute({
    this.attributeIdentifier,
    this.attributeValue,
    this.inUse,
    this.isDisabled,
    this.isPopular,
    this.minPrice,
    this.resultCount,
  });

  factory FilterAttribute.fromJson(Map<String, dynamic> json) => FilterAttribute(
    attributeIdentifier: json["attribute-identifier"],
    attributeValue: json["attribute-value"],
    inUse: json["in-use"],
    isDisabled: json["is-disabled"],
    isPopular: json["is-popular"],
    minPrice: json["min-price"],
    resultCount: json["result-count"],
  );

  Map<String, dynamic> toJson() => {
    "attribute-identifier": attributeIdentifier,
    "attribute-value": attributeValue,
    "in-use": inUse,
    "is-disabled": isDisabled,
    "is-popular": isPopular,
    "min-price": minPrice,
    "result-count": resultCount,
  };
}

class Range {
  String? max;
  String? min;
  String? type;
  String? selectedMaxValue;
  String? selectedMinValue;

  Range({
    this.max,
    this.min,
    this.type,
    this.selectedMaxValue,
    this.selectedMinValue,
  });

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    max: json["max"],
    min: json["min"],
    type: json["type"],
    selectedMaxValue: json["selected-max-value"],
    selectedMinValue: json["selected-min-value"],
  );

  Map<String, dynamic> toJson() => {
    "max": max,
    "min": min,
    "type": type,
    "selected-max-value": selectedMaxValue,
    "selected-min-value": selectedMinValue,
  };
}

enum Type {
  CHECKBOX,
  RADIO,
  RANGE
}

final typeValues = EnumValues({
  "checkbox": Type.CHECKBOX,
  "radio": Type.RADIO,
  "range": Type.RANGE
});

class HotelElement {
  Analytics? analytics;
  List<dynamic>? badges;
  BestOffer? bestOffer;
  int? category;
  CategoryType? categoryType;
  String? destination;
  String? hotelId;
  List<ImageType>? images;
  double? latitude;
  double? longitude;
  String? name;
  RatingInfo? ratingInfo;

  HotelElement({
    this.analytics,
    this.badges,
    this.bestOffer,
    this.category,
    this.categoryType,
    this.destination,
    this.hotelId,
    this.images,
    this.latitude,
    this.longitude,
    this.name,
    this.ratingInfo,
  });

  factory HotelElement.fromJson(Map<String, dynamic> json) => HotelElement(
    analytics: json["analytics"] == null ? null : Analytics.fromJson(json["analytics"]),
    badges: json["badges"] == null ? [] : List<dynamic>.from(json["badges"]!.map((x) => x)),
    bestOffer: json["best-offer"] == null ? null : BestOffer.fromJson(json["best-offer"]),
    category: json["category"],
    categoryType: categoryTypeValues.map[json["category-type"]]!,
    destination: json["destination"],
    hotelId: json["hotel-id"],
    images: json["images"] == null ? [] : List<ImageType>.from(json["images"]!.map((x) => ImageType.fromJson(x))),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    name: json["name"],
    ratingInfo: json["rating-info"] == null ? null : RatingInfo.fromJson(json["rating-info"]),
  );

  Map<String, dynamic> toJson() => {
    "analytics": analytics?.toJson(),
    "badges": badges == null ? [] : List<dynamic>.from(badges!.map((x) => x)),
    "best-offer": bestOffer?.toJson(),
    "category": category,
    "category-type": categoryTypeValues.reverse[categoryType],
    "destination": destination,
    "hotel-id": hotelId,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "rating-info": ratingInfo?.toJson(),
  };
}

class Analytics {
  SelectItemItem0? selectItemItem0;

  Analytics({
    this.selectItemItem0,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    selectItemItem0: json["select_item.item.0"] == null ? null : SelectItemItem0.fromJson(json["select_item.item.0"]),
  );

  Map<String, dynamic> toJson() => {
    "select_item.item.0": selectItemItem0?.toJson(),
  };
}

class SelectItemItem0 {
  Currency? currency;
  String? itemCategory;
  String? itemCategory2;
  String? itemId;
  ItemListName? itemListName;
  String? itemName;
  String? itemRooms;
  String? price;
  String? quantity;

  SelectItemItem0({
    this.currency,
    this.itemCategory,
    this.itemCategory2,
    this.itemId,
    this.itemListName,
    this.itemName,
    this.itemRooms,
    this.price,
    this.quantity,
  });

  factory SelectItemItem0.fromJson(Map<String, dynamic> json) => SelectItemItem0(
    currency: currencyValues.map[json["currency"]]!,
    itemCategory: json["itemCategory"],
    itemCategory2: json["itemCategory2"],
    itemId: json["itemId"],
    itemListName: itemListNameValues.map[json["itemListName"]]!,
    itemName: json["itemName"],
    itemRooms: json["itemRooms"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currencyValues.reverse[currency],
    "itemCategory": itemCategory,
    "itemCategory2": itemCategory2,
    "itemId": itemId,
    "itemListName": itemListNameValues.reverse[itemListName],
    "itemName": itemName,
    "itemRooms": itemRooms,
    "price": price,
    "quantity": quantity,
  };
}

enum Currency {
  EUR
}

final currencyValues = EnumValues({
  "EUR": Currency.EUR
});

enum ItemListName {
  HOTEL_LIST_RECOMMENDATION
}

final itemListNameValues = EnumValues({
  "hotel list - recommendation": ItemListName.HOTEL_LIST_RECOMMENDATION
});

class BestOffer {
  dynamic appliedTravelDiscount;
  List<dynamic>? detailedPricePerPerson;
  int? includedTravelDiscount;
  int? originalTravelPrice;
  int? simplePricePerPerson;
  int? total;
  int? travelPrice;
  List<AvailableSpecialGroup>? availableSpecialGroups;
  bool? flightIncluded;
  Rooms? rooms;
  TravelDate? travelDate;

  BestOffer({
    this.appliedTravelDiscount,
    this.detailedPricePerPerson,
    this.includedTravelDiscount,
    this.originalTravelPrice,
    this.simplePricePerPerson,
    this.total,
    this.travelPrice,
    this.availableSpecialGroups,
    this.flightIncluded,
    this.rooms,
    this.travelDate,
  });

  factory BestOffer.fromJson(Map<String, dynamic> json) => BestOffer(
    appliedTravelDiscount: json["applied-travel-discount"],
    detailedPricePerPerson: json["detailed-price-per-person"] == null ? [] : List<dynamic>.from(json["detailed-price-per-person"]!.map((x) => x)),
    includedTravelDiscount: json["included-travel-discount"],
    originalTravelPrice: json["original-travel-price"],
    simplePricePerPerson: json["simple-price-per-person"],
    total: json["total"],
    travelPrice: json["travel-price"],
    availableSpecialGroups: json["available-special-groups"] == null ? [] : List<AvailableSpecialGroup>.from(json["available-special-groups"]!.map((x) => availableSpecialGroupValues.map[x]!)),
    flightIncluded: json["flight-included"],
    rooms: json["rooms"] == null ? null : Rooms.fromJson(json["rooms"]),
    travelDate: json["travel-date"] == null ? null : TravelDate.fromJson(json["travel-date"]),
  );

  Map<String, dynamic> toJson() => {
    "applied-travel-discount": appliedTravelDiscount,
    "detailed-price-per-person": detailedPricePerPerson == null ? [] : List<dynamic>.from(detailedPricePerPerson!.map((x) => x)),
    "included-travel-discount": includedTravelDiscount,
    "original-travel-price": originalTravelPrice,
    "simple-price-per-person": simplePricePerPerson,
    "total": total,
    "travel-price": travelPrice,
    "available-special-groups": availableSpecialGroups == null ? [] : List<dynamic>.from(availableSpecialGroups!.map((x) => availableSpecialGroupValues.reverse[x])),
    "flight-included": flightIncluded,
    "rooms": rooms?.toJson(),
    "travel-date": travelDate?.toJson(),
  };
}

enum AvailableSpecialGroup {
  FLEXIBLE,
  PROMOTION
}

final availableSpecialGroupValues = EnumValues({
  "flexible": AvailableSpecialGroup.FLEXIBLE,
  "promotion": AvailableSpecialGroup.PROMOTION
});

class Rooms {
  Overall? overall;
  List<PricesAndOccupancy>? pricesAndOccupancy;
  List<RoomGroup>? roomGroups;

  Rooms({
    this.overall,
    this.pricesAndOccupancy,
    this.roomGroups,
  });

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
    overall: json["overall"] == null ? null : Overall.fromJson(json["overall"]),
    pricesAndOccupancy: json["prices-and-occupancy"] == null ? [] : List<PricesAndOccupancy>.from(json["prices-and-occupancy"]!.map((x) => PricesAndOccupancy.fromJson(x))),
    roomGroups: json["room-groups"] == null ? [] : List<RoomGroup>.from(json["room-groups"]!.map((x) => RoomGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overall": overall?.toJson(),
    "prices-and-occupancy": pricesAndOccupancy == null ? [] : List<dynamic>.from(pricesAndOccupancy!.map((x) => x.toJson())),
    "room-groups": roomGroups == null ? [] : List<dynamic>.from(roomGroups!.map((x) => x.toJson())),
  };
}

class Overall {
  List<OverallAttribute>? attributes;
  String? boarding;
  String? name;
  int? adultCount;
  List<dynamic>? childrenAges;
  int? childrenCount;
  int? quantity;
  bool? sameBoarding;
  bool? sameRoomGroups;

  Overall({
    this.attributes,
    this.boarding,
    this.name,
    this.adultCount,
    this.childrenAges,
    this.childrenCount,
    this.quantity,
    this.sameBoarding,
    this.sameRoomGroups,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    attributes: json["attributes"] == null ? [] : List<OverallAttribute>.from(json["attributes"]!.map((x) => OverallAttribute.fromJson(x))),
    boarding: json["boarding"],
    name: json["name"],
    adultCount: json["adult-count"],
    childrenAges: json["children-ages"] == null ? [] : List<dynamic>.from(json["children-ages"]!.map((x) => x)),
    childrenCount: json["children-count"],
    quantity: json["quantity"],
    sameBoarding: json["same-boarding"],
    sameRoomGroups: json["same-room-groups"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "boarding": boarding,
    "name": name,
    "adult-count": adultCount,
    "children-ages": childrenAges == null ? [] : List<dynamic>.from(childrenAges!.map((x) => x)),
    "children-count": childrenCount,
    "quantity": quantity,
    "same-boarding": sameBoarding,
    "same-room-groups": sameRoomGroups,
  };
}

class OverallAttribute {
  Id? id;
  Name? name;
  dynamic value;
  bool? isUnique;

  OverallAttribute({
    this.id,
    this.name,
    this.value,
    this.isUnique,
  });

  factory OverallAttribute.fromJson(Map<String, dynamic> json) => OverallAttribute(
    id: idValues.map[json["id"]]!,
    name: nameValues.map[json["name"]]!,
    value: json["value"],
    isUnique: json["is-unique"],
  );

  Map<String, dynamic> toJson() => {
    "id": idValues.reverse[id],
    "name": nameValues.reverse[name],
    "value": value,
    "is-unique": isUnique,
  };
}

enum Id {
  IT05_BT_BA,
  IT05_BT_BT
}

final idValues = EnumValues({
  "IT05-BT#BA": Id.IT05_BT_BA,
  "IT05-BT#BT": Id.IT05_BT_BT
});

enum Name {
  BALKON,
  BALKON_TERRASSE
}

final nameValues = EnumValues({
  "Balkon": Name.BALKON,
  "Balkon/Terrasse": Name.BALKON_TERRASSE
});

class PricesAndOccupancy {
  int? adultCount;
  List<dynamic>? childrenAges;
  int? childrenCount;
  List<dynamic>? detailedPricePerPerson;
  String? groupIdentifier;
  int? simplePricePerPerson;
  int? total;

  PricesAndOccupancy({
    this.adultCount,
    this.childrenAges,
    this.childrenCount,
    this.detailedPricePerPerson,
    this.groupIdentifier,
    this.simplePricePerPerson,
    this.total,
  });

  factory PricesAndOccupancy.fromJson(Map<String, dynamic> json) => PricesAndOccupancy(
    adultCount: json["adult-count"],
    childrenAges: json["children-ages"] == null ? [] : List<dynamic>.from(json["children-ages"]!.map((x) => x)),
    childrenCount: json["children-count"],
    detailedPricePerPerson: json["detailed-price-per-person"] == null ? [] : List<dynamic>.from(json["detailed-price-per-person"]!.map((x) => x)),
    groupIdentifier: json["group-identifier"],
    simplePricePerPerson: json["simple-price-per-person"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "adult-count": adultCount,
    "children-ages": childrenAges == null ? [] : List<dynamic>.from(childrenAges!.map((x) => x)),
    "children-count": childrenCount,
    "detailed-price-per-person": detailedPricePerPerson == null ? [] : List<dynamic>.from(detailedPricePerPerson!.map((x) => x)),
    "group-identifier": groupIdentifier,
    "simple-price-per-person": simplePricePerPerson,
    "total": total,
  };
}

class RoomGroup {
  List<OverallAttribute>? attributes;
  String? boarding;
  String? name;
  String? detailedDescription;
  String? groupIdentifier;
  int? quantity;

  RoomGroup({
    this.attributes,
    this.boarding,
    this.name,
    this.detailedDescription,
    this.groupIdentifier,
    this.quantity,
  });

  factory RoomGroup.fromJson(Map<String, dynamic> json) => RoomGroup(
    attributes: json["attributes"] == null ? [] : List<OverallAttribute>.from(json["attributes"]!.map((x) => OverallAttribute.fromJson(x))),
    boarding: json["boarding"],
    name: json["name"],
    detailedDescription: json["detailed-description"],
    groupIdentifier: json["group-identifier"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "boarding": boarding,
    "name": name,
    "detailed-description": detailedDescription,
    "group-identifier": groupIdentifier,
    "quantity": quantity,
  };
}

class TravelDate {
  int? days;
  DateTime? departureDate;
  int? nights;
  DateTime? returnDate;

  TravelDate({
    this.days,
    this.departureDate,
    this.nights,
    this.returnDate,
  });

  factory TravelDate.fromJson(Map<String, dynamic> json) => TravelDate(
    days: json["days"],
    departureDate: json["departure-date"] == null ? null : DateTime.parse(json["departure-date"]),
    nights: json["nights"],
    returnDate: json["return-date"] == null ? null : DateTime.parse(json["return-date"]),
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "departure-date": "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
    "nights": nights,
    "return-date": "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
  };
}

enum CategoryType {
  DOTS
}

final categoryTypeValues = EnumValues({
  "dots": CategoryType.DOTS
});

class ImageType {
  String? large;
  String? small;

  ImageType({
    this.large,
    this.small,
  });

  factory ImageType.fromJson(Map<String, dynamic> json) => ImageType(
    large: json["large"],
    small: json["small"],
  );

  Map<String, dynamic> toJson() => {
    "large": large,
    "small": small,
  };
}

class RatingInfo {
  int? recommendationRate;
  int? reviewsCount;
  double? score;
  String? scoreDescription;

  RatingInfo({
    this.recommendationRate,
    this.reviewsCount,
    this.score,
    this.scoreDescription,
  });

  factory RatingInfo.fromJson(Map<String, dynamic> json) => RatingInfo(
    recommendationRate: json["recommendation-rate"],
    reviewsCount: json["reviews-count"],
    score: json["score"]?.toDouble(),
    scoreDescription: json["score-description"],
  );

  Map<String, dynamic> toJson() => {
    "recommendation-rate": recommendationRate,
    "reviews-count": reviewsCount,
    "score": score,
    "score-description": scoreDescription,
  };
}

class Meta {
  Agent? agent;
  int? count;
  List<ScarcityElement>? scarcityElements;

  Meta({
    this.agent,
    this.count,
    this.scarcityElements,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
    count: json["count"],
    scarcityElements: json["scarcity-elements"] == null ? [] : List<ScarcityElement>.from(json["scarcity-elements"]!.map((x) => ScarcityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "agent": agent?.toJson(),
    "count": count,
    "scarcity-elements": scarcityElements == null ? [] : List<dynamic>.from(scarcityElements!.map((x) => x.toJson())),
  };
}

class Agent {
  String? availability;
  ImageType? image;
  String? name;
  String? telephone;
  String? text;
  String? vita;

  Agent({
    this.availability,
    this.image,
    this.name,
    this.telephone,
    this.text,
    this.vita,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    availability: json["availability"],
    image: json["image"] == null ? null : ImageType.fromJson(json["image"]),
    name: json["name"],
    telephone: json["telephone"],
    text: json["text"],
    vita: json["vita"],
  );

  Map<String, dynamic> toJson() => {
    "availability": availability,
    "image": image?.toJson(),
    "name": name,
    "telephone": telephone,
    "text": text,
    "vita": vita,
  };
}

class ScarcityElement {
  String? type;

  ScarcityElement({
    this.type,
  });

  factory ScarcityElement.fromJson(Map<String, dynamic> json) => ScarcityElement(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}

class UsedSearchRequest {
  String? attributes;
  String? departureAirports;
  DateTime? departureDate;
  DurationRangeClass? durationRange;
  DurationRangeClass? priceRange;
  DateTime? returnDate;
  List<Room>? rooms;
  String? travelType;
  String? destination;
  String? sort;
  dynamic destinationName;
  int? limit;
  int? offset;

  UsedSearchRequest({
    this.attributes,
    this.departureAirports,
    this.departureDate,
    this.durationRange,
    this.priceRange,
    this.returnDate,
    this.rooms,
    this.travelType,
    this.destination,
    this.sort,
    this.destinationName,
    this.limit,
    this.offset,
  });

  factory UsedSearchRequest.fromJson(Map<String, dynamic> json) => UsedSearchRequest(
    attributes: json["attributes"],
    departureAirports: json["departure-airports"],
    departureDate: json["departure-date"] == null ? null : DateTime.parse(json["departure-date"]),
    durationRange: json["duration-range"] == null ? null : DurationRangeClass.fromJson(json["duration-range"]),
    priceRange: json["price-range"] == null ? null : DurationRangeClass.fromJson(json["price-range"]),
    returnDate: json["return-date"] == null ? null : DateTime.parse(json["return-date"]),
    rooms: json["rooms"] == null ? [] : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
    travelType: json["travel-type"],
    destination: json["destination"],
    sort: json["sort"],
    destinationName: json["destinationName"],
    limit: json["limit"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes,
    "departure-airports": departureAirports,
    "departure-date": "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
    "duration-range": durationRange?.toJson(),
    "price-range": priceRange?.toJson(),
    "return-date": "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
    "rooms": rooms == null ? [] : List<dynamic>.from(rooms!.map((x) => x.toJson())),
    "travel-type": travelType,
    "destination": destination,
    "sort": sort,
    "destinationName": destinationName,
    "limit": limit,
    "offset": offset,
  };
}

class DurationRangeClass {
  String? max;
  String? min;

  DurationRangeClass({
    this.max,
    this.min,
  });

  factory DurationRangeClass.fromJson(Map<String, dynamic> json) => DurationRangeClass(
    max: json["max"],
    min: json["min"],
  );

  Map<String, dynamic> toJson() => {
    "max": max,
    "min": min,
  };
}

class Room {
  int? adultCount;
  List<dynamic>? childrenAges;

  Room({
    this.adultCount,
    this.childrenAges,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    adultCount: json["adult-count"],
    childrenAges: json["children-ages"] == null ? [] : List<dynamic>.from(json["children-ages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "adult-count": adultCount,
    "children-ages": childrenAges == null ? [] : List<dynamic>.from(childrenAges!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
