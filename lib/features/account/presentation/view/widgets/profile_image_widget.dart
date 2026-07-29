import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';

class ProfileImageWidget extends StatelessWidget {
  final AccountCubit cubit;
  final UserEntity? userEntity;

  const ProfileImageWidget({
    super.key,
    required this.cubit,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Stack(
        children: [
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 4),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: cubit.selectedImagePath != null
                  ? Image.file(
                      File(cubit.selectedImagePath!),
                      fit: BoxFit.cover,
                    )
                  : (userEntity?.image != null && userEntity!.image.isNotEmpty)
                  ? Image.network(
                      userEntity!.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 60,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 60,
                      color: colorScheme.onSurfaceVariant,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
              onTap: () => cubit.doIntent(PickImageIntent()),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.surface, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: colorScheme.onPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
