import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/product_text/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../model/order_model.dart';
import 'infomation_card.dart';

class PriceInfomation extends StatelessWidget {
  const PriceInfomation({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final totalAmount = PricingCalculator.calculateTotalPrice(order.totalPrice);

    return InfomationCard(
      hideButton: true,
      title: 'Chi tiết thanh toán',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giá dịch vụ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ProductPriceText(price: order.totalPrice.toString(), isLarge: false),
            ],
          ),
          SizedBox(height: AppSize.small),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí phụ thu',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ProductPriceText(
                  price: PricingCalculator.calculateFee(order.totalPrice).toString(),
                  isLarge: false,
              ),
            ],
          ),
          SizedBox(height: AppSize.small),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thành tiền',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              ProductPriceText(price: totalAmount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
