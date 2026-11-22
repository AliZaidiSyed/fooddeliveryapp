
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';
import 'package:fooddeliveryapp/features/auth/data/services/auth.dart';
import 'package:fooddeliveryapp/features/auth/screens/onboarding.dart';
import 'package:fooddeliveryapp/providers/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileProvider _profileProvider =
  ProfileProvider();

  @override
  void initState() {
    super.initState();
    _profileProvider.loadProfile();
  }

  @override
  void dispose() {
    _profileProvider.dispose();
    super.dispose();
  }

  Future<void> _changeImage(
      ProfileProvider provider,
      ) async {
    try {
      final uploaded =
      await provider.changeProfileImage();

      if (!mounted) return;

      if (uploaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Profile image updated successfully',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
        ),
      );
    }
  }

  // Profile avatar with camera button.
  Widget _profileAvatar(
      ProfileProvider provider,
      ) {
    return SizedBox(
      width: 135,
      height: 135,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HotFlavourColors.softRed,
                border: Border.all(
                  color: HotFlavourColors.primary,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: provider.profileImageUrl != null &&
                    provider.profileImageUrl!.isNotEmpty
                    ? Image.network(
                  provider.profileImageUrl!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return const Icon(
                      Icons.person,
                      size: 65,
                      color: HotFlavourColors.primary,
                    );
                  },
                )
                    : const Icon(
                  Icons.person,
                  size: 65,
                  color: HotFlavourColors.primary,
                ),
              ),
            ),
          ),

          // Red camera button on right side.
          Positioned(
            right: 12,
            bottom: 15,
            child: Material(
              color: HotFlavourColors.primary,
              elevation: 3,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: provider.isUploadingImage
                    ? null
                    : () => _changeImage(provider),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: provider.isUploadingImage
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: HotFlavourColors.primary,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize:
                        title == 'Email' ? 13 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCard(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: HotFlavourColors.primary,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: HotFlavourColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await AuthMethod().SignOut();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Onboarding(),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      await AuthMethod().deleteUser();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Onboarding(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete account failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>.value(
      value: _profileProvider,
      child: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        'Profile',
                        style: AppWidget.HeadlineTextField(),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: HotFlavourColors.cream,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),

                            _profileAvatar(provider),

                            const SizedBox(height: 30),

                            _infoCard(
                              Icons.person_outline,
                              'Name',
                              provider.name ?? 'No Name',
                            ),

                            const SizedBox(height: 30),

                            _infoCard(
                              Icons.email_outlined,
                              'Email',
                              provider.email ?? 'No Email',
                            ),

                            const SizedBox(height: 30),

                            _actionCard(
                              Icons.logout,
                              'Logout',
                              _logout,
                            ),

                            const SizedBox(height: 35),

                            _actionCard(
                              Icons.delete,
                              'Delete Account',
                              _deleteAccount,
                            ),

                            const SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
