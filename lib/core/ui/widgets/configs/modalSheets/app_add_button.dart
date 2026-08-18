import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

/// Кнопка "+" — по нажатию открывает дропдаун с 4 способами добавить конфиг.
/// Вставляешь вместо своей текущей кнопки-плюсика в ряду иконок.
///
/// Что делает сама:
///  - "Paste via clipboard" — реально читает буфер обмена и отдаёт текст наружу
///  - "Add via URL" — показывает диалог с полем ввода, отдаёт введённый URL
///
/// Что нужно подключить у себя (требуют доп. пакеты, поэтому просто колбэк):
///  - "QR code" — например через пакет mobile_scanner
///  - "Add via file" — например через пакет file_picker

class AppAddConfigsButton extends StatefulWidget {
  final ValueChanged<String> onConfigString; // пришла строка конфига (из URL/clipboard)
  final VoidCallback onScanQr;
  final VoidCallback onPickFile;

  const AppAddConfigsButton({
    super.key,
    required this.onConfigString,
    required this.onScanQr,
    required this.onPickFile,
  });

  @override
  State<AppAddConfigsButton> createState() => _AppAddConfigsButtonState();
}

class _AppAddConfigsButtonState extends State<AppAddConfigsButton> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _toggle() {
    if (_entry != null) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    _entry = _buildOverlay();
    Overlay.of(context).insert(_entry!);
  }

  void _close() {
    _entry?.remove();
    _entry = null;
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _close,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              targetAnchor: .bottomRight,
              followerAnchor: .topRight,
              offset: Offset(0, 8),
              child: Material(
                color: Colors.transparent,
                child: _AddConfigMenu(
                  onScanQr: () {
                    _close();
                    widget.onScanQr();
                  },
                  onPasteClipboard: () async {
                    _close();
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    final text = data?.text?.trim();
                    if (text != null && text.isNotEmpty) {
                      widget.onConfigString(text);
                    } else if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Буфер обмена пуст')),
                      );
                    }
                  },
                  onAddUrl: () async {
                    _close();
                    final url = await _showUrlInputDialog(context);
                    if (url != null && url.trim().isNotEmpty) {
                      widget.onConfigString(url.trim());
                    }
                  },
                  onAddFile: () {
                    _close();
                    widget.onPickFile();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _showUrlInputDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Color(0xFF17171A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Add via URL', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'https://...',
              hintStyle: TextStyle(color: Color(0xFF8A8A90)),
              filled: true,
              fillColor: Color(0xFF1A1A1D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2A2A2E)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2A2A2E)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF8A8A90))),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: _toggle,
        child: Container(
          height: 32.fh,
          width: 32.fw,
          decoration: BoxDecoration(
            color: AppColors.ghostButtonBackground,
            border: .all(color: AppColors.ghostButtonBorder),
            borderRadius: BorderRadius.circular(8.r),
          ),
          margin: po(l: 6),
          padding: pa(5),
          child: SvgPicture.asset('assets/icons/plus.svg', color: AppColors.contentPrimary),
        ),
      ),
    );
  }
}

class _AddConfigMenu extends StatelessWidget {
  final VoidCallback onScanQr;
  final VoidCallback onPasteClipboard;
  final VoidCallback onAddUrl;
  final VoidCallback onAddFile;

  const _AddConfigMenu({
    required this.onScanQr,
    required this.onPasteClipboard,
    required this.onAddUrl,
    required this.onAddFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: Color(0xff1c1c1c),
        borderRadius: .circular(16),
        border: .all(color: Color(0xff2a2a2a)),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      padding: .symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuItem(
            icon: Icons.qr_code_scanner,
            label: 'Scan QR code',
            onTap: onScanQr,
          ),
          _MenuItem(
            icon: Icons.content_paste,
            label: 'Paste via clipboard',
            onTap: onPasteClipboard,
          ),
          _MenuItem(
            icon: Icons.link,
            label: 'Add via URL',
            onTap: onAddUrl,
          ),
          _MenuItem(
            icon: Icons.insert_drive_file_outlined,
            label: 'Add via file',
            onTap: onAddFile,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: .symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 19, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14.5),
            ),
          ],
        ),
      ),
    );
  }
}