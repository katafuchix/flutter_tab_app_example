import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';
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
        child: ChangeNotifierProvider<ThemeNotifier>(
          // Добавляем ChangeNotifierProvider
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            // Используем Consumer для отслеживания изменений
            builder: (context, themeNotifier, child) {
              return buildApp(context, themeNotifier);
            },
          ),
        ),
      ),
    );
  }

  buildApp(BuildContext context, ThemeNotifier themeNotifier) {
    return MultiBlocProvider(
      providers: buildListProviders(locator: locator),
      child: MaterialApp.router(
        darkTheme: ThemeData.dark(),
        theme: themeNotifier.currentTheme,
        builder: BotToastInit(),
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
      ),
    );
  }
}
