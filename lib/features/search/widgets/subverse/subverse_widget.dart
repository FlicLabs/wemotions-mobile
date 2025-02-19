import 'dart:developer';
import 'package:socialverse/export.dart';

class SubverseWidget extends StatefulWidget {
  const SubverseWidget({
    Key? key,
    required this.spheres,
    required this.GridView,
  }) : super(key: key);

  final List<Category> spheres;
  final bool GridView;

  @override
  State<SubverseWidget> createState() => _SubverseWidgetState();
}

class _SubverseWidgetState extends State<SubverseWidget> {
  final spheresController = ScrollController();

  @override
  void initState() {
    spheresController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final sphere = Provider.of<SearchProvider>(context, listen: false);
    if (mounted) {
      if (spheresController.position.pixels ==
          spheresController.position.maxScrollExtent) {
        sphere.page++;
        // sphere.getSubverses(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sphere = Provider.of<SearchProvider>(context);
    return SingleChildScrollView(
      controller: spheresController,
      key: PageStorageKey(0),
      child: sphere.isGridView == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                GridViewButton(),
                GridView.builder(
                  itemCount: widget.spheres.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: cs.height(context) * 0.115,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 3.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, index) {
                    return SubverseGridItem(
                      imageUrl: widget.spheres[index].imageUrl,
                      name: widget.spheres[index].name,
                      hasAccess: widget.spheres[index].hasAccess,
                      onTap: () async {
                        if (widget.spheres[index].isSubscriptionRequired ==
                            true) {
                          launchUrl(
                            Uri.parse(
                              widget.spheres[index].standaloneAppDeeplink!,
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          // sphere.onSubverseTap(
                          //   context: context,
                          //   category_id: sphere.spheres[index].id,
                          //   category_count: sphere.spheres[index].count,
                          //   category_desc: sphere.spheres[index].description,
                          //   category_name: sphere.spheres[index].name,
                          //   category_photo: sphere.spheres[index].imageUrl,
                          // );
                        }
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          builder: (context) {
                            return Container();
                            // return SubverseSheet(
                            //   category_name: sphere.spheres[index].name,
                            //   category_desc: sphere.spheres[index].description,
                            //   category_count: sphere.spheres[index].count,
                            //   category_id: sphere.spheres[index].id,
                            //   category_photo: sphere.spheres[index].imageUrl,
                            //   isSubscribedRequired:
                            //       widget.spheres[index].isSubscriptionRequired,
                            // );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                GridViewButton(),
                ListView.builder(
                  itemCount: widget.spheres.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).size.height * 0.115,
                  ),
                  itemBuilder: (_, index) {
                    return SubverseListItem(
                      imageUrl: widget.spheres[index].imageUrl,
                      name: widget.spheres[index].name,
                      description: widget.spheres[index].description,
                      hasAccess: widget.spheres[index].hasAccess,
                      onTap: () async {
                        log('tap');
                        if (widget.spheres[index].isSubscriptionRequired ==
                            true) {
                          launchUrl(
                            Uri.parse(
                              widget.spheres[index].standaloneAppDeeplink!,
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                          LaunchMode.externalApplication;
                        } else {
                          // sphere.onSubverseTap(
                          //   context: context,
                          //   category_id: sphere.spheres[index].id,
                          //   category_count: sphere.spheres[index].count,
                          //   category_desc: sphere.spheres[index].description,
                          //   category_name: sphere.spheres[index].name,
                          //   category_photo: sphere.spheres[index].imageUrl,
                          // );
                        }
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          builder: (context) {
                            return Container();
                            // return SubverseSheet(
                            //   category_name: sphere.spheres[index].name,
                            //   category_desc: sphere.spheres[index].description,
                            //   category_count: sphere.spheres[index].count,
                            //   category_id: sphere.spheres[index].id,
                            //   category_photo: sphere.spheres[index].imageUrl,
                            //   isSubscribedRequired:
                            //       widget.spheres[index].isSubscriptionRequired,
                            // );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
