import 'package:socialverse/export.dart';

class TagPeopleWidget extends StatelessWidget {
  const TagPeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (_, __, ___) {
        return Container(

          height: cs().height(context) / 1.45,
          width: cs().width(context),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: cs().width(context),
                padding: EdgeInsets.only(
                    top: 18, bottom: 18, left: 20, right: 20),
                child: Stack(
                  alignment:
                  Alignment.center, // Center the Stack's children
                  children: [
                    Positioned(
                      child: Text(
                        "Tag someone",
                        style: AppTextStyle.normalSemiBold20Black.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).focusColor,
                height: 0,
              ),
              height15,
              Container(
                padding:EdgeInsets.only(left: 20,right: 20),
                // margin: EdgeInsets.all(10),
                child: TextField(
                  controller: __.searchController,
                  decoration: textFormFieldDecoration.copyWith(
                    hintText: 'Enter name here please',
                    fillColor: Colors.transparent,
                    hintStyle: AppTextStyle.displaySmall.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFA858F4)),
                    ),
                    enabledBorder: OutlineInputBorder(
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
              if (__.selected_users.isNotEmpty && __.searchController.text.isEmpty)...[
                Expanded(
                  child: ListView.builder(
                    itemCount: __.selected_users.length,
                    itemBuilder: (context, index) {
                      if (__.selected_users[index].username == prefs_username) {
                        return Container();
                      }
                      return GestureDetector(
                        onTap: () {
                          __.selectUsers(__.selected_users[index]);
                          print(__.selected_users);
                          __.searched_users.clear();
                          __.searchController.clear();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),

                          child: ListTile(
                            title: Text(
                              __.selected_users[index].firstName +
                                  ' ' +
                                  __.selected_users[index].lastName,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontSize: 14),
                            ),
                            subtitle: Text(
                              __.selected_users[index].username,
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
                                __.selected_users[index].profilePictureUrl,
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
                              child: Center(
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: Theme.of(context)
                                      .focusColor, // Color of the plus icon
                                  size: 35, // Size of the plus icon
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]else...[
                Expanded(
                  child: ListView.builder(
                    itemCount: __.searched_users.length,
                    itemBuilder: (context, index) {
                      if (__.searched_users[index].username == prefs_username) {
                        return Container();
                      }
                      return GestureDetector(
                        onTap: () {
                          __.selectUsers(__.searched_users[index]);
                          print(__.selected_users);
                          __.searched_users.clear();
                          __.searchController.clear();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),

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
                            trailing:__.selected_users.contains(
                                __.searched_users[index].username) ? Container(
                              width: 35, // Width of the circle
                              height: 35, // Height of the circle
                              child: Center(
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: Theme.of(context)
                                      .focusColor, // Color of the plus icon
                                  size: 35, // Size of the plus icon
                                ),
                              ),
                            ) : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],

            ],
          ),
        );
      },
    );
  }
}
