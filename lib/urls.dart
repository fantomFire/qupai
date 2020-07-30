class Urls {
  static final String base = "http://tianyun.skybirdcloud.com/api";
 // static final String base = "http://appshop.skybirdcloud.com/api";
  static final String imageBase = "http://tianyun.skybirdcloud.com/";
  static final String imageTest = "http://5b0988e595225.cdn.sohucs.com/images/20190421/f71c5a13db224d82882c336db9fe7b6e.jpeg";

  static final String AddBank = "/login/add_bank"; //添加银行卡
  static final String Login = "/Clientlogin/login"; //登录
  static final String Register = "/login/registered"; //注册

  static final String CardManager = "/login/bank_admin"; //银行卡管理
  static final String addAddress = "/Addressbook/add"; //添加收货地址
  static final String EditAddress =   "/Addressbook/edit";//修改收货地址
  static final String AddressList = "/Addressbook/index"; //地址列表
  static final String SetAddress =  "/Addressbook/edit"; //默认地址
  static final String getYZM = '/login/send';//验证码
  static final String DeleteAddress = "/Addressbook/delete"; //删除地址
  static final String HomeUrl = "/shouye/goodslist";//首页地址
  static final String HomeNoid = "/shouye/goodslistpro";//首页地址

  static final String MyTeam= "/login/team"; //我的团队
  static final String  version  ="/login/edition";//版本
  static final String  Banner  ="/shouye/banner" ;//banner
  static final String  UserInfo  ="/login/my";//用户信息
  static final String  Setting  ="/login/set";//设置
  static final String  loginOut  ="/clientlogin/quit";// 退出登录
  static final String  GoodDetail  ="/shouye/goodslist"; // 商品详情
  static final String  OrderList  ="/order" ;//订单列表
  static final String  getCards  ="/login/bank_list"; // 获取银行卡列表
  static final String  getWallet  ='/login/bill';//我的钱包
  static final String  uploadPhoto  ='/login/upload' ;// 身份证
  static final String  personIdentify  ='/login/certification';//实名认证
  static final String  ordinaryDetail='/order/order_info';//普通订单接口
  static final String  checkedLogistics= '/Logistics/Logisticslist';//查看物流
  static final String  getSaleDetail= '/order/sale_info';//挂售详情
  static final String  withdrawalInfo='/login/withdraw';//提现页面数据
  static final String  defaultAddress='/Addressbook/default_address';//默认地址
  static final String  deleteCard='/login/bank_del';//删除银行卡
  static final String  mineMoney='/login/sale';//我的分利
  static final String  addSale='/order/add';//添加挂售订单
  static final String  getRate='/order/rate_add'; //查看利率
  static final String customer='/login/service';//客服
  static final String updatePass='/login/change';//修个密码
  static final String getMoney='/login/withdraw_add';//提现

  static final String toPay='/order/paytype';//支付

  static final String payInfo='/order/pay_info';//支付信息

  static final String invite ='/login/invite_friends';
  static final String mineLevel ='/login/my_grades';//我的等级
  static final String uplaoadPictuer ='/user/userheadsculpture';

  static String nick ='/user/useredit';

  static String savePictuer='/user/useredit';

  static String addAli='/login/add_zfb'; //添加支付宝
  static String addAliCode= '/login/add_zfbqrcode';

  static String getAliInfo='/login/zfblist';

  static String addAliPictuer='/login/add_zfbqrcode';//支付宝信息

  static String getRule='/Article/article';
  static String homeTab='/shouye/goodscatelist';//首页tab

  static String certificationSucc='/login/card_status';

  static String cancelOrder = '/order/pay_cancel';//取消订单

  static String findPass = '/login/find';
  static String chatList ='/chat/chat_list';
  static String sendMess ='/chat/chat_add';

  static String chatRefresh = '/chat/chat_refresh';

  static String sendImage='/chat/upload';
  static String updateVersion='http://tianyun.skybirdcloud.com/down/?from=singlemessage#/';

  static String service='/login/service';//客服
}
