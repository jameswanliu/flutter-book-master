import 'package:flutter/material.dart';
import 'package:flutter_book_master/core/AppComponent.dart';

import 'application/BookApplication.dart';

var _application = BookApplication();

void main() => runApp(AppComponent(_application));
