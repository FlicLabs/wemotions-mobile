import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:socialverse/export.dart';

class TaggingWidget extends StatelessWidget {
  const TaggingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return Container(
          height: cs().height(context) / 1.25,
          width: cs().width(context),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (__.selected_users.isNotEmpty) ...[
                height10,
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 10.0, // Space between the children horizontally
                      runSpacing: 10.0,
                      // direction: Axis.vertical,
                      children: __.selected_users.map((i) {
                        return Container(
                          child: Text(
                            i,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    )),
                height10,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).hintColor),
                    onPressed: () async {
                      Navigator.pop(context);
                      await __.addTag(__.posts[__.index][0].id);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(color: Theme.of(context).hintColor),
                      child: Text(
                        'Tag these users',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ))
              ],
              height15,
              Container(
                // margin: EdgeInsets.all(10),
                child: TextField(
                  controller: __.searchController,
                  decoration: textFormFieldDecoration.copyWith(
                    hintText: 'Search Users',
                    fillColor: Theme.of(context).hoverColor,
                    hintStyle: AppTextStyle.displaySmall.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 13),
                  onChanged: (value) {
                    __.onSearchChanged(value);
                  },
                ),
              ),
              height15,
              Expanded(
                child: ListView.builder(
                  itemCount: __.searched_users.length,
                  itemBuilder: (context, index) {
                    if (__.searched_users[index].username == prefs_username ||
                        __.posts[__.index][0].tags.any((element) =>
                            element.user.username ==
                            __.searched_users[index].username)) {
                      return Container();
                    }
                    return GestureDetector(
                      onTap: () {
                        __.selectUsers(__.searched_users[index].username);
                        print(__.selected_users);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: __.selected_users
                                    .contains(__.searched_users[index].username)
                                ? Theme.of(context).hintColor
                                : Colors.transparent,
                          ),
                          // color: __.selected_users
                          //         .contains(__.searched_users[index].username)
                          //     ? Theme.of(context).hintColor
                          //     : Colors.transparent
                        ),
                        child: ListTile(
                          title: Text(
                            __.searched_users[index].firstName +
                                ' ' +
                                __.searched_users[index].lastName,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14),
                          ),
                          subtitle: Text(
                            __.searched_users[index].username,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 0),
                              fadeOutDuration: Duration(milliseconds: 0),
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                              imageUrl:
                                  __.searched_users[index].profilePictureUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
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
                          trailing: Container(
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
                                __.selected_users.contains(
                                        __.searched_users[index].username)
                                    ? Icons.add
                                    : CupertinoIcons.xmark,
                                color: Theme.of(context)
                                    .focusColor, // Color of the plus icon
                                size: __.selected_users.contains(
                                        __.searched_users[index].username)
                                    ? 30
                                    : 25, // Size of the plus icon
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
