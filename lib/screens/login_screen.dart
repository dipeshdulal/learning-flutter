import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _handleLogin(BuildContext context, WidgetRef ref) {
    return () async {
      if (_formKey.currentState!.validate()) {
        await ref.read(authServiceProvider.notifier).signIn(
              email: _emailController.value.text,
              password: _passwordController.value.text,
            );
        AutoRouter.of(context).replaceNamed("/home");
      }
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    AutoRouter.of(context).replaceNamed("/register");
                  },
                  child: Text("Register"),
                ),
                ElevatedButton(
                  onPressed: authState.maybeWhen(
                    loading: () {},
                    orElse: () => _handleLogin(context, ref),
                  ),
                  child: Row(
                    children: [
                      authState.maybeWhen(
                        loading: () => Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        orElse: () => Container(),
                      ),
                      Text("Login"),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 20),
              authState.maybeWhen(
                error: (err) => Text(
                  err ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.red),
                ),
                orElse: () => Container(),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(authServiceProvider.notifier)
                        .signInWithGoogle();
                    AutoRouter.of(context).replaceNamed("/home");
                  },
                  child: Container(
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.android),
                        SizedBox(width: 10),
                        Text("Sign in with Google"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
