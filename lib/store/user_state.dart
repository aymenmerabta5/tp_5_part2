import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String id;
  final String email;
  final bool isLoading;
  final String? token;
  final String? error;

  User({required this.id, required this.email, required this.isLoading, required this.token, required this.error});
}

class UserStateNotifier extends Notifier<User> {
  @override
  User build() {
    return User(id: '', email: '', isLoading: false, token: null, error: null);
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final user = json.decode(response.body);
      state = User(id: user['id'], email: user['email'], isLoading: false, token: user['token'], error: null);
    } else {
      state = User(id: '', email: '', isLoading: false, token: null, error: 'Invalid email or password');

    }
  }
}

final userStateProvider = NotifierProvider<UserStateNotifier, User>(UserStateNotifier.new);