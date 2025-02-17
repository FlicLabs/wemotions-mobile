import 'package:socialverse/export.dart';

class ReplyPlaybackSheet extends StatelessWidget {
  const ReplyPlaybackSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<double> playbackSpeeds = [0.5, 1.0, 1.5, 2.0];

    return Consumer<ReplyProvider>(
      builder: (_, replyProvider, __) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: playbackSpeeds.length,
                itemBuilder: (context, index) {
                  final speed = playbackSpeeds[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      speed == 1.0 ? 'Normal' : '${speed}x',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15),
                    ),
                    trailing: Radio<double>(
                      value: speed,
                      activeColor: Theme.of(context).indicatorColor,
                      groupValue: replyProvider.playbackSpeed,
                      onChanged: (value) {
                        if (value != null) {
                          HapticFeedback.mediumImpact();
                          replyProvider.setPlaybackSpeed(value);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
