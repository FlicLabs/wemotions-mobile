import 'dart:developer';
import 'package:socialverse/export.dart';

class SubverseSearchList extends StatelessWidget {
  const SubverseSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, provider, __) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: provider.subverse_search.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, provider, index);
          },
        );
      },
    );
  }

  /// Extracted function to improve readability
  Widget _buildListItem(BuildContext context, SearchProvider provider, int index) {
    final item = provider.subverse_search[index];

    return GestureDetector(
      onTap: () => _handleTap(context, provider, item),
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: cs().width(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CustomCircularAvatar(
                  imageUrl: item.imageUrl,
                  height: 55,
                  width: 55,
                ),
                if (!item.hasAccess)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3), // Semi-transparent lock overlay
                      child: const Center(
                        child: Icon(Icons.lock, color: Colors.white, size: 35),
                      ),
                    ),
                  ),
              ],
            ),
            width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  height5,
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Extracted function to handle tap logic
  void _handleTap(BuildContext context, SearchProvider provider, dynamic item) {
    log('tap');
    HapticFeedback.mediumImpact();

    if (!item.hasAccess) {
      // Handle subscription logic here if needed
      log('Locked content');
    } else {
      // provider.onSubverseTap(
      //   context: context,
      //   category_id: item.id,
      //   category_count: item.count,
      //   category_desc: item.description,
      //   category_name: item.name,
      //   category_photo: item.imageUrl,
      // );
    }
  }
}
