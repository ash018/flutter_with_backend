/*
 * Copyright 2018 Harsh Sharma
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_client_php_backend/customviews/progress_dialog.dart';
import 'package:flutter_client_php_backend/futures/app_futures.dart';
import 'package:flutter_client_php_backend/models/User.dart';
import 'package:flutter_client_php_backend/models/Point.dart';
import 'package:flutter_client_php_backend/models/base/EventObject.dart';
import 'package:flutter_client_php_backend/pages/splash_page.dart';
import 'package:flutter_client_php_backend/utils/app_shared_preferences.dart';
import 'package:flutter_client_php_backend/utils/constants.dart';
import 'package:flutter_client_php_backend/pages/menu_page.dart';
import 'package:provider/provider.dart';
//import 'package:location/location.dart';



class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final globalKey = new GlobalKey<ScaffoldState>();



  User user;
  Point pt = new Point();



  TextEditingController oldPasswordController =
      new TextEditingController(text: "");

  TextEditingController newPasswordController =
      new TextEditingController(text: "");



//------------------------------------------------------------------------------

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
    await initLocation();
  }

//------------------------------------------------------------------------------

  Future<void> initUserProfile() async {
    User up = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = up;
    });
  }

  Future<void> initLocation() async {

    setState(() {


    });
  }



//------------------------------------------------------------------------------

  static ProgressDialog progressDialog = ProgressDialog
      .getProgressDialog(ProgressDialogTitles.USER_CHANGE_PASSWORD);

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      body: new Stack(
        children: <Widget>[homeText(), progressDialog],
      ),
    );
  }

//------------------------------------------------------------------------------

  void _logoutFromTheApp() {
    AppSharedPreferences.clear();
    setState(() {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new SplashPage()),
      );
    });
  }



//------------------------------------------------------------------------------
  int _groupValue = -1;
  Widget homeText() {
    var userLocation = Provider.of<Point>(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  // A fixed-height child.
                  height: 50.0,
                  constraints: BoxConstraints.expand(height: 50),
                  padding: EdgeInsets.all(10),
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0),),),color: Colors.greenAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('জব কার্ড', style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 1.0),
                ),
                Container(
                  // A fixed-height child.
                  height: 50.0,
                  constraints: BoxConstraints.expand(height: 50,width: 200),
                  padding: EdgeInsets.all(10),
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),),),color: Colors.greenAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('সার্ভিস কল', style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 2.0),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 150),
                  padding: EdgeInsets.all(10),
                  decoration: ShapeDecoration
                    (shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0),),),color: Colors.green[100]),
                      child: Column(
                        children: <Widget>[
                          _myRadioButton(
                            title: "গ্রাহক",
                            value: 0,
                            onChanged: (newValue) => setState(() => _groupValue = newValue),

                          ),
                          _myRadioButton(
                            title: "নিজ",
                            value: 1,
                            onChanged: (newValue) => setState(() => _groupValue = newValue),
                          ),
                        ],
                      )
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(builder: (context) => new MenuPage()),
                        );
                      },
                      padding: EdgeInsets.all(15.0),
                      child: new Text(
                          "ফিরে যান",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                             )
                      ),
                      new RaisedButton(
                        color: Colors.blue,
                        onPressed: (){
                          print("Hi"+_groupValue.toString());
                          if(_groupValue==-1){
                            _showAlertOption(context);
                          }
                        },
                        textColor: Colors.black,
                        padding: EdgeInsets.all(15.0),
                        child: new Text(
                            "এগিয়ে যান",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                        ),
                      )
                    ]
                ),

              ],
            ),
          ),
        );
      },
    );
  }

//------------------------------------------------------------------------------

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title,style: new TextStyle(color: Colors.black, fontSize: 20.0))
    );
  }

  Widget _logOutDialog() {
    return new AlertDialog(
      title: new Text(
        "Logout",
        style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
      ),
      content: new Text(
        "Are you sure you want to Logout from the App",
        style: new TextStyle(color: Colors.grey, fontSize: 20.0),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
            AppSharedPreferences.clear();
            Navigator.pushReplacement(
              globalKey.currentContext,
              new MaterialPageRoute(builder: (context) => new SplashPage()),
            );
          },
        ),
        new FlatButton(
          child: new Text("Cancel",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
            Navigator.of(globalKey.currentContext).pop();
          },
        ),
      ],
    );
  }

//------------------------------------------------------------------------------

  Widget _changePasswordDialog() {
    return new AlertDialog(
      title: new Text(
        "Change Password",
        style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
      ),
      content: new Container(
        child: new Form(
            child: new Theme(
                data: new ThemeData(primarySwatch: Colors.pink),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                        child: new TextFormField(
                          controller: oldPasswordController,
                          decoration: InputDecoration(
                              suffixIcon: new Icon(
                                Icons.vpn_key,
                                color: Colors.pink,
                              ),
                              labelText: Texts.OLD_PASSWORD,
                              labelStyle: TextStyle(fontSize: 18.0)),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0)),
                    new Container(
                        child: new TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                              suffixIcon: new Icon(
                                Icons.vpn_key,
                                color: Colors.pink,
                              ),
                              labelText: Texts.NEW_PASSWORD,
                              labelStyle: TextStyle(fontSize: 18.0)),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0)),
                  ],
                ))),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("OK",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
            if (oldPasswordController.text == "") {
              globalKey.currentState.showSnackBar(new SnackBar(
                content: new Text(SnackBarText.ENTER_OLD_PASS),
              ));
              return;
            }

            if (newPasswordController.text == "") {
              globalKey.currentState.showSnackBar(new SnackBar(
                content: new Text(SnackBarText.ENTER_NEW_PASS),
              ));
              return;
            }

            FocusScope
                .of(globalKey.currentContext)
                .requestFocus(new FocusNode());
            Navigator.of(globalKey.currentContext).pop();
            progressDialog.showProgress();
            _changePassword(user.email, oldPasswordController.text,
                newPasswordController.text);
          },
        ),
        new FlatButton(
          child: new Text("Cancel",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
            Navigator.of(globalKey.currentContext).pop();
          },
        ),
      ],
    );
  }

//------------------------------------------------------------------------------

  void _showAlertOption(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Alert!"),
          content: Text("একটি অপশন নির্বাচন করুন"),
        )
    );
  }

  void _changePassword(
      String emailID, String oldPassword, String newPassword) async {
    EventObject eventObject =
        await changePassword(emailID, oldPassword, newPassword);
    switch (eventObject.id) {
      case EventConstants.CHANGE_PASSWORD_SUCCESSFUL:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.CHANGE_PASSWORD_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.CHANGE_PASSWORD_UN_SUCCESSFUL:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.CHANGE_PASSWORD_UN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.INVALID_OLD_PASSWORD:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.INVALID_OLD_PASSWORD),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
    }
  }
}
