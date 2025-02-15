import 'dart:developer';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/slider_shape.dart';

// ignore: must_be_immutable
class PopupMenuSlider extends PopupMenuEntry<double> {
  double rateValue;
  final int id;

  PopupMenuSlider({required this.rateValue, required this.id});

  @override
  double get height => kMinInteractiveDimension;

  @override
  PopupMenuSliderState createState() => PopupMenuSliderState();

  @override
  bool represents(double? n) {
    return n == rateValue;
  }
}

class PopupMenuSliderState extends State<PopupMenuSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.purpleAccent,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            trackShape: RainbowTrackShape(),
            thumbColor: Colors.purple,
            overlayColor: Colors.purple.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
          ),
          child: Transform.rotate(
            angle: -90 * 3.14159265359 / 180,
            child: SizedBox(
              width: 140,
              height: 160,
              child: Slider(
                value: widget.rateValue.clamp(1, 100),
                onChanged: (double value) {
                  HapticFeedback.selectionClick();
                  setState(() {
                    widget.rateValue = value;
                  });
                },
                onChangeEnd: (double value) {
                  home.slider_val = value;
                  int roundedValue = value.round();
                  log("Slider Value: $roundedValue");
                  home.updateRating(
                    id: widget.id,
                    rating: roundedValue.clamp(0, 100),
                  );
                },
                min: 0,
                max: 100,
                divisions: 50,
                label: "${widget.rateValue.round()}%",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

