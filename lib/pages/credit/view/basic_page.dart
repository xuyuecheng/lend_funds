import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/utils/entity/syscode_entity.dart';

class BasicPage extends HookWidget {
  final String formId;
  final List<dynamic> forms;
  BasicPage({Key? key, required this.formId, required this.forms})
      : super(key: key);

  // 表单数据(选择框)
  List<dynamic> listFormUseState = [];
  List<dynamic> listUseTextEditingController = [];
  List<dynamic> contactFormUseState = [];
  List<dynamic> nameUseTextEditingController = [];
  List<dynamic> phoneUseTextEditingController = [];
  List<dynamic> contents = [];
  BuildContext? mContext;
  String? address1;
  String? address2;
  String? job1;
  String? job2;
  String? formType;
  String? nameLabel;
  String? phoneLabel;
  String? phonePlaceholder;
  int phoneSize = 11;
  String? relationLabel;
  String? contactId;
  dynamic props;
  int? count;
  dynamic focusNodes;

  @override
  Widget build(BuildContext context) {
    mContext = context;
    // final theme = Theme.of(context);
    // final refreshController =
    // useMemoized(() => RefreshController(initialRefresh: true));

    String formName = "";
    String columnField;
    if (forms.length > 0) {
      contents = forms[0].containsKey("content") ? forms[0]["content"] : null;
      formName = forms[0].containsKey("formName") ? forms[0]["formName"] : null;
      columnField =
          forms[0].containsKey("columnField") ? forms[0]["columnField"] : null;
      print("contents:${contents.length},formName:$formName");

      if (contents.length > 0) {
        formType = contents[0].containsKey("type") ? contents[0]["type"] : null;
        if (formType == "contact") {
          props =
              contents[0].containsKey("props") ? contents[0]["props"] : null;
          contactId = contents[0].containsKey("id") ? contents[0]["id"] : null;
          dynamic fieldConf =
              props.containsKey("fieldConf") ? props["fieldConf"] : null;
          count = fieldConf.containsKey("count") ? fieldConf["count"] : 0;
          nameLabel = fieldConf.containsKey("nameLabel")
              ? fieldConf["nameLabel"]
              : null;
          phoneLabel = fieldConf.containsKey("phoneLabel")
              ? fieldConf["phoneLabel"]
              : null;
          phonePlaceholder = fieldConf.containsKey("phonePlaceholder")
              ? fieldConf["phonePlaceholder"]
              : "";
          phoneSize =
              phonePlaceholder!.replaceAll("Example:", "").trim().length;
          relationLabel = fieldConf.containsKey("relationLabel")
              ? fieldConf["relationLabel"]
              : null;

          contactFormUseState.clear();
          nameUseTextEditingController.clear();
          phoneUseTextEditingController.clear();
          for (int i = 0; i < count!; i++) {
            contactFormUseState
                .add(useState(SysCodeEntity("", "", "", "", false, null)));
            nameUseTextEditingController
                .add(useTextEditingController(text: ""));
            phoneUseTextEditingController
                .add(useTextEditingController(text: ""));
          }
          focusNodes = List.generate(count! * 2, (index) => useFocusNode());
        } else {
          //插入一条数据在银行卡号码后面
          if (columnField == "formBank") {
            Map<String, dynamic> map = {
              "name": "Confirm Bank Number",
              "id": "userBank.bankCardAgainTemp",
              "type": "text",
              "required": true,
            };
            bool hadBankNumAgainData = false;
            int bankNumberIndex = 0;
            for (int index = 0; index < contents.length; index++) {
              Map item = contents[index];
              if (item["name"] == "Confirm Bank Number") {
                hadBankNumAgainData = true;
              }
              if (item["name"] == "Bank Number") {
                bankNumberIndex = index;
              }
            }
            if (hadBankNumAgainData == false) {
              contents.insert(bankNumberIndex + 1, map);
            }
          }
          listFormUseState.clear();
          listUseTextEditingController.clear();
          focusNodes =
              List.generate(contents.length, (index) => useFocusNode());
          contents.forEach((element) {
            listFormUseState
                .add(useState(SysCodeEntity("", "", "", "", false, null)));
            listUseTextEditingController
                .add(useTextEditingController(text: ""));
          });
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        title: Text(
          // widget.formName,
          formName,
          style: TextStyle(
              fontSize: 17.5.sp,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xffF1F2F2),
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Container(
                    width: 345.w,
                    height: 50.h,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF003C6A),
                          borderRadius: BorderRadius.circular(5.w)),
                      child: TextButton(
                        onPressed: () {
                          // Get.toNamed(CZRouteConfig.contacts);
                        },
                        child: Text("Next step",
                            style: TextStyle(
                                fontSize: 17.5.sp,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  SizedBox(height: 52.h),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
