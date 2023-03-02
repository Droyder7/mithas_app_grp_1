// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mithas/components.dart';
import 'package:mithas/view_model.dart';

class LoginPageView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE8E6E5),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset("assets/mithas_logo.png", width: 450.0),
              ),
              //const SizedBox(height: 20.0),
              EmailAndPasswordFields(),
              SizedBox(height: 20.0),
              RegisterAndLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class EmailAndPasswordFields extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    return Column(
      children: [
        //Email Field
        SizedBox(
          width: 350.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: _emailField,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
                size: 30.0,
              ),
              hintText: "Email",
              hintStyle: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        //Password Field
        SizedBox(
          width: 350.0,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: _passwordField,
            obscureText: viewModelProvider.isObscure,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: IconButton(
                onPressed: () {
                  viewModelProvider.toogleObscure();
                },
                icon: Icon(
                  viewModelProvider.isObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
              hintText: "Password",
              hintStyle: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class RegisterAndLoginButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final viewModelProvider = ref.watch(viewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.0,
          width: 130.0,
          //Sign UP Button
          child: MaterialButton(
            child: OpenSans(text: "SIGN UP", size: 24.0),
            splashColor: Colors.grey,
            color: const Color(0xff7D4D40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              await viewModelProvider.createUserWithEmailAndPassword(
                  context, _emailField.text, _passwordField.text);
            },
          ),
        ),
        SizedBox(width: 15.0),
        Text(
          "OR",
          style: GoogleFonts.pacifico(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 15.0),
        SizedBox(
          height: 50.0,
          width: 130.0,
          //Login Button
          child: MaterialButton(
            child: OpenSans(text: "LOGIN", size: 24.0),
            splashColor: Colors.grey,
            color: const Color(0xff7D4D40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              await viewModelProvider.signInWithEmailAndPassword(
                  context, _emailField.text, _passwordField.text);
            },
          ),
        ),
      ],
    );
  }
}
