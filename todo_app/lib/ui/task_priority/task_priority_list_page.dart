import 'package:flutter/material.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPage();
}

class _TaskPriorityListPage extends State<TaskPriorityListPage> {
  List<int> priorityListDataSource = [];
  int? _selectPriority;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        priorityListDataSource = List.generate(10, (index) => index + 1);
      });
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
            _buildChoosePriorityTitle(),
            _buildGridPriorityList(),
            _buildCreatePriorityButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Task Priority",
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

  Widget _buildGridPriorityList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final priority = priorityListDataSource.elementAt(index);
        return _buildGridPriorityItem(priority);
      },
      itemCount: priorityListDataSource.length + 1,
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = priority == _selectPriority;
    return GestureDetector(
      onTap: () {
        _selectPriority = priority;
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? const Color(0xFF8687E7)
                  : const Color(0xFF272727),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/flag.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
                Text(
                  priority.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
                Navigator.pop(context, {"priority": _selectPriority});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
        ],
      ),
    );
  }
}
