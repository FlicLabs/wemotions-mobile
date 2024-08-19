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
    final node = FocusScope.of(context);
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.darkThemeBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Form(
                              key: __.signUpFormKey,
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppAsset.icon,
                                    height: 180,
                                    width: cs().width(context) / 2,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            AuthAlignedText(
                                                title: 'First Name'),
                                            height5,
                                            TextFormField(
                                              controller: __.first_name,
                                              keyboardType: TextInputType.name,
                                              onFieldSubmitted: (_) =>
                                                  node.unfocus(),
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                hintText: 'First Name',
                                                fillColor: Colors.white,
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'sofia',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              // validator: (String? v) {
                                              //   if (v!.isValidName) {
                                              //     return null;
                                              //   } else {
                                              //     return 'Please enter your first name';
                                              //   }
                                              // },
                                            ),
                                          ],
                                        ),
                                      ),
                                      width20,
                                      Expanded(
                                        child: Column(
                                          children: [
                                            AuthAlignedText(title: 'Last Name'),
                                            height5,
                                            TextFormField(
                                              controller: __.last_name,
                                              keyboardType: TextInputType.name,
                                              onFieldSubmitted: (_) =>
                                                  node.unfocus(),
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                hintText: 'Last Name',
                                                fillColor: Colors.white,
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'sofia',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              // validator: (String? v) {
                                              //   if (v!.isValidName) {
                                              //     return null;
                                              //   } else {
                                              //     return 'Please enter your last name';
                                              //   }
                                              // },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  height15,
                                  AuthAlignedText(title: 'Username'),
                                  height5,
                                  TextFormField(
                                    controller: __.username,
                                    keyboardType: TextInputType.name,
                                    onFieldSubmitted: (_) => node.unfocus(),
                                    maxLength: 30,
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Username',
                                      counterStyle:
                                          TextStyle(color: Colors.white),
                                      fillColor: Colors.white,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: SvgPicture.asset(
                                          AppAsset.icuser,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'sofia',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    validator: (String? v) {
                                      // TODO: Reduce regex strictness for usernames
                                      if (v!.isValidUserName) {
                                        return null;
                                      } else if (v.isEmpty) {
                                        return 'Please enter your username';
                                      } else {
                                        return 'Invalid username: only letters, numbers, and underscores allowed';
                                      }
                                    },
                                  ),
                                  height15,
                                  AuthAlignedText(title: 'Email'),
                                  height5,
                                  TextFormField(
                                    controller: __.email,
                                    keyboardType: TextInputType.emailAddress,
                                    onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Email',
                                      fillColor: Colors.white,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: SvgPicture.asset(
                                          AppAsset.icemail,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'sofia',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    validator: (String? v) {
                                      if (v!.isValidEmail) {
                                        return null;
                                      } else {
                                        return 'Please enter your email';
                                      }
                                    },
                                  ),
                                  height15,
                                  AuthAlignedText(title: 'Password'),
                                  height5,
                                  TextFormField(
                                    controller: __.password,
                                    obscureText: __.obscureText,
                                    keyboardType: TextInputType.visiblePassword,
                                    onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Password',
                                      fillColor: Colors.white,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: SvgPicture.asset(
                                          AppAsset.icprivacy,
                                          color: Colors.black,
                                        ),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          __.obscureText = !__.obscureText;
                                        },
                                        child: AuthObscureIcon(),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'sofia',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    validator: (String? v) {
                                      if (v!.isValidPassword) {
                                        return null;
                                      } else {
                                        return 'Please enter your password';
                                      }
                                    },
                                  ),
                                  Terms(),
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
                                    CustomTextButton(
                                      buttonColor: __.checkValue
                                          ? Colors.white
                                          : Colors.grey,
                                      onTap: __.checkValue
                                          ? () async {
                                              log('tap');
                                              if (__.signUpFormKey.currentState!
                                                  .validate()) {
                                                await __.register(
                                                  firstName: __.first_name.text,
                                                  lastName: __.last_name.text,
                                                  username: __.username.text,
                                                  password:
                                                      'auth.password.text',
                                                  email: __.email.text,
                                                );
                                              }
                                            }
                                          : null,
                                      title: 'Sign Up',
                                    ),
                                  ],
                                  height20,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: Platform.isAndroid ? 5 : 0,
                    left: 15,
                    child: SafeArea(
                      child: CustomIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        borderRadius: 12,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
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
