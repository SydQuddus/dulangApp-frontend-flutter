class Food {
  String id, userid, username, name, foodLocation, type, imageUrl, imageFileName;
  String foodRequesterID, foodRequesterName, foodRequesterLocation;
  int qty, requestedQty;
  bool requested;
  bool requestAccepted, requestCollected;

  Food(
      {this.id,
      this.userid,
      this.username,
      this.name,
      this.foodLocation,
      this.type,
      this.imageUrl,
      this.imageFileName,
      this.qty,
      this.requestedQty,
      this.foodRequesterID = '',
      this.foodRequesterName,
      this.foodRequesterLocation,
      this.requested = false,
      this.requestAccepted = false,
      this.requestCollected = false});
 
  Food.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userid: json['userid'],
            username: json['username'],
            name: json['name'],
            foodLocation: json['foodLocation'],
            type: json['type'],
            imageUrl: json['imageUrl'],
            imageFileName: json['imageFileName'],
            qty: json['qty'],
            requestedQty: json['requestedQty'],
            foodRequesterID: json['foodRequesterID'],
            foodRequesterName: json['foodRequesterName'],
            foodRequesterLocation: json['foodRequesterLocation'],
            requested: json['requested'],
            requestAccepted: json['requestAccepted'],
            requestCollected: json['requestCollected']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'userid': userid,
        'username': username,
        'name': name,
        'foodLocation': foodLocation,
        'type': type,
        'imageUrl': imageUrl,
        'imageFileName': imageFileName,
        'qty': qty,
        'requestedQty': requestedQty,
        'foodRequesterName': foodRequesterName,
        'foodRequesterLocation': foodRequesterLocation,
        'foodRequesterID': foodRequesterID,
        'requested': requested,
        'requestAccepted': requestAccepted,
        'requestCollected': requestCollected
      };
}
