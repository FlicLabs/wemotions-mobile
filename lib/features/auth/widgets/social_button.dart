import 'package:socialverse/export.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final IconData icon;
  final String title;
  const SocialButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).indicatorColor,
        ),
        height: 50,
        width: width ?? cs.width(context),
        alignment: Alignment.center,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              width5,
              Text(
                title,
                style: AppTextStyle.normalRegular16,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
    // TextButton(
    //   style: TextButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     backgroundColor: buttonColor ?? Theme.of(context).hintColor,
    //     fixedSize: Size(width ?? cs().width(context), 50),
    //     alignment: Alignment.center,
    //   ),
    //   child: Icon(
    //     icon,
    //     color: Colors.white,
    //   ),
    //   onPressed: onTap,
    // );
  }
}
