import '../project_export/project_export.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, SigninPage.routeName,
                  (route) {

                return route.settings.name == ModalRoute.of(context)!.settings.name
                    ? true
                    : false;
              });
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, ChatPage.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}