import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app_theme.dart';
import '../core/profiles/avatars.dart';
import '../core/profiles/profile.dart';
import '../core/profiles/profile_providers.dart';
import 'avatar_button.dart';

class ProfileManager extends ConsumerStatefulWidget {
  const ProfileManager({super.key});

  static const maxNickname = 12;
  static const nicknameKey = ValueKey('nickname');
  static const addKey = ValueKey('add-profile');

  @override
  ConsumerState<ProfileManager> createState() => _ProfileManagerState();
}

class _ProfileManagerState extends ConsumerState<ProfileManager> {
  final _nickname = TextEditingController();
  String _avatar = Avatars.all.first;

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final nickname = _nickname.text.trim();
    if (nickname.isEmpty) return;
    await ref.read(profileStoreProvider).create(nickname: nickname, avatar: _avatar);
    _nickname.clear();
    ref.invalidate(profilesProvider);
  }

  Future<void> _delete(Profile profile) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¿Borrar a ${profile.nickname}?'),
        content: const Text('Se borra también todo su progreso.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(
            key: const ValueKey('confirm-delete'),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (ref.read(activeProfileProvider)?.profile.id == profile.id) {
      ref.read(activeProfileProvider.notifier).leave();
    }
    await ref.read(profileStoreProvider).delete(profile);
    ref.invalidate(profilesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(profilesProvider).value ?? const [];
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _heading('Perfiles'),
        if (profiles.isEmpty) const Text('Todavía no hay perfiles.'),
        for (final profile in profiles)
          ListTile(
            leading: AvatarButton(avatar: profile.avatar, onPressed: null, size: 48),
            title: Text(profile.nickname, style: const TextStyle(fontSize: 20)),
            trailing: IconButton(
              key: ValueKey('delete-${profile.id}'),
              tooltip: 'Borrar',
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => _delete(profile),
            ),
          ),
        const SizedBox(height: 24),
        _heading('Agregar un perfil'),
        TextField(
          key: ProfileManager.nicknameKey,
          controller: _nickname,
          maxLength: ProfileManager.maxNickname,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Apodo',
            helperText: 'No hace falta el nombre real.',
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final avatar in Avatars.all)
              AvatarButton(
                key: ValueKey('avatar-$avatar'),
                avatar: avatar,
                size: 72,
                isSelected: avatar == _avatar,
                onPressed: () => setState(() => _avatar = avatar),
              ),
          ],
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            key: ProfileManager.addKey,
            onPressed: _add,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Agregar'),
          ),
        ),
      ],
    );
  }

  Widget _heading(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.outline),
    ),
  );
}
