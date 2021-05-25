import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/login/cubit/google_signin_cubit.dart';
import 'package:pedantic/pedantic.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _emailNode;
  late FocusNode _passwordNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailNode = FocusNode();
    _passwordNode = FocusNode();

    super.initState();
  }

  void _onSubmit() {}

  Future<void> _onGoogleSignin() async {
    unawaited(BlocProvider.of<GoogleSigninCubit>(context).login());
  }

  Widget _fadeInWrapper({
    required Widget child,
    required Duration duration,
  }) {
    return PlayAnimation<double>(
      tween: (0.0).tweenTo(1.0),
      duration: duration,
      curve: Curves.easeIn,
      builder: (_, __, opacity) => Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSigninCubit, GoogleSigninState>(
      listener: (context, state) {
        if (state is GoogleSigninSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
        }

        if (state is GoogleSigninError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 64.0),
            _fadeInWrapper(
              duration: (0.5).seconds,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    width: 64,
                    height: 64,
                    cacheWidth: 64,
                    cacheHeight: 64,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    'Listastic',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            _fadeInWrapper(
              duration: (0.75).seconds,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  focusNode: _emailNode,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => _passwordNode.requestFocus(),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Indtast email..',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            _fadeInWrapper(
              duration: (1.0).seconds,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  obscureText: true,
                  onFieldSubmitted: (_) {
                    _passwordNode.unfocus();
                    _onSubmit();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Indtast password..',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            _fadeInWrapper(
              duration: (1.25).seconds,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                    (_) => const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                  ),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _onSubmit();
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 8.0),
            _fadeInWrapper(
              duration: (1.5).seconds,
              child: Text(
                'eller',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 8.0),
            _fadeInWrapper(
              duration: (1.75).seconds,
              child: BlocBuilder<GoogleSigninCubit, GoogleSigninState>(
                builder: (context, state) {
                  if (state is GoogleSigninLoading) {
                    return ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((_) =>
                                Theme.of(context).accentColor.withOpacity(0.5)),
                      ),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }

                  return ElevatedButton.icon(
                    onPressed: _onGoogleSignin,
                    icon: Image.asset(
                      'assets/google.png',
                      width: 24,
                      height: 24,
                      cacheWidth: 24,
                      cacheHeight: 24,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (_) =>
                              Theme.of(context).accentColor.withOpacity(0.5)),
                    ),
                    label: const Text('Log ind med Google'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
