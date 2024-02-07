import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// Model
class BaseModel extends ChangeNotifier {
  List<CancelToken> cancelTokens = [];

  CancelToken getCancelToken() {
    CancelToken token = CancelToken();
    addCancelToken(token);
    return token;
  }

  addCancelToken(CancelToken token) {
    if (!cancelTokens.contains(token)) {
      cancelTokens.add(token);
    }
  }

  @override
  void dispose() {
    cancelTokens.forEach((element) => element.cancel());
    super.dispose();
  }
}

/// Model
abstract class BaseListModel<T> extends BaseModel {
  int page = 1;
  List<T> data = [];
  bool loading = true;

  ///
  clear() {
    refresh();
  }

  ///
  refresh() async {
    this.page = 1;
    final list = await loadData();
    this.data.clear();

    if (list != null && list.isNotEmpty) {
      this.data.addAll(list);
    }
    notifyListeners();
  }

  ///
  loadMore() async {
    this.page++;
    final list = await loadData();
    if (list != null && list.isNotEmpty) {
      this.data.addAll(list);
      notifyListeners();
    }
    return list != null && list.isNotEmpty;
  }

  ///
  Future<dynamic> loadData();
}
