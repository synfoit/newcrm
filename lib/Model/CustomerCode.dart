class CustomerCode{

  String customername;
  CustomerCode(this.customername);

  factory CustomerCode.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}


CustomerCode _$PostFromJson(Map<String, dynamic> data) {
  return CustomerCode(
    //data['customertype_id'] as int,
    data['customername'] as String,

  );
}
Map<String, dynamic> _$PostToJson(CustomerCode instance) => <String, dynamic>{
  //'customertype_id': instance.customertype_id,
  'customername': instance.customername,

};