import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/core/utils/constants/static_sizes.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/providers/home_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AltTaggingSheet extends StatefulWidget {
  const AltTaggingSheet({super.key});

  @override
  State<AltTaggingSheet> createState() => _AltTaggingSheetState();
}

class _AltTaggingSheetState extends State<AltTaggingSheet> {
  List<Color> bgClr = [
    Colors.redAccent,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Constants.primaryColor
  ];
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height15,
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: __.posts[__.index][0].tags.map((e) {
                  return Chip(
                    padding: EdgeInsets.all(5),
                    backgroundColor: bgClr[Random().nextInt(5)],
                    shadowColor: Colors.black,
                    avatar: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        fit: BoxFit.cover,
                        imageUrl: e.user.pictureUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Image.asset(
                          AppAsset.load,
                          fit: BoxFit.cover,
                          height: cs().height(context),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            AppAsset.icuser,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      e.user.username,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    // deleteIcon: Icon(Icons.cancel),
                    deleteIconColor: Colors.white,
                    onDeleted: () {
                      __.removeTag(
                          __.posts[__.index][0].id, e.user.username);
                    },
                  );
                }).toList(),
              ),
              height15
            ],
          ),
        );
      },
    );
  }
}
