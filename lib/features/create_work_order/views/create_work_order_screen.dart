// 📁 lib/features/create_work_order/views/create_work_order_screen.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/create_work_order_form.dart';

class CreateWorkOrderScreen extends StatelessWidget {
  const CreateWorkOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_work_order.app_bar_title'.tr())),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: const CreateWorkOrderForm(),
      ),
    );
  }
}
