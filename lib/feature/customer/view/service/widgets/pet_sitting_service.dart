import 'package:flutter/material.dart';
import 'package:pet_care_app/feature/customer/model/services/service_model.dart';

import '../../../controller/service_controller.dart';
import '../../../model/services/pet_sitting_model.dart';

class PetSittingService extends StatelessWidget {
  const PetSittingService({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final petSittingService = service as PetSittingModel;
    final serviceController = ServiceController.instance;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ],
      ),
    );
  }
}
