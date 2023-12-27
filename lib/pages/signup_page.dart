import '../project_export/project_export.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _name, _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SignupCubit>().signup(
          name: _name!,
          email: _email!,
          password: _password!,
        );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupStatus == SignupStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 20.0),
                      AppTextFormField(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.account_box),
                        onSaved: (String? value) {
                          _name = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      AppTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        onSaved: (String? value) {
                          _email = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      AppTextFormField(
                        textEditingController: _passwordController,
                        isPassWord: true,
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        onSaved: (String? value) {
                          _password = value;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      AppTextFormField(
                        obscureText: true,
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        validator: (String? value) {
                          if (_passwordController.text != value) {
                            return 'Passwords not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: state.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit,
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                        ),
                        child: Text(
                          state.signupStatus == SignupStatus.submitting
                              ? 'Loading...'
                              : 'Sign Up',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: state.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: const Text('Already a member? Sign in!'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
