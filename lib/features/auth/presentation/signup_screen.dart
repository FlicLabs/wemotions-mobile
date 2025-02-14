import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/export.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Consumer<AuthProvider>(
      builder: (_, authProvider, ___) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: authProvider.signUpFormKey,
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppAsset.icon,
                                    height: 180,
                                    width: MediaQuery.of(context).size.width / 2,
                                  ),
                                  height10,
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: 'sofia',
                                    ),
                                  ),
                                  height10,
                                  Text(
                                    'Please fill the form to create an account',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                      fontFamily: 'sofia',
                                    ),
                                  ),
                                  height15,
                                  _buildNameFields(authProvider, node),
                                  height15,
                                  _buildUsernameField(authProvider, node),
                                  height15,
                                  _buildEmailField(authProvider, node),
                                  height15,
                                  _buildPasswordField(authProvider, node),
                                  Terms(),
                                  height15,
                                  authProvider.registeredAuthStatus == AuthStatus.Registering
                                      ? CustomProgressIndicator(color: Colors.white)
                                      : _buildSignUpButton(authProvider),
                                  height20,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildBackButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNameFields(AuthProvider authProvider, FocusScopeNode node) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              AuthAlignedText(title: 'First Name'),
              height5,
              _buildTextField(authProvider.first_name, 'First Name', node),
            ],
          ),
        ),
        width20,
        Expanded(
          child: Column(
            children: [
              AuthAlignedText(title: 'Last Name'),
              height5,
              _buildTextField(authProvider.last_name, 'Last Name', node),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField(AuthProvider authProvider, FocusScopeNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthAlignedText(title: 'Username'),
        height5,
        TextFormField(
          controller: authProvider.username,
          keyboardType: TextInputType.name,
          onFieldSubmitted: (_) => node.unfocus(),
          maxLength: 30,
          decoration: textFormFieldDecoration.copyWith(
            hintText: 'Username',
            counterStyle: TextStyle(color: Colors.white),
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(AppAsset.icuser, color: Colors.black),
            ),
          ),
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),
          validator: (v) => v!.isValidUserName ? null : 'Invalid username',
        ),
      ],
    );
  }

  Widget _buildEmailField(AuthProvider authProvider, FocusScopeNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthAlignedText(title: 'Email'),
        height5,
        _buildTextField(authProvider.email, 'Email', node, AppAsset.icemail),
      ],
    );
  }

  Widget _buildPasswordField(AuthProvider authProvider, FocusScopeNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthAlignedText(title: 'Password'),
        height5,
        TextFormField(
          controller: authProvider.password,
          obscureText: authProvider.obscureText,
          keyboardType: TextInputType.visiblePassword,
          onFieldSubmitted: (_) => node.unfocus(),
          decoration: textFormFieldDecoration.copyWith(
            hintText: 'Password',
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(AppAsset.icprivacy, color: Colors.black),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                authProvider.togglePasswordVisibility();
              },
              child: AuthObscureIcon(),
            ),
          ),
          validator: (v) => v!.isValidPassword ? null : 'Invalid password',
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, FocusScopeNode node, [String? icon]) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (_) => node.unfocus(),
      decoration: textFormFieldDecoration.copyWith(
        hintText: hint,
        fillColor: Colors.white,
        prefixIcon: icon != null ? Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(icon),
        ) : null,
      ),
    );
  }

  Widget _buildSignUpButton(AuthProvider authProvider) {
    return CustomTextButton(
      buttonColor: authProvider.checkValue ? Colors.white : Colors.grey,
      onTap: authProvider.checkValue ? () async {
        if (authProvider.signUpFormKey.currentState!.validate()) {
          await authProvider.register();
        }
      } : null,
      title: 'Sign Up',
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 5,
      left: 15,
      child: SafeArea(
        child: CustomIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          borderRadius: 12,
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
