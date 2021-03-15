class Medication{
  final int id;
  final String img;
  final String manufacturer;
  final String name;
  final String description;
  final String price;
  final bool isHave;
  final String composition;
  final List<dynamic> available;

  const Medication(this.id, this.name, this.manufacturer, this.img, this.description, this.price, this.isHave, this.composition, this.available);
}