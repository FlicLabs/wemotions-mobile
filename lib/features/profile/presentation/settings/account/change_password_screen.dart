import 'package:flutter/cupertino.dart';
import 'package:socialverse/export.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/change-password';
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);


  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChangePasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (_, __, ___) {
        final user = Provider.of<ProfileProvider>(context);
        final auth = Provider.of<AuthProvider>(context);
        return WillPopScope(
          onWillPop: () async{
            __.clearPasswordController();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              title: Text(
                'Change Password',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileAlignedText(
                            title: 'Password',
                          ),
                          height5,
                          AuthTextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: '*********',
                            obscureText: auth.obscureText,
                            controller: __.password,

                            suffixIcon: GestureDetector(
                              onTap: () {
                                auth.obscureText = !auth.obscureText;
                              },
                              child: AuthObscureIcon(),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                __.passwordError =
                                'Please enter your password';
                                return '';
                              } else {
                                __.passwordError = null;
                                return null; // No error
                              }
                            },
                          ),
                          height15,
                          ProfileAlignedText(
                            title: 'Confirm Password',
                          ),
                          height5,
                          AuthTextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: '*********',
                            controller: __.password_confirm,
                            obscureText: true,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                __.passwordError =
                                'Please confirm your password';
                                return '';
                              } else {
                                __.passwordError = null;
                                return null; // No error
                              }
                            },
                          ),
                          height20,
                          // Text(
                          //   'Your username ${username} cannot be changed at the moment, this feature will be available soon.',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .displaySmall!
                          //       .copyWith(fontSize: 15),
                          // ),
                          // height20,
                          height20,

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                  child: Column(
                    children: [
                      if (__.loading) ...[
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CustomProgressIndicator(),
                          ),
                        ),
                      ],
                      if(!__.loading) ...[
                        AuthButtonWithColor(
                            title: 'Confirm',
                            onTap: () async {
                              if(__.password.text!='' && __.password_confirm!=''){
                                await __.resetPassword(context);
                                __.clearPasswordController();

                              }

                            },
                            isGradient: __.password.text.isNotEmpty && __.password_confirm.text.isNotEmpty)
                      ],
                      height15
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
