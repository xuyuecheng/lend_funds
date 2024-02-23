import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/pages/common/model/global_config.dart';
import 'package:sahayak_cash/pages/main/controllers/main_config.dart';
import 'package:sahayak_cash/pages/main/controllers/main_controller.dart';
import 'package:sahayak_cash/utils/controller/controller_utils.dart';
import 'package:sahayak_cash/utils/route/route_config.dart';
import 'package:sahayak_cash/utils/service/TelAndSmsService.dart';
import 'package:sahayak_cash/utils/theme/app_theme.dart';

late List<CameraDescription> cameras;

void main() async {
  setUpGetIt();
  await CZMainConfig.CZBeforeRunAppConfig();
  cameras = await availableCameras();
  await GlobalConfig.scrollMessageRequest();
  runApp(ProviderScope(child: App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GoogleInstanceId
    // HttpController.uploadGoogleInstanceIdRequest();
    // HttpController.uploadGoogleTokenRequest();
    HttpController.uploadInstallReferrerRequest();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    CZMainConfig.init(context);
    return GetMaterialApp(
      title: 'sahayak_cash',
      theme: CZAppThemeConfig.themeData,
      initialRoute: CZRouteConfig.initialRouteSplash,
      getPages: CZRouteConfig.getPages,
      onGenerateRoute: CZRouteConfig.generateRoute,
      unknownRoute: CZRouteConfig.onUnknownRoute,
      routingCallback: (routing) {},
      defaultTransition: Transition.rightToLeftWithFade,
      initialBinding: CZControllerBinding(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
