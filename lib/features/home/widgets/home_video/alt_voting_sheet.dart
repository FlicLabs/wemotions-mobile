import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/core/utils/constants/static_sizes.dart';
import 'package:socialverse/features/home/providers/home_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AltVotingSheet extends StatefulWidget {
  const AltVotingSheet({super.key});

  @override
  State<AltVotingSheet> createState() => _AltVotingSheetState();
}

class _AltVotingSheetState extends State<AltVotingSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return Container(
          // height: 100,
          width: cs().width(context),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...__.votings.sublist(0, 5).map((item) {
                    return GestureDetector(
                      onTap: () async {
                        if (item.marked == true) {
                          Navigator.pop(context);
                          item.marked = false;
                          await __.removeVoting(__.posts[__.index][0].id);
                        } else {
                          __.votings.forEach(
                            (element) {
                              if (element.marked) {
                                element.marked = false;
                              }
                            },
                          );
                          item.marked = true;
                          await __.addVoting(
                              __.posts[__.index][0].id, item.voting);
                          Navigator.pop(context);
                        }
                        // __.makeItems(__.currentEmote!);
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              // color: __.votings[index].marked
                              //     ? Theme.of(context).hintColor
                              //     : Colors.transparent,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            item.voting,
                            style: GoogleFonts.notoColorEmoji(
                                textStyle: TextStyle(fontSize: 30)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              Positioned(
                                top: 50, // Position from the top
                                left: 20,
                                right: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: Theme.of(context).hintColor.withOpacity(0.2),
                                      gradient: RadialGradient(
                                        radius: 1,
                                        center: Alignment.center,
                                        colors: [
                                          Colors.transparent,
                                          Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.2),
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        height: 110,
                                        width: cs().width(context),
                                        padding: EdgeInsets.all(5),
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                6, // Increase the number of columns
                                            childAspectRatio:
                                                1.0, // Aspect ratio for compactness
                                            crossAxisSpacing:
                                                4.0, // Horizontal spacing
                                            mainAxisSpacing: 4.0, //
                                          ),
                                          itemCount: __.votings.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (__.votings[index].marked ==
                                                    true) {
                                                  Navigator.pop(context);
                                                  __.votings[index].marked =
                                                      false;
                                                  await __.removeVoting(
                                                      __.posts[__.index][0].id);
                                                } else {
                                                  __.votings.forEach(
                                                    (element) {
                                                      if (element.marked) {
                                                        element.marked = false;
                                                      }
                                                    },
                                                  );
                                                  __.votings[index].marked =
                                                      true;
                                                      Navigator.pop(context);
                                                  await __.addVoting(
                                                      __.posts[__.index][0].id,
                                                      __.votings[index].voting);
                                                  
                                                }
                                                // __.makeItems(__.currentEmote!);
                                              },
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      // color: __.votings[index]
                                                      //         .marked
                                                      //     ? Theme.of(context)
                                                      //         .hintColor
                                                      //     : Colors.transparent,
                                                      shape: BoxShape.circle),
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    __.votings[index].voting,
                                                    style: GoogleFonts
                                                        .notoColorEmoji(
                                                      textStyle: TextStyle(
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 35, // Width of the circle
                      height: 35, // Height of the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).focusColor,
                            width: 2), // Circle border color and width
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context)
                              .focusColor, // Color of the plus icon
                          size: 30, // Size of the plus icon
                        ),
                      ),
                    ),
                  )
                ],
              ),
              height15
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 6, // Increase the number of columns
              //       childAspectRatio: 1.0, // Aspect ratio for compactness
              //       crossAxisSpacing: 4.0, // Horizontal spacing
              //       mainAxisSpacing: 4.0, //
              //     ),
              //     itemCount: __.votings.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: () async {
              //           if (__.votings[index].marked == true) {
              //             Navigator.pop(context);
              //             __.votings[index].marked = false;
              //             await __.removeVoting(__.posts[__.index][0].id);
              //           } else {
              //             __.votings.forEach(
              //               (element) {
              //                 if (element.marked) {
              //                   element.marked = false;
              //                 }
              //               },
              //             );
              //             __.votings[index].marked = true;
              //             await __.addVoting(__.posts[__.index][0].id,
              //                 __.votings[index].voting);
              //             Navigator.pop(context);
              //           }
              //         },
              //         child: Center(
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 color: __.votings[index].marked
              //                     ? Theme.of(context).hintColor
              //                     : Colors.transparent,
              //                 shape: BoxShape.circle),
              //             padding: EdgeInsets.all(5),
              //             child: Text(
              //               __.votings[index].voting,
              //               style: GoogleFonts.notoColorEmoji(
              //                   textStyle: TextStyle(fontSize: 20)),
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
