import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/network_cubit.dart';
import '../../page/auth/auth_cubit.dart';
import '../../page/my_data/my_data_cubit.dart';
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
    BlocProvider<MyDataCubit>(
      create: (context) => MyDataCubit(),
    ),
  ];
}
