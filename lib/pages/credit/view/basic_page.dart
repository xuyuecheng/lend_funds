import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahayak_cash/pages/common/marquee_widget.dart';
import 'package:sahayak_cash/pages/common/privacy_agreement.dart';
import 'package:sahayak_cash/pages/common/retention_dialog.dart';
import 'package:sahayak_cash/pages/credit/view/widget/bank_dialog.dart';
import 'package:sahayak_cash/pages/credit/view/widget/credit_choose_info_widget.dart';
import 'package:sahayak_cash/pages/credit/view/widget/credit_input_info_widget.dart';
import 'package:sahayak_cash/pages/credit/view/widget/dict_sheet.dart';
import 'package:sahayak_cash/pages/home/controller/home_controller.dart';
import 'package:sahayak_cash/utils/entity/syscode_entity.dart';
import 'package:sahayak_cash/utils/network/dio_config.dart';
import 'package:sahayak_cash/utils/network/dio_request.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as myBottomSheet;

class BasicPage extends HookWidget {
  final String formId;
  final List<dynamic> forms;
  BasicPage({Key? key, required this.formId, required this.forms})
      : super(key: key);

  //
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
    String formName = "";
    String columnField = "";
    if (forms.length > 0) {
      contents = forms[0].containsKey("contentCxb7jm")
          ? forms[0]["contentCxb7jm"]
          : null;
      formName = forms[0].containsKey("formNameQCVJjC")
          ? forms[0]["formNameQCVJjC"]
          : null;
      columnField =
          forms[0].containsKey("columnField") ? forms[0]["columnField"] : null;
      print("contents:${contents.length},formName:$formName");

      if (contents.length > 0) {
        formType = contents[0].containsKey("typeIVyt6h")
            ? contents[0]["typeIVyt6h"]
            : null;
        if (formType == "contact") {
          props =
              contents[0].containsKey("props") ? contents[0]["props"] : null;
          contactId = contents[0].containsKey("idxQEzsQ")
              ? contents[0]["idxQEzsQ"]
              : null;
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
          //
          if (columnField == "formBank") {
            Map<String, dynamic> map = {
              "nameyJEzwD": "Confirm Bank Number",
              "idxQEzsQ": "userBank.bankCardAgainTemp",
              "typeIVyt6h": "number",
              "required": true,
            };
            bool hadBankNumAgainData = false;
            int bankNumberIndex = 0;
            for (int index = 0; index < contents.length; index++) {
              Map item = contents[index];
              if (item["nameyJEzwD"] == "Confirm Bank Number") {
                hadBankNumAgainData = true;
              }
              if (item["nameyJEzwD"] == "Bank Number") {
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
    return WillPopScope(
      onWillPop: () async {
        _backEvent();
        return false;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  _backEvent();
                }),
            title: Text(
              formName,
              style: TextStyle(
                  fontSize: 17.5.sp,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              MarqueeWidget(),
              Expanded(
                  child: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 11.h),
                          Center(
                            child: Image.asset(
                              (columnField == "formBank")
                                  ? "assets/credit/progress_bank.png"
                                  : "assets/credit/progress_information.png",
                            ),
                          ),
                          SizedBox(height: 15.h),
                          (formType == "contact")
                              ? (mGetContactWidget(context, contents[0]))
                              : (contents.isNotEmpty
                                  ? Column(
                                      children: contents.map((e) {
                                        int index = contents.indexOf(e);
                                        return _mGetWidget(context, e, index);
                                      }).toList(),
                                    )
                                  : SizedBox.shrink()),
                          SizedBox(height: 25.h),
                          Container(
                            width: 345.w,
                            height: 50.h,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF00A651),
                                  borderRadius: BorderRadius.circular(5.w)),
                              child: TextButton(
                                onPressed: () {
                                  focusNodes
                                      .forEach((element) => element.unfocus());
                                  if ((columnField == "formBank")) {
                                    List titleList = [];
                                    List contentList = [];
                                    for (var i = 0; i < contents.length; i++) {
                                      String? name =
                                          contents[i].containsKey("nameyJEzwD")
                                              ? contents[i]["nameyJEzwD"]
                                              : null;
                                      String type =
                                          contents[i].containsKey("typeIVyt6h")
                                              ? contents[i]["typeIVyt6h"]
                                              : null;
                                      titleList.add(name ?? "");
                                      if (type == "select") {
                                        contentList.add(listFormUseState[i]
                                            .value
                                            .name
                                            .toString());
                                      } else {
                                        contentList.add(
                                            listUseTextEditingController[i]
                                                .text
                                                .toString());
                                      }
                                    }
                                    debugPrint("titleList:$titleList");
                                    debugPrint("contentList:$contentList");
                                    CZDialogUtil.show(
                                      BankDialog(
                                        titleList: titleList,
                                        contentList: contentList,
                                        onConfirm: () {
                                          _submitInfo();
                                        },
                                      ),
                                    );
                                  } else {
                                    //
                                    _submitInfo();
                                  }
                                },
                                child: Text("Next",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Center(
                            child: PrivacyAgreement(),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
          backgroundColor: Color(0xffF5F4F2),
        ),
      ),
    );
  }

  _backEvent() {
    CZDialogUtil.show(RetentionDialog());
  }

  _submitInfo() async {
    focusNodes.forEach((element) => element.unfocus());
    Map<String, dynamic> params = <String, dynamic>{};
    Map<String, dynamic> mParams = <String, dynamic>{};
    Map<String, dynamic> model = <String, dynamic>{};
    Map<String, dynamic> submitData = <String, dynamic>{};
    Map<String, dynamic> address = <String, dynamic>{};
    Map<String, dynamic> job = <String, dynamic>{};
    Map<String, dynamic> bigAddress = <String, dynamic>{};
    Map<String, dynamic> detailAddress = <String, dynamic>{};
    List<Map<String, dynamic>> userEmerges = [];
    model["formIdrS92EN"] = formId;

    String bankNumberContentStr = "";
    String bankNumberAgainContentStr = "";
    if (formType == "contact") {
      for (int i = 0; i < count!; i++) {
        Map<String, dynamic> userEmerge = <String, dynamic>{};
        if (nameUseTextEditingController[i].text.toString().length == 0) {
          CZLoading.toast("$nameLabel Can not be empty");
          return;
        }
        if (phoneUseTextEditingController[i].text.toString().length == 0) {
          CZLoading.toast("$phoneLabel Can not be empty");
          return;
        }
        if (contactFormUseState[i].value.name == null ||
            contactFormUseState[i].value.name.length == 0) {
          CZLoading.toast("$relationLabel Can not be empty");
          return;
        }
        userEmerge["name"] = nameUseTextEditingController[i].text.toString();
        userEmerge["phone"] = phoneUseTextEditingController[i].text.toString();
        userEmerge["relation"] = contactFormUseState[i].value.id;
        userEmerges.add(userEmerge);
      }
      submitData[contactId ?? ""] = userEmerges;
    } else {
      for (var i = 0; i < contents.length; i++) {
        String id = contents[i].containsKey("idxQEzsQ")
            ? contents[i]["idxQEzsQ"]
            : null;
        String name = contents[i].containsKey("nameyJEzwD")
            ? contents[i]["nameyJEzwD"]
            : null;
        String type = contents[i].containsKey("typeIVyt6h")
            ? contents[i]["typeIVyt6h"]
            : null;

        if (type == "select") {
          if (listFormUseState[i].value.id.toString().isEmpty) {
            CZLoading.toast("$name Can not be empty");
            return;
          }
          List<String> ids = id.split(".");
          if (ids.length > 1) {
            var param = submitData[ids.first];
            if (param == null) {
              mParams[ids.last] = listFormUseState[i].value.id;
              submitData[ids.first] = mParams;
            } else {
              param[ids.last] = listFormUseState[i].value.id;
              submitData[ids.first] = param;
            }
          } else {
            submitData[id] = listFormUseState[i].value.id;
          }
        } else if (type == "jobType") {
          if ((job1 == null || job1?.length == 0) ||
              (job2 == null || job2?.length == 0)) {
            CZLoading.toast("$name Can not be empty");
            return;
          }
          print("jobType:$id");
          job["workType"] = job1;
          job["profession"] = job2;
          submitData[id] = job;
        } else if (type == "addressType") {
          if ((address1 == null || address1?.length == 0) ||
              (address2 == null || address2?.length == 0)) {
            CZLoading.toast("$name Can not be empty");
            return;
          }
          print("addressf.l:$id");
          List<String> ids = id.split(".");
          bigAddress["state"] = address1;
          bigAddress["city"] = address2;
          address[ids.last] = bigAddress;
          var param = submitData[ids.first];
          if (param == null) {
            submitData[ids.first] = address;
          } else {
            param[ids.last] = bigAddress;
            submitData[ids.first] = param;
          }
        } else {
          if (listUseTextEditingController[i].text.toString().isEmpty) {
            CZLoading.toast("$name Can not be empty");
            return;
          }

          if (name == "Bank Number") {
            bankNumberContentStr =
                listUseTextEditingController[i].text.toString();
          }
          if (name == "Confirm Bank Number") {
            bankNumberAgainContentStr =
                listUseTextEditingController[i].text.toString();
          }
          List<String> ids = id.split(".");
          if (ids.length > 1) {
            var param = submitData[ids.first];
            if (param == null) {
              detailAddress[ids.last] =
                  listUseTextEditingController[i].text.toString();
              submitData[ids.first] = detailAddress;
            } else {
              if (ids.last != "bankCardAgainTemp") {
                param[ids.last] =
                    listUseTextEditingController[i].text.toString();
              }
              submitData[ids.first] = param;
            }
          } else {
            submitData[id] = listUseTextEditingController[i].text.toString();
          }
        }
      }
    }
    model["submitDatavf7pYW"] = submitData;
    params["modelU8mV9A"] = model;

    print("submitInfo:" + json.encode(params));
    debugPrint("bankNumberContentStr:$bankNumberContentStr");
    debugPrint("bankNumberAgainContentStr:$bankNumberAgainContentStr");
    if (bankNumberContentStr.isNotEmpty &&
        bankNumberAgainContentStr.isNotEmpty &&
        bankNumberContentStr != bankNumberAgainContentStr) {
      CZLoading.toast(
          "the two bank numbers are not the same. please input again,thanks");
      return;
    }
    CZLoading.loading();
    final response = await submitInfoRequest(params);
    CZLoading.dismiss();
    if (response["statusE8iqlh"] == 0) {
      CZLoading.loading();
      await HomeController.to.requestIncompleteForm(isOff: true);
      CZLoading.dismiss();
    }
  }

  Widget mGetContactWidget(BuildContext context, dynamic content) {
    dynamic props = content.containsKey("props") ? content["props"] : null;

    List<Widget> widgetList = [];
    for (int index = 0; index < count!; index++) {
      int poIndex = index * 2;
      widgetList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreditInputTitleWidget(name: "Contact Person ${index + 1}"),
          CreditInputInfoWidget(
              name: nameLabel ?? "",
              inputController: nameUseTextEditingController[index],
              focusNode: focusNodes[poIndex]),
          CreditInputInfoWidget(
              name: phoneLabel ?? "",
              inputController: phoneUseTextEditingController[index],
              numberSize: phoneSize,
              hint: phonePlaceholder != null ? phonePlaceholder : null,
              require: true,
              focusNode: focusNodes[poIndex + 1]),
          CreditChooseInfoWidget(
            name: relationLabel ?? "",
            text: contactFormUseState[index].value.name,
            tapBlock: () {
              focusNodes.forEach((element) => element.unfocus());
              if (props != null) {
                List<dynamic>? relationList =
                    this.props.containsKey("relationList")
                        ? this.props["relationList"]
                        : null;
                List<SysCodeEntity> sysCodeEntityList = [];
                if (relationList != null) {
                  sysCodeEntityList = relationList
                      .map<SysCodeEntity>(
                          (value) => SysCodeEntity.fromJson(value))
                      .toList();
                }
                myBottomSheet.showCupertinoModalBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (context) => SupervisionDictSheet(
                    sysCodes: sysCodeEntityList,
                    onSelect: (sysCodeEntityList) => {
                      _mySelect(
                          contactFormUseState[index], sysCodeEntityList.first)
                    },
                  ),
                );
              }
            },
          )
        ],
      ));
      if (index != count! - 1) {
        widgetList.add(SizedBox(height: 7.5));
      }
    }
    return count != 0 ? Column(children: widgetList) : SizedBox.shrink();
  }

  Widget _mGetWidget(BuildContext context, dynamic content, int index) {
    String type =
        content.containsKey("typeIVyt6h") ? content["typeIVyt6h"] : null;
    String name =
        content.containsKey("nameyJEzwD") ? content["nameyJEzwD"] : null;
    List<dynamic>? options =
        content.containsKey("options") ? content["options"] : null;
    List<SysCodeEntity> sysCodeEntityList = [];
    if (options != null) {
      sysCodeEntityList = options
          .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
          .toList();
      print("sysCodeEntityList:" + sysCodeEntityList.length.toString());
    }
    listFormUseState[index].value.firstName = name;
    if (type == "select") {
      return CreditChooseInfoWidget(
        name: name,
        text: listFormUseState[index].value.name,
        tapBlock: () {
          focusNodes.forEach((element) => element.unfocus());
          myBottomSheet.showCupertinoModalBottomSheet(
            enableDrag: false,
            context: context,
            builder: (context) => SupervisionDictSheet(
              sysCodes: sysCodeEntityList,
              onSelect: (sysCodeEntityList) =>
                  {_mySelect(listFormUseState[index], sysCodeEntityList.first)},
            ),
          );
        },
      );
    } else if (type == "number") {
      return CreditInputInfoWidget(
        name: name,
        inputController: listUseTextEditingController[index],
        require: true,
        focusNode: focusNodes[index],
      );
    } else if (type == "addressType") {
      return CreditChooseInfoWidget(
        name: name,
        text: listFormUseState[index].value.name,
        tapBlock: () {
          //
          focusNodes.forEach((element) => element.unfocus());
          _getAddressInfo(listFormUseState[index], "");
        },
      );
    } else if (type == "jobType") {
      return CreditChooseInfoWidget(
        name: name,
        text: listFormUseState[index].value.name,
        tapBlock: () {
          //
          focusNodes.forEach((element) => element.unfocus());
          _getJobInfo(listFormUseState[index], "");
        },
      );
    } else {
      return CreditInputInfoWidget(
        name: name,
        inputController: listUseTextEditingController[index],
        focusNode: focusNodes[index],
      );
    }
  }

  _mySelect(dynamic round, SysCodeEntity sysCodeEntity) {
    sysCodeEntity.firstName = round.value.firstName;
    round.value = sysCodeEntity;
  }

  _getAddressInfo(dynamic round, String id) async {
    CZLoading.loading();
    List<dynamic>? models = await getSecondAddressInfo(round, id);
    CZLoading.dismiss();
    List<SysCodeEntity> sysCodeEntityList = [];
    if (models != null) {
      sysCodeEntityList = models
          .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
          .toList();
    }
    //
    await myBottomSheet.showCupertinoModalBottomSheet(
      enableDrag: false,
      context: mContext!,
      builder: (mContext) => SupervisionDictSheet(
        sysCodes: sysCodeEntityList,
        onSelect: (sysCodeEntityList) =>
            {myAddressSelect(round, sysCodeEntityList.first)},
      ),
    );
  }

  Future getSecondAddressInfo(dynamic round, String id) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.address_info,
      params: {"modelU8mV9A": id},
    );
    return result["modelU8mV9A"];
  }

