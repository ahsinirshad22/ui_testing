import 'package:flutter/material.dart';
import 'package:studio_93_test/model/meal_category.dart';
import 'package:studio_93_test/widget/expandable_item.dart';

import '../utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var categories = [
    MealCategory(title: "Meal One", icon: Icon(Icons.sunny_snowing), items: []),
    MealCategory(title: "Meal Two", icon: Icon(Icons.copy), items: []),
    MealCategory(
        title: "Meal Three", icon: Icon(Icons.fastfood_outlined), items: []),
    MealCategory(title: "Meal Four", icon: Icon(Icons.no_meals), items: []),
    MealCategory(title: "Meal Five", icon: Icon(Icons.dark_mode), items: []),
    MealCategory(title: "Meal Six", icon: Icon(Icons.light_mode), items: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyBackgroundColor,
      appBar: AppBar(
        title: const Text("Meals"),
        backgroundColor: AppColor.bodyBackgroundColor,
        actions: const [
          Icon(
            Icons.favorite,
            color: AppColor.primaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Icon(
              Icons.menu,
              color: AppColor.black,
            ),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ExpandableItem(catergories: categories, index: index);
        },
      ),
    );
  }
}
