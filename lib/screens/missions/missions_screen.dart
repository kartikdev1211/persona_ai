import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/mission_card.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/models/home/home_model.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Confidence',
    'Social Skills',
    'Grooming',
    'Mindset',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        title: Text('Missions', style: AppTextStyles.displayMD),
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: AppColors.neonBlue,
          labelColor: AppColors.neonBlue,
          unselectedLabelColor: AppColors.textDisabled,
          dividerColor: AppColors.glassBorder,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _MissionsList(
            missions: kTodayMissions.where((m) => !m.isCompleted).toList(),
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
          ),
          _MissionsList(
            missions: kTodayMissions.where((m) => m.isCompleted).toList(),
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
            isHistory: true,
          ),
        ],
      ),
    );
  }
}

class _MissionsList extends StatelessWidget {
  final List<DailyMission> missions;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final bool isHistory;

  const _MissionsList({
    required this.missions,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.isHistory = false,
  });

  @override
  Widget build(BuildContext context) {
    final filteredMissions = selectedCategory == 'All'
        ? missions
        : missions.where((m) => m.category == selectedCategory).toList();

    return Column(
      children: [
        // Category Selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (_) => onCategoryChanged(cat),
                  backgroundColor: AppColors.bg200,
                  selectedColor: AppColors.neonBlue.withOpacity(0.15),
                  labelStyle: AppTextStyles.labelSM.copyWith(
                    color: isSelected
                        ? AppColors.neonBlue
                        : AppColors.textSecondary,
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.neonBlue.withOpacity(0.5)
                        : AppColors.glassBorder,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  showCheckmark: false,
                ),
              );
            }).toList(),
          ),
        ),

        // List
        Expanded(
          child: filteredMissions.isEmpty
              ? _EmptyState(isHistory: isHistory)
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenH,
                  ),
                  itemCount: filteredMissions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: MissionCard(mission: filteredMissions[index]),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isHistory;
  const _EmptyState({required this.isHistory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isHistory ? Icons.history_rounded : Icons.bolt_rounded,
            size: 48,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: 16),
          Text(
            isHistory ? 'No completed missions yet' : 'All caught up!',
            style: AppTextStyles.titleMD.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isHistory
                ? 'Finish your first mission to see it here.'
                : 'Check back later for new challenges.',
            style: AppTextStyles.bodySM,
          ),
        ],
      ),
    );
  }
}
