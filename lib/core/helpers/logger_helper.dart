import 'package:logger/logger.dart';
var logger=Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: true,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  )
);