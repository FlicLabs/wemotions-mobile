import 'package:socialverse/export.dart';

class SmoothPageIndicatorProvider with ChangeNotifier {
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