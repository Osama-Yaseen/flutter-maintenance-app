// 📁 lib/features/create_work_order/widgets/custom_dropdown_field.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String labelKey;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.labelKey,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelKey.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        value: value,
        items:
            items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(_mapValueToTranslation(e, labelKey)),
                  ),
                )
                .toList(),
        onChanged: onChanged,
        validator:
            (val) =>
                val == null
                    ? 'create_work_order.validator_required'.tr(
                      namedArgs: {'field': labelKey.tr()},
                    )
                    : null,
      ),
    );
  }

  // Helper function to map a dropdown value to its translation
  String _mapValueToTranslation(String value, String fieldLabelKey) {
    switch (fieldLabelKey) {
      case 'create_work_order.label_category':
        return 'create_work_order.category.${value.toLowerCase()}'.tr();
      case 'create_work_order.label_priority':
        return 'work_order_card.priority.${value.toLowerCase().replaceAll(' ', '_')}'
            .tr();
      case 'create_work_order.label_technician':
        // Technician names are often proper nouns, so we don't translate them.
        return value;
      default:
        return value;
    }
  }
}
