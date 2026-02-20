import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/resources/assets/resources.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/typography.dart';
import 'route_path.dart';
import 'routing.dart';
import 'scaffold_with_nav_bar_tab_item.dart';
import 'app_route_single_tone.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({
    super.key, // 最新の記法に整理
    //required this.body,
    this.navigationShell, // Routerから直接受け取る
  });

  //final Widget body;
  final StatefulNavigationShell? navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> alpha;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
    );

    alpha = Tween<double>(begin: 1, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shellState = widget.navigationShell;

    final data = MediaQuery.of(context);
    final bottomPadding = data.viewPadding.bottom;

    final double screenHeight = data.size.height;
    final double navBarHeight = bottomPadding > 0 ? 56.0 + bottomPadding : 56.0;
    final double availableHeight = screenHeight - navBarHeight;
    final double keyboardHeight = data.viewInsets.bottom;

    // shellStateがない（ログイン画面など）場合のガード処理
    final bool showNavBar =
        shellState != null && appRouteSingleTone.showValue != 0;

    return MediaQuery(
      data: data.copyWith(
        textScaler: TextScaler.linear(
            data.textScaleFactor > 1.2 ? 1.2 : data.textScaleFactor),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: (showNavBar ? navBarHeight : 0) + keyboardHeight,
                ),
                child: SizedBox(
                  // ContainerよりSizedBoxの方が軽量（コスト削減）
                  height: availableHeight - keyboardHeight,
                  child: shellState ?? const SizedBox.shrink(),
                ),
              ),
            ),
            if (shellState != null) // shellStateがある時のみNavBarを描画
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: appRouteSingleTone.showValue,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .04),
                          offset: Offset(0.0, -7.0),
                          blurRadius: 14,
                        )
                      ],
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: BottomNavigationBar(
                      selectedLabelStyle: AppTypography.font16Regular,
                      unselectedLabelStyle: AppTypography.font16Regular,
                      unselectedItemColor: AppColors.gray.shade70,
                      selectedItemColor: AppColors.orange200,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.gray.shade90
                              : AppColors.white,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        ScaffoldWithNavBarTabItem(
                          rootRoutePath: RoutePath.mainScreenPath,
                          iconActive: GestureDetector(
                            onTap: () => HapticFeedback.lightImpact(),
                            child: SvgPicture.asset(VectorAssets.icHomeActive),
                          ),
                          icon: SvgPicture.asset(VectorAssets.icHomeDeactive),
                          label: 'Главная',
                        ),
                        ScaffoldWithNavBarTabItem(
                          rootRoutePath: RoutePath.profileScreenPath,
                          iconActive:
                              SvgPicture.asset(VectorAssets.icProfileActive),
                          icon:
                              SvgPicture.asset(VectorAssets.icProfileDeactive),
                          label: 'Профиль',
                        ),
                      ],
                      //currentIndex: shellState.currentIndex,
                      currentIndex: shellState?.currentIndex ?? 0,
                      onTap: (int tappedIndex) {
                        HapticFeedback.mediumImpact();
                        shellState.goBranch(tappedIndex);
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
