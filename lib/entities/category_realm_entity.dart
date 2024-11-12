import 'package:realm/realm.dart';

part 'category_realm_entity.g.dart';

@RealmModel()
class $CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoin; // luu icon. Icons
  late String? backgroundColorHex; // color hex string
  late String? iconColorHex; // color hex string
}
