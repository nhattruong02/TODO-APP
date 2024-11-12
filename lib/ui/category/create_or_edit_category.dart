import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/ultils/color_extension.dart';

import '../../entities/category_realm_entity.dart';

class CreateOrEditCategory extends StatefulWidget {
  final String? categoryId;
  const CreateOrEditCategory({super.key, this.categoryId});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  final List<Color> _colorDataSource = [];
  Color _backgroundcolorSelected = const Color(0xFFC9CC41);
  Color _iconColorSelected = const Color(0xFF66CC41);
  IconData? _iconSelected;
  bool get isEdit {
    return widget.categoryId != null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final storagePath = Configuration.defaultRealmPath;
    print(storagePath);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isEdit) {
        _findCategory(widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isEdit ? "Edit category" : "Create new category",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: _buildBodyPageScreen(),
    );
  }

  Widget _buildBodyPageScreen() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryNameField(),
                _buildCategoryChooseIconField(),
                _buildCategoryChooseBackgroundColorField(),
                _buildCategoryChooseIconAndTextColorField(),
                _buildCategoryPreview()
              ],
            ),
          ),
          _buildCancelAndCreateOrEditCategoryButton()
        ],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Category name :"),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Category name",
                  hintStyle:
                      const TextStyle(fontSize: 16, color: Color(0xFFAFAFAF)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: Color(0xFF979797), width: 1))),
              onChanged: (String? value) {
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Category icon :"),
          GestureDetector(
            onTap: _chooseIcon,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withOpacity(0.21),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _iconSelected != null
                    ? Icon(
                        _iconSelected,
                        color: Colors.white,
                        size: 26,
                      )
                    : const Text(
                        "Choose icon from library",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundColorField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Category color :"),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryBackGroundColor,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36 / 2),
                    color: _backgroundcolorSelected),
              ),
            ),
          ),
          /*Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final color = _colorDataSource.elementAt(index);
                final isSelected = _colorSelected == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _colorSelected = color;
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36 / 2),
                        color: color),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                );
              },
              itemCount: _colorDataSource.length,
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconAndTextColorField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Category icon & text color :"),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: _onChooseCategoryIconTextColor,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36 / 2),
                    color: _iconColorSelected),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("Category preview :"),
        ],
      ),
    );
  }

  Widget _buildFieldTitle(String titleLable) {
    return Text(
      titleLable,
      style: TextStyle(color: Colors.white.withOpacity(0.87), fontSize: 16),
    );
  }

  Widget _buildCancelAndCreateOrEditCategoryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 20, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  _editCategory();
                } else {
                  _onHandleCreateCategory();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                isEdit ? "Edit category" : "Create category",
                style: const TextStyle(
                    fontSize: 16, fontFamily: "Lato", color: Colors.white),
              )),
        ],
      ),
    );
  }

  void _onHandleCreateCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        _showAlert("Validation", "Category name is required!");
        return;
      }
      if (_iconSelected == null) {
        _showAlert("Validation", "Category icon is required!");
        return;
      }
      // mo Realm de ghi du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);
      final backgroundColorHex = _backgroundcolorSelected.toHex();
      var category = CategoryRealmEntity(ObjectId(), categoryName,
          iconCodePoin: _iconSelected?.codePoint,
          backgroundColorHex: backgroundColorHex,
          iconColorHex: _iconColorSelected.toHex());
      // luu Realm
      await realm.writeAsync(() {
        realm.add(category);
      });
      _nameCategoryTextController.text = "";
      _backgroundcolorSelected = const Color(0xFFC9CC41);
      _iconColorSelected = const Color(0xFF66CC41);
      _iconSelected = null;
      setState(() {});
      // show alert
      _showAlert("Successfully", "Create category success!");
    } catch (e) {
      _showAlert("Failure", "Create category failure!");
    }
  }

  void _chooseIcon() async {
    IconData? icon = await showIconPicker(
      context,
      iconPackModes: [IconPack.material],
    );
    setState(() {
      _iconSelected = icon;
    });
  }

  void _onChooseCategoryBackGroundColor() async {
    showDialog(
        context: context,
        builder: (context) {
          // C1
          /*return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _colorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _colorSelected = newColor;
                  });
                },
              ),
            ),
          );*/
          // C2
          return AlertDialog(
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: _backgroundcolorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _backgroundcolorSelected = newColor;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  void _onChooseCategoryIconTextColor() async {
    showDialog(
        context: context,
        builder: (context) {
          // C1
          return AlertDialog(
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: _iconColorSelected,
                onColorChanged: (Color newColor) {
                  setState(() {
                    _iconColorSelected = newColor;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  void _findCategory(String id) {
    var config = Configuration.local([CategoryRealmEntity.schema]);
    var realm = Realm(config);
    final category =
        realm.find<CategoryRealmEntity>(ObjectId.fromHexString(id));
    if (category == null) {
      return;
    }
    _nameCategoryTextController.text = category.name;
    if (category.iconCodePoin != null) {
      _iconSelected =
          IconData(category.iconCodePoin!, fontFamily: "MaterialIcons");
    }
    if (category.backgroundColorHex != null) {
      _backgroundcolorSelected = HexColor(category.backgroundColorHex!);
    }

    if (category.iconColorHex != null) {
      _iconColorSelected = HexColor(category.iconColorHex!);
    }
    setState(() {});
  }

  Future<void> _editCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        _showAlert("Validation", "Category name is required!");
        return;
      }
      if (_iconSelected == null) {
        _showAlert("Validation", "Category icon is required!");
        return;
      }
      // mo Realm de ghi du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);
      final category = realm.find<CategoryRealmEntity>(
          ObjectId.fromHexString(widget.categoryId!));
      if (category == null) {
        return;
      }

      final backgroundColorHex = _backgroundcolorSelected.toHex();
      // luu Realm
      await realm.writeAsync(() {
        category.name = categoryName;
        category.iconCodePoin = _iconSelected?.codePoint;
        category.backgroundColorHex = _backgroundcolorSelected.toHex();
        category.iconColorHex = _iconColorSelected.toHex();
      });
      _nameCategoryTextController.text = "";
      _backgroundcolorSelected = const Color(0xFFC9CC41);
      _iconColorSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      if (context.mounted) {
        Navigator.pop(context);
      }
      // show alert
      await _showAlert("Successfully", "Edit category success!");
    } catch (e) {
      await _showAlert("Failure", "Edit category failure!");
    }
  }
}
