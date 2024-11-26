class Trash {
  int? id;
  String? trashType;
  String? subTrashType;
  String? unitOfMeasurement;
  String? code;
  String? description;
  String? priceForMember;
  String? priceForBsb;
  String? createdAt;
  String? updatedAt;

  Trash(
      {this.id,
      this.trashType,
      this.subTrashType,
      this.unitOfMeasurement,
      this.code,
      this.description,
      this.priceForMember,
      this.priceForBsb,
      this.createdAt,
      this.updatedAt});

  Trash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trashType = json['trash_type'];
    subTrashType = json['sub_trash_type'];
    unitOfMeasurement = json['unit_of_measurement'];
    code = json['code'];
    description = json['description'];
    priceForMember = json['price_for_member'];
    priceForBsb = json['price_for_bsb'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trash_type'] = this.trashType;
    data['sub_trash_type'] = this.subTrashType;
    data['unit_of_measurement'] = this.unitOfMeasurement;
    data['code'] = this.code;
    data['description'] = this.description;
    data['price_for_member'] = this.priceForMember;
    data['price_for_bsb'] = this.priceForBsb;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
