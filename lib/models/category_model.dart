class CategoryModel {
  String id;
  String name;
  int? iconCodePoin; // luu icon. Icons
  String? backgroundColorHex; // color hex string
  String? iconColorHex;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconCodePoin,
    this.backgroundColorHex,
    this.iconColorHex,
  }); // color hex string
}
