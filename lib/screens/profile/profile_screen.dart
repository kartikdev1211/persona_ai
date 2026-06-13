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
import 'package:persona_ai/models/home/home_model.dart';
import 'package:persona_ai/screens/profile/widgets/badge_items.dart';
import 'package:persona_ai/screens/profile/widgets/profile_stat_card.dart';
import 'package:persona_ai/screens/profile/widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = StorageHelper.notificationsEnabled;

  void _confirmDelete() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action is permanent and will erase all your progress. Are you sure?',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await StorageHelper.clearUserSession();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.onboarding,
                  (route) => false,
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const user = kMockUser;

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
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                          border: Border.all(
                            color: AppColors.neonBlue,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          user.avatarEmoji,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.name,
                        style: AppTextStyles.displayMD.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Level ${user.level} Growth Initiate',
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
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '${user.xpToNext} XP',
                            style: AppTextStyles.labelSM.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: LinearProgressIndicator(
                          value: user.xpProgress,
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
                        value: '${user.streakDays}',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.neonAmber,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: ProfileStatCard(
                        label: 'Confidence',
                        value: '${(user.confidenceScore * 100).toInt()}',
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
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BadgeItem(
                        icon: Icons.emoji_events_rounded,
                        color: AppColors.neonAmber,
                        label: 'Early Bird',
                      ),
                      BadgeItem(
                        icon: Icons.forum_rounded,
                        color: AppColors.neonBlue,
                        label: 'Chatty',
                      ),
                      BadgeItem(
                        icon: Icons.bolt_rounded,
                        color: AppColors.neonPurple,
                        label: 'Consistent',
                      ),
                      BadgeItem(
                        icon: Icons.shield_rounded,
                        color: AppColors.neonGreen,
                        label: 'Disciplined',
                      ),
                    ],
                  ),
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
                      onTap: () => context.read<ThemeBloc>().add(ToggleTheme()),
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
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                      StorageHelper.notificationsEnabled =
                          _notificationsEnabled;
                    });
                  },
                  trailing: CupertinoSwitch(
                    value: _notificationsEnabled,
                    activeTrackColor: AppColors.neonBlue,
                    onChanged: (val) {
                      setState(() {
                        _notificationsEnabled = val;
                        StorageHelper.notificationsEnabled = val;
                      });
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
                    StorageHelper.isLoggedIn = false;
                    await StorageHelper.clearUserSession();
                    if (mounted) {
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
                  onTap: _confirmDelete,
                ),

                const SizedBox(height: AppSpacing.xl3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
