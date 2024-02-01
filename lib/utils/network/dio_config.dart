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
  static const String securityProtocol =
      "${DioConfig.baseURL}html/xxx/xxx.html";
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
  static const String tria =
      'noic-cryptographical-infarcted/ensheath/cystoscope-nebulous-segmental';
  static const String loan = "pedodontic-cardcarrier-opiology/telophase";
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
  static const String alive = 'cheyenne/cadaster/tentaculiform';
  //删除用户
  static const String del = 'semiagricultural/shotty-eudaimonism';
  static const String order_list = "get/user/orders_by_page";
  static const String repayment_plan =
      "modernity/alimentative-chrp-airfoil/benignly-smudgy-milky";
  static const String upi = "sideroscope/quirkish/plot-disparate-rancho";
  static const String upi_url =
      "spectrofluorometer-dragoness-leavings/rhodoplast-diurnally";
  static const String rollover_plan =
      "lacerna/buckthorn-bullshot/touraine-coreopsis";
  static const String feedback_list =
      "swati-viduity/magicube-geniture-whaleman";
  static const String feedback_type =
      "cellulated/apneusis-compile-emplane/mesophile";
  static const String feedback_submit =
      "mistakable-corruptibility/undignify-titubate-bight";
  //检测设备信息上报情况
  static const String dev_report_situation = "check/report_device_information";
  //上报设备信息
  static const String report_dev = "upload/equipment";
}
