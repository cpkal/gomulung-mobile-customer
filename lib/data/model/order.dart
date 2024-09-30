class Order {
  int? id;
  String? subTotal;
  String? grandTotal;
  PickupLocation? pickupLocation;
  String? status;
  String? address;
  String? trashType;
  String? trashWeightSelection;
  String? trashPhotoPath;
  String? paymentMethod;
  int? userId;
  String? updatedAt;
  String? createdAt;

  Order(
      {this.id,
      this.subTotal,
      this.grandTotal,
      this.pickupLocation,
      this.status,
      this.address,
      this.trashType,
      this.trashWeightSelection,
      this.trashPhotoPath,
      this.paymentMethod,
      this.userId,
      this.updatedAt,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTotal = json['sub_total'];
    grandTotal = json['grand_total'];
    pickupLocation = json['pickup_location'] != null
        ? new PickupLocation.fromJson(json['pickup_location'])
        : null;
    status = json['status'];
    address = json['address'];
    trashType = json['trash_type'];
    trashWeightSelection = json['trash_weight_selection'];
    trashPhotoPath = json['trash_photo_path'];
    paymentMethod = json['payment_method'];
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_total'] = this.subTotal;
    data['grand_total'] = this.grandTotal;
    if (this.pickupLocation != null) {
      data['pickup_location'] = this.pickupLocation!.toJson();
    }
    data['status'] = this.status;
    data['address'] = this.address;
    data['trash_type'] = this.trashType;
    data['trash_weight_selection'] = this.trashWeightSelection;
    data['trash_photo_path'] = this.trashPhotoPath;
    data['payment_method'] = this.paymentMethod;
    data['user_id'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class PickupLocation {
  String? type;
  List<double>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
