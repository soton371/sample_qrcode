import 'package:hive/hive.dart';

class AppDB {
  static const userInfoBox = "userInfoBox";
  static const saUsersId = "saUsersId";
  static const sessionId = "sessionId";
  static const userCode = "userCode";
  static const usersName = "usersName";

  //for sa user id
  static Future<void> putSaUserId(int usersId) async {
    final box = await Hive.openBox(userInfoBox);
    box.put(saUsersId, usersId);
  }

  static Future<int> fetchSaUserId()async{
    final box = await Hive.openBox(userInfoBox);
    final userId = box.get(saUsersId);
    return userId;
  }

  //for session
  static Future<void> putSessionId(String session) async {
    final box = await Hive.openBox(userInfoBox);
    box.put(sessionId, session);
  }

  static Future<String> fetchSessionId()async{
    final box = await Hive.openBox(userInfoBox);
    final session = box.get(sessionId);
    return session;
  }

  //for userCode
  static Future<void> putUserCode(String code) async {
    final box = await Hive.openBox(userInfoBox);
    box.put(userCode, code);
  }

  static Future<String> fetchUserCode()async{
    final box = await Hive.openBox(userInfoBox);
    final uc = box.get(userCode);
    return uc;
  }

  //for user name
  static Future<void> putUserName(String userName) async {
    final box = await Hive.openBox(userInfoBox);
    box.put(usersName, userName);
  }

  static Future<String> fetchUserName()async{
    final box = await Hive.openBox(userInfoBox);
    final uc = box.get(usersName);
    return uc;
  }

  //for log out
  static Future<void> clearUserInfo() async {
    final box = await Hive.openBox(userInfoBox);
    box.clear();
  }
}
