


class LeadDataSync {

  int androidLeadId;
  int leadId;
  String employeeName;
  String customerCode;
  String customerName;
  String visit;
  String requirement;
  String projectName;
  String unit;
  String customerType;
  String industryType;
  String clss;
  String meeting;
  String proposalStatus;
  String submissionStatus;
  String sbu;
  int sSLValue;
  int oEMValue;
  String expOrdDate;
  String risk;
  String sSLManager;
  String oemManager;
  String diManager;
  String remark;
  String support;
  String leadCreationDate;
  String syncwithserver;
  LeadDataSync(
      this.androidLeadId,
      this.leadId,
      this.employeeName,
      this.customerCode,
      this.customerName,
      this.visit,
      this.requirement,
      this.projectName,
      this.unit,
      this.customerType,
      this.industryType,
      this.clss,
      this.meeting,
      this.proposalStatus,
      this.submissionStatus,
      this.sbu,
      this.sSLValue,
      this.oEMValue,
      this.expOrdDate,
      this.risk,
      this.sSLManager,
      this.oemManager,
      this.diManager,
      this.remark,
      this.support,
      this.leadCreationDate,this.syncwithserver);

  Map<String, dynamic> toJson() => _$PostToJson(this);

}



Map<String, dynamic> _$PostToJson(LeadDataSync instance) => <String, dynamic>{
  'android_lead_id' :instance.androidLeadId,
  'lead_id': instance.leadId,
  'employeename': instance.employeeName,
  'customercode': instance.customerCode,
  'customername': instance.customerName,
  'visit': instance.visit,
  'requirement': instance.requirement,
  'projectname': instance.projectName,
  'unit': instance.unit,
  'customertype': instance.customerType,
  'industrytype': instance.industryType,
  'clss': instance.clss,
  'meeting': instance.meeting,
  'proposal_status': instance.proposalStatus,
  'submission_status': instance.submissionStatus,
  'sbu': instance.sbu,
  'ssl_value': instance.sSLValue,
  'oem_value': instance.oEMValue,
  'exp_ord_date': instance.expOrdDate,
  'risk': instance.risk,
  'ssl_manager': instance.sSLManager,
  'oem_manager': instance.oemManager,
  'di_manager': instance.diManager,
  'remark': instance.remark,
  'support': instance.support,
  'leadcreationDate': instance.leadCreationDate,
  'syncwithserver': instance.syncwithserver
};
