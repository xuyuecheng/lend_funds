import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lend_funds/pages/camera/views/camera_kpt.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_input_info_widget.dart';
import 'package:lend_funds/pages/credit/view/widget/dict_sheet.dart';
import 'package:lend_funds/utils/base/base_view_model.dart';
import 'package:lend_funds/utils/entity/syscode_entity.dart';
import 'package:lend_funds/utils/network/dio_config.dart';
import 'package:lend_funds/utils/network/dio_request.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as myBottomSheet;

class FeedbackPage extends StatefulWidget {
  final String thirdOrderId;
  const FeedbackPage({Key? key, required this.thirdOrderId}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var textEditingController = TextEditingController();

  // var model;
  String? result;
  var resultUrl;
  SysCodeEntity? sysCodeEntity;
  @override
  void initState() {
    super.initState();
    //...
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer(builder: (_, watch, __) {
      Map<String, dynamic> params = <String, dynamic>{};
      params["thirdOrderId"] = widget.thirdOrderId;
      params["context"] = context;
      // model = watch(basicProvider(params));
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
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(240, 240, 240, 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Choose question type:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: MaterialButton(
                                      color: Color.fromRGBO(54, 65, 225, 1),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: ListTile(
                                        title: Text(
                                            (sysCodeEntity != null &&
                                                    sysCodeEntity!.name != null)
                                                ? sysCodeEntity!.name!
                                                : "Please choose question type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 15)),
                                        trailing: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        _getBasicData(
                                            context, widget.thirdOrderId);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(240, 240, 240, 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Input Questions and suggestions:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CreditInputInfoWidget(
                                      require: false,
                                      name: "",
                                      hint:
                                          "Please input Questions and suggestions",
                                      inputController: textEditingController,
                                      // focusNode: focusNodes[poIndex]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
                    child: InkWell(
                      onTap: () async {
                        // result = await Navigator.push(
                        //   context,
                        //   new MaterialPageRoute(
                        //       builder: (context) => new CameraKpt()),
                        // );
                        XFile? imageFile = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraKpt()),
                        );
                        if (imageFile != null) {
                          result = imageFile.path;
                          setState(() {});
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          ListTile(
                            title: Text(
                                "upload questions and suggestions,only JPG and PNG:",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15)),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.add_box_rounded,
                                color: Color.fromRGBO(54, 65, 225, 1),
                                size: 100,
                              ),
                              (result != null && result!.isNotEmpty)
                                  ? Image.file(
                                      File(result!),
                                      width: 100,
                                      height: 100,
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ]),
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
                    if (sysCodeEntity == null ||
                        sysCodeEntity?.name == null ||
                        sysCodeEntity?.name?.length == 0) {
                      CZLoading.toast("Please select a question type");
                      return;
                    }
                    if (textEditingController.value.text.length == 0) {
                      CZLoading.toast("Please enter questions and suggestions");
                      return;
                    }
                    if (result == null || result!.isEmpty) {
                      CZLoading.toast("please take a picture");
                      return;
                    }
                    print("textEditingController:" +
                        textEditingController.value.text);

                    Map<String, dynamic> params = new Map<String, dynamic>();
                    // final String thirdOrderId;
                    // final String typeId;
                    // final String content;
                    // final String image;
                    var ossUrl = await _uploadFile(context);
                    if (ossUrl != null && ossUrl.toString().length > 0) {
                      params["thirdOrderId"] = widget.thirdOrderId;
                      params["typeId"] = sysCodeEntity?.id;
                      params["content"] = textEditingController.value.text;
                      params["image"] = ossUrl;
                      _submitData(context, params);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _getBasicData(BuildContext context, String thirdOrderId) async {
    CZLoading.loading();

    final response = await context.read(basicProvider(thirdOrderId)).loadData();
    List<dynamic>? list = response["list"];
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

  _submitData(BuildContext context, Map<String, dynamic> params) async {
    CZLoading.loading();
    var response = await context.read(submitProvider(params)).loadMyData();
    CZLoading.dismiss();
    if (response["status"] == 0) {
      Get.back(result: true);
    }
  }

  _uploadFile(BuildContext context) async {
    CZLoading.loading();
    resultUrl = await context.read(fileProvider("")).loadFile(result ?? "");
    CZLoading.dismiss();
    return resultUrl;
  }
}

final basicProvider = ChangeNotifierProvider.autoDispose
    .family((ref, thirdOrderId) => BasicModel(thirdOrderId.toString()));

class BasicModel extends BaseListModel<dynamic> {
  bool isSelect = false;
  final String thirdOrderId;

  // final String context;
  // final Map<String, dynamic> params;

  BasicModel(this.thirdOrderId);

  loadData() async {
    this.loading = true;

    final response = await HttpRequest.request(InterfaceConfig.feedback_type,
        params: {"id": thirdOrderId});
    return response;
  }
}

final submitProvider = ChangeNotifierProvider.autoDispose
    .family((ref, params) => SubmitModel(params as Map<String, dynamic>));

class SubmitModel extends BaseListModel<dynamic> {
  final Map<String, dynamic> params;

  SubmitModel(this.params);

  loadMyData() async {
    this.loading = true;
    final response =
        await HttpRequest.request(InterfaceConfig.feedback_submit, params: {
      "model": {
        "thirdOrderId": params["thirdOrderId"],
        "typeId": params["typeId"],
        "content": params["content"],
        "images": [params["image"]]
      }
    });
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

  Future<String?> loadFile(String filePath) async {
    final response =
        await HttpRequest.uploadFile(InterfaceConfig.uploadFile, filePath);

    if (response["status"] == 0) {
      String? ossUrl = response["model"].containsKey("ossUrl")
          ? response["model"]["ossUrl"]
          : null;
      print("ossUrl:$ossUrl");
      return ossUrl;
    }
  }
}
