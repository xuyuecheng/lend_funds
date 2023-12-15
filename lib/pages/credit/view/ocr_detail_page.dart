import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/credit/controller/ocr_controller.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_choose_info_widget.dart';
import 'package:lend_funds/pages/credit/view/widget/credit_input_info_widget.dart';
import 'package:lend_funds/utils/time/time_utils.dart';
import 'package:lend_funds/utils/toast/toast_utils.dart';

class OcrDetailPage extends HookWidget {
  final Map<String, dynamic> params;
  const OcrDetailPage({Key? key, required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dutyIdCardController =
        useTextEditingController(text: params["idCard"]);
    final dutyRealNameController =
        useTextEditingController(text: params["realName"]);
    // DateTime now = DateTime.fromMillisecondsSinceEpoch(params["birthDay"]);
    // final currTime = useState(now);
    // final dutyBirthDayController = useTextEditingController(text: now.toString());
    final dutyTaxRegNumberController =
        useTextEditingController(text: params["taxRegNumber"]);
    final rectifyTime =
        useState(CZTimeUtils.formatDateTime(params["birthDay"]));
    debugPrint("MyDate:${rectifyTime.value}");
    debugPrint("MyDate1:" +
        DateTime.parse(rectifyTime.value).millisecondsSinceEpoch.toString());
    final focusNodes = List.generate(4, (index) => useFocusNode());

    return GestureDetector(
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
                Get.back();
              }),
          title: Text(
            'Ocr Detail',
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
                    SizedBox(height: 16.5.h),
                    CreditInputInfoWidget(
                        name: "Idcard",
                        inputController: dutyIdCardController,
                        focusNode: focusNodes[0]),
                    CreditInputInfoWidget(
                        name: "Realname",
                        inputController: dutyRealNameController,
                        focusNode: focusNodes[1]),
                    CreditChooseInfoWidget(
                        name: "Birthday",
                        text: rectifyTime.value,
                        tapBlock: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                            rectifyTime.value = CZTimeUtils.formatDate(date);
                          },
                              currentTime:
                                  CZTimeUtils.stringToDate(rectifyTime.value),
                              locale: LocaleType.en);
                        }),
                    CreditInputInfoWidget(
                      name: "Taxregnumber",
                      inputController: dutyTaxRegNumberController,
                      focusNode: focusNodes[3],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 345.w,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF003C6A),
                            borderRadius: BorderRadius.circular(5.w)),
                        child: TextButton(
                          onPressed: () {
                            _ocrInfo(
                                dutyIdCardController.text.toString(),
                                dutyRealNameController.text.toString(),
                                dutyTaxRegNumberController.text.toString(),
                                rectifyTime.value,
                                params["idCardImageFront"],
                                params["idCardImageBack"],
                                params["idCardImagePan"]);
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
      ),
    );
  }

  _ocrInfo(
      String idCard,
      String realName,
      String taxRegNumber,
      String birthDay,
      String idCardImageFront,
      String idCardImageBack,
      String idCardImagePan) async {
    if (idCard.isEmpty) {
      CZLoading.toast("Please enter idCard");
      return;
    }
    if (realName.isEmpty) {
      CZLoading.toast("please enter realName");
      return;
    }
    if (taxRegNumber.isEmpty) {
      CZLoading.toast("please enter taxRegNumber");
      return;
    }
    if (birthDay.isEmpty) {
      CZLoading.toast("please enter birthDay");
      return;
    }

    CZLoading.loading();
    await OcrController.to.submitOcrInfo(params: {
      "model": {
        "idCard": idCard,
        "realName": realName,
        "taxRegNumber": taxRegNumber,
        "birthDay": DateTime.parse(birthDay).millisecondsSinceEpoch.toString(),
        "idCardImageFront": idCardImageFront,
        "idCardImageBack": idCardImageBack,
        "idCardImagePan": idCardImagePan,
      }
    }).then((value) {
      CZLoading.dismiss();
      if (value["status"] == 0) {
        //返回上个页面
        Get.back(result: true);
      }
    });
  }
}
