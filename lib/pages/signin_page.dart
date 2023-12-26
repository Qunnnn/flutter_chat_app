import '../project_export/project_export.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = '/signin';

  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state.signinStatus == SigninStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      'assets/images/chat.png',
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 20.0),
                    AppTextFormField(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      isEmailType: true,
                      onSaved: (String? value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    AppTextFormField(
                      labelText: 'Password',
                      textEditingController: _passwordController,
                      prefixIcon: const Icon(Icons.password),
                      isPassWord: true,
                      onSaved: (String? value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    AppElevatedButton(
                      text: state.signinStatus == SigninStatus.submitting
                          ? 'Loading...'
                          : 'Sign In',
                      onPressed: state.signinStatus == SigninStatus.submitting
                          ? null
                          : _submit,
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: state.signinStatus == SigninStatus.submitting
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, SignupPage.routeName);
                            },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text(
                        'Not a member? Sign Up!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
