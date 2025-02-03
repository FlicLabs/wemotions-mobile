import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/circular_dot.dart';

class SmoothPageIndicatorView extends StatelessWidget {
  // final int maxHorizontal;
  // final int maxVertical;
  // final VoidCallback onHorizontalIndexChange;
  // final VoidCallback onVerticalIndexChange;
  //
  // DotScrollingView({required this.maxHorizontal, required this.maxVertical, required this.onHorizontalIndexChange,required this.onVerticalIndexChange});
  @override
  Widget build(BuildContext context) {
    double horizontalPadding=8;
    double verticalPadding=8;
    return Consumer<SmoothPageIndicatorProvider>(
      builder: (_, __, ___) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  __.hidePlaceHorizontal==0?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: false,)
                      :
                  CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Colors.grey,onFocus: false,),

                  __.hidePlaceHorizontal==1?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: true, )
                      :
                  CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Constants.primaryColor,onFocus: true,),

                  __.hidePlaceHorizontal==2?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: false, )
                      :
                  CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Colors.grey,onFocus: false,),

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // height,
                  __.hidePlaceVertical==0? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: false,)
                      :
                  CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.grey,onFocus: false,),


                  __.hidePlaceVertical==1? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: true,)
                      :
                  CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Constants.primaryColor,onFocus: false,),


                  __.hidePlaceVertical==2? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: false,)
                      :
                  CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.grey,onFocus: false,)

                ],
              ),
              height2
            ],
          ),
        );
      },
    );
  }
}
