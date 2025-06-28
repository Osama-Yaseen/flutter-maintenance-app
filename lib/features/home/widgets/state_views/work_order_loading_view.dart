// 📁 lib/features/work_order_list/widgets/work_order_loading_view.dart

import 'package:flutter/material.dart';

class WorkOrderLoadingView extends StatelessWidget {
  const WorkOrderLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      ),
    );
  }
}
