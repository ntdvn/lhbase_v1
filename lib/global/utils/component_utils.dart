import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:get/get.dart';

class ComponentUtils {
  static void showCupertinoDatePicker(BuildContext context,
      {String? title,
      required ValueChanged<DateTime> onSubmitted,
      VoidCallback? onDelete,
      bool use24hFormat = true,
      DateTime? minimumDate,
      DateTime? initialDateTime,
      DateTime? maximumDate}) {
    DateTime datetime = maximumDate!;
    FocusScope.of(context).unfocus();
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Wrap(
              children: [
                Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        child: Column(
                          children: [
                            Material(
                              child: Container(
                                color: Colors.grey.shade100,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${title ?? ''}',
                                        style: LhStyle.DEFAULT_18
                                            .copyWith(color: Colors.lightBlue),
                                      ),
                                    ),
                                    RichText(
                                      text: new TextSpan(
                                        children: [
                                          if (onDelete != null)
                                            new TextSpan(
                                              text:
                                                  'cupertino_picker.delete'.tr,
                                              style: LhStyle.DEFAULT_18
                                                  .copyWith(color: Colors.red),
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      onDelete();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                            ),
                                          if (onDelete != null)
                                            new TextSpan(
                                              text: ' | ',
                                              style: LhStyle.DEFAULT_18
                                                  .copyWith(
                                                      color: Colors.lightBlue),
                                            ),
                                          new TextSpan(
                                              text:
                                                  'cupertino_picker.select'.tr,
                                              style: LhStyle.DEFAULT_18
                                                  .copyWith(
                                                      color: Colors.lightBlue),
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      onSubmitted(datetime);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                initialDateTime: initialDateTime ?? minimumDate,
                                use24hFormat: use24hFormat,
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (value) {
                                  datetime = value;
                                },
                                minimumDate: minimumDate,
                                maximumDate: maximumDate,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Close the modal
                    ],
                  ),
                ),
              ],
            ));
  }

  static Future<bool> showConfirmDialog(
    BuildContext context,
    String title,
    String message, {
    String? positiveTitle,
    VoidCallback? positiveTap,
    TextStyle? positiveStyle,
    String? negativeTitle,
    VoidCallback? negativeTap,
    TextStyle? negativeStyle,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                if (negativeTap != null) negativeTap();
              },
              child: Text(
                negativeTitle ?? 'No',
                style: negativeStyle,
              ),
            ),
            negativeTitle != null || negativeTap != null
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      if (positiveTap != null) positiveTap();
                    },
                    child: Text(
                      positiveTitle ?? 'Yes',
                      style: positiveStyle,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }

  static Widget alertDialogConfirm(String title, String message,
      {String? positiveTitle,
      VoidCallback? positiveTap,
      TextStyle? positiveStyle,
      String? negativeTitle,
      VoidCallback? negativeTap,
      TextStyle? negativeStyle}) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        negativeTitle != null || negativeTap != null
            ? TextButton(
                onPressed: () {
                  if (negativeTap != null) negativeTap();
                },
                child: Text(
                  negativeTitle ?? 'No',
                  style: negativeStyle,
                ),
              )
            : const SizedBox.shrink(),
        TextButton(
          onPressed: () {
            if (positiveTap != null) positiveTap();
          },
          child: Text(
            positiveTitle ?? 'Yes',
            style: positiveStyle,
          ),
        ),
      ],
    );
  }

  static void setStatusBarStyle(
      {required Brightness brightness,
      Brightness? statusBarIconBrightness,
      Brightness? systemNavigationBarIconBrightness,
      Color? systemNavigationBarColor,
      Color? statusBarColor,
      Color? systemNavigationBarDividerColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: brightness,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      systemNavigationBarColor:
          systemNavigationBarColor, // navigation bar color
      statusBarColor: statusBarColor, // status bar color

      systemNavigationBarDividerColor: systemNavigationBarDividerColor,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ));
  }

  static void setStatusBarBrightness(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: brightness == Brightness.light
            ? Colors.black.withOpacity(0.4)
            : Colors.white.withOpacity(0.1),
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent));
  }
}
