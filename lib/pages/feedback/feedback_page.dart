import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/pages/camera/views/camera_kpt.dart';
import 'package:sahayak_cash/pages/credit/view/widget/dict_sheet.dart';
import 'package:sahayak_cash/utils/base/base_view_model.dart';
import 'package:sahayak_cash/utils/entity/syscode_entity.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/network/dio_request.dart';
import 'package:sahayak_cash/utils/theme/screen_utils.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as myBottomSheet;

class FeedbackPage extends StatefulWidget {
  final String thirdOrderId;
  const FeedbackPage({Key? key, required this.thirdOrderId}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var textEditingController = TextEditingController();
  String? result;
  SysCodeEntity? sysCodeEntity;
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 7.5.w, right: 7.5.w, top: 15.h, bottom: 15.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(5.w)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9.5.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "*",
                              style: TextStyle(
                                  fontSize: 22.5.sp,
                                  color: const Color(0xFFF83048),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Question typeAsk questions",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.5.h,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              getBasicData(context, widget.thirdOrderId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 44.h,
                              decoration: BoxDecoration(
                                  color: Color(0xffF1F2F2),
                                  borderRadius: BorderRadius.circular(5.w)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (sysCodeEntity != null &&
                                            sysCodeEntity!.name != null)
                                        ? sysCodeEntity!.name!
                                        : "Please choose question type",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Image.asset(
                                      'assets/credit/credit_right_arrow.png',
                                      width: 4.1.w,
                                      height: 8.2.w,
                                      fit: BoxFit.fill),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(5.w)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9.5.h,
                        ),
                        Row(
                          children: [
                            // Container(
                            //   color: Color(0xff003C6A),
                            //   width: 4.w,
                            //   height: 24.5.h,
                            // ),
                            // SizedBox(
                            //   width: 2.5.w,
                            // ),
                            Text(
                              "*",
                              style: TextStyle(
                                  fontSize: 22.5.sp,
                                  color: const Color(0xFFF83048),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Guestions and suggestions",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          height: 103.h,
                          decoration: BoxDecoration(
                              color: Color(0xffF1F1F1),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: TextFormField(
                              minLines: 1,
                              maxLines: 20,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(100) //
                              ],
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText:
                                    "Please enter vour questions and suggestions,we will continue to optimize the experience",
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                                //
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                //
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              controller: textEditingController),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(5.w)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 11.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Upload Problem Pictures, Only JPG And\nPNG Are supported",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 88.h,
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  XFile? imageFile = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CameraKpt()),
                                  );
                                  if (imageFile != null) {
                                    result = imageFile.path;
                                    setState(() {});
                                  }
                                },
                                child: Image.asset(
                                    'assets/feedback/feedback_take_photo.png',
                                    width: 37.w,
                                    height: 37.w),
                              ),
                              (result != null && result!.isNotEmpty)
                                  ? Image.file(
                                      File(result!),
                                      width: 70.h,
                                      height: 70.h,
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
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
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (sysCodeEntity == null ||
                            sysCodeEntity?.name == null ||
                            sysCodeEntity?.name?.length == 0) {
                          CZLoading.toast("Please select a question type");
                          return;
                        }
                        if (textEditingController.value.text.length == 0) {
                          CZLoading.toast(
                              "Please enter questions and suggestions");
                          return;
                        }
                        // if (result == null || result!.isEmpty) {
                        //   CZLoading.toast("please take a picture");
                        //   return;
                        // }

                        Map<String, dynamic> params =
                            new Map<String, dynamic>();
                        if (result != null && result!.isNotEmpty) {
                          var ossUrl = await uploadFile(context);
                          if (ossUrl != null && ossUrl.toString().length > 0) {
                            params["imagesTBfcXb"] = [ossUrl];
                          }
                        }
                        params["thirdOrderIdq8jvtj"] = widget.thirdOrderId;
                        params["typeIdflzCog"] = sysCodeEntity?.id;
                        params["contentCxb7jm"] =
                            textEditingController.value.text;
                        submitData(context, params);
                      },
                      child: Text("Submit",
                          style: TextStyle(
                              fontSize: 17.5.sp,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            )),
      );
    });
  }

  getBasicData(BuildContext context, String thirdOrderId) async {
    CZLoading.loading();

    final response = await context.read(basicProvider(thirdOrderId)).loadData();
    List<dynamic>? list = response["listNPJAeA"];
    CZLoading.dismiss();
    if (list != null && list.isNotEmpty) {
      List<SysCodeEntity> sysCodeEntityList = [];
      sysCodeEntityList = list
          .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
          .toList();
      await myBottomSheet.showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => SupervisionDictSheet(
          sysCodes: sysCodeEntityList,
          onSelect: (sysCodeEntityList) =>
              {sysCodeEntity = sysCodeEntityList.first, setState(() {})},
        ),
      );
    } else {
      CZLoading.toast("fetch failed");
    }
  }

  submitData(BuildContext context, Map<String, dynamic> params) async {
    CZLoading.loading();
    var response = await context.read(submitProvider(params))._loadMyData();
    CZLoading.dismiss();
    if (response["statusE8iqlh"] == 0) {
      Get.back(result: true);
    }
  }

  uploadFile(BuildContext context) async {
    CZLoading.loading();
    String? resultUrl =
        await context.read(fileProvider(""))._loadFile(result ?? "");
    CZLoading.dismiss();
    return resultUrl;
  }
}

final basicProvider = ChangeNotifierProvider.autoDispose
    .family((ref, thirdOrderId) => BasicModel(thirdOrderId.toString()));

class BasicModel extends BaseListModel<dynamic> {
  bool isSelect = false;
  final String thirdOrderId;

  BasicModel(this.thirdOrderId);

  loadData() async {
    this.loading = true;

    final response = await HttpRequest.request(InterfaceConfig.feedback_type,
        params: {"idxQEzsQ": thirdOrderId});
    return response;
  }
}

final submitProvider = ChangeNotifierProvider.autoDispose
    .family((ref, params) => SubmitModel(params as Map<String, dynamic>));

class SubmitModel extends BaseListModel<dynamic> {
  final Map<String, dynamic> params;

  SubmitModel(this.params);

  _loadMyData() async {
    this.loading = true;
    final response = await HttpRequest.request(InterfaceConfig.feedback_submit,
        params: {"modelU8mV9A": params});
    return response;
  }

  @override
  Future loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}

final fileProvider =
    ChangeNotifierProvider.autoDispose.family((ref, _) => FileModel());

class FileModel extends BaseModel {
  FileModel();

  Future<String?> _loadFile(String filePath) async {
    final response =
        await HttpRequest.uploadFile(InterfaceConfig.uploadFile, filePath);

    if (response["statusE8iqlh"] == 0) {
      String? ossUrl = response["modelU8mV9A"].containsKey("ossUrl")
          ? response["modelU8mV9A"]["ossUrl"]
          : null;
      print("ossUrl:$ossUrl");
      return ossUrl;
    }
    return null;
  }
}
