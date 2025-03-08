
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as DatePicker;
import 'package:get/get.dart';
import 'package:pet_care_app/utils/formatters/formatter.dart';

import '../controller/order_controller.dart';

class RoutineModel {
  final DateTime timeStart;
  final DateTime timeEnd;

  RoutineModel({required this.timeStart, required this.timeEnd});
}

class DateTimeController extends GetxController {
  static DateTimeController get to => Get.find();

  final orderController = OrderController.instance;

  Rx<String> selectedTime = 'Thời Gian Bắt Đầu'.obs;
  Rx<String> selectedDate = 'Ngày Bắt Đầu'.obs;

  void updateSelectedTime(String time) {
    selectedTime.value = time;
    orderController.timeStart.value = time;
  }

  void updateSelectedDate(String date) {
    selectedDate.value = date;
    orderController.dateStart.value = date;
  }

  void resetDateTime() {
    selectedTime.value = 'Thời Gian Bắt Đầu';
    selectedDate.value = 'Ngày Bắt Đầu';
  }

  Future<DateTime?> selectDate(
    BuildContext context,
    String? cancelText,
    String? confirmText,
    String? helpText,
  ) async {
    return await DatePicker.showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
    );
  }

  Future<DatePicker.TimeOfDay?> selectTime(
    BuildContext context,
    String? cancelText,
    String? confirmText,
    String? helpText,
  ) async {
    return await DatePicker.showTimePicker(
      context: context,
      initialTime: DatePicker.TimeOfDay.now(),
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate =
        await selectDate(context, 'Hủy', 'Đồng Ý', 'Chọn Ngày Đặt');
    if (pickedDate != null) {
      updateSelectedDate(Formatter.formatDate(pickedDate));
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final DatePicker.TimeOfDay? picked =
        await selectTime(context, 'Hủy', 'Đồng Ý', 'Chọn Giờ Đặt');
    if (picked != null) {
      updateSelectedTime(Formatter.formatTime(picked));
    }
  }
}
