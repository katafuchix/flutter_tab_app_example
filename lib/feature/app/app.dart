import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../core/theme/theme_notifier.dart';
import '../route/routing.dart';
import 'app_adaptive_provider.dart';
import 'app_router_provider.dart';
import 'bloc_providers.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _router = RoutesInit();
  late GetIt locator;

  @override
  void initState() {
    locator = GetIt.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppAdaptiveProvider(
      child: AppRouterProvider(
        goRouter: _router.router,
        // Add ChangeNotifierProvider
        child: ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
          // Consumer で変更を反映
          child: Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return _buildApp(context, themeNotifier);
            },
          ),
        ),
      ),
    );
  }

  MultiBlocProvider _buildApp(
      BuildContext context, ThemeNotifier themeNotifier) {
    return MultiBlocProvider(
      providers: buildListProviders(locator: locator),
      child: MaterialApp.router(
        darkTheme: ThemeData.dark(),
        theme: themeNotifier.currentTheme,
        // アプリ全体の描画空間をカスタマイズする場所
        builder: (context, child) {
          // 1. まず BotToast でラップする
          final botToastBuilder = BotToastInit();
          child = botToastBuilder(context, child);

          // 2. 次に SmartDialog でラップする
          final smartDialogBuilder = FlutterSmartDialog.init();
          child = smartDialogBuilder(context, child);

          return child;
        },
        title: 'VAS documents',
        routerConfig: _router.router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        themeMode: ThemeMode.light,
        scaffoldMessengerKey: GlobalSnackBar.scaffoldMessengerKey,
      ),
    );
  }
}

class GlobalSnackBar {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
