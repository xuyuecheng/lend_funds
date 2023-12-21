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
  //短信验证码
  static const String phoneCode =
      'zap-cropless-euphobia/osf-metapolitics-subcontraoctave';
  //登录/注册
  static const String userLogin = 'curacao/regardless/cadent-electrofishing';
  //表单获取
  static const String formList =
      'dissyllable/smallboy-dishearteningly-unexamining/rheda-polysepalous';
  //表单指定表单
  static const String getOneFormFlow = 'fieldstone-agonising/snakebite-oke';
  //获取产品信息
  static const String product_list = 'lacing-washy/ctn-fives';
  //获取手续费试算
  static const String tria =
      'noic-cryptographical-infarcted/ensheath/cystoscope-nebulous-segmental';
  static const String loan = "pedodontic-cardcarrier-opiology/telophase";
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
  //活体检测
  static const String alive = 'cheyenne/cadaster/tentaculiform';
  //删除用户
  static const String del = 'semiagricultural/shotty-eudaimonism';
  static const String order_list = "omnidirectional/tropocollagen-preharvest";
  static const String repayment_plan =
      "modernity/alimentative-chrp-airfoil/benignly-smudgy-milky";
  static const String upi = "sideroscope/quirkish/plot-disparate-rancho";
  static const String upi_url =
      "spectrofluorometer-dragoness-leavings/rhodoplast-diurnally";
  static const String rollover_plan =
      "lacerna/buckthorn-bullshot/touraine-coreopsis";
}
