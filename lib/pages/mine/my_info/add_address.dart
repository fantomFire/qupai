import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:qupai/common_views/inputitem.dart';
import 'package:qupai/common_views/selectitem.dart';
import 'package:qupai/model/address_bean.dart';
import 'package:qupai/model/city.dart';
import 'package:qupai/model/district.dart';
import 'package:qupai/model/province.dart';
import 'package:qupai/utils/cacahe_manager.dart';
import 'package:qupai/utils/pickerutils.dart';
import 'package:qupai/utils/toast_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';


class AddAddress extends StatefulWidget {
  final AddressBean addressData;

  const AddAddress({Key key, this.addressData}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  Picker _addressPicker;
  String address_province;
  String address_city;
  String address_district;

  @override
  void initState() {
    super.initState();
/*    if (widget.addressData != null) {
      nameController.text = widget.addressData?.address_people;
      phoneController.text = widget.addressData?.address_phone;
      detailController.text = widget.addressData?.address_add;
      _addressController.text =
          "${widget.addressData?.address_province} ${widget.addressData?.address_city} ${widget.addressData?.address_district}";
      address_province = widget.addressData?.address_province;
      address_city = widget.addressData?.address_city;
      address_district = widget.addressData?.address_district;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              AppBars.normalTitle(context, "添加地址"),
              InputItem(
                title: "收货人",
                controller: nameController,
                hintText: "您的姓名",
              ),
              InputItem(
                title: "手机号",
                controller: phoneController,
                hintText: "您的手机号",
              ),
              SelectItem(
                must: false,
                controller: _addressController,
                title: "所在地区",
                hintText: "请选择",
                inputTextAlign: TextAlign.right,
                titleWidth: 115,
                rightWidget: Image.asset(
                  UiUtils.getImgPath('nextpage'),
                  width: 8,
                  height: 14,
                ),
                margin: EdgeInsets.only(bottom: 1),
                onclick: () {
                  showAddressPicker(context);
                },
              ),
              InputItem(
                title: "街道小区门牌号",
                controller: detailController,
                hintText: "详细地址",
              ),
              GestureDetector(
                onTap: () {
                  if (widget.addressData == null) {
                    submitAddress();
                  } else {
                    submitEditAddress();
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 45, top: 200, right: 45),
                    decoration: BoxDecoration(
                     color: BaseColor.color_C60000,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    constraints: BoxConstraints.expand(width: 280, height: 40),
                    child: Text(
                      "确定",
                      style: TextStyles.color_withe_18,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddressPicker(BuildContext context) {
    if (_addressPicker == null) {
      _addressPicker = PickerUtils.getAddressPicker(
          lists: CacheManager.instance.getProvinceList(),
          title: "选择地区",
          onConfirm: (Picker picker, List value) {
            StringBuffer sb = new StringBuffer();
            if (picker.getSelectedValues().length >= 1) {
              Province selectProvince = picker.getSelectedValues()[0];
              sb.write(selectProvince.name);
              address_province = selectProvince.name;
            } else {}
            if (picker.getSelectedValues().length >= 2) {
              City selectCity = picker.getSelectedValues()[1];
              sb.write(" ");
              sb.write(selectCity.name);
              address_city = selectCity.name;
            } else {}
            if (picker.getSelectedValues().length >= 3) {
              District selectDistrict = picker.getSelectedValues()[2];

              sb.write(" ");
              sb.write(selectDistrict.name);
              address_district = selectDistrict.name;
            } else {}
            setState(() {
              _addressController.text = sb.toString();
            });
          });
    }
    _addressPicker.showModal(context);
  }

  void submitAddress() async {
    int userId = CacheManager.instance.getUerInfo()?.user_id;
    if (nameController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人姓名");
    } else if (phoneController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人电话");
    } else if (_addressController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人地址");
    } else if (detailController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人详细地址");
    } else {
     /* HttpResponse response =
          await HttpUtil.send(context, "post", Urls.addAddress, {
        "user_id": userId.toString(),
        "address_people": nameController.text.trim().toString(),
        "address_phone": phoneController.text.trim().toString(),
        "address_add": detailController.text.trim().toString(),
        "address_province": address_province,
        "address_city": address_city,
        "address_district": address_district,
      });
      if (response.result) {
        ToastUtil.toast("添加地址成功");
        NavigatorUtil.pop(context, true);
      }*/
    }
  }

  void submitEditAddress() async {
    int userId = CacheManager.instance.getUerInfo()?.user_id;
    if (nameController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人姓名");
    } else if (phoneController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人电话");
    } else if (_addressController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人地址");
    } else if (detailController.text.trim().length == 0) {
      ToastUtil.toast("请输入收货人详细地址");
    } else {
    /*  HttpResponse response =
          await HttpUtil.send(context, "post", Urls.EditAddress, {
        "address_id": widget.addressData.address_id,
        "address_people": nameController.text.trim().toString(),
        "address_phone": phoneController.text.trim().toString(),
        "address_add": detailController.text.trim().toString(),
        "address_province": address_province,
        "address_city": address_city,
        "address_district": address_district,
      });
      if (response.result) {
        ToastUtil.toast("修地址成功");
        NavigatorUtil.pop(context, true);
      }*/
    }
  }
}
