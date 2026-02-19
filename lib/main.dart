import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/theme_notifier.dart';
import 'feature/app/app.dart';
import 'page/main/main_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(
    // Оборачиваем наше приложение в DevicePreview
    DevicePreview(
      enabled: false, // Включаем только в режиме разработки
      builder: (context) => const Application(),
    ),
  );

  //runApp(const MyApp());
  /*runApp(MaterialApp(
      // これが Directionality や Theme を提供する
      home: MainPage()));*/

  /*
  buildApp(BuildContext context, ThemeNotifier themeNotifier) {
    //return MultiBlocProvider(
    //providers: [], //buildListProviders(locator: locator),
    //child:
    return MaterialApp(
      //.router(
      darkTheme: ThemeData.dark(),
      theme: themeNotifier.currentTheme,
      builder: BotToastInit(),
      title: 'VAS documents',
      //routerConfig: _router.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      themeMode: ThemeMode.light,
      home: const MainPage(),
    );
    //);

  }

  runApp(
      // Оборачиваем наше приложение в DevicePreview
      DevicePreview(
    enabled: false, // Включаем только в режиме разработки
    builder: (context) => ChangeNotifierProvider<ThemeNotifier>(
      // Добавляем ChangeNotifierProvider
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        // Используем Consumer для отслеживания изменений
        builder: (context, themeNotifier, child) {
          return buildApp(context, themeNotifier);
        },
      ),
    ),
  ));
  */
}
