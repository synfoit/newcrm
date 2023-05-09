

class LeadData {

  int Lead_Id;
  String EmployeeName;
  String CustomerCode;
  String CustomerName;
  String Visit;
  String Requirement;
  String ProjectName;
  String Unit;
  String CustomerType;
  String IndustryType;
  String Clss;
  String Meeting;
  String ProposalStatus;
  String SubmissionStatus;
  String SBU;
  int SSLValue;
  int OEM_Value;
  String Exp_Ord_Date;
  String Risk;
  String SSL_Manager;
  String OEM_Manager;
  String Di_Manager;
  String Remark;
  String Support;
  String LeadCreationDate;
  String sync_status;
  LeadData(
      this.Lead_Id,
      this.EmployeeName,
      this.CustomerCode,
      this.CustomerName,
      this.Visit,
      this.Requirement,
      this.ProjectName,
      this.Unit,
      this.CustomerType,
      this.IndustryType,
      this.Clss,
      this.Meeting,
      this.ProposalStatus,
      this.SubmissionStatus,
      this.SBU,
      this.SSLValue,
      this.OEM_Value,
      this.Exp_Ord_Date,
      this.Risk,
      this.SSL_Manager,
      this.OEM_Manager,
      this.Di_Manager,
      this.Remark,
      this.Support,
      this.LeadCreationDate);

  factory LeadData.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}

LeadData _$PostFromJson(Map<String, dynamic> data) {
  return LeadData(
    data['lead_id'] as int,
    data['employeename'] as String,
    data['customercode'] as String,
    data['customername'] as String,
    data['visit'] as String,
    data['requirement'] as String,
    data['projectname'] as String,
    data['unit'] as String,
    data['customertype'] as String,
    data['industrytype'] as String,
    data['clss'] as String,
    data['meeting'] as String,
    data['proposal_status'] as String,
    data['submission_status'] as String,
    data['sbu'] as String,
    data['ssl_value'] as int,
    data['oem_value'] as int,
    data['exp_ord_date'] as String,
    data['risk'] as String,
    data['ssl_manager'] as String,
    data['oem_manager'] as String,
    data['di_manager'] as String,
    data['remark'] as String,
    data['support'] as String,
    data['leadcreationDate'] as String,
  );
}

Map<String, dynamic> _$PostToJson(LeadData instance) => <String, dynamic>{
      'lead_id': instance.Lead_Id,
      'employeename': instance.EmployeeName,
      'customercode': instance.CustomerCode,
      'customername': instance.CustomerName,
      'visit': instance.Visit,
      'requirement': instance.Requirement,
      'projectname': instance.ProjectName,
      'unit': instance.Unit,
      'customertype': instance.CustomerType,
      'industrytype': instance.IndustryType,
      'clss': instance.Clss,
      'meeting': instance.Meeting,
      'proposal_status': instance.ProposalStatus,
      'submission_status': instance.SubmissionStatus,
      'sbu': instance.SBU,
      'ssl_value': instance.SSLValue,
      'oem_value': instance.OEM_Value,
      'exp_ord_date': instance.Exp_Ord_Date,
      'risk': instance.Risk,
      'ssl_manager': instance.SSL_Manager,
      'oem_manager': instance.OEM_Manager,
      'di_manager': instance.Di_Manager,
      'remark': instance.Remark,
      'support': instance.Support,
      'leadcreationDate': instance.LeadCreationDate
    };
