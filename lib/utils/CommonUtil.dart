import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:qupai/model/city.dart';
import 'package:qupai/model/province.dart';

import 'cacahe_manager.dart';



class CommonUtil {
  // 验证手机号是否合法的正则表达式
  static RegExp _phoneRegExp = new RegExp(r'^1[0-9]{10}$');

  // 验证手机号是否合法
  static bool checkPhone(String phone) {
    return phone.length == 11 && _phoneRegExp.hasMatch(phone);
  }

  // 验证身份证号是否合法
  static bool checkCardId(String cardId) {
    RegExp _passwordRegExp = new RegExp(r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');
    return _passwordRegExp.hasMatch(cardId);
  }
  static bool checkImageType(File file) {
    String fileName = file.path.toLowerCase();
    if (fileName.endsWith(".jpg") ||
        fileName.endsWith(".png") ||
        fileName.endsWith(".jpeg") ||
        fileName.endsWith(".svg") ||
        fileName.endsWith(".bmp") ||
        fileName.endsWith(".tif") ||
        fileName.endsWith(".gif")) {
      return true;
    }
    return false;
  }
  //验证密码
  static bool checkPassword(String password) {
    RegExp _passwordRegExp = new RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$');
    return _passwordRegExp.hasMatch(password);
  }

  //验证邮箱
  static bool checkEmail(String email) {
    RegExp _emailRegExp = new RegExp(r'^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$');
    return _emailRegExp.hasMatch(email);
  }


  static String getAddressString(String province, String city, String district) {
    String result = "";
    if (province != null) {
      result += province;
    }
    if (city != null) {
      result = "$result $city";
    }
    if (district != null) {
      result = "$result $district";
    }
    return result;
  }



  static bool isCardId(String cardId) {
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    // 身份证号码正则
    RegExp postalCode = new RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
    // 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    //将前17位加权因子保存在数组里
    final List idCardList = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = ['1', '0', '10', '9', '8', '7', '6', '5', '4', '3', '2'];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }
    return true;
  }

  static bool compareDateTime(String startDate, String deadline) {
    if (startDate != null && startDate.length != 0 && deadline != null && deadline.length != 0) {
      DateFormat df = new DateFormat("yyyy-MM-dd");
      DateTime startDateTime = df.parse(startDate);
      DateTime deadlineDateTime = df.parse(deadline);
      if (startDateTime.compareTo(deadlineDateTime) >= 0) {
        return true;
      }
    }
    return false;
  }
  //获取省市区数据
  static Future<List<Province>> getRegion(BuildContext context) async {
    List<Province> provinceList = CacheManager.instance.getProvinceList();
    if (provinceList == null) {
      dynamic region = await DefaultAssetBundle.of(context).loadString("assets/region.json");
      dynamic jsonBody = json.decode(region);
      provinceList = new List();
      for (var string in jsonBody) {
        provinceList.add(Province.fromJson(string));
      }
      CacheManager.instance.setProvinceList(provinceList);
    }
    return provinceList;
  }

  static Future<List<Province>> getSelectRegion(BuildContext context) async {
    List<Province> provinceList = CacheManager.instance.getSelectProvinceList();
    if (provinceList == null) {
      dynamic region = await DefaultAssetBundle.of(context).loadString("assets/region.json");
      dynamic jsonBody = json.decode(region);
      provinceList = new List();
      for (var string in jsonBody) {
        Province p = Province.fromJson(string);
        List<City> citys = p.children;
        if (citys != null) {
          City city1 = new City();
          city1.code = null;
          city1.name = "不限";
          citys.insert(0, city1);
          p.children = citys;
        }
        provinceList.add(p);
      }
      Province province = new Province();
      province.code = null;
      province.name = "不限";
      City city = new City();
      city.code = null;
      city.name = "不限";
      List<City> cityLists = new List();
      cityLists.add(city);
      province.children = cityLists;
      provinceList.insert(0, province);
      CacheManager.instance.setSelectProvinceList(provinceList);
    }
    return provinceList;
  }
  static Future initCache(BuildContext context) async {
    dynamic region = await DefaultAssetBundle.of(context).loadString("assets/region.json");
    dynamic jsonBody = json.decode(region);
    List<Province> provinceList = new List();
    for (var string in jsonBody) {
      provinceList.add(Province.fromJson(string));
    }
    CacheManager.instance.setProvinceList(provinceList);
    List<Province> selectProvinceList = new List();
    for (var string in jsonBody) {
      Province p = Province.fromJson(string);
      List<City> citys = p.children;
      if (citys != null) {
        City city1 = new City();
        city1.code = null;
        city1.name = "不限";
        citys.insert(0, city1);
        p.children = citys;
      }
      selectProvinceList.add(p);
    }
    Province province = new Province();
    province.code = null;
    province.name = "不限";
    City city = new City();
    city.code = null;
    city.name = "不限";
    List<City> cityLists = new List();
    cityLists.add(city);
    province.children = cityLists;
    selectProvinceList.insert(0, province);
    CacheManager.instance.setSelectProvinceList(selectProvinceList);

  }
}
