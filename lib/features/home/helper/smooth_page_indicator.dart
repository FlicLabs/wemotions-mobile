import 'package:flutter/cupertino.dart';
import 'package:socialverse/export.dart';
import 'dart:math';
import 'package:socialverse/features/home/utils/circular_dot.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SmoothPageIndicatorView extends StatelessWidget {
  const SmoothPageIndicatorView({
    Key? key,
  }) : super(key: key);

  List<Widget> _buildDots({
    required SmoothPageIndicatorProvider provider,
    required int totalCount,
    required int currentIndex,
    required bool isHorizontal,
    required int visibleDots,
  }) {
    List<Widget> dots = [];

    if (totalCount == 0) {
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
    // if (start > 0) {
    //   dots.add(
    //     Indicator(
    //       isActive: false,
    //       isHorizontal: isHorizontal,
    //       isMoreIndicator: true,
    //     ),
    //   );
    // }

    // Add main dots
    for (int i = start; i <= end; i++) {
      if(!isHorizontal){
        dots.add(
          Row(
            children: [
              Indicator(
                isActive: provider.onReply? false:i == currentIndex,
                isHorizontal: isHorizontal,
                makeTransparent: provider.onReply && i != currentIndex? true:false,
              ),

              if (provider.totalHorizontalPages != -1 &&
                  provider.currentHorizontalIndex != -1 &&
                  provider.currentVerticalIndex != -1 &&
                  provider.totalHorizontalPages != 0 && i==currentIndex)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildDots(
                    provider: provider,
                    totalCount: provider.totalHorizontalPages,
                    currentIndex: provider.currentHorizontalIndex,
                    isHorizontal: true,
                    visibleDots: provider.horizontalVisibleDots,
                  ),
                ),
            ],
          ),
        );
      }else{
        dots.add(
          Indicator(
            isActive: provider.onReply? i == currentIndex:false,
            isHorizontal: isHorizontal,
          ),
        );
      }

    }

    // // Add trailing more indicator if needed
    // if (end < totalCount - 1) {
    //   dots.add(
    //     Indicator(
    //       isActive: false,
    //       isHorizontal: isHorizontal,
    //       isMoreIndicator: true,
    //     ),
    //   );
    // }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothPageIndicatorProvider>(
      builder: (_, provider, ___) {
        // Ensure we have valid data before building
        if (provider.totalVerticalPages == -1 || provider.currentVerticalIndex == -1) {
          return SizedBox.shrink();
        }

        // Calculate offset to ensure horizontal indicator overlaps vertical active indicator
        double verticalOffset = 0;
        if (provider.currentVerticalIndex != -1) {
          // Calculate position based on current index (accounting for more indicators)
          // int visibleVerticalPosition = 0;
          // if (provider.currentVerticalIndex > 0) {
          //   visibleVerticalPosition++; // Account for leading more indicator
          // }
          verticalOffset = (provider.currentVerticalIndex == 0 ? 0 : 1) +
              (provider.currentVerticalIndex - math.max(0, provider.currentVerticalIndex - 1));
        }

        return Container(
          // width: 72,
          height: 82,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Vertical indicators
              Padding(
                padding: EdgeInsets.only(left: provider.totalHorizontalPages>=3?(cs.width(context) / 4.5)/(2.4):(cs.width(context) / 4.5)/(1.9)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildDots(
                    provider: provider,
                    totalCount: provider.totalVerticalPages,
                    currentIndex: provider.currentVerticalIndex,
                    isHorizontal: false,
                    visibleDots: provider.verticalVisibleDots,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  final bool isHorizontal;
  final bool isMoreIndicator;
  final bool makeTransparent;

  const Indicator({
    Key? key,
    required this.isActive,
    required this.isHorizontal,
    this.isMoreIndicator = false,
    this.makeTransparent =false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: isHorizontal ? 3 : 0,
        vertical: isHorizontal ? 0 : 4,
      ),
      width: isHorizontal
          ? (isMoreIndicator ? 6 : (isActive? 9:8))
          : (isMoreIndicator ? 6 : 8),
      height: isHorizontal
          ? (isMoreIndicator ? 6 : 8)
          : (isMoreIndicator ? 6 : (isActive? 9:8)),
      decoration: BoxDecoration(
        color: makeTransparent? Colors.transparent:isActive
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
