import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mithas/home_page_view.dart';
import 'package:mithas/login_page_view.dart';
import 'package:mithas/view_model.dart';

class LoginHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    // TODO: implement build
    return _authState.when(
      data: (data) {
        if (data != null) {
          return HomePageView();
        } else {
          return LoginPageView();
        }
      },
      error: (error, stackTrace) {
        return LoginPageView();
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
