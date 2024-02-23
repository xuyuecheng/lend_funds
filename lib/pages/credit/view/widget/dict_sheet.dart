import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sahayak_cash/pages/credit/view/widget/syscode_widget.dart';
import 'package:sahayak_cash/utils/base/base_view_model.dart';
import 'package:sahayak_cash/utils/entity/syscode_entity.dart';
import 'package:sahayak_cash/utils/toast/toast_utils.dart';

class SupervisionDictSheet extends HookWidget {
  final List<SysCodeEntity> sysCodes;
  final Function(List<SysCodeEntity>) onSelect;

  SupervisionDictSheet({required this.onSelect, required this.sysCodes});

  @override
  Widget build(BuildContext context) {
    final model = useProvider(dictProvider);
    return SysCodeWidget(
      onConfirm: () {
        if (model.selected == null) {
          CZLoading.toast("Please select first");
          return;
        }
        if (onSelect != null) {
          onSelect(model.selected);
          Navigator.pop(context);
        }
      },
      onSelect: (sysCode) => {model.toggleSelect(sysCode)},
      data: sysCodes,
      selected: model.selected,
      showName: true,
    );
  }
}

final dictProvider =
    ChangeNotifierProvider.autoDispose((ref) => SupervisionDictModel());

class SupervisionDictModel extends BaseModel {
  List<SysCodeEntity> selected = [];

  SupervisionDictModel();

  toggleSelect(SysCodeEntity sysCode) {
    selected.clear();
    selected.add(sysCode);
    notifyListeners();
  }
}
