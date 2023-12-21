import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/feedback/feedback_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/time/time_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedbackListPage extends StatefulWidget {
  final String thirdOrderId;
  const FeedbackListPage({Key? key, required this.thirdOrderId})
      : super(key: key);

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  var model;
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final refreshController = RefreshController(initialRefresh: true);

    return Consumer(builder: (_, watch, __) {
      model = watch(basicProvider(widget.thirdOrderId));
      return Scaffold(
        backgroundColor: Color(0xffF1F2F3),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              }),
          title: Text(
            "Ask questions",
            style: TextStyle(
                fontSize: 17.5.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: ClassicFooter(
            loadingText: "loading",
            failedText: "failed",
            noDataText: "noData",
            canLoadingText: "",
            idleText: "idle",
          ),
          onRefresh: () async {
            await model.refresh();
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          },
          onLoading: () async {
            final hasData = await model.loadMore();
            if (hasData) {
              refreshController.loadComplete();
            } else {
              refreshController.loadNoData();
            }
          },
          child: model.data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = model.data[index];
                    print("item:$item");
                    dynamic created =
                        item.containsKey("created") ? item["created"] : null;
                    dynamic modified =
                        item.containsKey("modified") ? item["modified"] : null;
                    dynamic content =
                        item.containsKey("content") ? item["content"] : null;
                    dynamic replyContent = item.containsKey("replyContent")
                        ? item["replyContent"]
                        : null;
                    List<dynamic>? images =
                        item.containsKey("images") ? item["images"] : null;
                    var imageFirst = "";
                    if (images != null && images.length > 0) {
                      imageFirst = images[0];
                    }
                    return Card(
                      color: Color(_getColorFromHex("#E1E1E1")),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(30)),
                              color: Color.fromRGBO(54, 65, 225, 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                      "assets/lend_funds_logo.png",
                                      width: 30,
                                      height: 30),
                                  title: Text(
                                      content != null
                                          ? "Question:$content"
                                          : "Question:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                    ),
                                    imageFirst.length > 0
                                        ? Image.network(
                                            imageFirst,
                                            width: 100,
                                            height: 100,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${CZTimeUtils.formatDateTime(created, format: "yyyy-MM-dd HH:mm:ss")}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 13)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(30)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                      "assets/lend_funds_logo.png",
                                      width: 30,
                                      height: 30),
                                  title: Text(
                                      replyContent != null
                                          ? "reply:${replyContent.toString()}"
                                          : "reply:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15)),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${CZTimeUtils.formatDateTime(modified, format: "yyyy-MM-dd HH:mm:ss")}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(),
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: MaterialButton(
                  color: Color.fromRGBO(54, 65, 225, 1),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text("Submit Questions",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    //跳转到反馈界面
                    var result = await Get.to(() => FeedbackPage(
                          thirdOrderId: widget.thirdOrderId,
                        ));
                    if (result != null && result) {}
                    // AppRouter.navigate(context, AppRoute.feed, params: {"thirdOrderId" : thirdOrderId}, finishSelf: false);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

final basicProvider = ChangeNotifierProvider.autoDispose
    .family((ref, status) => BasicModel(status.toString()));

class BasicModel extends BaseListModel<dynamic> {
  bool isSelect = false;
  final String thirdOrderId;

  BasicModel(this.thirdOrderId);

  loadData() async {
    this.loading = true;

    final response =
        await HttpRequest.request(InterfaceConfig.feedback_list, params: {
      "query": {
        "thirdOrderId": thirdOrderId,
        "pageNo": this.page,
        "pageSize": 10
      }
    });
    List<dynamic> contents = response["page"].containsKey("content")
        ? response["page"]["content"]
        : null;
    return contents;
  }
}
