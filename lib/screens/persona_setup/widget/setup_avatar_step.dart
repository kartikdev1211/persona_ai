// lib/screens/persona_setup/widget/setup_avatar_step.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import '../bloc/bloc/persona_setup_bloc.dart';
import '../bloc/event/persona_setup_event.dart';
import '../bloc/state/persona_setup_state.dart';
import 'setup_name_step.dart';

class SetupAvatarStep extends StatelessWidget {
  const SetupAvatarStep({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      if (Platform.isAndroid) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    }

    if (status.isGranted || status.isLimited || !Platform.isAndroid) {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        context.read<PersonaSetupBloc>().add(ImageSelected(image.path));
      }
    } else if (status.isPermanentlyDenied && context.mounted) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonaSetupBloc, PersonaSetupState>(
      builder: (context, state) {
        final firstName = state.userName.trim().split(' ').first;
        final imagePath = state.selectedImagePath;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepHeading(
              tag: 'STEP 2 OF 4',
              title: 'Upload your',
              accent: 'avatar',
              subtitle: firstName.isNotEmpty
                  ? 'Add a photo so we can recognize you, $firstName.'
                  : 'Add a photo so we can recognize you.',
            ),
            const SizedBox(height: AppSpacing.xl3),

            // Image Preview
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bg300,
                      border: Border.all(
                        color: AppColors.neonBlue.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      image: imagePath != null
                          ? DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: imagePath == null
                        ? Icon(
                            Icons.person_rounded,
                            size: 60,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.2),
                          )
                        : null,
                  ),
                  if (imagePath != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => context.read<PersonaSetupBloc>().add(
                          ImageSelected(''),
                        ), // Or some way to clear
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl3),

            // Pick buttons
            Row(
              children: [
                Expanded(
                  child: _PickButton(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () => _pickImage(context, ImageSource.camera),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _PickButton(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () => _pickImage(context, ImageSource.gallery),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _PickButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.neonBlue, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.labelLG.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
