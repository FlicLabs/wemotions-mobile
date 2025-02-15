import 'package:socialverse/core/utils/constants/constants.dart';
import 'package:socialverse/export.dart';

class InspiredDialog extends StatelessWidget {
  const InspiredDialog({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeProvider>();
    final exit = context.read<ExitProvider>();
    final bool isFirstExitValue = isFirstExit ?? false;

    return AlertDialog(
      elevation: 0,
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            height5,
            Text(
              isFirstExitValue ? exit_message1 : exit_message2,
              style: AppTextStyle.normalRegular16.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).indicatorColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              if (isFirstExitValue) _buildInspiredButton(context, home, exit),
              if (!isFirstExitValue) _buildOkayButton(context),
              if (isFirstExitValue) _buildLearnMoreButton(context),
              height10,
            ],
          ),
        ),
      ],
    );
  }

  /// Button for "I FEEL INSPIRED"
  Widget _buildInspiredButton(BuildContext context, HomeProvider home, ExitProvider exit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TransparentButton(
        title: 'I FEEL INSPIRED',
        onTap: () async {
          HapticFeedback.heavyImpact();
          if (Platform.isAndroid) {
            await home.updateExitCount(id: id);
            await exit.initPlayer();
            await exit.controller?.play();
          } else if (Platform.isIOS) {
            await exit.initPlayer();
            await exit.controller?.play();
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// Button for "Okay"
  Widget _buildOkayButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
    );
  }

  /// Tooltip for "Learn More"
  Widget _buildLearnMoreButton(BuildContext context) {
    return Tooltip(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(40),
      showDuration: const Duration(seconds: 5),
      triggerMode: TooltipTriggerMode.tap,
      preferBelow: true,
      message: info_message,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: CustomTextButton(
          title: 'ⓘ Learn More',
          onTap: null,
          fontSize: 13,
          buttonColor: Theme.of(context).indicatorColor,
          textColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}


