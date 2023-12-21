import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/utils/vm/app_model.dart';

final appModel = AppModel();
final appProvider = ChangeNotifierProvider((ref) => appModel);
