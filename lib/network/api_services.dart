abstract class ApiServices {
  Future<dynamic> basicAuth(String endpoint, var data);
  Future<dynamic> postData(String endpoint, var data);
  Future<dynamic> postDataWithoutToken(String endpoint, var data);
  Future<dynamic> getData(String endpoint);
  Future<dynamic> getDataWithoutStatusCode(String endpoint);
}
