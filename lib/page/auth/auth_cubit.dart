import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(const AuthState(
          screen: ScreenState.initial(),
          dialog: DialogState.idle(),
        ));

  // 検索実行
  Future<void> getWeather(String cityName) async {
    // 画面（screen）だけをロード中に変更
    emit(state.copyWith(screen: const ScreenState.loading()));
    // 遅延確認
    //await Future.delayed(Duration(seconds: 3));
    try {
      emit(state.copyWith(
        screen: ScreenState.success(
          result: true,
        ),
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
        screen: ScreenState.error(
          message: e.toString(),
        ),
      ));
    }
  }
}
