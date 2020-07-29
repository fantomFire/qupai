import 'package:qupai/login/entity/login_entity.dart';

import 'entity/province.dart';

class CacheManager{
  CacheManager._internal();

  static CacheManager get instance => _getInstance();
  static CacheManager _instance;

  static _getInstance   () {
    if (_instance == null) {
      _instance = new CacheManager._internal();
    }
    return _instance;
  }
  LoginEntity _userInfo;
  List<Province> _provinces;
  List<Province> _selectProvinces;
  String _cookie;
  void setCookie(String cookie) {
    _cookie = cookie;
  }

  String getCookie() {
    return _cookie;
  }


  void   setUserInfo(LoginEntity userInfo) {
    _userInfo = userInfo;
  }
  LoginEntity getUerInfo() {
    return _userInfo;
  }



  set selectProvinces(List<Province> value) {
    _selectProvinces = value;
  }
  List<Province> getSelectProvinceList() {
    return _selectProvinces;
  }

  void setSelectProvinceList(List<Province> selectProvinceList) {
    _selectProvinces = selectProvinceList;
  }

  List<Province> getProvinceList() {
    return _provinces;
  }

  void setProvinceList(List<Province> provinceList) {
    _provinces = provinceList;
  }
}