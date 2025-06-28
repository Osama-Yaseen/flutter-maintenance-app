// 📁 lib/features/create_work_order/widgets/create_work_order_form.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quiqflow_maintenance_app/core/constants/app_constants.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/models/create_work_order_state.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/viewmodels/create_work_order_cubit.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/custom_date_picker_field.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/custom_dropdown_field.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/custom_text_field.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/schedule_slot_picker_button.dart';
import 'package:quiqflow_maintenance_app/features/create_work_order/widgets/section_title.dart';
import 'package:quiqflow_maintenance_app/features/schedule_picker/models/schedule_slot.dart';

class CreateWorkOrderForm extends StatelessWidget {
  const CreateWorkOrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<CreateWorkOrderCubit>();

    return BlocConsumer<CreateWorkOrderCubit, CreateWorkOrderState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('create_work_order.snackbar_success'.tr())),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: 'create_work_order.section_work_details'.tr(),
                ),
                CustomTextField(
                  label: 'create_work_order.label_title'.tr(),
                  initialValue: state.title,
                  onChanged: cubit.updateTitle,
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'create_work_order.validator_required'.tr(
                                namedArgs: {
                                  'field': 'create_work_order.label_title'.tr(),
                                },
                              )
                              : null,
                ),
                CustomTextField(
                  label: 'create_work_order.label_description'.tr(),
                  initialValue: state.description,
                  onChanged: cubit.updateDescription,
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'create_work_order.validator_required'.tr(
                                namedArgs: {
                                  'field':
                                      'create_work_order.label_description'
                                          .tr(),
                                },
                              )
                              : null,
                  maxLines: 3,
                ),
                SectionTitle(text: 'create_work_order.section_meta_info'.tr()),
                CustomDropdownField(
                  labelKey: 'create_work_order.label_category',
                  value: state.category,
                  items: kCategories,
                  onChanged: cubit.updateCategory,
                ),
                CustomDropdownField(
                  labelKey: 'create_work_order.label_priority',
                  value: state.priority,
                  items: kPriorites,
                  onChanged: cubit.updatePriority,
                ),
                CustomDatePickerField(
                  date: state.date,
                  onDateSelected: cubit.updateDate,
                ),
                SectionTitle(
                  text: 'create_work_order.section_technician_schedule'.tr(),
                ),
                CustomDropdownField(
                  labelKey: 'create_work_order.label_technician',
                  value: state.technicianId,
                  items: kTechnicianNames,
                  onChanged: cubit.updateTechnician,
                ),
                ScheduleSlotPickerButton(
                  technicianId: state.technicianId,
                  assignedSlot: state.assignedSlot,
                  onPressed: () async {
                    // This logic remains here as it involves navigation
                    final slot = await context.push<ScheduleSlot>(
                      '/schedule-picker/${state.technicianId}',
                    );
                    if (slot != null) cubit.updateAssignedSlot(slot);
                  },
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        state.isSubmitting
                            ? null
                            : () {
                              if (formKey.currentState!.validate() &&
                                  state.date != null &&
                                  state.assignedSlot != null) {
                                cubit.submit();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'create_work_order.snackbar_complete_fields'
                                          .tr(),
                                    ),
                                  ),
                                );
                              }
                            },
                    icon:
                        state.isSubmitting
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Icon(Icons.save),
                    label: Text(
                      state.isSubmitting
                          ? 'create_work_order.button_submitting'.tr()
                          : 'create_work_order.button_save'.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
