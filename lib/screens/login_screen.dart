import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tp_5_part2/store/user_state.dart';
import 'package:tp_5_part2/screens/home_screen.dart';

class LoginScreen extends HookConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
          const SizedBox(height: 10),
          TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password')),
          ElevatedButton(onPressed: () async {
            await ref.read(userStateProvider.notifier).login(emailController.text, passwordController.text);
            if (ref.read(userStateProvider).token != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ref.read(userStateProvider).error ?? ''), backgroundColor: Colors.red,));
            }
          }, child: Text('Login')),
          if (ref.watch(userStateProvider).isLoading)
            CircularProgressIndicator(),
          if (ref.watch(userStateProvider).error != null)
            Text(ref.watch(userStateProvider).error ?? ''),
        ],
      ),
    );
  }
}