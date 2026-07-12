import 'package:flutter/material.dart';

/// A labeled `-`/`+` stepper bound to an integer within [min]..[max],
/// integrated with [Form] like a regular [FormField].
///
/// Replaces raw numeric [TextFormField]s for small bounded counts
/// (participants, threshold, number of shares): stepping with buttons is
/// more discoverable than typing a number for users unfamiliar with the
/// underlying m-of-n secret-sharing concept, and it makes going
/// out-of-range structurally impossible instead of relying purely on a
/// validator message after the fact.
class NumberStepperField extends FormField<int> {
  NumberStepperField({
    super.key,
    required String label,
    required int min,
    required int max,
    int? initialValue,
    ValueChanged<int>? onChanged,
    super.validator,
  }) : super(
         initialValue: initialValue ?? min,
         builder: (field) {
           final value = field.value ?? min;

           void update(int next) {
             final clamped = next.clamp(min, max);
             field.didChange(clamped);
             onChanged?.call(clamped);
           }

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 label,
                 style: Theme.of(field.context).textTheme.labelMedium?.copyWith(
                   color: field.hasError
                       ? Theme.of(field.context).colorScheme.error
                       : Theme.of(field.context).colorScheme.onSurface,
                 ),
               ),
               const SizedBox(height: 8),
               Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   _StepperButton(
                     icon: Icons.remove_rounded,
                     onPressed: value > min ? () => update(value - 1) : null,
                   ),
                   Container(
                     width: 56,
                     alignment: Alignment.center,
                     child: Text(
                       '$value',
                       style: Theme.of(field.context).textTheme.headlineSmall,
                     ),
                   ),
                   _StepperButton(
                     icon: Icons.add_rounded,
                     onPressed: value < max ? () => update(value + 1) : null,
                   ),
                 ],
               ),
               if (field.hasError) ...[
                 const SizedBox(height: 4),
                 Text(
                   field.errorText!,
                   style: TextStyle(
                     color: Theme.of(field.context).colorScheme.error,
                     fontSize: 12,
                   ),
                 ),
               ],
             ],
           );
         },
       );
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _StepperButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: scheme.surfaceContainerHighest,
        foregroundColor: scheme.primary,
        disabledBackgroundColor: scheme.surfaceContainerHighest.withValues(
          alpha: 0.4,
        ),
        disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }
}
