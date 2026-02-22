import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/resources/assets/resources.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/button_style.dart';
import '../../core/theme/theme_notifier.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/text_block.dart';
import '../../feature/route/route_path.dart';
import '../../feature/ui/app_bars.dart';
import 'my_data_cubit.dart';
import 'my_data_state.dart';
//import '../../feature/profile_page/presentation/widjets/text_block.dart';

//import '../bloc/profile_bloc.dart';

class MyDataPage extends StatelessWidget {
  const MyDataPage({super.key});

  static String name = RoutePath.myDataPagePath;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final isDarkTheme = themeNotifier.isDarkTheme;
      return BlocBuilder<MyDataCubit, MyDataState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildNormalAppBar(context, 'My Data',
                isDarkTheme: isDarkTheme, isCloseButtonVisible: true),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 400),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    curve: Curves.easeOut,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, right: 15),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            child: SvgPicture.asset(
                              VectorAssets.icProfileActive,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Text(
                                'Редактировать',
                                style: AppTypography.font16Regular.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue200,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextBlockWidget(
                                text: "state.userInfo?.lastName" ?? '',
                                hintText: 'Фамилия',
                              ),
                              TextBlockWidget(
                                text: "state.userInfo?.name" ?? '',
                                hintText: 'Имя',
                              ),
                              TextBlockWidget(
                                text: "state.userInfo?.middleName" ?? '',
                                hintText: 'Отчество',
                              ),
                              TextBlockWidget(
                                text: "state.userInfo?.phone" ?? '',
                                hintText: 'Телефон',
                              ),
                              TextBlockWidget(
                                text: "state.userInfo?.login" ?? '',
                                hintText: 'Логин',
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style:
                                    AppButtonStyle.primaryStyleOrange.copyWith(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  // backgroundColor: const WidgetStatePropertyAll(AppColors.white),
                                ),
                                child: Text(
                                  'Сохранить изменения',
                                  style: AppTypography.font18Regular.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
