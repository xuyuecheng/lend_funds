import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class TelAndSmsService {
  void sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  void openUrl(String url) async {
    // launch(url);
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

GetIt getIt = GetIt.instance;
void setUpGetIt() {
  getIt.registerSingleton(TelAndSmsService());
}
