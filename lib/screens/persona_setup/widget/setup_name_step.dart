// lib/screens/persona_setup/widget/setup_name_step.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../persona_setup_notifier.dart';

class SetupNameStep extends StatefulWidget {
  final PersonaSetupNotifier notifier;

  const SetupNameStep({super.key, required this.notifier});

  @override
  State<SetupNameStep> createState() => _SetupNameStepState();
}

class _SetupNameStepState extends State<SetupNameStep> {
  late final TextEditingController _ctrl;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.notifier.userName);
    _ctrl.addListener(() {
      widget.notifier.userName = _ctrl.text;
      // rebuild parent CTA via notifier
      widget.notifier.notifyListeners();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepHeading(
          tag: 'STEP 1 OF 4',
          title: "What's your",
          accent: 'name?',
          subtitle: 'This is how your AI coach will address you.',
        ),
        const SizedBox(height: AppSpacing.xl3),

        Focus(
          onFocusChange: (f) => setState(() => _focused = f),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: _focused
                  ? [
                      BoxShadow(
                        color: AppColors.neonBlue.withOpacity(0.15),
                        blurRadius: 20,
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              controller: _ctrl,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              style: AppTextStyles.titleLG.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. Alex',
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  size: 18,
                  color: _focused ? AppColors.neonBlue : AppColors.textDisabled,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Character counter hint
        ValueListenableBuilder(
          valueListenable: _ctrl,
          builder: (_, __, ___) => AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _ctrl.text.isNotEmpty ? 1.0 : 0.0,
            child: Text(
              _ctrl.text.trim().length < 2
                  ? 'At least 2 characters'
                  : 'Looking good, ${_ctrl.text.trim().split(' ').first}!',
              style: AppTextStyles.caption.copyWith(
                color: _ctrl.text.trim().length < 2
                    ? AppColors.textDisabled
                    : AppColors.neonGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Shared heading widget used across all steps
class StepHeading extends StatelessWidget {
  final String tag;
  final String title;
  final String accent;
  final String subtitle;

  const StepHeading({
    required this.tag,
    required this.title,
    required this.accent,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.neonBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: AppColors.neonBlue.withOpacity(0.25)),
          ),
          child: Text(
            tag,
            style: AppTextStyles.labelSM.copyWith(color: AppColors.neonBlue),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        RichText(
          text: TextSpan(
            style: AppTextStyles.displayMD,
            children: [
              TextSpan(text: '$title '),
              WidgetSpan(
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (b) => const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                  child: Text(accent, style: AppTextStyles.displayMD),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(subtitle, style: AppTextStyles.bodyMD),
      ],
    );
  }
}
