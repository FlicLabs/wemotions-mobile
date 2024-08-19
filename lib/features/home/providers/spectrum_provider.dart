import 'package:socialverse/export.dart';

class SpectrumProvider with ChangeNotifier {
  final notification = getIt<NotificationProvider>();
  final _homeService = HomeService();
  double _startSwipePositionY = 0.0;
  double _endSwipePositionY = 0.0;
  double _ratingValue = 0.0;
  bool _isSwiping = false;
  final double _swipeThreshold = 10.0;

  double get ratingValue => _ratingValue;
  bool get isSwiping => _isSwiping;

  void startSwipe(double positionY) {
    _startSwipePositionY = positionY;
    _isSwiping = true;
    _endSwipePositionY = positionY;
  }

  void updateSwipe(double positionY, BuildContext context) {
    if (!_isSwiping) return;

    double tempRatingValue = (_startSwipePositionY - positionY) /
        (MediaQuery.of(context).size.height - 100) *
        100;
    tempRatingValue = tempRatingValue.clamp(0, 100);

    if ((_startSwipePositionY - positionY).abs() > _swipeThreshold) {
      _endSwipePositionY = positionY;
      _ratingValue = tempRatingValue;
      HapticFeedback.lightImpact();
      // print('Swiping up, rating: $_ratingValue');
      notifyListeners();
    }
  }

  void endSwipe(int id) {
    if (!_isSwiping) return;
    _isSwiping = false;

    if ((_startSwipePositionY - _endSwipePositionY).abs() > _swipeThreshold) {
      int roundedValue = _ratingValue.round();
      if (roundedValue != 0) {
        updateRating(id: id, rating: roundedValue);
      }
      // notification.show(
      //   type: NotificationType.local,
      //   title: 'Post rated $roundedValue!',
      // );
    } else {
      // print('Swipe too short, no rating update.');
    }

    _startSwipePositionY = 0.0;
    _endSwipePositionY = 0.0;
    _ratingValue = 0.0;
    notifyListeners();
  }

  Future<void> updateRating({required int id, required int rating}) async {
    Map data = {
      "post_id": id,
      "rating": rating,
    };
    print('Updating rating: $data');
    await _homeService.rating(data: data);
    notifyListeners();
  }
}
