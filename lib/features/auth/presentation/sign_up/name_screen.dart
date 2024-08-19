import 'package:socialverse/export.dart';

class NameScreen extends StatelessWidget {
  static const String routeName = '/add-name';
  const NameScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => NameScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add your name',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: __.nameFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        hintText: 'First Name',
                        controller: __.first_name,
                        validator: (String? v) {
                          if (v!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter your first name';
                          }
                        },
                      ),
                      height10,
                      AuthTextFormField(
                        keyboardType: TextInputType.name,
                        hintText: 'Surname',
                        controller: __.last_name,
                        validator: (String? v) {
                          if (v!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter your surname';
                          }
                        },
                      ),
                      height20,
                      AuthButton(
                        title: 'Continue',
                        onTap: () {
                          if (__.nameFK.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                              EmailScreen.routeName,
                            );
                          }
                        },
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
