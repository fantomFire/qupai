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
  static String getGuide = '/Mydetails/guide';

  static final String forgetPsd = "/Login/uppass"; //忘记密码
  static final String resetPsd = "/Login/savepass"; //修改密码

  static String setNickName = '/Userinfo/up_nickname'; //修改昵称
  static String setUserPhoto = '/Userinfo/userpic'; //修改头像

}
