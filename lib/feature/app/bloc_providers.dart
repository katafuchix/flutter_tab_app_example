import 'package:flutter_bloc/flutter_bloc.dart';
import '../../page/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';

//import 'package:vas_app/feature/auth_page/presentation/bloc/auth_bloc.dart';
//import 'package:vas_app/feature/history_page/presentation/bloc/history_order_bloc.dart';
//import 'package:vas_app/feature/order_page/presentation/bloc/order_bloc.dart';

//import '../profile_page/presentation/bloc/profile_bloc.dart';

// GetItは「アプリ内のどこからでも、必要なモノ（インスタンス）を取り出せる魔法の保管庫
List<BlocProvider> buildListProviders({required GetIt locator}) {
  return [
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
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
