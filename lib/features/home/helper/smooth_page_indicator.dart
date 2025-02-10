import 'package:flutter/cupertino.dart';
import 'package:socialverse/export.dart';
import 'dart:math';
import 'package:socialverse/features/home/utils/circular_dot.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SmoothPageIndicatorView extends StatelessWidget {
  // final int? totalHorizontalPages;
  // final int? totalVerticalPages;
  // final int? currentHorizontalIndex;
  // final int? currentVerticalIndex;

  const SmoothPageIndicatorView({
    Key? key,
    // this.totalHorizontalPages,
    // this.totalVerticalPages,
    // this.currentHorizontalIndex,
    // this.currentVerticalIndex,
  }) : super(key: key);



  List<Widget> _buildDots({
    required int totalCount,
    required int currentIndex,
    required bool isHorizontal,
    required int visibleDots,
  }) {

    List<Widget> dots=[];

    if(totalCount==0){
      dots.clear();
      return dots;
    }

    int start = currentIndex - 1;
    int end = currentIndex + 1;


    if (start < 0) {
      start = 0;
      end = math.min(visibleDots - 1, totalCount - 1);
    } else if (end >= totalCount) {
      end = totalCount - 1;
      start = math.max(end - (visibleDots - 1), 0);
    }

    // Add leading more indicator if needed
    if (start > 0) {
      dots.add(
        Indicator(
          isActive: false,
          isHorizontal: isHorizontal,
          isMoreIndicator: true,
        ),
      );
    }

    // Add main dots
    for (int i = start; i <= end; i++) {
      dots.add(
        Indicator(
          isActive: i == currentIndex,
          isHorizontal: isHorizontal,
        ),
      );
    }

    if (end < totalCount - 1) {
      dots.add(
        Indicator(
          isActive: false,
          isHorizontal: isHorizontal,
          isMoreIndicator: true,
        ),
      );
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      // color: Colors.red,
      width: 60,
      height: 82,
      child: Consumer<SmoothPageIndicatorProvider>(
        builder: (_, __, ___) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Vertical indicators
              if (__.totalVerticalPages != -1 && __.currentVerticalIndex != -1)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildDots(
                      totalCount: __.totalVerticalPages,
                      currentIndex: __.currentVerticalIndex,
                      isHorizontal: false,
                      visibleDots: __.verticalVisibleDots,
                  ),
                ),
              //horizontal indicator
              if (__.totalHorizontalPages != -1 &&
                  __.currentHorizontalIndex != -1 &&
                  __.currentVerticalIndex != -1)
                if(__.totalHorizontalPages!=0) ...[
                  Positioned(
                    top: (0),
                    left: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _buildDots(
                        totalCount: __.totalHorizontalPages,
                        currentIndex: __.currentHorizontalIndex,
                        isHorizontal: true,
                        visibleDots: __.horizontalVisibleDots,
                      ),
                    ),
                  ),
                ]

            ],
          );
        },
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  final bool isHorizontal;
  final bool isMoreIndicator;

  const Indicator({
    Key? key,
    required this.isActive,
    required this.isHorizontal,
    this.isMoreIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: isHorizontal ? 4 : 0,
        vertical: isHorizontal ? 0 : 4,
      ),
      width: isHorizontal
          ? (isMoreIndicator ? 6 : (isActive ? 12 : 8))
          : (isMoreIndicator ? 6 : 8),
      height: isHorizontal
          ? (isMoreIndicator ? 6 : 8)
          : (isMoreIndicator ? 6 : (isActive ? 12 : 8)),
      decoration: BoxDecoration(
        color: isActive
            ? Constants.primaryColor
            : (isMoreIndicator
            ? Constants.lightPrimary.withOpacity(0.3)
            : Constants.lightPrimary.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(isMoreIndicator ? 3 : 4),
      ),
    );
  }
}


//
//
// class SmoothPageIndicatorView extends StatelessWidget {
//   // final int maxHorizontal;
//   // final int maxVertical;
//   // final VoidCallback onHorizontalIndexChange;
//   // final VoidCallback onVerticalIndexChange;
//   //
//   // DotScrollingView({required this.maxHorizontal, required this.maxVertical, required this.onHorizontalIndexChange,required this.onVerticalIndexChange});
//   @override
//   Widget build(BuildContext context) {
//     double horizontalPadding=8;
//     double verticalPadding=8;
//     return Consumer<SmoothPageIndicatorProvider>(
//       builder: (_, __, ___) {
//         return SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   __.hidePlaceHorizontal==0?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: false,)
//                       :
//                   CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Colors.grey,onFocus: false,),
//
//                   __.hidePlaceHorizontal==1?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: true, )
//                       :
//                   CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Constants.primaryColor,onFocus: true,),
//
//                   __.hidePlaceHorizontal==2?CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr:Colors.transparent,onFocus: false, )
//                       :
//                   CircularDot(horizontalPadding: horizontalPadding, verticalPadding: 0, clr: Colors.grey,onFocus: false,),
//
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // height,
//                   __.hidePlaceVertical==0? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: false,)
//                       :
//                   CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.grey,onFocus: false,),
//
//
//                   __.hidePlaceVertical==1? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: true,)
//                       :
//                   CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Constants.primaryColor,onFocus: false,),
//
//
//                   __.hidePlaceVertical==2? CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.transparent,onFocus: false,)
//                       :
//                   CircularDot(horizontalPadding: 0, verticalPadding: verticalPadding, clr: Colors.grey,onFocus: false,)
//
//                 ],
//               ),
//               height2
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
