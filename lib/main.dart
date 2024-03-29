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

import 'package:flutter/material.dart';
import 'package:flutter_client_php_backend/pages/splash_page.dart';
import 'package:flutter_client_php_backend/models/Point.dart';
import 'package:flutter_client_php_backend/services/location_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(new FlutterClientPHPBackendApp());

class FlutterClientPHPBackendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Point>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Client PHP Backend',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new SplashPage(),
      ),
    );
  }
}
