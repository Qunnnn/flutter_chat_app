import 'dart:io';
import '../../project_export/packages_export.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;

  SignupCubit({
    required this.authRepository,
  }) : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    emit(
      state.copyWith(
        signupStatus: SignupStatus.submitting,
      ),
    );

    try {
      await authRepository.signup(
        name: name,
        email: email,
        password: password,
        image: image,
      );
      emit(
        state.copyWith(
          signupStatus: SignupStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signupStatus: SignupStatus.error,
          error: e,
        ),
      );
    }
  }
}
