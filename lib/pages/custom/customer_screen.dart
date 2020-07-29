import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qupai/common_views/appbar_actions.dart';
import 'package:qupai/common_views/customview.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/utils/file_select.dart';
import 'package:qupai/utils/time_utlils.dart';
import 'package:qupai/utils/uiutils.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';
import 'entity/message_detail_bean_entity.dart';

class CustomServiceScreen extends StatefulWidget {
  @override
  _CustomServiceScreenState createState() => _CustomServiceScreenState();
}

class _CustomServiceScreenState extends State<CustomServiceScreen>
    with WidgetsBindingObserver {
  List<MessageEntity> dataList = new List();
  EasyRefreshController _controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();
  List<MessageEntity> data = [];
  int mDataPage = 0;
  bool isShow = false;
  TextEditingController _replyFieldController = new TextEditingController();
  String user_id;
  final ImagePicker _picker = ImagePicker();
  List<String> emoList;

  int page = 1;
  int lastMessId = -1;
  FileSelect _fileUploadUtil;
  bool isFirst = true;
  bool hasAdd = false;
  bool showButton = false;
  Timer timer;
  double offset = 0;
  double height = 0;
  double extentAfter = 0;
  FocusNode _commentFocus = FocusNode();
  String csId = "1";
  @override
  void initState() {
    super.initState();
  //  initEmo();
    WidgetsBinding.instance.addObserver(this);
   // getService();
    user_id = UiUtils.getUserId();
    scrollController.addListener(() {
      setState(() {
        extentAfter = scrollController.position.extentAfter;
      });
    });

    _commentFocus.addListener(() {
      if (_commentFocus.hasFocus) {
        // TextField has lost focus
        isShow = false;
        setState(() {});
      }
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
         // setToBottom();
        } else {
         // setToBottom();
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    if(timer!=null){
      if (timer.isActive) {
        timer.cancel();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          // Focus.of(context).requestFocus(FocusNode());
          _commentFocus.unfocus();
          isShow = false;
          setState(() {});
        },
        child: Column(
          children: <Widget>[
            MyAppBarActions.getInstance()
                .getSecondaryTopAppBar(context, "我的客服"),
            Line(
              height: 10,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(bottom: 10),
              color: BaseColor.color_chat,
              child: EasyRefresh(
                header: ClassicalHeader(
                  refreshText: "下拉加载",
                  refreshReadyText: "松手加载",
                  refreshingText: "正在加载",
                  refreshedText: "加载完成",
                  infoText: "刷新于 %T",
                  bgColor: BaseColor.color_ffffff,
                  textColor: BaseColor.color_333333,
                ),
                controller: _controller,
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  itemCount: dataList.length,
                  itemBuilder: _itemBuild,
                ),
                onRefresh: () async {
                  page++;

                },
              ),
            )),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 15, bottom: 5),
                          decoration: BoxDecoration(
                              color: BaseColor.color_ffffff,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: TextField(
                            controller: _replyFieldController,
                            onSubmitted: (value) {

                            },
                            onChanged: (v) {
                              setState(() {
                                if (v != null) {
                                  showButton = true;
                                }
                                if (v == "") {
                                  showButton = false;
                                }

                                scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent);
                              });
                            },
                            maxLines: 10,
                            minLines: 1,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15.0,
                                    top: 10.0,
                                    bottom: 6.0,
                                    right: 15.0),
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: BaseColor.color_ffffff))),
                            style: TextStyle(color: Colors.black87),
                            focusNode: _commentFocus,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            isShow = !isShow;
                            _commentFocus.unfocus();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerRight,
                            child: Image.asset(UiUtils.getImgPath("emotion")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new IconButton(
                    icon: Image.asset(UiUtils.getImgPath('add_file')),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                    },
                  ),
                  showButton
                      ? Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: new Theme(
                            data: Theme.of(context).copyWith(
                                buttonTheme: ButtonThemeData(
                                    minWidth: 40.0,
                                    height: 5,
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        top: 0.0,
                                        right: 10.0,
                                        bottom: 0.0))),
                            child: new RaisedButton(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 2, bottom: 2.0, right: 10.0),
                              onPressed: () {
                                _commentFocus.requestFocus();

                              },
                              color: BaseColor.color_d68,
                              child:
                                  Text("发送", style: TextStyles.color_ffffff_14),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),
                          ))
                      : Container(),
                ],
              ),
            ),
            isShow
                ? Container(
                    height: 180,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1),
                      itemCount: emoList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            isShow = false;
                            setState(() {});
                          },
                          child: Container(
                            child:
                                Image.asset(UiUtils.getEmoPath(emoList[index])),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _itemBuild(context, index) {
    return Column(
      children: <Widget>[
        /* SizedBox(
          height: 20,
        ),*/
        "showTime(index)"=="1"
            ? Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 44,
                      height: 1,
                      color: BaseColor.color_lineColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: TextView(
                          "${TimeUtils.getChatTime(dataList[index].create_time)}"),
                    ),
                    Container(
                      width: 44,
                      height: 1,
                      color: BaseColor.color_lineColor,
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(
          height: 15,
        ),

      ],
    );
  }
/*
  void _getNewDatas() async {
    HttpResponse response = await HttpUtil.send(
        context,
        "post",
        Urls.chatRefresh,
        {"user_id": user_id, "cs_id": csId, "sender": '2', 'id': lastMessId},
        showLoading: false,
        initState: true);
    if (response.result) {
      if (response.datas != null && !response.datas.isEmpty) {
        for (var i in response.datas) {
          MessageEntity info = MessageEntity.fromJson(i);
          dataList.add(info);
          hasAdd = true;
        }

        setState(() {});
      }
      if (hasAdd) {
        hasAdd = false;
        Timer(Duration(milliseconds: 200), () {
          if (dataList.length > 0) {
            if (isFirst) {
              isFirst = false;
              setToBottom();
            }
            lastMessId = dataList[dataList.length - 1].id;
            if (extentAfter < height / 2) {
              print('滑动到最底部');
              setToBottom();
            }
          }
        });
      }

      // scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void _getDatas() async {
    HttpResponse response = await HttpUtil.send(context, "post", Urls.chatList,
        {"user_id": user_id, "cs_id": csId, "sender": '2', 'page': page},
        initState: true);
    if (response.result) {
      if (response.datas != null) {
        for (var i in response.datas) {
          MessageEntity info = MessageEntity.fromJson(i);
          dataList.insert(0, info);
        }
      }
      setState(() {});
    }
  }

  void _replyMessage(String content, String chat_type) async {
    HttpResponse response = await HttpUtil.send(
      context,
      "post",
      Urls.sendMess,
      {
        'cs_id': csId,
        'user_id': user_id,
        'conetent': content,
        'chat_type': chat_type,
        'sender': '2'
      },
    );
    if (response.result) {
      setState(() {
        showButton = false;
        _replyFieldController.text = "";
      });
      _getNewDatas();
    }
  }

  Widget getText(bool left, MessageEntity info) {
    return left
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getImageLeft(info.cs_image),
              Container(
                constraints: BoxConstraints(maxWidth: 220),
                margin: EdgeInsets.only(
                  left: 16,
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BaseColor.color_d68,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(3),
                    ),
                  ),
                  child: TextView(
                    "${info.conetent.trim()}",
                    style: TextStyles.color_ffffff_14,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxWidth: 220),
                margin: EdgeInsets.only(right: 5),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BaseColor.color_ffffff,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: TextView(
                    "${info.conetent}",
                    style: TextStyles.color_333333_14,
                  ),
                ),
              ),
              imgPhotoRight(info.user_img),
            ],
          );
  }

  Widget setMessage(MessageEntity info) {
    if (info.chat_type == 1) {
      if (info.sender == 1) {
        return getText(true, info);
      } else {
        return getText(false, info);
      }
    } else if (info.chat_type == 2) {
      if (info.sender == 1) {
        return getImage(true, info);
      } else {
        return getImage(false, info);
      }
    } else if (info.chat_type == 3) {
      if (info.sender == 1) {
        return getEmoImage(true, info);
      } else {
        return getEmoImage(false, info);
      }
    }

    return Container();
  }

  Widget getImage(bool left, MessageEntity info) {
    return left
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getImageLeft(info.cs_image),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new FadeRoute(
                      page: PhotoViewSimpleScreen(
                    imageProvider:
                        NetworkImage("${Urls.imageBase}${info.conetent}"),
                    heroTag: 'simple',
                  )));
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 140),
                  margin: EdgeInsets.only(left: 16),
                  child: ImageUtil(
                    url: "${Urls.imageBase}${info.conetent}",
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new FadeRoute(
                      page: PhotoViewSimpleScreen(
                    imageProvider:
                        NetworkImage("${Urls.imageBase}${info.conetent}"),
                    heroTag: 'simple',
                  )));
                },
                child: Container(
                  color: BaseColor.color_ffffff,
                  alignment: Alignment.topLeft,
                  *//*  constraints: new BoxConstraints.expand(
                    width: 100,height: 140
                  ),*//*
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 140),
                  child: ImageUtil(
                    url: "${Urls.imageBase}${info.conetent}",
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              imgPhotoRight(info.user_img),
            ],
          );
  }

  Widget getEmoImage(bool left, MessageEntity info) {
    return left
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getImageLeft(info.cs_image),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Image.asset(
                  UiUtils.getEmoPath(info.conetent),
                  width: 38,
                  height: 38,
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                child: Image.asset(
                  UiUtils.getEmoPath(info.conetent),
                  width: 38,
                  height: 38,
                ),
              ),
              imgPhotoRight(info.user_img),
            ],
          );
  }

  void saveImage() {
    if (_fileUploadUtil == null) {
      _fileUploadUtil = new FileSelect(context);
    }
    _fileUploadUtil.selectPhoto(({file, result}) {
      upload(file, result);
    });
  }

  void upload(File file, result) async {
    HttpResponse httpResponse =
        await FileUpLoadServer.sendImage(context, user_id, csId, file);
    if (httpResponse.result) {
      setState(() {
        _replyFieldController.text = "";
      });
      _getNewDatas();
    }
  }

  void initEmo() {
    emoList = new List();
    for (int i = 1; i < 100; i++) {
      emoList.add("sg$i");
    }
    setState(() {});
  }

  setToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  bool showTime(index) {
    if (index != 0) {
      if ((dataList[index].create_time - dataList[index - 1].create_time) >
          10 * 60) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Widget imgPhotoRight(String user_img) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: ImageUtil(
          url: "${Urls.imageBase}$user_img",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getImageLeft(String cs_image) {
    print('cs_image' + cs_image);
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: ImageUtil(
          url: "${Urls.imageBase}$cs_image",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void getService() async {
    HttpResponse response = await HttpUtil.send(context, "post", Urls.service,{}, initState: true);
    if(response.result){
      ChatBean chatBean = ChatBean.fromJson(response.datas);
      if(chatBean!=null){
        csId = chatBean.cs_id.toString();
        _getNewDatas();
        timer = new Timer.periodic(Duration(seconds: 3), (as) {
          _getNewDatas();
        });
      }

    }else{
      timer = new Timer.periodic(Duration(seconds: 3), (as) {
        _getNewDatas();
      });
    }


  }*/
}
