import 'package:socialverse/export.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 5,
            right: 10,
            bottom: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
                width: 15,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor:
                      MaterialStateProperty.all(Theme.of(context).hintColor),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ), // Rounded Checkbox
                  value: __.checkValue,
                  onChanged: (inputValue) {
                    __.checkValue = inputValue!;
                  },
                ),
              ),
              width15,
              Text("I agree to the",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontSize: 14,
                  )),
              GestureDetector(
                onTap: () {
                  // TOD: Go to webpage
                },
                child: Text(
                  " terms and conditions",
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
