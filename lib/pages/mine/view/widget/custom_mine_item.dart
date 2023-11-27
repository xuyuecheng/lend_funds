import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineItem extends StatelessWidget {
  final String title;
  final String path;
  final Color color;
  final bool isRequired;
  final String content;
  final int needContent;
  bool showLine = true;

  MineItem(
      {Key? key,
      required this.title,
      required this.path,
      required this.color,
      required this.isRequired,
      required this.content,
      required this.needContent,
      this.showLine = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createMine(
      title: title,
      path: path,
      color: color,
      required: isRequired,
      content: content,
      needContent: needContent,
    );
  }

  _createMine(
      {required String title,
      required String path,
      required Color color,
      bool required = true,
      int needContent = -1,
      String content = ""}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (path.isNotEmpty)
            ? ListTile(
                // leading: CZCustomShimmer.circular(height: 36.w, width: 36.w),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    color: color,
                  ),
                  child: Image.asset(
                    // "assets/mine/mine_bank_icon.png",
                    path,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                trailing: required
                    ? const Icon(Icons.chevron_right)
                    : Text(
                        content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(92, 92, 92, 1),
                        ),
                        textAlign: TextAlign.start,
                      ),
              )
            : ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(92, 92, 92, 1),
                        ))
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (needContent != -1)
                        ? Container(
                            width: 90.w,
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                                color: (needContent == 0)
                                    ? Colors.red
                                    : const Color.fromRGBO(184, 184, 184, 1),
                                borderRadius: BorderRadius.circular(10.w)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                maxLines: 1,
                                (needContent == 0)
                                    ? "Versi Baru Ditemukan"
                                    : "Versi Terbaru Saat Ini",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(92, 92, 92, 1),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                trailing: required
                    ? const Icon(Icons.chevron_right)
                    : Text(
                        content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(92, 92, 92, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
        showLine
            ? Divider(
                height: 1.w,
                color: const Color.fromRGBO(244, 244, 244, 1),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
