import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../secrets/stripe/stripe_api_key.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      final paymentIntent = await createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Pet Care App',
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
    try {
      final dio = Dio();

      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
          },
        ),
      );

      return response.data;
    } on DioException catch (err) {
      throw Exception(err.message);
    }
  }

  String calculateAmount(double amount) {
    return (amount * 100).toString();
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
