import 'package:socialverse/export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ForgotPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (_, __, ____)
    {
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
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, size: 24,),
              ),
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: cs.height(context),
            width: cs.width(context),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Form(
                          key: __.emailFK,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Forgot Your Password?",
                                style: AppTextStyle.normalSemiBold28Black
                                    .copyWith(color: Theme
                                    .of(context)
                                    .focusColor),),
                              height8,
                              Text(
                                "No worries, enter your email, and we'll send you instructions to reset it",
                                style: AppTextStyle.subheadlineMedium.copyWith(
                                    color: Theme
                                        .of(context)
                                        .primaryColorDark),),
                              height24,
                              Text("Email",
                                style: AppTextStyle.labelMedium.copyWith(
                                    color: Theme
                                        .of(context)
                                        .indicatorColor),),
                              height8,
                              AuthTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Bryan_Reichert15@hotmail.com ',
                                controller: __.email,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    __.emailError =
                                    'Please enter your email or username';
                                    return ''; // Return empty to suppress default error message
                                  }
                                  __.emailError = null;
                                  return null; // No error
                                },
                              ),
                              // Display error message if exists
                              if (__.emailError != null) ...[
                                height8,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.error_outline_rounded,
                                      color: Colors.red.shade600, size: 20,),
                                    width5,
                                    Center(
                                      child: Text(
                                        __.emailError!,
                                        style: TextStyle(
                                            color: Colors.red.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 32,bottom: 32),
                  child: Column(
                    children: [
                      if (!__.isLoading) ...[
                        AuthButtonWithColor(
                          isGradient: __.email.text.isNotEmpty,
                          title: 'Continue',
                          onTap: () async {
                            if (__.emailFK.currentState!.validate()) {
                              await __.reset();
                            }
                          },
                        ),
                      ],
                      if (__.isLoading) ...[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: const CustomProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),)
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}
