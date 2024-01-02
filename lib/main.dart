import 'package:flutter_chat_app/global_providers.dart';
import 'package:flutter_chat_app/project_export/project_export.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: MaterialApp(
        title: 'Flutter Chat App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177),
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          ChatPage.routeName: (context) => const ChatPage(),
        },
      ),
    );
  }
}
