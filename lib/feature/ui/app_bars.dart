import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/typography.dart';

/*
AppBar buildHomeAppBar(BuildContext context, String title,
    {TabBar? tabBar, bool noActions = false}) {
  List<Widget> actions = [
    IconButton(
        icon: Icon(
          Icons.my_library_books,
          color: Colors.white,
        ),
        onPressed: () => MyNavigator.pushNamed(context, Routes.setting)),
    IconButton(
        icon: Icon(Icons.person, color: Colors.white),
        onPressed: () async {
          await MyNavigator.pushNamed(context, Routes.myPage);
          MyProfileNotifier.getNoListenerNotifier(context).update(context);
        })
  ].where((element) => element != null).toList();
  return AppBar(
    title: buildH3Text(title, colors: TextColors.WHITE),
    backgroundColor: getAppColors().primary,
    centerTitle: (MyPlatform.isIOS || MyPlatform.isWeb),
    leading: Container(),
    actions: noActions ? null : actions,
    bottom: tabBar,
  );
}
*/

AppBar buildNormalAppBar(BuildContext context, String title,
    {List<Widget>? actions,
    dynamic Function()? popResult,
    bool isCloseButtonVisible = false,
    isDarkTheme = false}) {
  return AppBar(
    title: Text(
      title,
      style: AppTypography.font22Regular.copyWith(
        fontWeight: FontWeight.w600,
        color: isDarkTheme ? AppColors.white : AppColors.black,
      ),
    ),
    centerTitle: true,
    //backgroundColor: getAppColors().primary,
    //centerTitle: (MyPlatform.isIOS || MyPlatform.isWeb),
    leading: isCloseButtonVisible
        ? IconButton(
            icon: Icon(
              Icons.close,
              color: isDarkTheme ? AppColors.white : AppColors.black,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context, popResult?.call());
            },
          )
        : Container(),
    actions: actions,
  );
}
