import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
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
                controller: emailController,
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
                controller: passwordController,
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
                  onPressed: !authState.isLoading
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            await ref.read(authServiceProvider.notifier).signIn(
                                  email: emailController.value.text,
                                  password: passwordController.value.text,
                                );
                            AutoRouter.of(context).replaceNamed("/home");
                          }
                        }
                      : null,
                  child: Row(
                    children: [
                      if (authState.isLoading)
                        Row(
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
                      Text("Login"),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 20),
              if (authState.hasError)
                Text(
                  authState.error ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.red),
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
