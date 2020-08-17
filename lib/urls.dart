class Urls {
  static final String base = "http://auction.skybirdcloud.com/api";
  static final String imageBase = "http://auction.skybirdcloud.com/";
  static final String imageTest =
      "http://5b0988e595225.cdn.sohucs.com/images/20190421/f71c5a13db224d82882c336db9fe7b6e.jpeg";
  static final String Login = "/Login/index"; //登录
  static final String Register = "/Login/register"; //注册
  static final String getYZM = '/Login/Smscode'; //验证码
  static final String MyTeam = "/login/team"; //我的团队
  static final String version = "/login/edition"; //版本
  static final String UserInfo = "/Userinfo/userinfo"; //用户信息
  static final String Setting = "/login/set"; //设置
  static final String customer = '/login/service'; //客服
  static final String uplaoadPictuer = '/user/userheadsculpture';
  static String savePictuer = '/user/useredit';
  static String certificationSucc = '/login/card_status';

  static String findPass = '/login/find';
  static String chatList = '/chat/chat_list';
  static String sendMess = '/chat/chat_add';

  static String chatRefresh = '/chat/chat_refresh';

  static String sendImage = '/chat/upload';

  static String addAliPictuer = "";
  static String uploadPhoto = "";

  static String homeInfo = '/Homepage/index'; //首页信息
  static String goodsList = '/Homepage/specialgoods'; //专场列表
  static String goodDetail = '/Homepage/goods'; //商品详情

  static String getGuide = '/Mydetails/guide';

  static final String forgetPsd = "/Login/uppass"; //忘记密码
  static final String resetPsd = "/Login/savepass"; //修改密码

  static String setNickName = '/Userinfo/up_nickname'; //修改昵称
  static String setUserPhoto = '/Userinfo/userpic'; //修改头像
  static String toRenZheng = '/Mydetails/certification'; //实名认证
  static String checkRenZheng = '/Mydetails/iscid'; //检测实名认证
  static String getRenZheng = '/Mydetails/cidpage'; //获取实名认证数据
  static String uploadCodePic = '/Mydetails/instancset'; //上传支付二维码


  static final String orderAll = "/Myorder/index"; //我的买单 全部
  static final String orderUnPaid = "/Myorder/unpaid"; //我的买单 待付款
  static final String orderConform = "/Myorder/unconfirmed"; //我的买单 待确认
  static final String orderAppeal = "/Myorder/appeal"; //我的买单 申诉
  static final String orderCancel = "/Myorder/cancel"; //我的买单 已取消
  static final String orderCompleted = "/Myorder/completed"; //我的买单 已完成
  static final String orderDetail = "/Myorder/orderdetail"; //我的买单 详情

  static final String sellAll = "/Myorder/saleorder"; //我的卖单 全部
  static final String sellNosale = "/Myorder/nosale"; //我的卖单 待交易
  static final String sellNobuy = "/Myorder/nobuy"; //我的卖单 待收款
  static final String sellHaveappeal = "/Myorder/haveappeal"; //我的卖单 申诉
  static final String sellReceived = "/Myorder/received"; //我的卖单 已完成
  static final String sellDetail = "/Myorder/myorderdel"; //我的卖单 详情





}
