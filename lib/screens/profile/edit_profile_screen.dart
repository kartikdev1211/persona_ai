// lib/screens/profile/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/common_widget/glass_card.dart';
import 'package:persona_ai/common_widget/gradient_button.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/app_text_styles.dart';
import 'package:persona_ai/core/theme/spacing.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: StorageHelper.userName);
    _emailController = TextEditingController(
      text: 'alex@persona-ai.com',
    ); // Mock email for now
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate saving delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Update storage
    StorageHelper.userName = _nameController.text.trim();

    if (mounted) {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile updated successfully!',
            style: AppTextStyles.bodySM.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.neonGreen.withValues(alpha: 0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context, true); // Return true to indicate change
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Edit Profile', style: AppTextStyles.titleLG),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details',
                style: AppTextStyles.labelSM.copyWith(
                  color: AppColors.neonBlue,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Enter your name',
                      icon: Icons.person_outline_rounded,
                      validator: (v) {
                        if (v == null || v.trim().length < 2)
                          return 'Please enter at least 2 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'your@email.com',
                      icon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Please enter your email';
                        if (!v.contains('@') || !v.contains('.'))
                          return 'Please enter a valid email';
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl3),

              GradientButton(
                label: _isLoading ? 'Saving...' : 'Save Changes',
                onTap: _isLoading ? () {} : _saveChanges,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSM.copyWith(color: AppColors.textDisabled),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: AppTextStyles.titleSM,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              size: 20,
              color: AppColors.neonBlue.withValues(alpha: 0.7),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}
