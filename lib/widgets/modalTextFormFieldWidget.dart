import 'package:flutter/material.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ModalTextFormFieldWidget<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData? iconSufix;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final TextEditingController controller;

  const ModalTextFormFieldWidget({
    super.key,
    required this.label,
    required this.icon,
    this.iconSufix,
    this.padding,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormFieldWidget(
          controller: controller,
          icon: icon,
          label: label,
          iconSufix: iconSufix ?? Icons.arrow_drop_down,
        ),
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 55,
          ),
          onTap: () {
            WoltModalSheet.show(
              context: context,
              pageListBuilder: (bottomSheetContext) => [
                WoltModalSheetPage(
                  hasTopBarLayer: false,
                  child: Padding(
                    padding: padding ??
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                    child: child,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
