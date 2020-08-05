import 'package:flutter/material.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/model/address_bean.dart';
import 'package:qupai/utils/navigator_util.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/textstyles.dart';
import 'package:qupai/widgets/appbars.dart';
class AddressManager extends StatefulWidget {
  @override
  _AddressManagerState createState() => _AddressManagerState();
}

class _AddressManagerState extends State<AddressManager> {
  bool isCheck = true;
  int userId;
  List<AddressBean> addressList = List();
  int selectIndex = -1;

  @override
  void initState() {
    super.initState();
   // userId = CacheManager.instance.getUerInfo()?.user_id;
    getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
      AppBars.normalTitleWithRightButton(context, "地址管理", "添加", () {
            NavigatorUtil.pushNamed(context, "/add_address").then((v) {
              if (v) {
                getAddressList();
              }
            });
          }),
          Line(),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: addressList.length,
                itemBuilder: (BuildContext context, int index) {
                  return getAddressItem(index);
                }),
          ),
        ],
      ),
    );
  }

  Widget getAddressItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: TextView(addressList[index]?.address_people,
                          style: TextStyles.color_333333_15),
                    ),
                    TextView(addressList[index]?.address_phone.toString(),
                        style: TextStyles.color_333333_15),
                  ],
                ),
             Container(
               alignment: Alignment.centerLeft,
               child:    TextView(
                 getAdress(addressList[index]),
                 style: TextStyles.color_999999_14,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
              ],
            ),
          ),
          Line(),
          Container(
            height: 45,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                   if(selectIndex!=index){
                     setCurrentAddress(index);

                   }
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: selectIndex ==index
                            ? Image.asset(
                                UiUtils.getImgPath("address_xuanzhong_icon"),
                                height: 19,
                                width: 19,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                UiUtils.getImgPath("addres_unselected_icon"),
                                height: 19,
                                width: 19,
                                fit: BoxFit.fill,
                              ),
                      ),
                      TextView(
                        "默认地址",
                        style: TextStyles.color_999999_15,
                      ),
                    ],
                  ),
                )),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.pushNamed(context, "/add_address",
                                arguments: {"addressData": addressList[index]})
                            .then((v) {
                          if (v) {
                            getAddressList();
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            UiUtils.getImgPath("addres_redact_icon"),
                            height: 19,
                            width: 19,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 10),
                            child: TextView(
                              "编辑",
                              style: TextStyles.color_999999_14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                          UiUtils.showTipDialog(context,"是否删除该地址",onSubmit: (){
                            deleteAddress(index);
                          });

                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            UiUtils.getImgPath("addres_delete_icon"),
                            height: 19,
                            width: 19,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: TextView(
                              "删除",
                              style: TextStyles.color_999999_14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getAddressList() async {
  /*  HttpResponse response = await HttpUtil.send(
        context, "post", Urls.AddressList, {"user_id": userId.toString()},
        initState: true);

    if (response.result) {
      addressList.clear();
      if (response.datas != null && response.datas.length > 0) {

        for (int i = 0;i< response.datas.length;i++) {
          AddressBean item = AddressBean.fromJson(response.datas[i]);
          if (item.address_status == "1") {
            selectIndex = i;
          }
          addressList.add(item);
        }

      }else{
        ToastUtil.toast(response.message);
      }
      setState(() {});
    }*/
  }

  void deleteAddress(int index) async {
   /* HttpResponse response = await HttpUtil.send(
        context,
        "post",
        Urls.DeleteAddress,
        {"address_id": addressList[index]?.address_id.toString()},
        initState: false);
    if (response.result) {
      ToastUtil.toast("删除地址成功");
      getAddressList();
    }*/
  }

  String getAdress(AddressBean address) {
    StringBuffer sb = new StringBuffer();
    if (address.address_province != null) {
      sb.write(address.address_province);
    }
    if (address.address_city != null) {
      sb.write(address.address_city);
    }
    if (address.address_district != null) {
      sb.write(address.address_district);
    }
    if (address.address_add != null) {
      sb.write(address.address_add);
    }
    return sb.toString();
  }

  void setCurrentAddress(int index) async{
  /*  HttpResponse response = await HttpUtil.send(
        context, "post", Urls.SetAddress, {"user_id": userId.toString(),"address_id":addressList[index].address_id,"address_status":"1"},);

    if (response.result) {
      getAddressList();
    }*/
  }
}
