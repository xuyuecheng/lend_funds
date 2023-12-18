import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// 基础Model
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

/// 基础分页Model
abstract class BaseListModel<T> extends BaseModel {
  int page = 1;
  List<T> data = [];
  bool loading = true;

  /// 清除数据，当前场景与下拉刷新一致
  clear() {
    refresh();
  }

  /// 下拉刷新
  refresh() async {
    this.page = 1;
    final list = await loadData();
    this.data.clear();

    if (list != null && list.isNotEmpty) {
      this.data.addAll(list);
    }
    notifyListeners();
  }

  /// 加载更多
  loadMore() async {
    this.page++;
    final list = await loadData();
    if (list != null && list.isNotEmpty) {
      this.data.addAll(list);
      notifyListeners();
    }
    return list != null && list.isNotEmpty;
  }

  /// 子类覆写该方法并返回数据
  Future<dynamic> loadData();
}