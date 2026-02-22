import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../core/resources/assets/resources.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/button_style.dart';
import '../../feature/route/route_path.dart';
import '../../core/theme/theme_notifier.dart';
import '../../feature/ui/app_bars.dart';
import 'auth_cubit.dart';
import 'auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static String name = RoutePath.authScreenPath;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Устанавливаем анимацию на повторение
    _animationController.repeat(
        reverse: true); // Анимация будет повторяться бесконечно
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final isDarkTheme = themeNotifier.isDarkTheme;

        // 1. まず Scaffold を配置（この context に Scaffold 情報が載る）
        return Scaffold(
          appBar: buildNormalAppBar(context, 'Login Example',
              isDarkTheme: isDarkTheme),
          backgroundColor: isDarkTheme ? AppColors.black : AppColors.white,
          body: BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                previous.screen != current.screen ||
                previous.dialog != current.dialog,
            listener: (context, state) {
              // ローディング制御（SmartDialog）
              if (state.screen is ScreenLoading ||
                  state.dialog is DialogLoading) {
                SmartDialog.showLoading(msg: 'Loading...');
              } else {
                SmartDialog.dismiss();
              }

              // 遷移・エラー処理
              state.screen.maybeWhen(
                success: (_) {
                  context.go(RoutePath.mainScreenPath);
                },
                error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(msg), backgroundColor: Colors.redAccent),
                ),
                orElse: () {},
              );
            },
            child: SingleChildScrollView(
              child: Center(
                // 中央に配置するために必要
                child: FractionallySizedBox(
                  widthFactor: 0.8, // ここで80%を指定
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                          top: 100,
                          left: 60,
                          right: 60,
                        ),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            double angle = _animationController.value *
                                2.0 *
                                3.141592653589793;
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                // Ограничиваем размеры логотипа
                                double maxSize = 200;
                                double logoSize = constraints.maxWidth < maxSize
                                    ? constraints.maxWidth
                                    : maxSize;

                                return Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001) // Перспектива
                                    ..rotateY(angle),
                                  // Вращение вокруг оси Y
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: logoSize,
                                    height: logoSize,
                                    child: SvgPicture.asset(
                                      ImageAssets.logo,
                                      //color: AppColors.orange200,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      /*Text(
                        'Example',
                        style: AppTypography.font24Regular.copyWith(
                          fontWeight: FontWeight.w800,
                          color:
                              isDarkTheme ? AppColors.white : AppColors.black,
                        ),
                      ),*/
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: isDarkTheme
                              ? Colors.grey.shade700
                              : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: isDarkTheme
                              ? Colors.grey.shade700
                              : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          style: AppButtonStyle.primaryStyleOrange,
                          onPressed: () {
                            context.read<AuthCubit>().doLogin();
                          },
                          child: BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                            return state.screen.when(
                                initial: () => _loginText(),
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (_) => const CircularProgressIndicator(),
                                success: (_) => _loginText());
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _loginText() {
    return const Text(
      'Login',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}
