import 'package:dulang_new/models/food.dart';

class Profile {
  String id;
  String name;
  String imageUrl;
  String imageFileName;
  String location;
  String distance = "0.5";
  List<Food> foodList = [];

  Profile(
      {this.id,
      this.name,
      this.imageUrl,
      this.imageFileName,
      this.location,
      this.distance});

  Profile.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            location: json['location'],
            distance: json['distance'],
            imageUrl: json['imageUrl'],
            imageFileName: json['imageFileName']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'distance': distance,
        'imageUrl': imageUrl,
        'imageFileName': imageFileName
      };
}
