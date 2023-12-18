class DioConfig {
  static const String baseURL = "https://app.lendfunds.help/";
  static const Duration timeout = Duration(seconds: 20);
}

class AppConfig {
  static const String appId = 'IOAPAOQJ';
  static const String appName = 'Lend Funds';
  static const String AESKey = 'YG7KaTFGcbJKEdZK';
  static const String AESPadding = 'PKCS5Padding';
  static const String privacyAgreementURL =
      'https://app.rupeerain.xyz/thinclad_uniflow/overblouse/celtic/f1llqb.html';
  static const String permissionProtocolURL =
      'https://app.rupeerain.xyz/thinclad_uniflow/overblouse/celtic/yvsuem.html';
  static const String clauseAgreement =
      'https://app.rupeerain.xyz/thinclad_uniflow/overblouse/celtic/izldod.html';

  static const String privacyStatementURL =
      "${DioConfig.baseURL}html/agreement/PRIVATE.html";
  static const String competenceAgreements =
      "${DioConfig.baseURL}html/agreement/AUTHORITY.html";
  static const String termsAgreement =
      "${DioConfig.baseURL}html/agreement/TERM.html";
  static const String securityProtocol =
      "${DioConfig.baseURL}html/xxx/xxx.html";
  static const String aboutUs = "${DioConfig.baseURL}html/xxx/xxx.html";
}

class InterfaceConfig {
  //打点
  static const String rbi = 'dot/add';

  /// 批量打点
  static const String addBatch = 'dot/add_batch';
  //短信验证码
  static const String phoneCode =
      'zap-cropless-euphobia/osf-metapolitics-subcontraoctave';
  //语音验证码
  static const String sendVotpCode = 'auth/send_votp_code';
  //登录/注册
  static const String userLogin = 'curacao/regardless/cadent-electrofishing';
  //表单获取
  static const String formList =
      'dissyllable/smallboy-dishearteningly-unexamining/rheda-polysepalous';
  //表单指定表单
  static const String getOneFormFlow = 'fieldstone-agonising/snakebite-oke';
  //获取省市区三级联动
  static const String addressList = 'form/address_list';
  //获取产品信息
  static const String product = 'product/get_product';
  //提交表单
  static const String submitForm =
      'warsaw-coitus/hylophagous-meniscoid/jingoism';
  //上传文件
  static const String uploadFile = 'gannet/insphere/roentgenise-peccancy';
  //ocr识别
  static const String ocr = 'transfection/general-significance-deathy';
  //ocr信息提交
  static const String submitOcrInfo =
      'isogamy/tulipwood-fraenulum-afreet/phantasmic-smartless';
  static const String address_info = "dominee-elucidation/ek-fatness-melodrame";
  static const String job_info = "tamburlaine/tatami/controvert";
  //检测设备信息上报情况
  static const String checkUpload = 'device/check_upload';
  //上报设备信息
  static const String devInfo = 'device/upload_device_info';
  //AppList
  static const String appList = 'device/upload_app_info';
  //活体检测
  static const String liveCheck = 'form/liveness_check';
  //活体授权
  static const String authLicense = 'form/auth_license';
  //获取用户额度
  static const String creditAmount = 'user/get_credit_amount';
  //App-额度提升或者在贷一笔弹窗
  static const String creditPopup = 'popup/my_popup_list';
  //App-首贷评价
  static const String evaluate = 'popup/evaluate';
  //根据额度获取产品列表
  static const String getProductByCreditAmount =
      'product/get_product_by_credit_amount';
  //根据产品还款计划
  static const String getProductRepayPlan = 'product/get_product_repay_plan';
  //还款列表
  static const String payBack = 'order/pay_back_page';
  //还款列表tab
  static const String payBackTab = 'order/pay_back_tab';
  //订单列表
  static const String orderList = 'order/page';
  //App我的-银行卡信息
  static const String bankInfo = 'user/get_bank_info';
  //检测更新
  static const String update = 'app/update_version';
  //申请下单
  static const String applyOrder = 'order/apply_order';
  //根据产品数据获取对应额度
  static const String getProductAmount = 'product/get_product_amount';
  //是否删除
  static const String judgeDel = 'user/judge_del_user';
  //删除用户
  static const String del = 'semiagricultural/shotty-eudaimonism';
  //银行卡列表
  static const String bankList = 'bank/repaymentBankList';
  //还款详情
  static const String payBackDetail = 'order/pay_back_detail';
  //还款计划
  static const String payBackPlan = 'order/pay_back_plan';
  //APP-生成还款码
  static const String createCode = 'order/create_code';
  //APP-获取还款码
  static const String getCode = 'order/get_code';
  //App我的-FAQ问题解答接口
  static const String getFaqList = 'faq_question/page';
  //获取后台相关配置
  static const String getUserConfig = 'user/get_user_config';
  //上报谷歌token
  static const String uploadGoogleToken = 'device/upload_google_token';
  //上报google-app-instance-id
  static const String uploadGoogleInstanceId =
      'device/upload_google_instance_id';
  //获取whatsapp email phone等等配置信息
  static const String appFindConfig = 'app/find_config';
  //获取app是否需要打点的开关
  static const String findDotConfig = 'app/find_dot_config';
  //App判断当前用户是否为Google用户
  static const String isGoogleTest = 'user/is_google_test';
  //App判断当前用户是否有消息未读
  static const String haveNoRead = 'msg_record/have_noread';
  //上报appsflyer id
  static const String uploadAppsflyerId = 'device/upload_appsflyer_id';
  //App消息列表
  static const String msgRecordList = 'msg_record/page';
  //该用户的消息全部设置为已读
  static const String msgRecordReadAll = 'msg_record/read_all';
}

