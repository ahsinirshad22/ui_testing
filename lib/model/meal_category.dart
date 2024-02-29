import 'dart:convert';

import 'package:flutter/material.dart';

class MealCategory {
  String? title;
  Icon? icon;
  List<MealItem>? items;

  MealCategory({
    this.title,
    required this.icon,
    this.items,
  });

  factory MealCategory.fromJson(String str) =>
      MealCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MealCategory.fromMap(Map<String, dynamic> json) => MealCategory(
        title: json["title"],
        icon: null,
        items: json["items"] == null
            ? []
            : List<MealItem>.from(
                json["items"]!.map((x) => MealItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "icon": null,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class MealItem {
  String? title;
  double? calories;

  MealItem({
    this.title,
    this.calories,
  });

  factory MealItem.fromJson(String str) => MealItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MealItem.fromMap(Map<String, dynamic> json) => MealItem(
        title: json["title"],
        calories: json["calories"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "calories": calories,
      };
}
