import 'package:razorpay_flutter/razorpay_flutter.dart';

class razorpay {
  // Instance of razor pay
  final Razorpay _razorpay = Razorpay();

  initiateRazorPay() {
// To handle different event with previous functions
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  oppensession(num amount) {
    var options = {
      'key': 'rzp_test_8HwGoKx5qi6NaC', //Razor pay API Key
      'amount':
          100, //in the smallest currency sub-unit. 'timeout': 60, // in seconds
      'name': 'e shoping', // Generate order id using Orders API
      'description':
          'Description for order', //Order Description to be shown in razor pay page
      'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
    }; //contact number and email id of user
    _razorpay.open(options);
  }
}