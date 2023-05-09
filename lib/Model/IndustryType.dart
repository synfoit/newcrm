class IndustryType{
 // int industryname_id;
  String industryname;
//this.industryname_id,
  IndustryType(this.industryname);
  factory IndustryType.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}

IndustryType _$PostFromJson(Map<String, dynamic> data) {
  return IndustryType(
   // data['industryname_id'] as int,
    data['industryname'] as String,

  );
}
Map<String, dynamic> _$PostToJson(IndustryType instance) => <String, dynamic>{
 // 'industryname_id': instance.industryname_id,
  'industryname': instance.industryname,

};