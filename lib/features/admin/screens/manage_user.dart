
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fooddeliveryapp/core/services/database.dart';
import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';
import 'package:fooddeliveryapp/providers/manage_users_provider.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  final ManageUsersProvider _screenProvider =
  ManageUsersProvider();

  @override
  void initState() {
    super.initState();
    _screenProvider.loadUsers();
  }

  @override
  void dispose() {
    _screenProvider.dispose();
    super.dispose();
  }

  Widget _defaultPersonIcon() {
    return const Icon(
      Icons.person,
      color: HotFlavourColors.primary,
      size: 44,
    );
  }

  Widget _userAvatar(String? imageUrl) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HotFlavourColors.softRed,
        border: Border.all(
          color: HotFlavourColors.primary,
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: imageUrl == null || imageUrl.isEmpty
            ? _defaultPersonIcon()
            : Image.network(
          imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return _defaultPersonIcon();
          },
        ),
      ),
    );
  }

  Future<void> _removeUser(String userId) async {
    try {
      await DataBaseMethods().DeleteUser(userId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User removed successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Remove failed: $e'),
        ),
      );
    }
  }

  Widget _userCard(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    final name = (data['Name'] ?? 'No Name').toString();
    final email = (data['Email'] ?? 'No Email').toString();

    final String? imageUrl =
    data['ProfileImageUrl'] is String
        ? data['ProfileImageUrl'] as String
        : null;

    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _userAvatar(imageUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: HotFlavourColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            name,
                            style:
                            AppWidget.boldTextFieldStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: HotFlavourColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            email,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () => _removeUser(document.id),
                      child: Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Remove',
                          style:
                          AppWidget.WhiteTextFieldStyle(),
                        ),
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

  Widget _allUsers(ManageUsersProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Text(provider.error!),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: provider.users,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Unable to load users: ${snapshot.error}',
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final documents = snapshot.data!.docs;

        if (documents.isEmpty) {
          return const Center(
            child: Text('No users available'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            return _userCard(documents[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManageUsersProvider>.value(
      value: _screenProvider,
      child: Consumer<ManageUsersProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 12,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: const BoxDecoration(
                              color: HotFlavourColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Text(
                            'Current Users',
                            style:
                            AppWidget.HeadlineTextField(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: HotFlavourColors.cream,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: _allUsers(provider),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
