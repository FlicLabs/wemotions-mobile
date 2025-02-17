import 'package:socialverse/export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ForgotPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    authProvider.emailError = null;
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, size: 24),
                ),
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async => true, // Allows back navigation
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: authProvider.emailFK,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Your Password?",
                              style: AppTextStyle.normalSemiBold28Black.copyWith(
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            height8,
                            Text(
                              "No worries, enter your email, and we'll send you instructions to reset it",
                              style: AppTextStyle.subheadlineMedium.copyWith(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            height24,
                            Text(
                              "Email",
                              style: AppTextStyle.labelMedium.copyWith(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                            height8,
                            AuthTextFormField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter your email',
                              controller: authProvider.email,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  authProvider.emailError =
                                      'Please enter your email or username';
                                  return ''; // Suppress default error
                                }
                                authProvider.emailError = null;
                                return null; // Valid input
                              },
                              onChanged: (val) {
                                authProvider.notifyListeners(); // Update UI
                              },
                            ),
                            if (authProvider.emailError != null) ...[
                              height8,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline_rounded,
                                      color: Colors.red.shade600, size: 20),
                                  width5,
                                  Text(
                                    authProvider.emailError!,
                                    style: TextStyle(color: Colors.red.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: Column(
                      children: [
                        if (!authProvider.isLoading) ...[
                          AuthButtonWithColor(
                            isGradient: authProvider.email.text.isNotEmpty,
                            title: 'Continue',
                            onTap: () async {
                              if (authProvider.emailFK.currentState!.validate()) {
                                await authProvider.reset();
                              }
                            },
                          ),
                        ],
                        if (authProvider.isLoading) ...[
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: CustomProgressIndicator(color: Colors.white),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
