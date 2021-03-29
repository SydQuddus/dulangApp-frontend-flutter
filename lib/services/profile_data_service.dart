import 'rest_service.dart';
import '../models/profile.dart';

class ProfileDataService {
  static final ProfileDataService _instance = ProfileDataService._constructor();
  factory ProfileDataService() {
    return _instance;
  }
 
  ProfileDataService._constructor();
  final rest = RestService();

  Future<List<Profile>> getAllProfiles() async {
    //here
    final listJson = await rest.get('users');

    return (listJson as List)
        .map((itemJson) => Profile.fromJson(itemJson))
        .toList();
  }

  Future<Profile> getProfile({String id}) async {
    //here
    final json = await rest.get('users/$id');
    return Profile.fromJson(json);
  }

  Future<Profile> updateProfile(
      {String id, String name, String imageUrl, String imageFileName}) async {
    //here
    final json = await rest.get('users/$id');

    Profile p = Profile.fromJson(json);
    p.name = name;
    p.imageUrl = imageUrl;
    p.imageFileName = imageFileName;
    final json2 = await rest.patch(
      'users/$id',
      data: {
        'name': p.name,
        'imageUrl': p.imageUrl,
        'imageFileName': p.imageFileName
      },
    );
    return Profile.fromJson(json2);
  }

  Future<Profile> updateLocation({String id, String location}) async {
    //here
    final json = await rest.get('users/$id');

    Profile p = Profile.fromJson(json);
    p.location = location;
    final json2 = await rest.patch(
      'users/$id',
      data: {'location': p.location},
    );
    return Profile.fromJson(json2);
  }
}

final profileDataService = ProfileDataService();
