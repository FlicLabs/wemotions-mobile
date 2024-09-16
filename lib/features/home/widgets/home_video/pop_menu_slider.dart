import 'dart:developer';

import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/slider_shape.dart';

// ignore: must_be_immutable
class PopupMenuSlider extends PopupMenuEntry<double> {
  double rate_value;
  final int id;

  PopupMenuSlider({required this.rate_value, required this.id});

  @override
  double get height => kMinInteractiveDimension;

  @override
  PopupMenuSliderState createState() => PopupMenuSliderState();

  @override
  bool represents(double? n) {
    return n == rate_value;
  }
}

class PopupMenuSliderState extends State<PopupMenuSlider> {
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Theme.of(context).hintColor,
          inactiveTrackColor: Theme.of(context).hintColor.withOpacity(0.3),
          trackShape: RainbowTrackShape(),
          thumbColor: Theme.of(context).hintColor,
          // thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        ),
        child: Transform.rotate(
          angle: -90 * 3.14159265359 / 180,
          child: Container(
            width: 150,
            height: 160,
            child: Slider(
              value: widget.rate_value.clamp(1, 100),
              onChanged: (double value) {
                HapticFeedback.mediumImpact();
                setState(() {
                  widget.rate_value = value;
                });
              },
              onChangeEnd: (double value) {
                home.slider_val = value;
                int roundedValue = value.round();
                log(roundedValue.toString());
                home.posts[home.index][0].ratingCount = value.toInt().round();
                home.updateRating(
                  id: widget.id,
                  rating: roundedValue.clamp(0, 100),
                );
              },
              min: 0,
              max: 100,
              divisions: 100,
              label: widget.rate_value.round().toString(),
            ),
          ),
        ),
      ),
    );
  }
}