  myAddressSelect(dynamic round, SysCodeEntity sysCodeEntity) {
    if (sysCodeEntity.haveChild != null && sysCodeEntity.haveChild == true) {
      address1 = sysCodeEntity.id;
      address2 = "";
      _getAddressInfo(round, sysCodeEntity.id ?? "");
    } else {
      address2 = sysCodeEntity.id;
      sysCodeEntity.name = round.value.name + "\n" + sysCodeEntity.name;
    }
    sysCodeEntity.firstName = round.value.firstName;
    round.value = sysCodeEntity;
  }

  _getJobInfo(dynamic round, String id) async {
    CZLoading.loading();
    List<dynamic>? models = await getSecondJobInfo();
    CZLoading.dismiss();
    List<SysCodeEntity> sysCodeEntityList = [];
    if (models != null) {
      sysCodeEntityList = models
          .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
          .toList();
    }
    //
    Future.delayed(Duration(milliseconds: 500)).then((value) => {
          myBottomSheet.showCupertinoModalBottomSheet(
            enableDrag: false,
            context: mContext!,
            builder: (mContext) => SupervisionDictSheet(
              sysCodes: sysCodeEntityList,
              onSelect: (sysCodeEntityList) =>
                  {myJobSelect(round, sysCodeEntityList.first)},
            ),
          )
        });
  }

