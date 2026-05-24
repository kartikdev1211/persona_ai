// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/common_widget/section_header.dart';
import 'package:persona_ai/models/home/home_model.dart';
import 'widget/goal_progress_row.dart';
import 'widget/home_header.dart';
import 'widget/insight_card.dart';
import 'widget/mission_card.dart';
import 'widget/quick_actions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  // Keep alive inside IndexedStack
  @override
  bool get wantKeepAlive => true;

  final _scrollCtrl = ScrollController();

  // Track completed missions locally
  final Set<int> _completedIndices = {2}; // index 2 pre-completed from model

  void _onMissionTap(int index) {
    if (kTodayMissions[index].isCompleted) return;
    setState(() => _completedIndices.add(index));
  }

  int get _completedCount =>
      kTodayMissions.where((m) => m.isCompleted).length +
      _completedIndices.difference({2}).length;

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Stack(
        children: [
          // ── Ambient top glow ──────────────────
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.neonBlue.withOpacity(0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Main scrollable content ───────────
          SafeArea(
            child: CustomScrollView(
              controller: _scrollCtrl,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Header ───────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH,
                      AppSpacing.lg,
                      AppSpacing.screenH,
                      0,
                    ),
                    child: HomeHeader(user: kMockUser),
                  ),
                ),

                _sliver(height: AppSpacing.xl2),

                // ── Quick actions ─────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: const QuickActions(),
                  ),
                ),

                _sliver(height: AppSpacing.xl2),

                // ── Today's missions ─────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: SectionHeader(
                      title: "Today's Missions",
                      actionLabel: _missionSubtitle,
                    ),
                  ),
                ),

                _sliver(height: AppSpacing.md),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      final mission = kTodayMissions[i];
                      final isLocallyCompleted = _completedIndices.contains(i);
                      final effectiveMission = isLocallyCompleted
                          ? DailyMission(
                              title: mission.title,
                              description: mission.description,
                              category: mission.category,
                              xpReward: mission.xpReward,
                              durationMinutes: mission.durationMinutes,
                              icon: mission.icon,
                              gradient: mission.gradient,
                              isCompleted: true,
                            )
                          : mission;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: MissionCard(
                          mission: effectiveMission,
                          onTap: () => _onMissionTap(i),
                        ),
                      );
                    }, childCount: kTodayMissions.length),
                  ),
                ),

                // ── Goal progress ─────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: SectionHeader(title: 'Goal Progress'),
                  ),
                ),

                _sliver(height: AppSpacing.md),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: GoalProgressRow(goals: kGoalProgresses),
                  ),
                ),

                _sliver(height: AppSpacing.xl2),

                // ── AI Insight ────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: SectionHeader(
                      title: 'AI Insight',
                      actionLabel: 'Tap to cycle',
                    ),
                  ),
                ),

                _sliver(height: AppSpacing.md),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: InsightCard(insights: kInsights),
                  ),
                ),

                _sliver(height: AppSpacing.xl3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _missionSubtitle {
    final total = kTodayMissions.length;
    return '$_completedCount/$total done';
  }

  SliverToBoxAdapter _sliver({required double height}) =>
      SliverToBoxAdapter(child: SizedBox(height: height));
}
