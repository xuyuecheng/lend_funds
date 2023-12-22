import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/feedback/feedback_page.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/theme/screen_utils.dart';
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
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shrinkWrap: true,
                      itemCount: model.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = model.data[index];
                        print("item:$item");
                        dynamic created = item.containsKey("created")
                            ? item["created"]
                            : null;
                        dynamic modified = item.containsKey("modified")
                            ? item["modified"]
                            : null;
                        dynamic content = item.containsKey("content")
                            ? item["content"]
                            : null;
                        dynamic replyContent = item.containsKey("replyContent")
                            ? item["replyContent"]
                            : null;
                        List<dynamic>? images =
                            item.containsKey("images") ? item["images"] : null;
                        var imageFirst = "";
                        if (images != null && images.length > 0) {
                          imageFirst = images[0];
                        }
                        return Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                replyContent != null
                                    ? "Reply:${replyContent.toString()}"
                                    : "Reply:",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                content != null
                                    ? "Question:$content"
                                    : "Question:",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                created != null
                                    ? "Created time:${CZTimeUtils.formatDateTime(created, format: "yyyy-MM-dd HH:mm:ss")}"
                                    : "Created time:",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  // SizedBox(
                                  //   width: 25,
                                  // ),
                                  imageFirst.length > 0
                                      ? Image.network(
                                          imageFirst,
                                          width: 106.w,
                                          height: 106.w,
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                created != null
                                    ? "Reply time:${CZTimeUtils.formatDateTime(modified, format: "yyyy-MM-dd HH:mm:ss")}"
                                    : "Reply time:",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15.h,
                        );
                      },
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 91.h,
                        ),
                        Image.asset('assets/feedback/feedback_list_empty.png',
                            width: 345.w, height: 345.w),
                      ],
                    )),
          bottomNavigationBar: Container(
            height: 80.h,
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Container(
                  width: CZScreenUtils.screenWidth - 30.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFF003C6A),
                      borderRadius: BorderRadius.circular(5.w)),
                  child: TextButton(
                    onPressed: () async {
                      //跳转到反馈界面
                      var result = await Get.to(() => FeedbackPage(
                            thirdOrderId: widget.thirdOrderId,
                          ));
                      if (result != null && result) {
                        await model.refresh();
                        refreshController.refreshCompleted();
                        refreshController.loadComplete();
                      }
                    },
                    child: Text("Submit Questions",
                        style: TextStyle(
                            fontSize: 17.5.sp,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
          ));
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
