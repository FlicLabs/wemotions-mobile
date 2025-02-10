import 'package:socialverse/export.dart';

class SmoothPageIndicatorProvider with ChangeNotifier {

  int _totalHorizontalPages=-1;
  int _totalVerticalPages=-1;
  int _currentHorizontalIndex=-1;
  int _currentVerticalIndex=-1;

  int get totalHorizontalPages=>_totalHorizontalPages;
  int get totalVerticalPages=>_totalVerticalPages;
  int get currentHorizontalIndex=>_currentHorizontalIndex;
  int get currentVerticalIndex=>_currentVerticalIndex;


  set totalHorizontalPages(int val){
    _totalHorizontalPages=val;
    notifyListeners();
  }


  set totalVerticalPages(int val){
    _totalVerticalPages=val;
    notifyListeners();
  }


  set currentHorizontalIndex(int val){
    _currentHorizontalIndex=val;
    notifyListeners();
  }


  set currentVerticalIndex(int val){
    _currentVerticalIndex=val;
    notifyListeners();
  }


  int _horizontalVisibleDots = 3;
  get horizontalVisibleDots=>_horizontalVisibleDots;

  int _verticalVisibleDots = 3;
  get verticalVisibleDots=>_verticalVisibleDots;






































  int _horizontalIndex = 0;
  int _verticalIndex = 0;
  int _maxHorizontal = 0;
  int _maxVertical = 1;
  int _hidePlaceHorizontal=0;
  int _hidePlaceVertical=0;

  int get horizontalIndex => _horizontalIndex;
  int get verticalIndex => _verticalIndex;
  int get maxHorizontal=> _maxHorizontal;
  int get maxVertical=> _maxVertical;
  int get hidePlaceHorizontal=>_hidePlaceHorizontal;
  int get hidePlaceVertical=>_hidePlaceVertical;

  void setMaxHorizontal(int max) {
    _maxHorizontal = max;
    // notifyListeners();
  }

  void setMaxVertical(int max) {
    _maxVertical = max;
    // notifyListeners();
  }

  void scrollHorizontal(int index) {
    if(index==0){
      //dot index
      _hidePlaceHorizontal=0;
      _horizontalIndex = index;
    }
    else if (index>0 && index<_maxHorizontal-1) {
      _hidePlaceHorizontal=-1;
      _horizontalIndex = index;
    }

    else if(index==_maxHorizontal-1){
      _hidePlaceHorizontal=2;
      _horizontalIndex = index;
    }
    print("${index}+++++++++++++++++++++++++++++++++++++${_maxHorizontal}++");
    notifyListeners();
  }

  void scrollVertical(int index) {
    if(index==0){
      //dot index
      _hidePlaceVertical=0;
    }
    else if (index>0 && index<_maxVertical-1) {
      _hidePlaceVertical=-1;
      _verticalIndex = index;

    }
    else if(index==_maxVertical-1){
      _hidePlaceVertical=2;
    }
    _hidePlaceHorizontal=0;
    _horizontalIndex=0;
    notifyListeners();
  }




}