import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../errors/api_exceptions.dart';
import '../../errors/bot_toast.dart';

class ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response?.statusCode;

      // Handling Error 422: Invalid username or password
      if (statusCode == 422) {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: "Incorrect username or password",
        );
        throw FailedRequestException(
          title: 'Error',
          message: 'Incorrect username or password',
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }

      // Handling Error 500: Server Error
      else if (statusCode == 500) {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: '${err.message}',
        );
        throw ServerError(
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }

      // For other error codes that are not covered
      else {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: '${err.message}',
        );
        throw FailedRequestException(
          title: 'Error',
          message: 'Unknown error',
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }
    } else {
      GetIt.I<BotToastDi>().showNotification(
        icon: null,
        title: '${err.message}',
      );
      throw UnknownException(
        requestOptions: err.requestOptions,
        error: err.error,
      );
    }

    return super.onError(err, handler);
  }
}
