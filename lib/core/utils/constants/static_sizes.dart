import 'package:socialverse/export.dart';

class cs {
  // cs: custom size
  height(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  width(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }
}

const SizedBox shrink = SizedBox.shrink();

const SizedBox width2 = SizedBox(width: 2);
const SizedBox width3 = SizedBox(width: 3);
const SizedBox width5 = SizedBox(width: 5);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width15 = SizedBox(width: 15);
const SizedBox width20 = SizedBox(width: 20);

const SizedBox height2 = SizedBox(height: 2);
const SizedBox height5 = SizedBox(height: 5);
const SizedBox height7 = SizedBox(height: 7);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox height15 = SizedBox(height: 15);
const SizedBox height20 = SizedBox(height: 20);
const SizedBox height40 = SizedBox(height: 40);
const SizedBox height60 = SizedBox(height: 60);
const SizedBox height80 = SizedBox(height: 80);
