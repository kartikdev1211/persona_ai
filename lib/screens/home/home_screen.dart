// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/common_widget/section_header.dart';
import 'package:persona_ai/models/home/home_model.dart';
import 'widget/goal_progress_row.dart';
import 'widget/home_header.dart';
import 'widget/insight_card.dart';
import 'package:persona_ai/common_widget/mission_card.dart';
import 'widget/quick_actions.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

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

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeStarted()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is HomeFailure) {
            return Scaffold(body: Center(child: Text(state.message)));
          }

          if (state is HomeLoaded) {
            return _buildContent(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeLoaded state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    AppColors.neonBlue.withOpacity(isDark ? 0.07 : 0.04),
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
                    child: HomeHeader(user: state.user),
                  ),
                ),

                _sliver(height: AppSpacing.xl2),

                // ── Quick actions ─────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                    ),
                    child: QuickActions(),
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
                      actionLabel: _missionSubtitle(state),
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
                      final mission = state.missions[i];
                      final isLocallyCompleted = state.completedIndices
                          .contains(i);
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
                          onTap: () {
                            context.read<HomeBloc>().add(HomeMissionTapped(i));
                          },
                        ),
                      );
                    }, childCount: state.missions.length),
                  ),
                ),

                // ── Goal progress ─────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
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
                    child: GoalProgressRow(goals: state.goals),
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
                    child: InsightCard(insights: state.insights),
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

  String _missionSubtitle(HomeLoaded state) {
    final total = state.missions.length;
    final completedCount =
        state.missions.where((m) => m.isCompleted).length +
        state.completedIndices.difference({2}).length;
    return '$completedCount/$total done';
  }

  SliverToBoxAdapter _sliver({required double height}) =>
      SliverToBoxAdapter(child: SizedBox(height: height));
}
