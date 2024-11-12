import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../../entities/category_realm_entity.dart';
import '../../models/category_model.dart';
import '../../ultils/color_extension.dart';
import 'create_or_edit_category.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];
  bool _isEditMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildBodyPage());
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFF363636)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),
            _buildCreateCategoryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Choose category",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.87),
            )),
        const Divider(
          color: Color(0xFF979797),
        )
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final isLastItem = index == categoryListDataSource.length;
        if (isLastItem) {
          return _buildGridCategoryItemCreateNew();
        }
        final category = categoryListDataSource.elementAt(index);
        return _buildGridCategoryItem(category);
      },
      itemCount: categoryListDataSource.length + 1,
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleClickCategoryItem(category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: category.backgroundColorHex != null
                    ? HexColor(category.backgroundColorHex!)
                    : Colors.white,
                border: Border.all(
                    color: _isEditMode ? Colors.orange : Colors.transparent,
                    width: _isEditMode ? 2 : 0)),
            child: category.iconCodePoin != null
                ? Icon(
                    IconData(category.iconCodePoin!,
                        fontFamily: "MaterialIcons"),
                    color: category.iconColorHex != null
                        ? HexColor(category.iconColorHex!)
                        : Colors.white,
                    size: 30,
                  )
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _gotoCreateCategoryPage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF80FFD1),
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFF00A369),
                size: 30,
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              "Create New",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 107, bottom: 24),
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
                setState(() {
                  _isEditMode = !_isEditMode;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                _isEditMode ? "Cancel category" : "Edit category",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              )),
        ],
      ),
    );
  }

  Future<void> _getCategoryList() async {
    var config = Configuration.local([CategoryRealmEntity.schema]);
    var realm = Realm(config);
    // RealmResult CategoryRealmEntity => List<CategoryRealmEntity>
    final categories =
        realm.all<CategoryRealmEntity>(); // List<CategoryRealmEntity>
    // List<CategoryModel>
    List<CategoryModel> categoriesModels = categories.map((e) {
      return CategoryModel(
          id: e.id.hexString,
          name: e.name,
          iconCodePoin: e.iconCodePoin,
          iconColorHex: e.iconColorHex,
          backgroundColorHex: e.backgroundColorHex);
    }).toList();
    setState(() {
      categoryListDataSource = categoriesModels;
    });
  }

  void _gotoCreateCategoryPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateOrEditCategory()));
  }

  void _onHandleClickCategoryItem(CategoryModel category) {
    if (_isEditMode) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateOrEditCategory(
                    categoryId: category.id,
                  )));
    } else {
      Navigator.pop(context, {
        "categoryId": category.id,
        "name": category.name,
        "iconCodePoin": category.iconCodePoin,
        "backgroundColorHex": category.backgroundColorHex,
        "iconColorHex": category.iconColorHex
      });
    }
  }
}
