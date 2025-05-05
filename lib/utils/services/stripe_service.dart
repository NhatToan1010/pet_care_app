import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../secrets/stripe/stripe_api_key.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      final paymentIntent = await createPaymentIntent(amount, currency);
      if (paymentIntent == null) return;


      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Pet Care App',
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      throw e.toString();
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      // final dio = Dio();

      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      print(response.body);

      return jsonDecode(response.body);
    } on DioException catch (err) {
      throw Exception(err.message);
    }
  }

  String calculateAmount(double amount) {
    return (amount.toInt() * 100).toString();
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      if (e is StripeException) {
        throw Exception(e.error.localizedMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
