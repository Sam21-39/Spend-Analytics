import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:spend_analytics/Core/UI/uicolors.dart';
// import 'package:spend_analytics/Core/cubit/conn_cubit.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Color appBarColor, backgroundColor;
  final Widget body;
  final List<Widget>? appBarActions;
  const BaseScaffold({
    super.key,
    required this.title,
    required this.appBarColor,
    required this.backgroundColor,
    required this.body,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: appBarColor,
        actions: appBarActions,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            // color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: body,
        // child: BlocProvider(
        //   create: (context) => ConnCubit()..init(),
        //   child: BlocConsumer<ConnCubit, ConnState>(
        //     listener: (context, state) {
        //       if (state.isLoading && !state.isConnected) {
        //         EasyLoading.show();
        //       } else if (state.isConnected && !state.isLoading) {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             duration: const Duration(milliseconds: 800),
        //             content: Text(
        //               state.errorMessage,
        //             ),
        //           ),
        //         );
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             duration: const Duration(milliseconds: 800),
        //             content: Text(
        //               state.errorMessage,
        //             ),
        //           ),
        //         );
        //       }
        //       EasyLoading.dismiss();
        //     },
        //     builder: (context, state) {
        //       if (state.isLoading && !state.isConnected) {
        //         return Container();
        //       } else if (state.isConnected && !state.isLoading) {
        //         return body;
        //       }
        //       return Center(
        //         child: Text(
        //           state.errorMessage,
        //           style: TextStyle(color: UiColors.red, fontSize: 36.sp),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}
