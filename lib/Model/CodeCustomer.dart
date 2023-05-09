class CodeCustomer{
  int customerid;
  String customername;
  String customecode;
  String reportTo;

  CodeCustomer(this.customerid,this.customername,this.customecode,this.reportTo);
  factory CodeCustomer.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}

CodeCustomer _$PostFromJson(Map<String, dynamic> data) {
  return CodeCustomer(
    data['customerid'] as int,
    data['customername'] as String,
    data['customercode'] as String,
    data['report_to'] as String,
  );
}
Map<String, dynamic> _$PostToJson(CodeCustomer instance) => <String, dynamic>{
  'customerid': instance.customerid,
  'customername': instance.customername,
  'customercode': instance.customecode,
  'report_to': instance.reportTo,
  };
