// lib/screens/profile/profile_detail_screen.dart

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/profile/bloc/bloc/profile_bloc.dart';
import 'package:persona_ai/screens/profile/bloc/event/profile_event.dart';
import 'package:persona_ai/screens/profile/bloc/state/profile_state.dart';
import 'package:persona_ai/screens/profile/widgets/profile_detail_widgets.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      // For gallery, it depends on Android version.
      // On many devices, image_picker handles this or it doesn't need explicit 'photos' permission.
      // However, we check storage/photos for safety.
      if (Platform.isAndroid) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    }

    if (status.isGranted || status.isLimited || !Platform.isAndroid) {
      // On Android, sometimes status might not be 'granted' but picker still works for gallery
      // So we proceed if it's not permanently denied, or just let image_picker handle its own errors.
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        context.read<ProfileBloc>().add(UpdateAvatar(image.path));
      }
    } else if (status.isPermanentlyDenied && context.mounted) {
      openAppSettings();
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Update Profile Picture', style: AppTextStyles.titleMD),
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ImageSourceButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    _pickImage(context, ImageSource.camera);
                  },
                ),
                _ImageSourceButton(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        final persona = state.persona;

        if (profile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Persona Profile', style: AppTextStyles.titleLG),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.screenH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Header
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
                            color: AppColors.neonBlue,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neonBlue.withValues(alpha: 0.15),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: profile.avatarUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: profile.avatarUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.person,
                                        size: 64,
                                        color: AppColors.neonBlue,
                                      ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 64,
                                  color: AppColors.neonBlue,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => _showImageSourceActionSheet(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.neonBlue,
                              shape: BoxShape.circle,
                            ),
                            child: state.status == ProfileStatus.updating
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 18,
                                    color: AppColors.textInverse,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl3),

                const ProfileSectionHeader(title: 'Basic Information'),
                const SizedBox(height: AppSpacing.md),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ProfileDetailItem(
                        icon: Icons.person_outline_rounded,
                        label: 'Display Name',
                        value: profile.fullName,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.editProfile),
                      ),
                      const ProfileDetailDivider(),
                      ProfileDetailItem(
                        icon: Icons.alternate_email_rounded,
                        label: 'Status',
                        value: 'Connected',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.editProfile),
                      ),
                      const ProfileDetailDivider(),
                      ProfileDetailItem(
                        icon: Icons.workspace_premium_rounded,
                        label: 'Account Status',
                        value: '${profile.levelTitle} (Free)',
                        valueColor: AppColors.neonBlue,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl2),

                const ProfileSectionHeader(title: 'Personality Attributes'),
                const SizedBox(height: AppSpacing.md),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ProfileDetailItem(
                        icon: Icons.auto_awesome_rounded,
                        label: 'Persona Name',
                        value: persona?.personaName ?? 'Not Set',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.archetype),
                      ),
                      const ProfileDetailDivider(),
                      ProfileDetailItem(
                        icon: Icons.trending_up_rounded,
                        label: 'Primary Focus',
                        value: persona?.focusGoal ?? 'Growth',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.focus),
                      ),
                      const ProfileDetailDivider(),
                      ProfileDetailItem(
                        icon: Icons.military_tech_rounded,
                        label: 'Confidence Level',
                        value: persona?.confidenceLevel ?? 'Beginner',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.experience),
                      ),
                      const ProfileDetailDivider(),
                      ProfileDetailItem(
                        icon: Icons.workspace_premium_rounded,
                        label: 'Experience Level',
                        value: 'Level ${profile.level}',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.experience),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl2),

                const ProfileSectionHeader(title: 'Growth Summary'),
                const SizedBox(height: AppSpacing.md),
                GlassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileStatMini(
                        label: 'STREAK',
                        value: '${profile.dayStreak}d',
                        color: AppColors.neonAmber,
                      ),
                      ProfileStatMini(
                        label: 'XP',
                        value: '${profile.xp}',
                        color: AppColors.neonBlue,
                      ),
                      ProfileStatMini(
                        label: 'CONFIDENCE',
                        value: '${profile.confidenceScore}',
                        color: AppColors.neonPurple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl3),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.bg300,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.neonBlue.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, color: AppColors.neonBlue, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelLG),
        ],
      ),
    );
  }
}
