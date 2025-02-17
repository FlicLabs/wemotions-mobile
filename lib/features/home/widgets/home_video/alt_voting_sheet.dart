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
  void _handleVoteTap(HomeProvider homeProvider, int index) async {
    final postId = homeProvider.posts[homeProvider.index][0].id;

    if (homeProvider.votings[index].marked) {
      homeProvider.votings[index].marked = false;
      await homeProvider.removeVoting(postId);
    } else {
      // Unmark all votes before marking the selected one
      for (var element in homeProvider.votings) {
        element.marked = false;
      }
      homeProvider.votings[index].marked = true;
      await homeProvider.addVoting(postId, homeProvider.votings[index].voting);
    }
    
    Navigator.pop(context); // Close the sheet after selection
    setState(() {}); // Ensure UI updates properly
  }

  void _showAllVotingOptions(BuildContext context, HomeProvider homeProvider) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1,
                    center: Alignment.center,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).hintColor.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: homeProvider.votings.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _handleVoteTap(homeProvider, index),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  homeProvider.votings[index].voting,
                                  style: GoogleFonts.notoColorEmoji(
                                    textStyle: const TextStyle(fontSize: 30),
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, homeProvider, __) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...homeProvider.votings.sublist(0, 5).map((item) {
                    return GestureDetector(
                      onTap: () => _handleVoteTap(homeProvider, homeProvider.votings.indexOf(item)),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            item.voting,
                            style: GoogleFonts.notoColorEmoji(
                              textStyle: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  GestureDetector(
                    onTap: () => _showAllVotingOptions(context, homeProvider),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).focusColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).focusColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              height15,
            ],
          ),
        );
      },
    );
  }
}
