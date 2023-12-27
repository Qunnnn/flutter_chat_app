import 'package:flutter_chat_app/project_export/project_export.dart';

class GlobalProviders extends StatelessWidget {
  const GlobalProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(
              firebaseFirestorage: FirebaseStorage.instance,
              firebaseAuth: FirebaseAuth.instance,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider<SigninCubit>(
              create: (context) => SigninCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider<SignupCubit>(
              create: (context) => SignupCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: child,
        ));
  }
}
