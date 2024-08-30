import 'package:socialverse/core/utils/constants/constants.dart';
import 'package:socialverse/export.dart';

class InspiredDialog extends StatelessWidget {
  const InspiredDialog({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final exit = Provider.of<ExitProvider>(context);
    return AlertDialog(
      elevation: 0,
      insetPadding: EdgeInsets.all(15),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                height5,
                Text(
                  isFirstExit == false ? exit_message2 : exit_message1,
                  // 'This button means you were INSPIRED and you would like to EXIT THE APP, Are you sure you want to exit?',
                  style: AppTextStyle.normalRegular16.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).indicatorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              !isFirstExit!
                  ? shrink
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TransparentButton(
                        title: 'I FEEL INSPIRED',
                        onTap: () async {
                          HapticFeedback.heavyImpact();
                          if (Platform.isAndroid) {
                            await home.updateExitCount(id: id);
                            await exit.initPlayer();
                            await exit.controller?.play();
                            Navigator.of(context).pop();
                            // SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            await exit.initPlayer();
                            await exit.controller?.play();
                            Navigator.of(context).pop();
                            // exit(0);
                          }
                        },
                      ),
                    ),
              !isFirstExit! ? shrink : height10,
              // height20,
              // height20,
              isFirstExit!
                  ? shrink
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: CustomTextButton(
                        title: 'Okay',
                        onTap: () async {
                          await prefs?.setBool('exit', true);
                          isFirstExit = await prefs?.getBool('exit') ?? false;
                          Navigator.of(context).pop();
                        },
                        fontSize: 13,
                        buttonColor: Theme.of(context).indicatorColor,
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ),
              // height5,
              !isFirstExit!
                  ? shrink
                  : Tooltip(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(40),
                      showDuration: Duration(seconds: 5),
                      triggerMode: TooltipTriggerMode.tap,
                      preferBelow: true,
                      message: info_message,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: CustomTextButton(
                          title: 'ⓘ Learn More',
                          onTap: null,
                          fontSize: 13,
                          buttonColor: Theme.of(context).indicatorColor,
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
              height10,
            ],
          ),
        )
      ],
    );
  }
}
