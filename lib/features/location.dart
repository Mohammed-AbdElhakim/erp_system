import 'package:erp_system/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';
import '../core/widgets/custom_app_bar.dart';
import 'bottomNavigationBar/presentation/widgets/my_drawer.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isPortrait,
        title: "Location",
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_sharp),
              ),
              Positioned(
                right: 12,
                top: 15,
                child: Icon(
                  Icons.circle,
                  color: AppColors.orange,
                  size: 12,
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...getMyWidgetList(),
            if (show == true) ...getMyWidgetList(),
            TextButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                child: const Text("onTap"))
          ],
        ),
      ),
    );
  }

  List<Widget> getMyWidgetList() {
    List<Widget> list = [];
    for (int i = 0; i < 2; i++) {
      TextEditingController controller = TextEditingController(text: "qqq");
      list.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "title",
                  style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                ),
                if (true == true)
                  const Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 10,
                  )
              ],
            ),
            StatefulBuilder(
              builder: (context, sssetState) => CustomTextFormField(
                hintText: '',
                controller: controller,
                isValidator: true,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  sssetState(() {
                    controller.text = value;
                  });
                },
                onSaved: (newValue) {
                  if (newValue!.isNotEmpty) {
                    setState(() {});
                  }
                },
              ),
            )
          ],
        ),
      ));
    }
    return list;
  }
}
