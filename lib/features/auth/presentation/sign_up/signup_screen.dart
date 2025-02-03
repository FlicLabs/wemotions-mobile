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
    final notification = getIt<NotificationProvider>();
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(right: 20,left: 5),
              child: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    __.emailError = null;
                    __.passwordError = null;
                    __.firstnameError = null;
                    __.lastnameError = null;
                    __.usernameError = null;
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,size: 24,),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          __.emailError = null;
                          __.passwordError = null;
                          __.firstnameError = null;
                          __.lastnameError = null;
                          __.usernameError = null;
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text(
                          'Login',
                          style: AppTextStyle.normalRegular14.copyWith(color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              height: cs.height(context),
              width: cs.width(context),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              child: Form(
                                key: __.signUpFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: AppTextStyle.normalSemiBold28Black.copyWith(color: Theme.of(context).focusColor),
                                    ),
                                    height8,
                                    Container(
                                      child: Text(
                                        'Signup to join the conversation and connect with your community',
                                        style: AppTextStyle.subheadlineMedium.copyWith(color: Theme.of(context).primaryColorDark),),
                                    ),
                                    height24,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // AuthAlignedText(
                                              //     title: 'First Name'),
                                              Container(
                                                child: Text(
                                                  'First name',
                                                  style: AppTextStyle
                                                      .normalRegular16
                                                      .copyWith(
                                                          color: Theme.of(context)
                                                              .focusColor),
                                                ),
                                              ),
                                              height8,
                                              AuthTextFormField(
                                                keyboardType: TextInputType.name,
                                                hintText: 'Bryan',
                                                controller: __.first_name,
                                                onChanged: (val){
                                                  __.firstnameError=null;
                                                },
                                                validator: (String? value) {
                                                  if (value == null || value.isEmpty) {
                                                    __.firstnameError = 'First name is required';
                                                    return ''; // Return empty to suppress default error message
                                                  }
                                                  __.firstnameError = null;
                                                  return null; // No error
                                                },
                                              ),
                                              if (__.firstnameError != null) ...[
                                                height8,
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start ,
                                                  children: [
                                                    Icon(Icons.error_outline_rounded, color: Colors.red.shade600,size: 17,),
                                                    width5,
                                                    SizedBox(
                                                      width: cs.width(context)/3,
                                                      child: Text(
                                                        __.firstnameError!,
                                                        style: TextStyle(color: Colors.red.shade600,fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              if(__.lastnameError!=null) ...[
                                                if(__.firstnameError==null)
                                                  height26
                                              ]
                                            ],
                                          ),
                                        ),
                                        width20,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // AuthAlignedText(title: 'Last Name'),
                                              Container(
                                                child: Text(
                                                  'Last name',
                                                  style: AppTextStyle
                                                      .normalRegular16
                                                      .copyWith(
                                                          color: Theme.of(context)
                                                              .focusColor),
                                                ),
                                              ),
                                              height8,
                                              AuthTextFormField(
                                                keyboardType: TextInputType.name,
                                                hintText: 'Reichert',
                                                controller: __.last_name,
                                                onChanged: (val){
                                                  __.lastnameError=null;
                                                },
                                                validator: (String? value) {
                                                  if (value == null || value.isEmpty) {
                                                    __.lastnameError = 'Last name is required';
                                                    return ''; // Return empty to suppress default error message
                                                  }
                                                  __.lastnameError = null;
                                                  return null; // No error
                                                },
                                              ),
                                              if (__.lastnameError != null) ...[
                                                height8,
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start  ,
                                                  children: [
                                                    Icon(Icons.error_outline_rounded, color: Colors.red.shade600,size: 17,),
                                                    width5,
                                                    SizedBox(
                                                      width: cs.width(context)/3,
                                                      child: Text(
                                                        __.lastnameError!,
                                                        style: TextStyle(color: Colors.red.shade600,fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              if(__.firstnameError!=null ) ...[
                                                if(__.lastnameError==null)
                                                  height26
                                              ]

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    height20,
                                    Container(
                                      child: Text(
                                        'Username',
                                        style:
                                            AppTextStyle.normalRegular16.copyWith(
                                          color: Theme.of(context).focusColor,
                                        ),
                                      ),
                                    ),
                                    height10,
                                    AuthTextFormField(
                                      keyboardType: TextInputType.name,
                                      hintText: 'Bryan_Reichert38',
                                      controller: __.username,
                                      onChanged: (val){
                                        __.usernameError=null;
                                      },
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          __.usernameError = 'Username is required';
                                          return ''; // Return empty to suppress default error message
                                        }
                                        __.usernameError = null;
                                        return null; // No error
                                      },
                                    ),
                                    if (__.usernameError != null) ...[
                                      height8,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start  ,
                                        children: [
                                          Icon(Icons.error_outline_rounded, color: Colors.red.shade600,size: 17,),
                                          width5,
                                          SizedBox(
                                            width: cs.width(context)/1.3,
                                            child: Text(
                                              __.usernameError!,
                                              softWrap: true,
                                              style: TextStyle(color: Colors.red.shade600,fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    height20,
                                    Container(
                                      child: Text(
                                        'Email',
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(
                                                color:
                                                    Theme.of(context).focusColor),
                                      ),
                                    ),
                                    height10,
                                    AuthTextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: 'Bryan_Reichert15@hotmail.com',
                                      controller: __.email,
                                      onChanged: (val){
                                        __.emailError=null;
                                      },
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          __.emailError = 'Email is required';
                                          return ''; // Return empty to suppress default error message
                                        }
                                        __.emailError = null;
                                        return null; // No error
                                      },
                                    ),
                                    if (__.emailError != null) ...[
                                      height8,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start  ,
                                        children: [
                                          Icon(Icons.error_outline_rounded, color: Colors.red.shade600,size: 17,),
                                          width5,
                                          SizedBox(
        width: cs.width(context)/1.3,
                                            child: Text(
                                              __.emailError!,
                                              style: TextStyle(color: Colors.red.shade600,fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    height20,
                                    Container(
                                      child: Text(
                                        'Password',
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(
                                                color:
                                                    Theme.of(context).focusColor),
                                      ),
                                    ),
                                    height10,
                                    AuthTextFormField(
                                      maxLines: 1,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        hintText: '********',
                                        obscureText: __.obscureText,
                                        controller: __.password,
                                        onChanged: (val){
                                          __.passwordError=null;
                                        },
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            __.obscureText = !__.obscureText;
                                          },
                                          child: AuthObscureIcon(),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            __.passwordError = 'Password is required';
                                            return ''; // Return empty to suppress default error message
                                          }else{
                                            if (!value.isValidPassword) {
                                              __.passwordError = 'Please enter a valid password';
                                              return '';
                                            }
                                            __.passwordError = null;
                                            return null; // No error
                                          }
                                        }),
                                    if (__.passwordError != null) ...[
                                      height8,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start  ,
                                        children: [
                                          Icon(Icons.error_outline_rounded, color: Colors.red.shade600,size: 17,),
                                          width5,
                                          SizedBox(
        width: cs.width(context)/1.3,
                                            child: Text(
                                              __.passwordError!,
                                              style: TextStyle(color: Colors.red.shade600,fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    // Terms(),

                                    // height20,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(left: 24,right: 24,top: 32,bottom: 32),
                        child: Column(
                          children: [
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
                              AuthButtonWithColor(
                                isGradient: __.first_name.text.isNotEmpty && __.last_name.text.isNotEmpty && __.username.text.isNotEmpty && __.email.text.isNotEmpty && __.password.text.isNotEmpty,
                                onTap:() async {
                                  FocusScope.of(context).unfocus();
                                  log('tap');
                                  if (__.signUpFormKey.currentState!
                                      .validate()) {

                                    await __.register(
                                      firstName:
                                      __.first_name.text.trim(),
                                      lastName:
                                      __.last_name.text.trim(),
                                      username:
                                      __.username.text.trim(),
                                      password:
                                      __.password.text.trim(),
                                      email: __.email.text.trim(),
                                    );
                                  }
                                },
                                title: 'Continue',
                              ),
                            ],
                          ],
                        ),)

                      ],
                    ),
                    // Positioned(
                    //   top: Platform.isAndroid ? 5 : 0,
                    //   left: 15,
                    //   child: SafeArea(
                    //     child: CustomIconButton(
                    //       icon: Icons.arrow_back_ios_new_rounded,
                    //       borderRadius: 12,
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
