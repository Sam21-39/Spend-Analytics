import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Utils/app_constatns.dart';
import 'package:spend_analytics/Core/Widget/base_scaffold.dart';
import 'package:spend_analytics/Core/Widget/base_widgets.dart';

class Setup extends StatelessWidget {
  const Setup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseScaffold(
      title: '',
      appBarColor: theme.appBarTheme.backgroundColor!,
      backgroundColor: theme.colorScheme.background,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _logo(context),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Welcome to Spend Analytics!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            FutureBuilder<bool>(
              initialData: false,
              future: Future.delayed(const Duration(milliseconds: 4000))
                  .then((value) => true),
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 1200),
                  opacity: snapshot.data != null && snapshot.data! ? 1 : 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'We have different categories for your expenses.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _categoryGrid(context),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            FutureBuilder<bool>(
              initialData: false,
              future: Future.delayed(const Duration(milliseconds: 8000))
                  .then((value) => true),
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 1200),
                  opacity: snapshot.data != null && snapshot.data! ? 1 : 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _visualiztionGrid(context),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Visualize them easily with us.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            FutureBuilder<bool>(
              initialData: false,
              future: Future.delayed(const Duration(milliseconds: 12000))
                  .then((value) => true),
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 1200),
                  opacity: snapshot.data != null && snapshot.data! ? 1 : 0,
                  child: BaseWidgets.customElevatedIconButton(
                    context: context,
                    icon: Icon(Icons.arrow_forward_rounded),
                    text: 'Let\'s Get Started',
                    btnColor: UiColors.primary,
                    onClick: () {},
                  ),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _visualiztionGrid(BuildContext context) => Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            ),
          ],
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.sp,
          mainAxisSpacing: 16.sp,
          children: [
            SizedBox.square(
              dimension: 60.sp,
              child: Icon(
                Icons.bar_chart_rounded,
                size: 40.sp,
                color: UiColors.primary,
              ),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: Icon(
                Icons.pie_chart_rounded,
                size: 40.sp,
                color: UiColors.lightBlue,
              ),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: Icon(
                Icons.show_chart_rounded,
                size: 40.sp,
                color: UiColors.lightBlue,
              ),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: Icon(
                Icons.ssid_chart_rounded,
                size: 40.sp,
                color: UiColors.primary,
              ),
            ),
          ],
        ),
      );

  _categoryGrid(BuildContext context) => Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            ),
          ],
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.sp,
          mainAxisSpacing: 16.sp,
          children: [
            SizedBox.square(
              dimension: 60.sp,
              child: SvgPicture.asset(ENTERTAIMENT),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: SvgPicture.asset(FOOD),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: SvgPicture.asset(BILLS),
            ),
            SizedBox.square(
              dimension: 60.sp,
              child: SvgPicture.asset(INVESTMENT),
            ),
          ],
        ),
      );

  _logo(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            ),
          ],
        ),
        child: SizedBox.square(
          dimension: 200.sp,
          child: Hero(
            tag: '_logo',
            child: SvgPicture.asset(
              LOGO_SVG,
            ),
          ),
        ),
      );
}
