import 'package:socialverse/export.dart';

class PlaybackSheet extends StatelessWidget {
  const PlaybackSheet({Key? key}) : super(key: key);

  static const List<double> _items = [0.5, 1.0, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, homeProvider, __) {
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
              ..._items.map(
                (speed) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
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
                    groupValue: homeProvider.playback_speed,
                    onChanged: (value) {
                      if (value != null) {
                        HapticFeedback.mediumImpact();
                        homeProvider.setPlaybackSpeed(value);
                        navKey.currentState?.pop();
                      }
                    },
                  ),
                ),
              ),
              height20,
            ],
          ),
        );
      },
    );
  }
}

