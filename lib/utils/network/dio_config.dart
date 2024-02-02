class DioConfig {
  static const String baseURL = "https://app.lendfunds.help/";
  static const String IMAGE_URL = "${baseURL}lt-image/resize/0x0/";
  static const Duration timeout = Duration(seconds: 20);
}

class AppConfig {
  static const String appId = 'IOAPAOQJ';
  static const String appName = 'Lend Funds';
  static const String AESKey = 'YG7KaTFGcbJKEdZK';
  static const String AESPadding = 'PKCS5Padding';

  static const String privacyStatementURL =
      "${DioConfig.baseURL}eurychoric-pornocracy-swiple/deuteranopia-filibeg-spadebone/toxoplasma-counterreconnaissance-headrest/l5fjys.html";
  static const String termsAgreement =
      "${DioConfig.baseURL}eurychoric-pornocracy-swiple/deuteranopia-filibeg-spadebone/toxoplasma-counterreconnaissance-headrest/5kiq5o.html";
  static const String permission =
      "${DioConfig.baseURL}eurychoric-pornocracy-swiple/deuteranopia-filibeg-spadebone/toxoplasma-counterreconnaissance-headrest/mzfxpk.html";
  static const String aboutUs =
      "${DioConfig.baseURL}eurychoric-pornocracy-swiple/deuteranopia-filibeg-spadebone/toxoplasma-counterreconnaissance-headrest/hcnihk.html";
}

class InterfaceConfig {
  //短信验证码
  static const String phoneCode = 'send/verification_code';
  //登录/注册
  static const String userLogin = 'login/interface';
  //获取一个未完成表单
  static const String formList = 'get/form_process';
  //表单指定表单
  static const String getOneFormFlow = 'feedback_list';
  //获取产品信息
  static const String product_list = 'get/product_information';
  //获取手续费试算
  static const String tria = 'calculate/handling_fee';
  static const String loan = "loan/apply";
  //提交表单
  static const String submitForm = 'submit/form';
  //上传文件
  static const String uploadFile = 'upload/document';
  //ocr识别
  static const String ocr = 'ocr/user_check';
  //ocr信息提交
  static const String submitOcrInfo = 'submit/user_info';
  static const String address_info = "get/address";
  static const String job_info = "get/job_information";
  //活体检测
  static const String alive = 'face/liveness/verification';
  //删除用户
  static const String del = 'delete_user';
  static const String order_list = "get/user/orders_by_page";
  static const String repayment_plan = "get/order_repayment_plan";
  static const String upi = "get/order/repayment_method";
  static const String upi_url = "order_repayment";
  static const String rollover_plan = "calculation/exhibition_period";
  static const String feedback_list = "get/swati/magicube";
  static const String feedback_type = "question/type";
  static const String feedback_submit = "submit/feedback";
  //检测设备信息上报情况
  static const String dev_report_situation = "check/report_device_information";
  //上报设备信息
  static const String report_dev = "upload/equipment";
}
