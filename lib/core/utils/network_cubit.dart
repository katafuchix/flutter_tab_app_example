import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// 状態を定義（シンプルに List<ConnectivityResult> を持つ形）
class NetworkState {
  final List<ConnectivityResult> results;

  NetworkState(this.results);

  // 利便性のためのゲッター（以前の logic を踏襲）
  bool get isOnline =>
      results.contains(ConnectivityResult.mobile) ||
      results.contains(ConnectivityResult.wifi);

  bool get isOffline => results.contains(ConnectivityResult.none);
}

class NetworkCubit extends Cubit<NetworkState> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final Connectivity _connectivity = Connectivity();

  NetworkCubit() : super(NetworkState([ConnectivityResult.none])) {
    _init();
  }

  Future<void> _init() async {
    // 1. 初回の接続確認
    final initialResult = await _connectivity.checkConnectivity();
    emit(NetworkState(initialResult));

    // 2. 変化を監視
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      emit(NetworkState(results));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
