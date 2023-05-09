import 'package:newcrm/Model/employee.dart';
import 'package:dio/dio.dart';

class Api_Provider{
  static const BASE_URL = "http://192.168.1.13:9090/";
  static const String apiEndpoint = BASE_URL + "getUserId/";
  final Dio _dio;

  Api_Provider(this._dio);

  /// Auth
  Future<Employee> authUser(String Userid, String password) async {
    Response response = await _dio.get(apiEndpoint +Userid+"/"+password,);
    return Employee.fromMap(response.data);
  }



  Future<List<String>> fetchAlbum_getCustomerName() async {
    List<String> CustomerName = [];
    Response response = await _dio.get(BASE_URL +"getCustomerNameList",);
      return CustomerName;

  }

  Future<List<String>> fetchAlbum_getCustomerType() async {
    List<String> CustomerType = [];
    Response response = await _dio.get(BASE_URL +"getCustomerType",);

      return CustomerType;

  }
  Future<List<String>> fetchAlbum_getIndustryType() async {
    List<String> IndustyType = [];
    Response response = await _dio.get(BASE_URL +"getIndustryType",);
      return IndustyType;

  }
}