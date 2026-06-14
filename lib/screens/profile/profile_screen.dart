import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/core/theme/theme_bloc.dart';
import 'package:persona_ai/core/network/repository/auth_repository.dart';
import 'package:persona_ai/core/utils/ui_utils.dart';
import 'package:persona_ai/screens/profile/bloc/bloc/profile_bloc.dart';
import 'package:persona_ai/screens/profile/bloc/event/profile_event.dart';
import 'package:persona_ai/screens/profile/bloc/state/profile_state.dart';
import 'package:persona_ai/screens/profile/widgets/badge_items.dart';
import 'package:persona_ai/screens/profile/widgets/profile_stat_card.dart';
import 'package:persona_ai/screens/profile/widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _confirmDelete(BuildContext context) {
    final passwordController = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          children: [
            const Text(
              'This action is permanent and will erase all your progress. Please enter your password to confirm.',
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: passwordController,
              placeholder: 'Password',
              obscureText: true,
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              context.read<ProfileBloc>().add(
                DeleteAccountRequested(passwordController.text),
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.accountDeleted) {
          StorageHelper.clearUserSession();
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.onboarding, (route) => false);
        }
        if (state.status == ProfileStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.profile;
        final persona = state.persona;
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Failed to load profile')),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF1E2530),
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.surface,
                              border: Border.all(
                                color: AppColors.neonBlue,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: user.avatarUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: user.avatarUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.person,
                                            size: 40,
                                            color: AppColors.neonBlue,
                                          ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: AppColors.neonBlue,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            user.fullName,
                            style: AppTextStyles.displayMD.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Level ${user.level} ${user.levelTitle}',
                            style: AppTextStyles.labelSM.copyWith(
                              color: AppColors.neonBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.screenH),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      'Experience Points',
                      style: AppTextStyles.titleSM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GlassCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${user.xp} XP',
                                style: AppTextStyles.labelLG.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '${user.xpRequired} XP',
                                style: AppTextStyles.labelSM.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            child: LinearProgressIndicator(
                              value: user.xp / user.xpRequired,
                              minHeight: 8,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.outline,
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.neonBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl2),

                    // Streak & Stats
                    Row(
                      children: [
                        Expanded(
                          child: ProfileStatCard(
                            label: 'Day Streak',
                            value: '${user.dayStreak}',
                            icon: Icons.local_fire_department_rounded,
                            color: AppColors.neonAmber,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ProfileStatCard(
                            label: 'Confidence',
                            value: '${user.confidenceScore}',
                            icon: Icons.auto_awesome_rounded,
                            color: AppColors.neonBlue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xl2),

                    Text(
                      'Achievements',
                      style: AppTextStyles.titleSM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    user.achievements.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                'No achievements yet. Keep growing!',
                                style: AppTextStyles.bodySM.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: user.achievements.length,
                              itemBuilder: (context, index) {
                                return BadgeItem(
                                  icon: Icons.emoji_events_rounded,
                                  color: AppColors.neonAmber,
                                  label: user.achievements[index],
                                );
                              },
                            ),
                          ),

                    const SizedBox(height: AppSpacing.xl2),

                    Text(
                      'Personality Attributes',
                      style: AppTextStyles.titleSM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.auto_awesome_rounded,
                      title: 'Persona Name',
                      trailing: Text(
                        persona?.personaName ?? 'Not Set',
                        style: AppTextStyles.labelSM.copyWith(
                          color: AppColors.neonBlue,
                        ),
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profileDetail),
                    ),
                    SettingsTile(
                      icon: Icons.trending_up_rounded,
                      title: 'Primary Focus',
                      trailing: Text(
                        persona?.focusGoal ?? 'Growth',
                        style: AppTextStyles.labelSM.copyWith(
                          color: AppColors.neonBlue,
                        ),
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profileDetail),
                    ),
                    SettingsTile(
                      icon: Icons.military_tech_rounded,
                      title: 'Confidence Level',
                      trailing: Text(
                        persona?.confidenceLevel ?? 'Beginner',
                        style: AppTextStyles.labelSM.copyWith(
                          color: AppColors.neonBlue,
                        ),
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profileDetail),
                    ),

                    const SizedBox(height: AppSpacing.xl2),

                    Text(
                      'Settings & Account',
                      style: AppTextStyles.titleSM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Persona Profile',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profileDetail),
                    ),

                    // Dark Mode Toggle
                    BlocBuilder<ThemeBloc, ThemeMode>(
                      builder: (context, mode) {
                        return SettingsTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          onTap: () =>
                              context.read<ThemeBloc>().add(ToggleTheme()),
                          trailing: CupertinoSwitch(
                            value: mode == ThemeMode.dark,
                            activeTrackColor: AppColors.neonBlue,
                            onChanged: (_) =>
                                context.read<ThemeBloc>().add(ToggleTheme()),
                          ),
                        );
                      },
                    ),

                    // Notifications Toggle
                    SettingsTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () {
                        context.read<ProfileBloc>().add(
                          UpdateNotificationPreference(
                            !user.notificationsEnabled,
                          ),
                        );
                      },
                      trailing: CupertinoSwitch(
                        value: user.notificationsEnabled,
                        activeTrackColor: AppColors.neonBlue,
                        onChanged: (val) {
                          context.read<ProfileBloc>().add(
                            UpdateNotificationPreference(val),
                          );
                        },
                      ),
                    ),

                    SettingsTile(
                      icon: Icons.workspace_premium_rounded,
                      title: 'PersonaAI Premium',
                      color: AppColors.neonPurple,
                      onTap: () {},
                    ),

                    SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      color: AppColors.textDisabled,
                      onTap: () async {
                        UIUtils.showLoader(context);
                        await AuthRepository().logout();
                        if (context.mounted) {
                          UIUtils.hideLoader(context);
                          StorageHelper.isLoggedIn = false;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.auth,
                            (route) => false,
                          );
                        }
                      },
                    ),

                    SettingsTile(
                      icon: Icons.delete_outline_rounded,
                      title: 'Delete Account',
                      color: AppColors.error,
                      onTap: () => _confirmDelete(context),
                    ),

                    const SizedBox(height: AppSpacing.xl3),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
