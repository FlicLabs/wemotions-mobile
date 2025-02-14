import 'package:socialverse/export.dart';

class EmailScreen extends StatelessWidget {
  static const String routeName = '/add-email';
  const EmailScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EmailScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notification = getIt<NotificationProvider>();

    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add your email',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: authProvider.emailFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        controller: authProvider.email,
                        validator: (String? v) {
                          if (v == null || v.isEmpty) {
                            return 'Email is required';
                          } else if (!v.isValidEmail) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      height10,
                      Terms(),
                      height10,
                      authProvider.registeredAuthStatus == AuthStatus.Registering
                          ? const SizedBox(
                              height: 45,
                              width: 45,
                              child: CustomProgressIndicator(color: Colors.white),
                            )
                          : AuthButton(
                              onTap: authProvider.checkValue &&
                                      authProvider.registeredAuthStatus != AuthStatus.Registering
                                  ? () async {
                                      if (authProvider.emailFK.currentState!.validate()) {
                                        await authProvider.register(
                                          firstName: authProvider.first_name.text.trim(),
                                          lastName: authProvider.last_name.text.trim(),
                                          username: authProvider.username.text.trim(),
                                          password: authProvider.password.text.trim(),
                                          email: authProvider.email.text.trim(),
                                        );
                                      }
                                    }
                                  : () => notification.show(
                                        title: 'Please agree to the terms',
                                        type: NotificationType.local,
                                      ),
                              title: 'Sign Up',
                              isDisabled: authProvider.registeredAuthStatus == AuthStatus.Registering,
                            ),
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
}
