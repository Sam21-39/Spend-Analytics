import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(
          SplashState(
            isLoggedIn: false,
            isSplashLoaded: false,
          ),
        );

  init() async {
    Future.delayed(Duration(milliseconds: 3000)).then(
      (value) => emit(
        SplashState(
          isLoggedIn: false,
          isSplashLoaded: true,
        ),
      ),
    );
  }
}
