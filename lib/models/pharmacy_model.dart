class PharmacyModel {
  int id;
  String name;
  String address;
  String workingHours;
  String phone;
  String city;
  String photo;
  int owner;

  PharmacyModel(
      {this.id,
        this.name,
        this.address,
        this.workingHours,
        this.phone,
        this.city,
        this.photo,
        this.owner});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    workingHours = json['working_hours'];
    phone = json['phone'];
    city = json['city'];
    photo = json['photo'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['working_hours'] = this.workingHours;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['photo'] = this.photo;
    data['owner'] = this.owner;
    return data;
  }
}