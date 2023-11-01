class AppUrls {
  static const int appId = 4;
  static const int versionCode = 1;
  static const String version = "Version: 1.0.0";

  static const baseUrl = "http://192.168.0.29:8088"; //local
  static const tokenBaseUrl = "http://192.168.0.29:9000"; //local

  // static const baseUrl = "http://gpst.billingdil.com:8088"; //live
  // static const tokenBaseUrl = "http://202.51.189.217:9000"; //live
  

  static const tokenUrl = "$tokenBaseUrl/realms/ati-realm/protocol/openid-connect/token";
  static const loginUrl = "$tokenBaseUrl/user-ms/api/user/login";


  static const searchLabelUrl = "$baseUrl/dil_load_ws/api/store/search-label-data";
  static const submitLabelUrl = "$baseUrl/dil_load_ws/api/store/submit-label-data";
}