import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComponentUtils {
  static void showCupertinoDatePicker(BuildContext context,
      {String? title,
      TextStyle? titleStyle,
      required ValueChanged<DateTime> onSubmitted}) {
    DateTime datetime = DateTime.now();
    FocusScope.of(context).unfocus();
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Wrap(
              children: [
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Material(
                              child: Container(
                                color: Colors.grey.shade100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        title ?? '',
                                        style: titleStyle,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          onSubmitted(datetime);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Chọn',
                                          style: titleStyle,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                use24hFormat: true,
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (value) {
                                  datetime = value;
                                },
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
}
