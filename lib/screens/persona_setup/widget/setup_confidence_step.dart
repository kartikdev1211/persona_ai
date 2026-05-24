// lib/screens/persona_setup/widget/setup_confidence_step.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../persona_setup_notifier.dart';
import 'setup_name_step.dart';

const _kLevels = [
  (
    label: 'Beginner',
    desc: 'I struggle in most social situations',
    emoji: '🌱',
  ),
  (
    label: 'Developing',
    desc: 'I manage but have clear weak spots',
    emoji: '🌿',
  ),
  (label: 'Intermediate', desc: 'Comfortable most of the time', emoji: '🌳'),
  (label: 'Confident', desc: 'I own most rooms I walk into', emoji: '🔥'),
  (label: 'Elite', desc: 'I want to sharpen my edge further', emoji: '⚡'),
];

class SetupConfidenceStep extends StatefulWidget {
  final PersonaSetupNotifier notifier;

  const SetupConfidenceStep({super.key, required this.notifier});

  @override
  State<SetupConfidenceStep> createState() => _SetupConfidenceStepState();
}

class _SetupConfidenceStepState extends State<SetupConfidenceStep> {
  double _value = 0.5;

  @override
  void initState() {
    super.initState();
    _value = widget.notifier.confidenceLevel;
  }

  int get _levelIndex => (_value * 4).round().clamp(0, 4);

  Color get _trackColor {
    if (_levelIndex <= 1) return AppColors.neonBlue;
    if (_levelIndex <= 2) return AppColors.neonGreen;
    if (_levelIndex <= 3) return AppColors.neonAmber;
    return AppColors.neonPink;
  }

  @override
  Widget build(BuildContext context) {
    final level = _kLevels[_levelIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepHeading(
          tag: 'STEP 3 OF 4',
          title: 'Your current',
          accent: 'confidence',
          subtitle:
              'Be honest — your AI coach uses this to calibrate your daily missions.',
        ),
        const SizedBox(height: AppSpacing.xl3),

        // Level card
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.bg300,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: _trackColor.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(color: _trackColor.withOpacity(0.12), blurRadius: 24),
            ],
          ),
          child: Row(
            children: [
              Text(level.emoji, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.label,
                      style: AppTextStyles.titleMD.copyWith(color: _trackColor),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(level.desc, style: AppTextStyles.bodySM),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xl2),

        // Custom slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            activeTrackColor: _trackColor,
            inactiveTrackColor: AppColors.bg400,
            thumbColor: _trackColor,
            overlayColor: _trackColor.withOpacity(0.15),
          ),
          child: Slider(
            value: _value,
            onChanged: (v) {
              setState(() => _value = v);
              widget.notifier.confidenceLevel = v;
            },
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Level labels row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _kLevels.asMap().entries.map((e) {
            final isActive = e.key == _levelIndex;
            return AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: isActive
                  ? AppTextStyles.labelSM.copyWith(color: _trackColor)
                  : AppTextStyles.caption,
              child: Text(e.value.label),
            );
          }).toList(),
        ),
      ],
    );
  }
}
