import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindRequest extends StatefulWidget {
  @override
  _FindRequestState createState() => _FindRequestState();
}

class _FindRequestState extends State<FindRequest> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child: MaterialApp(
      home: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[

              ],
            ),
          )
      ),
    )
    );
  }
}
