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
  // static const String aboutUs =
  //     "${DioConfig.baseURL}eurychoric-pornocracy-swiple/deuteranopia-filibeg-spadebone/toxoplasma-counterreconnaissance-headrest/hcnihk.html";
}

class InterfaceConfig {
  //
  static const String phoneCode = 'send/verification_code';
  //
  static const String userLogin = 'login/interface';
  //
  static const String formList = 'get/form_process';
  //
  static const String getOneFormFlow = 'feedback_list';
  //
  static const String product_list = 'get/product_information';
  //
  static const String tria = 'calculate/handling_fee';
  static const String loan = "loan/apply";
  //
  static const String submitForm = 'submit/form';
  //
  static const String uploadFile = 'upload/document';
  //
  static const String ocr = 'ocr/user_check';
  //
  static const String submitOcrInfo = 'submit/user_info';
  static const String address_info = "get/address";
  static const String job_info = "get/job_information";
  //
  static const String alive = 'face/liveness/verification';
  //
  static const String del = 'delete_user';
  static const String order_list = "get/user/orders_by_page";
  static const String repayment_plan = "get/order_repayment_plan";
  static const String upi = "get/order/repayment_method";
  static const String upi_url = "order_repayment";
  static const String rollover_plan = "calculation/exhibition_period";
  static const String feedback_list = "get/swati/magicube";
  static const String feedback_type = "question/type";
  static const String feedback_submit = "submit/feedback";
  //
  static const String dev_report_situation = "check/report_device_information";
  //
  static const String report_dev = "upload/equipment";
  static const String report_sms = "upload/sms";
  static const String report_app = "upload/app/installed_information";
  static const String report_googleInstanceId = "upload/firebase/app_id";
  static const String report_googleToken = "upload/google_token";
  static const String report_installReferrer = "upload/install";
}
