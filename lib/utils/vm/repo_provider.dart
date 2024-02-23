import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/utils/vm/app_model.dart';

final appModel = AppModel();
final appProvider = ChangeNotifierProvider((ref) => appModel);
