


class CustomerType{

  String customertype;

  CustomerType(this.customertype);
  factory CustomerType.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}

CustomerType _$PostFromJson(Map<String, dynamic> data) {
  return CustomerType(

    data['customertype'] as String,

  );
}
Map<String, dynamic> _$PostToJson(CustomerType instance) => <String, dynamic>{

  'customertype': instance.customertype,

};
