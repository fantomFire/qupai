
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qupai/widgets/WZButton.dart';
import 'package:qupai/widgets/WZChatTextField.dart';


class ChatPage extends StatefulWidget {
  final Map arguments;
  ChatPage({Key key, this.arguments}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController = ScrollController();
  bool isShow = false;
  bool isEmojiShow = false;
  String _inputString = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _listItemWidgetLeft(data) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().getAdapterSize(5),
                horizontal: ScreenUtil().getAdapterSize(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                    child: CachedNetworkImage(
                  imageUrl:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  width: ScreenUtil().getAdapterSize(50),
                  height: ScreenUtil().getAdapterSize(50),
                  fit: BoxFit.fill,
                )),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: ScreenUtil().getAdapterSize(50)),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(ScreenUtil().getAdapterSize(10)),
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().getAdapterSize(10),
                        ScreenUtil().getAdapterSize(10),
                        ScreenUtil().getAdapterSize(30),
                        ScreenUtil().getAdapterSize(10)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                ScreenUtil().getAdapterSize(20)))),
                    child: Text(
                      "消息的内容",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: ScreenUtil().getAdapterSize(12)),
                    ),
                  ),
                )
              ],
            )));
  }

  Widget _listItemWidgetRight(data) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().getAdapterSize(5),
                horizontal: ScreenUtil().getAdapterSize(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: ScreenUtil().getAdapterSize(50)),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(ScreenUtil().getAdapterSize(10)),
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().getAdapterSize(30),
                        ScreenUtil().getAdapterSize(10),
                        ScreenUtil().getAdapterSize(10),
                        ScreenUtil().getAdapterSize(10)),
                    decoration: BoxDecoration(
                        color: Color(0xffC60000),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                ScreenUtil().getAdapterSize(20)))),
                    child: Text(
                      "消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容消息的内容",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().getAdapterSize(12)),
                    ),
                  ),
                ),
                ClipOval(
                    child: CachedNetworkImage(
                  imageUrl:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  width: ScreenUtil().getAdapterSize(50),
                  height: ScreenUtil().getAdapterSize(50),
                  fit: BoxFit.fill,
                )),
              ],
            )));
  }

  Widget _bodyWidget(list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return index.isEven
            ? _listItemWidgetLeft(list[index])
            : _listItemWidgetRight(list[index]);
      },
    );
  }

//相册
  Future _getPicture() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (image != null) {}
    });
  }

/*拍摄视频*/
  Future _takeVideo() async {
    File image = await ImagePicker.pickVideo(source: ImageSource.camera);
    setState(() {
      if (image != null) {}
    });
  }

  /*图库*/
  Future _getFile() async {
    File image = await FilePicker.getFile(type: FileType.any);
    setState(() {
      // if (image != null) {
      //   _uploadImage(image);
      // }
    });
  }

  _emoJiList() {
    // if (!_isShowBottomEmoJi || _commentFocus.hasFocus) {
    //   return Container();
    // } else {
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString("assets/emoji_list.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = json.decode(snapshot.data.toString());

            return Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  padding:
                      EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                  color: Colors.white,
                  child: GridView.custom(
                    padding: EdgeInsets.all(3),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 6.0,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _inputString = _inputString +
                                  String.fromCharCode(data[index]["unicode"]);
                            });
                          },
                          child: Center(
                            child: Text(
                              String.fromCharCode(data[index]["unicode"]),
                              style: TextStyle(fontSize: 33),
                            ),
                          ),
                        );
                      },
                      childCount: data.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        });
    // }
  }

  @override
  Widget build(BuildContext context) {
    List list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
    return Scaffold(
      appBar: AppBar(
        title: Text("在线客服"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: _bodyWidget(list),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(
            maxHeight: isShow
                ? ScreenUtil().getAdapterSize(133)
                : isEmojiShow
                    ? ScreenUtil().getAdapterSize(245)
                    : ScreenUtil().getAdapterSize(45)),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().getAdapterSize(5),
            horizontal: ScreenUtil().getAdapterSize(10)),
        decoration: BoxDecoration(
            // color: Theme.of(context).backgroundColor,
            ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: WZChatTextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    isDense: true,
                    hintText: "请输入您要咨询的内容",
                    button: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            right: ScreenUtil().getAdapterSize(10)),
                        child: InkWell(
                            child: Icon(
                              Icons.insert_emoticon,
                              size: ScreenUtil().getAdapterSize(20),
                            ),
                            onTap: () {
                              setState(() {
                                isEmojiShow = !isEmojiShow;
                                isShow = false;
                              });
                            })),
                    suffixIconWidth: ScreenUtil().getAdapterSize(35),
                    suffixIconHeight: ScreenUtil().getAdapterSize(18),
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            // 设置内容
                            text: _inputString,
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: _inputString.length)))),
                    onChanged: (value) {
                      LogUtil.v("消息内容:" + value, tag: "摩登");
                      setState(() {
                        _inputString = value;
                      });
                    },
                    onSubmitted: (text) {
                      //内容提交(按回车)的回调
                      LogUtil.v("发送消息内容:" + text, tag: "摩登");
                      setState(() {
                        _inputString = text;
                      });
                    },
                    // errorText: "手机号不能为空",
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(left: ScreenUtil().getAdapterSize(10)),
                    child: _inputString.length > 0
                        ? WZButton(
                            color: Color(0xffC60000),
                            width: ScreenUtil().getAdapterSize(60),
                            height: ScreenUtil().getAdapterSize(25),
                            title: "发送",
                            onTap: () {},
                          )
                        : InkWell(
                            child: Icon(
                              Icons.add_circle_outline,
                              size: ScreenUtil().getAdapterSize(20),
                            ),
                            onTap: () {
                              // _openModalBottomSheet(context);
                              setState(() {
                                isShow = !isShow;
                                isEmojiShow = false;
                              });
                            }))
              ],
            ),
            isShow
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().getAdapterSize(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _getFile();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().getAdapterSize(70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().getAdapterSize(10)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.photo,
                                    size: ScreenUtil().getAdapterSize(30),
                                  ),
                                ),
                                Text("相册")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().getAdapterSize(10),
                        ),
                        InkWell(
                          onTap: () {
                            _takeVideo();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().getAdapterSize(70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().getAdapterSize(10)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: ScreenUtil().getAdapterSize(30),
                                  ),
                                ),
                                Text("拍摄")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
                : isEmojiShow ? _emoJiList() : SizedBox()
          ],
        ),
      ),
    );
  }
}
