import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/main/controllers/main_config.dart';
import 'package:lend_funds/utils/controller/controller_utils.dart';
import 'package:lend_funds/utils/route/route_config.dart';
import 'package:lend_funds/utils/theme/app_theme.dart';

late List<CameraDescription> cameras;

void main() async {
  await CZMainConfig.CZBeforeRunAppConfig();
  cameras = await availableCameras();
  runApp(ProviderScope(child: App()));
  //add test1
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
    //上报GoogleInstanceId 接口请求
    // HttpController.requestUploadGoogleInstanceId();
    // HttpController.requestUploadGoogleToken();
    // HttpController.requestUploadAppsflyerId();
    // HttpController.requestFindDotConfig();
    // dealPermission();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    CZMainConfig.init(context);
    return GetMaterialApp(
      title: 'lend_funds',
      theme: CZAppThemeConfig.themeData,
      initialRoute: CZRouteConfig.initialRouteSplash,
      getPages: CZRouteConfig.getPages,
      onGenerateRoute: CZRouteConfig.generateRoute,
      unknownRoute: CZRouteConfig.onUnknownRoute,
      routingCallback: (routing) {},
      defaultTransition: Transition.rightToLeftWithFade,
      initialBinding: CZControllerBinding(),
      builder: EasyLoading.init(),
    );
  }
}
