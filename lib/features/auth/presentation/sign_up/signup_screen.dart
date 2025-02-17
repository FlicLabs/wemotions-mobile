import 'dart:developer';
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
    final notification = getIt<NotificationProvider>();
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 24),
              onPressed: () {
                authProvider.clearErrors();
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  authProvider.clearErrors();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: Text(
                  'Login',
                  style: AppTextStyle.normalRegular14.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: authProvider.signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      _buildNameFields(authProvider),
                      height20,
                      _buildTextField(
                        context,
                        label: 'Username',
                        controller: authProvider.username,
                        hintText: 'Bryan_Reichert38',
                        errorText: authProvider.usernameError,
                        onValidate: (value) {
                          return _validateRequiredField(value, 'Username is required', authProvider.setUsernameError);
                        },
                      ),
                      height20,
                      _buildTextField(
                        context,
                        label: 'Email',
                        controller: authProvider.email,
                        hintText: 'bryanreichert@example.com',
                        errorText: authProvider.emailError,
                        onValidate: (value) {
                          return _validateRequiredField(value, 'Email is required', authProvider.setEmailError);
                        },
                      ),
                      height20,
                      _buildPasswordField(authProvider),
                      height20,
                      _buildSignUpButton(authProvider, context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: AppTextStyle.normalSemiBold28Black.copyWith(
            color: Theme.of(context).focusColor,
          ),
        ),
        height8,
        Text(
          'Sign up to join the conversation and connect with your community',
          style: AppTextStyle.subheadlineMedium.copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        height24,
      ],
    );
  }

  Widget _buildNameFields(AuthProvider authProvider) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            context,
            label: 'First Name',
            controller: authProvider.first_name,
            hintText: 'Bryan',
            errorText: authProvider.firstnameError,
            onValidate: (value) {
              return _validateRequiredField(value, 'First name is required', authProvider.setFirstnameError);
            },
          ),
        ),
        width20,
        Expanded(
          child: _buildTextField(
            context,
            label: 'Last Name',
            controller: authProvider.last_name,
            hintText: 'Reichert',
            errorText: authProvider.lastnameError,
            onValidate: (value) {
              return _validateRequiredField(value, 'Last name is required', authProvider.setLastnameError);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    required String? Function(String?) onValidate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.normalRegular16.copyWith(color: Theme.of(context).focusColor)),
        height8,
        AuthTextFormField(
          keyboardType: TextInputType.name,
          hintText: hintText,
          controller: controller,
          validator: onValidate,
        ),
        if (errorText != null) _buildErrorText(errorText),
      ],
    );
  }

  Widget _buildPasswordField(AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: AppTextStyle.normalRegular16.copyWith(color: Theme.of(context).focusColor),
        ),
        height10,
        AuthTextFormField(
          keyboardType: TextInputType.visiblePassword,
          hintText: '********',
          obscureText: authProvider.obscureText,
          controller: authProvider.password,
          suffixIcon: GestureDetector(
            onTap: authProvider.togglePasswordVisibility,
            child: AuthObscureIcon(),
          ),
          validator: (value) {
            return _validateRequiredField(value, 'Password is required', authProvider.setPasswordError);
          },
        ),
        if (authProvider.passwordError != null) _buildErrorText(authProvider.passwordError!),
      ],
    );
  }

  Widget _buildErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: Colors.red.shade600, size: 17),
          width5,
          Expanded(
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red.shade600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(AuthProvider authProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: authProvider.registeredAuthStatus == AuthStatus.Registering
          ? const Center(child: CircularProgressIndicator())
          : AuthButtonWithColor(
              isGradient: authProvider.isFormValid(),
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (authProvider.signUpFormKey.currentState!.validate()) {
                  await authProvider.register();
                }
              },
              title: 'Continue',
            ),
    );
  }

  String? _validateRequiredField(String? value, String errorMsg, Function(String?) setError) {
    if (value == null || value.trim().isEmpty) {
      setError(errorMsg);
      return ''; // Suppresses the default error message
    }
    setError(null);
    return null; // No error
  }
}

