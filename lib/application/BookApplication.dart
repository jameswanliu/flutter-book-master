import 'package:fluro/fluro.dart';
import 'package:flutter_book_master/router/AppRouter.dart';

import 'Application.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_book_master/repertory/api/ApiProvider.dart';

class BookApplication extends Application {
  ScreenUtil screenUtil;

  Router router;
  BookApplication() {
    onCreate();
  }

  @override
  Future<void> onCreate() async {
    _initApiRepository();
    _initScreenUtil();
    _initRouter();
  }

  @override
  void onTerminate() {}

   _initApiRepository() {
  }

   _initScreenUtil() {
    screenUtil = ScreenUtil.getInstance();
  }

   _initRouter() {
    router = Router();
    AppRouter.initRouter(router);
  }
}
