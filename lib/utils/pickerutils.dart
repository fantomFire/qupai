
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/model/province.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';

class PickerUtils {
  //列表选择框
  static Picker getSimpleStringPicker({
    List<String> lists,
    String title = "",
    dynamic onConfirm,
  }) {
    return new Picker(

      adapter: PickerDataAdapter(pickerdata: lists),
      cancelText: "取消",
      cancelTextStyle: TextStyles.color_999999_14,
      confirmText: "确定",
      confirmTextStyle: TextStyles.color_2192fc_14,
      textStyle: TextStyles.color_333333_14,
      title: TextView(
        title,
        style: TextStyles.color_333333_14,
      ),
      itemExtent: 40,
      height: 200,
      backgroundColor: BaseColor.color_ffffff,
      headercolor: BaseColor.color_ffffff,
      containerColor: BaseColor.color_ffffff,
      changeToFirst: true,
      onConfirm: onConfirm,
    );
  }


  //省市区选择框
  static Picker getAddressPicker({
    List<Province> lists,
    String title = "",
    dynamic onConfirm,
    bool hasCounty = true,
  }) {
    if (lists != null) {
      return new Picker(
        adapter: PickerDataAdapter(
        data: lists.map((province) {
            return province == null
                ? PickerItem()
                : PickerItem(
                    text: Center(
                      child: TextView(
                        province.name,
                        style: TextStyles.color_333333_14,
                      ),
                    ),
                    value: province,
                    children: (province.children == null || province.children.length == 0)
                        ? []
                        : province.children.map((city) {
                            return city == null
                                ? PickerItem()
                                : PickerItem(
                                    text: Center(
                                      child: TextView(
                                        city.name,
                                        style: TextStyles.color_333333_14,
                                      ),
                                    ),
                                    value: city,
                                    children: hasCounty
                                        ? (city.children == null || city.children.length == 0)
                                            ? []
                                            : city.children.map((district) {
                                                return district == null
                                                    ? PickerItem()
                                                    : PickerItem(
                                                        text: Center(
                                                          child: TextView(
                                                            district.name,
                                                            style: TextStyles.color_333333_14,
                                                          ),
                                                        ),
                                                        value: district,
                                                      );
                                              }).toList()
                                        : [],
                                  );
                          }).toList(),
                  );
          }).toList(),
        ),
        cancelText: "取消",
        cancelTextStyle: TextStyles.color_999999_14,
        confirmText: "确定",
        confirmTextStyle: TextStyles.color_2192fc_14,
        textStyle: TextStyles.color_333333_14,
        title: TextView(
          title,
          style: TextStyles.color_333333_14,
        ),
        itemExtent: 40,
        height: 200,
        changeToFirst: true,
        backgroundColor: BaseColor.color_ffffff,
        headercolor: BaseColor.color_ffffff,
        containerColor: BaseColor.color_ffffff,
        onConfirm: onConfirm,
      );
    } else {
      return Picker();
    }
  }

  //自定义选择框
  static Picker getCustomPicker({
    dynamic adapter,
    String title = "",
    dynamic onConfirm,
    bool changeToFirst: true,
  }) {
    return new Picker(
      adapter: adapter,
      cancelText: "取消",
      cancelTextStyle: TextStyles.color_999999_14,
      confirmText: "确定",
      changeToFirst: changeToFirst,
      confirmTextStyle: TextStyles.color_2192fc_14,
      textStyle: TextStyles.color_333333_14,
      title: TextView(
        title,
        style: TextStyles.color_333333_14,
      ),
      itemExtent: 40,
      height: 200,
      backgroundColor: BaseColor.color_ffffff,
      headercolor: BaseColor.color_ffffff,
      containerColor: BaseColor.color_ffffff,
      onConfirm: onConfirm,
    );
  }
}
