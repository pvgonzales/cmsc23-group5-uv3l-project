import 'package:flutter/material.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';

class OrgCategories extends StatelessWidget {
  const OrgCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizationProvider>(
      builder: (context, provider, _) {
        List<Map<String, dynamic>> categories = [
          {"icon": "assets/images/home1.png", "text": "Non-Profit", "type": "Non-Profit"},
          {"icon": "assets/images/home2.png", "text": "Religious", "type": "Religious"},
          {"icon": "assets/images/home3.png", "text": "Academic", "type": "Academic"},
          {"icon": "assets/images/home4.png", "text": "Health", "type": "Health"},
          {"icon": "assets/images/home5.png", "text": "Others", "type": "Others"},
        ];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  String selectedType = categories[index]["type"];
                  provider.filterOrganizationsByCategory(selectedType);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}


class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.icon, required this.text, required this.press});

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: "MyFont1",
              color: Color(0xFF212738),
            ),
          )
        ],
      ),
    );
  }
}
