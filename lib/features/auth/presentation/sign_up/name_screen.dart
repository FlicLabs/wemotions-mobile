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
      builder: (context, authProvider, _) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: authProvider.nameFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        hintText: 'First Name',
                        controller: authProvider.first_name,
                        validator: (String? v) =>
                            (v == null || v.isEmpty) ? 'Please enter your first name' : null,
                      ),
                      height10,
                      AuthTextFormField(
                        keyboardType: TextInputType.name,
                        hintText: 'Surname',
                        controller: authProvider.last_name,
                        validator: (String? v) =>
                            (v == null || v.isEmpty) ? 'Please enter your surname' : null,
                      ),
                      height20,
                      AuthButton(
                        title: 'Continue',
                        onTap: () {
                          if (authProvider.nameFK.currentState!.validate()) {
                            Navigator.of(context).pushNamed(EmailScreen.routeName);
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

