// lib/screens/profile/profile_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/home/home_model.dart';
import 'package:persona_ai/screens/profile/widgets/profile_detail_widgets.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final name = StorageHelper.userName.isEmpty
        ? kMockUser.name
        : StorageHelper.userName;

    return Scaffold(
      backgroundColor: AppColors.bg100,
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
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bg300,
                      border: Border.all(color: AppColors.neonBlue, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withValues(alpha: 0.15),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: const Text(
                      '🧑‍💻', // Fixed for now, could pull from setup
                      style: TextStyle(fontSize: 64),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.neonBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: AppColors.textInverse,
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
                    value: name,
                    onTap: () async {
                      final updated = await Navigator.pushNamed(
                        context,
                        AppRoutes.editProfile,
                      );
                      if (updated == true) setState(() {});
                    },
                  ),
                  const ProfileDetailDivider(),
                  ProfileDetailItem(
                    icon: Icons.alternate_email_rounded,
                    label: 'Email',
                    value: 'kartik@yopmail.com',
                    onTap: () async {
                      final updated = await Navigator.pushNamed(
                        context,
                        AppRoutes.editProfile,
                      );
                      if (updated == true) setState(() {});
                    },
                  ),
                  const ProfileDetailDivider(),
                  const ProfileDetailItem(
                    icon: Icons.workspace_premium_rounded,
                    label: 'Account Status',
                    value: 'Growth Initiate (Free)',
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
                    label: 'Archetype',
                    value: 'The Modern Stoic',
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.archetype),
                  ),
                  const ProfileDetailDivider(),
                  ProfileDetailItem(
                    icon: Icons.trending_up_rounded,
                    label: 'Primary Focus',
                    value: 'Confidence Building',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.focus),
                  ),
                  const ProfileDetailDivider(),
                  ProfileDetailItem(
                    icon: Icons.military_tech_rounded,
                    label: 'Experience Level',
                    value: 'Level ${kMockUser.level}',
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
                    value: '${kMockUser.streakDays}d',
                    color: AppColors.neonAmber,
                  ),
                  ProfileStatMini(
                    label: 'XP',
                    value: '${kMockUser.xp}',
                    color: AppColors.neonBlue,
                  ),
                  ProfileStatMini(
                    label: 'RANK',
                    value: '#128',
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
  }
}
