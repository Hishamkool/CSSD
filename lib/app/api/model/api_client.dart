import 'dart:io';

import 'package:cssd/app/api/model/api_links.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/model/depart_dropdown_jsonserializable.dart';
import 'package:cssd/app/modules/login_module/model/login_model.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // cssd user
  @POST(ApiLinks.preLoginAuth)
  Future<PreLoginAuthenticationModel> submitPhoneForHospitalIds(
      @Query("PhoneNumber") String phoneNumber);

  @POST(ApiLinks.login)
  Future<LoginModel> login(@Body() Map<String, dynamic> body);

  //department user
  @GET(ApiLinks.departementList)
  Future<HttpResponse<DepartmentListModel>> getDepartementList();
}
