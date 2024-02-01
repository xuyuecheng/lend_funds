/// 系统代码
class SysCodeEntity {
  String? name;
  String? value;
  String? id;
  String? firstName;
  List<dynamic>? sysCodeEntityList;
  bool? haveChild;
  String? methodName;
  String? methodCode;
  String? repayMethod;
  // final myController = useTextEditingController(text: "");

  SysCodeEntity(this.firstName, this.name, this.value, this.id, this.haveChild,
      this.sysCodeEntityList);

  SysCodeEntity.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("curName")) {
      this.name = json.containsKey("curName") ? json["curName"] : null;
    } else {
      this.name = json.containsKey("nameyJEzwD") ? json["nameyJEzwD"] : null;
    }
    this.value = json.containsKey("value") ? json["value"] : null;
    this.id = json.containsKey("idxQEzsQ") ? json["idxQEzsQ"] : null;
    this.haveChild =
        json.containsKey("haveChildSzi86C") ? json["haveChildSzi86C"] : null;
    this.sysCodeEntityList =
        json.containsKey("childrenYGaJBx") ? json["childrenYGaJBx"] : null;
    this.methodName =
        json.containsKey("methodName") ? json["methodName"] : null;
    this.methodCode =
        json.containsKey("methodCode") ? json["methodCode"] : null;
    this.repayMethod =
        json.containsKey("repayMethod") ? json["repayMethod"] : null;
    if (value == null && id != null) {
      value = id;
    }
    if (id == null && value != null) {
      id = value;
    }

    if (name == null && methodName != null) {
      name = methodName;
    }
    if (value == null && methodCode != null) {
      value = methodCode;
      id = methodCode;
    }
  }

  @override
  String toString() {
    return "$firstName,$name,$value,$id,$haveChild";
  }
}
