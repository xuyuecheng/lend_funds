class AddDotLoginConfig {
  //第一次打开（卸载后再次打开也发）
  static const String loginStart = 'login_start';
  //协议页点击确定
  static const String loginClickOk = 'login_click_ok';
  //手机号输入框获取焦点
  static const String loginPhoneFocus = 'login_phone_focus';
  //用户手动输入调用打点
  static const String loginPhoneInput = 'login_phone_input';
  //发送短信验证码
  static const String loginPhoneSend = 'login_phone_send';
  //发送获取短信成功（服务器返回请求成功）
  static const String loginPhoneSucess = 'login_phone_sucess';
  //验证手机号存在后在登陆页点击登陆按钮
  static const String loginClickLogin = 'login_click_login';
  //登陆成功
  static const String loginSucess = 'login_sucess';
  //点击注册后失败
  static const String loginError = 'login_error';
}

class AddDotRepaymentConfig {
  //引导区点击还款
  static const String repaymentClickRepayment = 'repayment_click_repayment';
  //引导区点击提前还款
  static const String repaymentClickEarly = 'repayment_click_early';
  //点击「我要展期」
  static const String repaymentClickDelay = 'repayment_click_delay';
  //进入展期页面
  static const String repaymentPageDelay = 'repayment_page_delay';
  //进入提前还款页面
  static const String repaymentPageEarly = 'repayment_page_early';
  //打开待还页面
  static const String repaymentPageWait = 'repayment_page_wait';

  //还款tab,提前还款
  static const String repaymentTabClickEarly = 'repayment_tab_click_early';
  //还款tab,分期还款
  static const String repaymentClickRepaymentTab =
      'repayment_click_repayment_tab';
  //还款tab,展期还款
  static const String repaymentTabClickDelay = 'repayment_tab_click_delay';

  //我的订单,分期还款
  static const String repaymentClickRepaymentOrder =
      'repayment_click_repayment_order';

  //额度首页,提前还款
  static const String repaymentIndexClickEarly = 'repayment_index_click_early';
  //额度首页,分期还款
  static const String repaymentClickRepaymentIndex =
      'repayment_click_repayment_index';
  //额度首页,展期还款
  static const String repaymentIndexClickDelay = 'repayment_index_click_delay';
}
