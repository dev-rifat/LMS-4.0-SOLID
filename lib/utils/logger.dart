import 'dart:developer';
import 'package:get/get_connect/http/src/response/response.dart';

import '../app/global/models/error_model.dart';

void logErrorMessage({required String logName, Response? response}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: ErrorModel.fromJson(response?.body).message);



void logSuccessMessage(
    {required String logName, Response? response, String? message}) =>
    log("${response?.statusCode} :  ${response?.request?.url.toString()}",
        name: logName, error: message);