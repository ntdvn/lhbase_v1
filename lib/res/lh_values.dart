import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LhValue {
  LhValue._();

  static const int SECRET_NUMBER = -1;

  static const DEFAULT_ASPECT_RATIO = 9 / 21;

  static const MONEY_VND = 'đ'; // ignore: non_constant_

  static final APP_MONEY_FORMAT = new NumberFormat.currency(
      locale: 'en', symbol: '\$'); // ignore: non_constant_identifier_names
  static final APP_COIN_FORMAT = new NumberFormat.currency(
      locale: 'vi', symbol: 'coin'); // ignore: non_constant_identifier_names
  static final APP_DATE_FORMAT = DateFormat('kk:mm - dd/MM/yyyy');
  static final TIME_FORMAT =
      DateFormat('kk:mm'); // ignore: non_constant_identifier_names
  static final DATE_FORMAT =
      DateFormat('dd/MM/yyyy'); // ignore: non_constant_identifier_names
  static final APP_DATE_FORMAT_ONLY_DATE =
      DateFormat('dd-MM-yyyy'); // ignore: non_constant_identifier_names
  static final YEAR_MONTH_DAY =
      DateFormat('yyyy-MM-dd'); // ignore: non_constant_identifier_names
  static final FORMAT_PRICE = new NumberFormat(
      "#,##0.00", "en_US"); // ignore: non_constant_identifier_names

  static const FONT_SIZE_10 = 10.0;
  static const FONT_SIZE_12 = 12.0;
  static const FONT_SIZE_14 = 14.0;
  static const FONT_SIZE_18 = 18.0;
  static const FONT_SIZE_16 = 16.0;
  static const FONT_SIZE_20 = 20.0;
  static const FONT_SIZE_22 = 22.0;
  static const FONT_SIZE_24 = 24.0;

  static const ACTION_BAR_HEIGHT = 45.0;

  static const INPUT_FORM_HEIGHT = 55.0;

  static const PRODUCT_HORIZONTAL_HEIGHT = 320.0;
  static const PRODUCT_HORIZONTAL_WIDTH = 200.0;
  static const PRODUCT_HORIZONTAL_SALE = 50.0;

  static const REFRESHER_CONTAINER_VIEW_HEIGHT = 80.0;
  static const REFRESHER_CONTAINER_VIEW_WIDTH = 80.0;

  static const CART_PROMOTION_MENU_HEIGHT = 50.0;

  static const VERIFY_RESEND_TIME = Duration(seconds: 60);
  static const FAKE_TIME_RELOAD = Duration(milliseconds: 500);

  static const PROFILE_MENU_HEIGHT = 40.0;

  static const BoxFit IMAGE_FIT_MODE = BoxFit.fill;

//  RATIO
  static const double BANNER_RATIO =
      16 / 9; //not use this, get device width/height in runtime
  static const double CATEGORIES_RATIO = 1 / 1;
  static const double CATEGORIES_RATIO_NAME = 1.25;
  static const double PRODUCT_IMAGE_RATIO = 0.7;
  static const double NEWS_IMAGE_RATIO = 1.6;

  static const double PRODUCT_GRID_RATIO =
      PRODUCT_HORIZONTAL_WIDTH / PRODUCT_HORIZONTAL_HEIGHT;

  static const double PRODUCT_FILTER_PRICE_BEGIN = 0;
  static const double PRODUCT_FILTER_PRICE_END = 5000000;
  static const double PRODUCT_FILTER_STEP_PRICE = 100000;

  static const APP_HORIZONTAL_PADDING = 10.0;

  static const Widget kEmptyWidget = SizedBox();

  static Widget hSpace(double width) => SizedBox(width: width);
  static const Widget hSpaceTiny = SizedBox(width: 8.0);
  static const Widget hSpaceSmall = SizedBox(width: 16.0);
  static const Widget hSpaceMedium = SizedBox(width: 32.0);

  static Widget vSpace(double height) => SizedBox(height: height);
  static const Widget vSpaceTiny = SizedBox(height: 8.0);
  static const Widget vSpaceSmall = SizedBox(height: 16.0);
  static const Widget vSpaceMedium = SizedBox(height: 32.0);
  static const Widget vSpaceLarge = SizedBox(height: 64.0);
  static const Widget vSpaceMassive = SizedBox(height: 128.0);

  static format_money(double money) {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return 'đ' + currencyFormatter.format(money);
  }

  static String formatStringDateAndTime(String dateString) =>
      APP_DATE_FORMAT.format(DateTime.parse(dateString));

  static String formatStringDate(String dateString) =>
      DATE_FORMAT.format(DateTime.parse(dateString));

  static String formatStringTime(String dateString) =>
      TIME_FORMAT.format(DateTime.parse(dateString));

  static String formatStringYMD(String dateString) =>
      YEAR_MONTH_DAY.format(DateTime.parse(dateString));

  static String dateTimeToTime(DateTime dateString) =>
      TIME_FORMAT.format(dateString.add(Duration(hours: 7)));

  static String dateTimeToDate(DateTime dateString) =>
      DATE_FORMAT.format(dateString.add(Duration(hours: 7)));

  static String formatStringDateYMD(String dateString) {
    List date = dateString.split('/');
    return date[2] + '-' + date[1] + '-' + date[0];
  }

  static final BorderRadius circleRadius = BorderRadius.circular(500.0);

  static const double messageImagesWidth = 250;
  static const double messageFullWidth = 300;
}
