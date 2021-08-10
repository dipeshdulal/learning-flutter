import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rnd/services/auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmationController = useTextEditingController();

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
                "Register",
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
              TextFormField(
                controller: passwordConfirmationController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password Confirmation is required";
                  }
                  if (value != passwordController.value.text) {
                    return "Password and Password Confirmation doesn't match";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Password Confirmation",
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                    onPressed: () {
                      AutoRouter.of(context).replaceNamed("/login");
                    },
                    child: Text("Login")),
                ElevatedButton(
                  onPressed: authState.maybeWhen(
                    loading: () {},
                    orElse: () {
                      return () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authServiceProvider.notifier)
                              .registerUser(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                              );
                          AutoRouter.of(context).replaceNamed("/home");
                        }
                      };
                    },
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
                      Text("Register"),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 20),
              authState.maybeWhen(
                error: (error) => Text(
                  error ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.red),
                ),
                orElse: () => Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
