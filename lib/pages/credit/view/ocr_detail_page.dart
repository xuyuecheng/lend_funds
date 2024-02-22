import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lend_funds/pages/common/marquee_widget.dart';
import 'package:lend_funds/pages/common/privacy_agreement.dart';
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
        useTextEditingController(text: params["idCardLpsFQr"]);
    final dutyRealNameController =
        useTextEditingController(text: params["userNameeRu4G3"]);
    final dutyTaxRegNumberController =
        useTextEditingController(text: params["taxRegNumberXgH70W"]);
    final rectifyTime =
        useState(CZTimeUtils.formatDateTime(params["birthDayclwqbz"]));
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
                        SizedBox(
                          height: 11.h,
                        ),
                        Image.asset(
                          "assets/credit/progress_ekyc.png",
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CreditInputInfoWidget(
                          name: "Idcard",
                          inputController: dutyIdCardController,
                          focusNode: focusNodes[0],
                        ),
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
                                rectifyTime.value =
                                    CZTimeUtils.formatDate(date);
                              },
                                  currentTime: CZTimeUtils.stringToDate(
                                      rectifyTime.value),
                                  locale: LocaleType.en);
                            }),
                        CreditInputInfoWidget(
                          name: "Taxregnumber",
                          inputController: dutyTaxRegNumberController,
                          focusNode: focusNodes[3],
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: 345.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: const Color(0xFF00A651),
                              borderRadius: BorderRadius.circular(5.w)),
                          child: TextButton(
                            onPressed: () {
                              _ocrInfo(
                                  dutyIdCardController.text.toString(),
                                  dutyRealNameController.text.toString(),
                                  dutyTaxRegNumberController.text.toString(),
                                  rectifyTime.value,
                                  params["idCardImageFrontRvZMet"],
                                  params["idCardImageBackexYcGa"],
                                  params["idCardImagePanRkLgYd"]);
                            },
                            child: Text("Next",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: PrivacyAgreement(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
        backgroundColor: Color(0xffF5F4F2),
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
    await OcrController.to.submitOcrInfoRequest(params: {
      "modelU8mV9A": {
        "idCardLpsFQr": idCard,
        "userNameeRu4G3": realName,
        "taxRegNumberXgH70W": taxRegNumber,
        "birthDayclwqbz":
            DateTime.parse(birthDay).millisecondsSinceEpoch.toString(),
        "idCardImageFrontRvZMet": idCardImageFront,
        "idCardImageBackexYcGa": idCardImageBack,
        "idCardImagePanRkLgYd": idCardImagePan,
      }
    }).then((value) {
      CZLoading.dismiss();
      if (value["statusE8iqlh"] == 0) {
        //
        Get.back(result: true);
      }
    });
  }
}
