import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/home/home_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const user = kMockUser;

    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1E2530), AppColors.bg100],
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
                          color: AppColors.bg300,
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
                      Text(user.name, style: AppTextStyles.displayMD),
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
                // XP Progress
                Text('Experience Points', style: AppTextStyles.titleSM),
                const SizedBox(height: 12),
                GlassCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user.xp} XP', style: AppTextStyles.labelLG),
                          Text(
                            '${user.xpToNext} XP',
                            style: AppTextStyles.labelSM,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: LinearProgressIndicator(
                          value: user.xpProgress,
                          minHeight: 8,
                          backgroundColor: AppColors.bg400,
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
                      child: _ProfileStatCard(
                        label: 'Day Streak',
                        value: '${user.streakDays}',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.neonAmber,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _ProfileStatCard(
                        label: 'Confidence',
                        value: '${(user.confidenceScore * 100).toInt()}',
                        icon: Icons.auto_awesome_rounded,
                        color: AppColors.neonBlue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl2),

                // Achievements
                Text('Achievements', style: AppTextStyles.titleSM),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _BadgeItem(
                        icon: Icons.emoji_events_rounded,
                        color: AppColors.neonAmber,
                        label: 'Early Bird',
                      ),
                      _BadgeItem(
                        icon: Icons.forum_rounded,
                        color: AppColors.neonBlue,
                        label: 'Chatty',
                      ),
                      _BadgeItem(
                        icon: Icons.bolt_rounded,
                        color: AppColors.neonPurple,
                        label: 'Consistent',
                      ),
                      _BadgeItem(
                        icon: Icons.shield_rounded,
                        color: AppColors.neonGreen,
                        label: 'Disciplined',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl2),

                // Settings
                Text('Account', style: AppTextStyles.titleSM),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Persona Profile',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.workspace_premium_rounded,
                  title: 'PersonaAI Premium',
                  color: AppColors.neonPurple,
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.logout_rounded,
                  title: 'Log Out',
                  color: AppColors.error,
                  onTap: () {},
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

class _ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ProfileStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.displayMD.copyWith(fontSize: 28)),
          Text(
            label,
            style: AppTextStyles.labelSM.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _BadgeItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.bg300,
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: color ?? AppColors.textSecondary,
            size: 20,
          ),
          title: Text(
            title,
            style: AppTextStyles.bodyMD.copyWith(color: color),
          ),
          trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        ),
      ),
    );
  }
}
