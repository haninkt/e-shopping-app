import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class api extends ChangeNotifier {
  List<dynamic> products = [];
  int productindex = 0;
  Future<void> fetchproduct() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonData = json.decode(response.body);

      products = jsonData['products'];
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  api() {
    fetchproduct();
    notifyListeners();
  }
}

class razorpay extends ChangeNotifier {
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
          40000, //in the smallest currency sub-unit. 'timeout': 60, // in seconds
      'name': 'e shoping', // Generate order id using Orders API
      'description':
          'Description for order', //Order Description to be shown in razor pay page
      'prefill': {'contact': '+91 8714139667', 'email': 'hanintdg@gmail.com'}
    }; //contact number and email id of user
    _razorpay.open(options);
  }
}
