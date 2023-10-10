import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  TextTheme textTheme(ctx) => Theme.of(ctx).textTheme;
  ThemeData themeOf(ctx) => Theme.of(ctx);

  void showLoading(BuildContext ctx) {
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (ctx) {
          return Stack(
            alignment: Alignment.center,
            children: const [
              Icon(Icons.cloud),
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ],
          );
        });
  }

  String convertToDayDisplay(String date) {
    DateTime parseDate = DateTime.parse(date);
    return DateFormat('EEEE').format(parseDate);
  }

  String convertToDateDisplay(String date) {
    DateTime parseDate = DateTime.parse(date);
    return DateFormat('MMMM d, y').format(parseDate);
  }

  String convertToForcastDateDisplay(String date) {
    DateTime parseDate = DateTime.parse(date);
    return DateFormat('EEE, MMMM d').format(parseDate);
  }
}