  getSecondJobInfo() async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.job_info,
    );
    return result["modelU8mV9A"];
  }

  myJobSelect(dynamic round, SysCodeEntity sysCodeEntity) {
    if (sysCodeEntity.sysCodeEntityList != null &&
        sysCodeEntity.sysCodeEntityList!.length > 0) {
      job1 = sysCodeEntity.id;
      job2 = "";
      //
      List<SysCodeEntity> sysCodeEntityList = [];
      if (sysCodeEntity.sysCodeEntityList != null) {
        sysCodeEntityList = sysCodeEntity.sysCodeEntityList!
            .map<SysCodeEntity>((value) => SysCodeEntity.fromJson(value))
            .toList();
      }
      Future.delayed(Duration(milliseconds: 500)).then((value) => {
            // showCode(round,sysCodeEntityList)
            myBottomSheet.showCupertinoModalBottomSheet(
              enableDrag: false,
              context: mContext!,
              builder: (mContext) => SupervisionDictSheet(
                sysCodes: sysCodeEntityList,
                onSelect: (sysCodeEntityList) =>
                    {myJobSelect(round, sysCodeEntityList.first)},
              ),
            )
          });
    } else {
      job2 = sysCodeEntity.id;
      sysCodeEntity.name = round.value.name + "\n" + sysCodeEntity.name;
    }
    sysCodeEntity.firstName = round.value.firstName;
    round.value = sysCodeEntity;
  }

  Future submitInfoRequest(Map<String, dynamic> params) async {
    dynamic result = await HttpRequest.request(
      InterfaceConfig.submitForm,
      params: params,
    );
    return result;
  }
}
