import 'package:flutter/material.dart';
import 'package:pet_care_app/common/widgets/appbar/custom_tabbar.dart';
import 'package:pet_care_app/feature/customer/view/history/widgets/order_infomation_card.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';

class HistoryBookingScreen extends StatelessWidget {
  const HistoryBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Lịch sử đặt hàng'),
          bottom: CustomTabBar(
            tabs: [
              Tab(text: 'Đang xử lý'),
              Tab(text: 'Đã hoàn thành'),
              Tab(text: 'Đã hủy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(AppSize.small),
              child: OrderInfomationCard(
                listOrder: orderController.pendingOrderList,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(AppSize.small),
              child: OrderInfomationCard(
                listOrder: orderController.successfulOrderList,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(AppSize.small),
              child: OrderInfomationCard(
                listOrder: orderController.canceledOrderList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
