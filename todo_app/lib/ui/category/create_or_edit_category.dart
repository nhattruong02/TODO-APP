import 'package:flutter/material.dart';

class CreateOrEditCategory extends StatefulWidget {
  const CreateOrEditCategory({super.key});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  final List<Color> _colorDataSource = [];
  Color? colorSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colorDataSource.addAll([
      const Color(0xFFC9CC41),
      const Color(0xFF66CC41),
      const Color(0xFF41CCA7),
      const Color(0xFF4181CC),
      const Color(0xFF41A2CC),
      const Color(0xFFCC8441),
      const Color(0xFF9741CC),
      const Color(0xFFCC4173)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363636),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Create new category",
          style: TextStyle(
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
                _buildCaregoryNameField(),
                _buildCategoryChooseIconField(),
                _buildCategoryChooseBackgroundColorField(),
              ],
            ),
          ),
          _buildCancelAndCreateOrEditCategoryButton()
        ],
      ),
    );
  }

  Widget _buildCaregoryNameField() {
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
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withOpacity(0.21),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
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
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final color = _colorDataSource.elementAt(index);
                final isSelected = colorSelected == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      colorSelected = color;
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
          ),
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
              onPressed: _onHandleCreateCategory,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Text(
                "Create category",
                style: TextStyle(
                    fontSize: 16, fontFamily: "Lato", color: Colors.white),
              )),
        ],
      ),
    );
  }

  void _onHandleCreateCategory() {
    final categoryName = _nameCategoryTextController.text;
  }
}
