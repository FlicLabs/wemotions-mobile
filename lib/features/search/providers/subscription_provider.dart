import 'package:socialverse/export.dart';

class SubscriptionProvider extends ChangeNotifier {
  // final _service = SubscriptionService();

  // Future<void> startSubscription({
  //   required int id,
  // }) async {
  //   final response = await _service.startSubscription(id);
  //   if (response.data['status'] == 'success') {
  //     String client_secret =
  //         response.data['message']['subscription']['client_secret'];
  //     paymentSheet(client_secret: client_secret, name: '');
  //     notifyListeners();
  //   }
  // }

  // Future paymentSheet(
  //     {required String client_secret, required String name}) async {
  //   await Stripe.instance.initPaymentSheet(
  //     paymentSheetParameters: SetupPaymentSheetParameters(
  //       applePay: PaymentSheetApplePay(
  //         merchantCountryCode: 'US',
  //       ),
  //       googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
  //       style: ThemeMode.light,
  //       merchantDisplayName: name,
  //       paymentIntentClientSecret: client_secret,
  //     ),
  //   );

  //   await Stripe.instance.presentPaymentSheet();
  // }
}