class RbiConfig {
  //进入未认证首页（新客首页）
  static const String firstIndexPage = 'first_index_page';
  //新客首页点击申请
  static const String firstIndexClickApply = 'first_index_click_apply';
  //基础信息页点击「下一步」
  static const String firstBaseClickNext = 'first_base_click_next';
  //请求认证基础信息
  static const String firstBaseAuthentication = 'first_base_authentication';
  //认证基础信息成功（服务器返回）
  static const String firstBaseAuthenticationSuccess =
      'first_base_authentication_sucess';
  //认证基础信息失败（服务器返回）
  static const String firstBaseAuthenticationError =
      'first_base_authentication_error';
  //每个输入框失焦时
  static const String firstBaseAuthenticationId = 'first_base_authentication_';
  //打开紧急联系人认证页面
  static const String firstUserEmergPage = 'first_UserEmerg_page';
  //请求认证联系人（「下一步」）
  static const String firstUserEmergClickNext = 'first_UserEmerg_click_next';
  //请求认证联系人（提交）
  static const String firstUserEmergSubmit = 'first_UserEmerg_submit';
  //请求认证联系人（输入）
  static const String firstUserEmergInput = 'first_UserEmerg_input_';
  //紧急联系人认证成功（服务器返回）
  static const String firstUserEmergClickSuccess =
      'first_UserEmerg_click_sucess';
  //紧急联系人认证失败（服务器返回）
  static const String firstUserEmergClickError = 'first_UserEmerg_click_error';
  //打开认证身份页面
  static const String firstOcrPage = 'first_ocr_page';
  //点击OCR相机按钮（正）
  static const String firstOcrFront = 'first_ocr_front';
  //OCR相机返回照片
  static const String firstOcrImage = 'first_ocr_image';
  //OCR识别失败
  static const String firstOcrError = 'first_ocr_error';
  //保存身份证信息，点击「下一步」
  static const String firstOcrClickNext = 'first_ocr_click_next';
  //请求相机权限成功，服务器允许认证后，开始活体检测
  static const String firstLiveness = 'first_liveness';
  //活体检测返回照片成功
  static const String firstLivenessSuccess = 'first_liveness_sucess';
  //活体检测返回照片失败
  static const String firstLivenessError = 'first_liveness_error';
  //打开银行卡认证页面
  static const String firstBankPage = 'first_bank_page';
  //银行卡输入框选择框点击确定时
  static const String firstBankClickOk = 'first_bank_click_ok';
  //银行卡输入框失焦时
  static const String firstBankInput_ = 'first_bank_input_';
  //请求银行卡信息认证
  static const String firstBankSubmit = 'first_bank_submit';
  //银行卡信息认证成功（服务器返回）
  static const String firstBankSucess = 'first_bank_sucess';
  //银行卡信息认证失败（服务器返回）
  static const String firstBankError = 'first_bank_error';
  //提交借款申请
  static const String firstOrderApply = 'first_order_apply';
  //申请贷款成功（服务器返回）
  static const String firstOrderSuccess = 'first_order_sucess';
  //跳转GP
  static const String firstGP = 'first_GP';
}
