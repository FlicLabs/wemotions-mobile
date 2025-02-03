import 'package:socialverse/export.dart';
import 'package:http/http.dart' as http;

Future<String> fetchSvg(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return preprocessSvgContent(response.body);
    } else {
      throw Exception('Failed to load SVG');
    }
  } catch (e) {
    throw Exception('Failed to fetch SVG: $e');
  }
}

String preprocessSvgContent(String svgContent) {
  RegExp exp3d = RegExp(r'translate3d\(([^,]+),([^,]+),[^)]+\)');
  svgContent = svgContent.replaceAllMapped(exp3d, (Match match) {
    return 'translate(${match.group(1)}, ${match.group(2)})'; // Converts 3D translate to 2D
  });

  RegExp expPercent = RegExp(r'(\d+)%');
  svgContent = svgContent.replaceAllMapped(expPercent, (Match match) {
    double value = double.parse(match.group(1)!);
    return (value * 100 / 100).toString(); // Converts percentages
  });

  return svgContent;
}

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final bool? isLoading;
  const CustomNetworkImage({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.imageUrl,
    this.borderRadius,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String checkLogoType(String logoUrl) {
      if (logoUrl.contains('.svg')) {
        return 'SVG';
      } else if (logoUrl.contains('.png')) {
        return 'PNG';
      } else {
        return 'Unknown';
      }
    }

    return checkLogoType(imageUrl!) == 'SVG'
        ? FutureBuilder<String>(
            future: fetchSvg(imageUrl!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SvgPicture.string(
                  snapshot.data!,
                  fit: BoxFit.contain,
                  height: height,
                  width: width,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return shrink;
              }
            },
          )
        : CachedNetworkImage(
            fit: fit ?? BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
            height: height,
            width: width,
            imageUrl: imageUrl!,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (isLoading == true) {
                return shrink;
              } else {
                return Image.asset(
                  AppAsset.load,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                );
              }
            },
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).hoverColor,
              height: cs.height(context),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  AppAsset.icon,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
          );
  }
}
