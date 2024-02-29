import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:studio_93_test/model/meal_category.dart';
import 'package:studio_93_test/utils/app_color.dart';
import 'package:studio_93_test/utils/helper.dart';
import 'package:studio_93_test/widget/custom_button.dart';

import 'add_item_dialog.dart';

class ExpandableItem extends StatefulWidget {
  List<MealCategory> catergories;
  int index;

  ExpandableItem({super.key, required this.catergories, required this.index});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool _isExpanded = false;
  bool _isEditing = false;
  double _totalCalories = 0.0;
  late int foodItemsLength;

  @override
  void initState() {
    super.initState();
    getBasicData();
  }

  getBasicData() {
    foodItemsLength = widget.catergories[widget.index].items?.length ?? 0;
    _totalCalories = 0.0;
    widget.catergories[widget.index].items?.forEach((element) {
      _totalCalories = _totalCalories + (element.calories ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(_isExpanded ? 0 : 20),
                  bottomRight: Radius.circular(_isExpanded ? 0 : 20),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.bodyBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.catergories[widget.index].icon ??
                              const Icon(
                                Icons.fastfood,
                                color: AppColor.secondaryColor,
                              ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.catergories[widget.index].title ?? "",
                                style: const TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              foodItemsLength > 0
                                  ? _isEditing
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomButton(
                                              title: "Save",
                                              onTap: () {
                                                setState(() {
                                                  _isEditing = false;
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomButton(
                                              title: "Edit",
                                              onTap: () {
                                                setState(() {
                                                  _isExpanded = true;
                                                  _isEditing = true;
                                                });
                                              },
                                            ),
                                            addWidth(5),
                                            const Icon(
                                              Icons.bookmark_outline_sharp,
                                              color: AppColor.secondaryColor,
                                              size: 25,
                                            )
                                          ],
                                        )
                                  : const CustomButton(
                                      title: "No Products",
                                      textColor: AppColor.white,
                                      backgroundColor: AppColor.lightGrey,
                                      borderColor: AppColor.lightGrey,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    decoration: const BoxDecoration(
                      color: AppColor.bodyBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddItemDialog((title, calories) {
                              widget.catergories[widget.index].items!.add(
                                  MealItem(title: title, calories: calories));
                              getBasicData();
                              _isExpanded = true;
                              setState(() {});
                            });
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColor.white,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isExpanded && foodItemsLength > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: AppColor.bodyBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: foodItemsLength,
                      itemBuilder: (context, index) {
                        MealItem item =
                            widget.catergories[widget.index].items![index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(item.title ?? ""),
                                ),
                                addWidth(10),
                                Row(
                                  children: [
                                    Text(
                                      item.calories!.toInt().toString(),
                                      style: const TextStyle(
                                          color: AppColor.secondaryColor),
                                    ),
                                    const Text(
                                      " Cals",
                                      style: TextStyle(
                                          color: AppColor.secondaryColor),
                                    ),
                                  ],
                                ),
                                _isEditing
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget
                                                .catergories[widget.index].items
                                                ?.removeAt(index);
                                            getBasicData();
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 10),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColor.red,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Icon(
                                            Icons.close,
                                            color: AppColor.white,
                                            size: 12,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10, left: 10),
                                        child: Icon(
                                          Icons.arrow_circle_right,
                                          color: AppColor.secondaryColor,
                                        ),
                                      )
                              ],
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: AppColor.white,
                            )
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Total",
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                          ),
                        ),
                        addWidth(10),
                        Row(
                          children: [
                            Text(
                              _totalCalories.toInt().toString(),
                              style:
                                  const TextStyle(color: AppColor.primaryColor),
                            ),
                            const Text(
                              " Cals",
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                          ],
                        ),
                        addWidth(35)
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
