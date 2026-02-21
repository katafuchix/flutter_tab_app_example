import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/network_cubit.dart';
import '../../core/utils/theme_cubit.dart';
import '../../page/auth/auth_cubit.dart';
import '../../page/profile/profile_cubit.dart';

// GetItは「アプリ内のどこからでも、必要なモノ（インスタンス）を取り出せる魔法の保管庫
List<BlocProvider> buildListProviders({required GetIt locator}) {
  return [
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
    ),
    BlocProvider<NetworkCubit>(
      create: (context) => NetworkCubit(),
    ),
    BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(),
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(locator<SharedPreferences>()),
    ),
  ];
}

/*
List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<AuthCubit>(
      create: (context) => locator<AuthCubit>(),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => locator<AuthBloc>(),
    ),
    BlocProvider<OrderBloc>(
      create: (context) => locator<OrderBloc>(),
    ),
    BlocProvider<HistoryOrderBloc>(
      create: (context) => locator<HistoryOrderBloc>(),
    ),
  ];
}
*/
