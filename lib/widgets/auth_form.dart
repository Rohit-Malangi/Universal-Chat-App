import 'dart:io';

import 'package:flutter/material.dart';

import './image_picker.dart';

class AuthForm extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AuthForm(this.submitAuthForm, this._isLoading, {Key? key}) : super(key: key);

  final void Function({
    required BuildContext ctx,
    required String email,
    File? image,
    required bool islogin,
    required String password,
    required String username,
  }) submitAuthForm;
  final bool _isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userName = '';
  String _userEmail = '';
  String _passWord = '';
  File? _userImage;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _trySummit() {
    final isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //for close the keyword
    if (!_isLogin && _userImage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Pick a Image')));
    }
    if (isvalid) {
      _formKey.currentState!.save();
      if (_userImage != null) {
        widget.submitAuthForm(
          email: _userEmail.trim(),
          username: _userName.trim(),
          password: _passWord.trim(),
          islogin: _isLogin,
          ctx: context,
        );
      } else {
        widget.submitAuthForm(
          email: _userEmail.trim(),
          username: _userName.trim(),
          password: _passWord.trim(),
          islogin: _isLogin,
          image: _userImage,
          ctx: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) ImageInput(_pickedImage),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Email';
                    } else if (!value.endsWith('@gmail.com')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('userName'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter a Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Password';
                      }
                      if (value.length < 6) {
                        return 'Please Enter at least 6 digit password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _passWord = value!;
                    }),
                const SizedBox(height: 12),
                widget._isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _trySummit,
                        child: Text(_isLogin ? 'Login' : 'SignUp')),
                TextButton(
                    onPressed: widget._isLoading
                        ? null
                        : () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I have already an Account'))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
