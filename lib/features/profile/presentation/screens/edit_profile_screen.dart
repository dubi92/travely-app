import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travely_app/shared/widgets/widgets.dart';
import '../../presentation/providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _picker = ImagePicker();
  
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
       final profile = ref.read(profileControllerProvider).value;
       if (profile != null) {
          _nameController.text = profile.fullName ?? '';
          _phoneController.text = profile.phone ?? '';
       }
       _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // This will trigger state update, resizing the build method
      await ref.read(profileControllerProvider.notifier).uploadAvatar(File(image.path));
    }
  }

  Future<void> _save() async {
    final profile = ref.read(profileControllerProvider).value;
    if (profile != null) {
      await ref.read(profileControllerProvider.notifier).updateProfile(
        profile.copyWith(
          fullName: _nameController.text,
          phone: _phoneController.text,
        ),
      );
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final isLoading = profileAsync.isLoading;
    final avatarUrl = profileAsync.value?.avatarUrl;

    return Scaffold(
      appBar: const AppAppBar(title: 'Edit Profile'),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24),
            children: [
               Center(
                 child: EditableAvatar(
                   imageUrl: avatarUrl,
                   initials: (_nameController.text.isNotEmpty ? _nameController.text : 'T').substring(0,1).toUpperCase(),
                   onEdit: _pickImage,
                   size: 100,
                 ),
               ),
               const SizedBox(height: 32),
               AppTextField(
                 label: 'Full Name',
                 controller: _nameController,
                 placeholder: 'Enter your full name',
               ),
               const SizedBox(height: 16),
               AppTextField(
                 label: 'Phone Number',
                 controller: _phoneController,
                 placeholder: '+1 234 567 8900',
                 keyboardType: TextInputType.phone,
               ),
               const SizedBox(height: 32),
               PrimaryButton(
                 text: 'Save Changes',
                 onPressed: isLoading ? null : _save,
                 isLoading: isLoading,
               )
            ],
          ),
          if (isLoading)
             Container(
               color: Colors.black12,
               child: const Center(child: LoadingIndicator()),
             ),
        ],
      ),
    );
  }
}
