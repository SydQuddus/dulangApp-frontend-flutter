//! Modify the class 'PostDataService' whenever possible



import './rest_service.dart';
import 'profile_data_service.dart';
import '../models/food.dart';
import '../models/profile.dart';
 
class FoodDataService {
  static final FoodDataService _instance = FoodDataService._constructor();
  factory FoodDataService() {
    return _instance;
  }

  FoodDataService._constructor();
  final rest = RestService();

  Future<List<Food>> getFood({type = ''}) async {
    List listJson = await rest.get('foods/');

    final foods = <Food>[];

    if (listJson != null) {
      if (type == '') {
        for (int i = 0; i < listJson.length; i++) {
          final json = listJson[i];
          Food f = Food.fromJson(json);

          foods.add(f);
        }
      } else {
        for (int i = 0; i < listJson.length; i++) {
          final json = listJson[i];
          Food f = Food.fromJson(json);

          if (f.type.toLowerCase() == type) foods.add(f);
        }
      }
    }

    return foods;
  }

  Future<List<Food>> getFoodByUser({uid = ''}) async {
    List listJson = await rest.get('foods/');

    final foods = <Food>[];

    if (listJson != null) {
      for (int i = 0; i < listJson.length; i++) {
        final json = listJson[i];
        Food f = Food.fromJson(json);

        if (f.userid == uid) foods.add(f);
      }
    }

    return foods;
  }

  Future<Food> addFood({Food food, String userid}) async {
    //here

    Profile profile = await profileDataService.getProfile(id: userid);
    food.username = profile.name;
    food.foodLocation = profile.location;
    food.requestCollected = false;
    food.requestAccepted = false;

    final json = await rest.post(
      'foods/',
      data: {
        'userid': food.userid,
        'username': food.username,
        'name': food.name,
        'foodLocation': food.foodLocation,
        'type': food.type,
        'imageUrl': food.imageUrl,
        'imageFileName': food.imageFileName,
        'qty': food.qty,
        'foodRequesterID': food.foodRequesterID,
        'foodRequesterName': food.foodRequesterName,
        'requested': food.requested,
        'requestAccepted': food.requested,
        'requestCollected': food.requestCollected
      },
    );
    return Food.fromJson(json);
  }

  Future<Food> updateFood({String id, int quantity}) async {
    //here
    final json = await rest.get('foods/$id');

    Food f = Food.fromJson(json);
    f.qty = f.qty + quantity;
    final json2 = await rest.patch('foods/$id', data: {'qty': f.qty});
    return Food.fromJson(json2);
  }

  Future<Food> collectFood({String id}) async {
    //here
    final json = await rest.get('foods/$id');

    Food f = Food.fromJson(json);
    f.requestCollected = true;
    final json2 = await rest
        .patch('foods/$id', data: {'requestCollected': f.requestCollected});
    return Food.fromJson(json2);
  }

  Future<Food> acceptFoodRequest({String id}) async {
    //here
    final json = await rest.get('foods/$id');

    Food f = Food.fromJson(json);
    f.requestAccepted = true;
    final json2 = await rest
        .patch('foods/$id', data: {'requestAccepted': f.requestAccepted});
    return Food.fromJson(json2);
  }

  Future deleteFood({String id}) async {
    //hereee

    // ignore: unused_local_variable
    final json = await rest.delete('foods/$id');

    // return Food.fromJson(json);
    return null;
  }

  Future<List<Food>> getCrowdFoodRequest({uid = ''}) async {
    List listJson = await rest.get('foods/');

    final foods = <Food>[];

    if (listJson != null) {
      for (int i = 0; i < listJson.length; i++) {
        final json = listJson[i];
        Food f = Food.fromJson(json);

        if (f.userid == uid && f.requested) foods.add(f);
      }
    }

    return foods;
  }

  Future<List<Food>> getMyFoodRequest({uid = ''}) async {
    List listJson = await rest.get('foods/');

    final foods = <Food>[];

    if (listJson != null) {
      for (int i = 0; i < listJson.length; i++) {
        final json = listJson[i];
        Food f = Food.fromJson(json);

        if (f.foodRequesterID == uid) foods.add(f);
      }
    }

    return foods;
  }

  Future<Food> requestFood(
      {String id,
      String foodRequesterID,
      String foodRequesterName,
      String foodRequesterLocation,
      int requestedQty}) async {
    //here
    final json = await rest.get('foods/$id');

    bool requested = true;

    Food f = Food.fromJson(json);
    f.foodRequesterID = foodRequesterID;
    f.foodRequesterName = foodRequesterName;
    f.foodRequesterLocation = foodRequesterLocation;
    f.requested = requested;
    f.qty = f.qty - requestedQty;
    final json2 = await rest.patch('foods/$id', data: {
      'foodRequesterID': f.foodRequesterID,
      'foodRequesterName': f.foodRequesterName,
      'foodRequesterLocation': f.foodRequesterLocation,
      'requested': f.requested,
      'qty': f.qty,
      'requestedQty': requestedQty
    });
    return Food.fromJson(json2);
  }

  Future<Food> cancelRequestFood({String id, int requestedQty}) async {
    //here
    final json = await rest.get('foods/$id');

    bool requested = false;

    Food f = Food.fromJson(json);
    f.foodRequesterID = '';
    f.foodRequesterName = '';
    f.foodRequesterLocation = '';
    f.requested = requested;
    f.qty = f.qty + requestedQty;
    f.requestedQty = 0;
    final json2 = await rest.patch('foods/$id', data: {
      'foodRequesterID': f.foodRequesterID,
      'foodRequesterName': f.foodRequesterName,
      'foodRequesterLocation': f.foodRequesterLocation,
      'requested': f.requested,
      'qty': f.qty,
      'requestedQty': f.requestedQty
    });
    return Food.fromJson(json2);
  }

  
}

//hereeee
final foodDataService = FoodDataService();
