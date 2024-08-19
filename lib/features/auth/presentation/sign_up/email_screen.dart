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
      builder: (_, __, ___) {
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
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: __.emailFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        controller: __.email,
                        validator: (String? v) {
                          if (v!.isValidEmail) {
                            return null;
                          } else {
                            return 'Please enter a valid email';
                          }
                        },
                      ),
                      height10,
                      Terms(),
                      height10,
                      if (__.registeredAuthStatus ==
                          AuthStatus.Registering) ...[
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: CustomProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      ],
                      if (__.registeredAuthStatus !=
                          AuthStatus.Registering) ...[
                        AuthButton(
                          onTap: __.checkValue
                              ? () async {
                                  if (__.emailFK.currentState!.validate()) {
                                    await __.register(
                                      firstName: __.first_name.text.trim(),
                                      lastName: __.last_name.text.trim(),
                                      username: __.username.text.trim(),
                                      password: __.password.text.trim(),
                                      email: __.email.text.trim(),
                                    );
                                  }
                                }
                              : () => notification.show(
                                    title: 'Please agree to the terms',
                                    type: NotificationType.local,
                                  ),
                          title: 'Sign Up',
                        ),
                      ],
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
