import 'package:easy_blood/socketIoChat/LoginScreen.dart';
import 'package:easy_blood/socketIoChat/ChatScreen.dart';
import 'package:easy_blood/socketIoChat/ChatUserScreens.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.ROUTE_ID: (context) => LoginScreen(),
      ChatUsersScreen.ROUTE_ID: (context) => ChatUsersScreen(),
      ChatScreen.ROUTE_ID: (context) => ChatScreen(),
    };
  }

  static initScreen() {
    return LoginScreen.ROUTE_ID;
  }
}
