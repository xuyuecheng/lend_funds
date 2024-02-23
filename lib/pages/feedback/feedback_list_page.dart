import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/pages/common/privacy_agreement.dart';
import 'package:sahayak_cash/pages/feedback/feedback_page.dart';
import 'package:sahayak_cash/utils/base/base_view_model.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/network/dio_request.dart';
import 'package:sahayak_cash/utils/theme/screen_utils.dart';
import 'package:sahayak_cash/utils/time/time_utils.dart';
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
          backgroundColor: Color(0xffEFF0F3),
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
                      dynamic created = item.containsKey("createdfouYQX")
                          ? item["createdfouYQX"]
                          : null;
                      dynamic modified = item.containsKey("modified")
                          ? item["modified"]
                          : null;
                      dynamic content = item.containsKey("contentCxb7jm")
                          ? item["contentCxb7jm"]
                          : null;
                      dynamic replyContent =
                          item.containsKey("replyContentmxfAU7")
                              ? item["replyContentmxfAU7"]
                              : null;
                      List<dynamic>? images = item.containsKey("imagesTBfcXb")
                          ? item["imagesTBfcXb"]
                          : null;
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
                : Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        top: 116.h,
                        child: Image.asset(
                            'assets/feedback/feedback_list_empty.png',
                            width: 167.w,
                            height: 181.w),
                      ),
                      Positioned(
                        bottom: 25.h,
                        child: PrivacyAgreement(),
                      ),
                    ],
                  ),
          ),
          bottomNavigationBar: Container(
            height: 80.h,
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Container(
                  width: CZScreenUtils.screenWidth - 15.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFF00A651),
                      borderRadius: BorderRadius.circular(5.w)),
                  child: TextButton(
                    onPressed: () async {
                      //
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
      "queryBQDz08": {
        "thirdOrderIdq8jvtj": thirdOrderId,
        "pageNowNjald": this.page,
        "pageSizeUTP2dN": 10
      }
    });
    List<dynamic> contents = response["pageLosuN4"].containsKey("contentCxb7jm")
        ? response["pageLosuN4"]["contentCxb7jm"]
        : null;
    return contents;
  }
}
