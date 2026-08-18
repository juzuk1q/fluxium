import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Fluxium/core/ui/theme/app_colors.dart';
import 'package:vize/vize.dart';

/// ============ МОДЕЛЬ РЕЗУЛЬТАТА ФИЛЬТРА ============
class FilterResult {
  final String sortValue;
  final Set<String> protocols;
  final String pingOrder;
  final int? minPing;
  final int? maxPing;
  final Set<String> countries;

  const FilterResult({
    required this.sortValue,
    required this.protocols,
    required this.pingOrder,
    required this.minPing,
    required this.maxPing,
    required this.countries,
  });
}

class AppFilter extends StatefulWidget {
  final List<String> availableCountries;
  final ValueChanged<FilterResult>? onApply;

  const AppFilter({
    super.key,
    this.availableCountries = const [],
    this.onApply,
  });

  @override
  State<AppFilter> createState() => _AppFilterState();
}

class _AppFilterState extends State<AppFilter> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<FilterResult>(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => _FilterSheet(
            availableCountries: widget.availableCountries,
          ),
        );
        if (result != null) widget.onApply?.call(result);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: AppColors.ghostButtonBackground,
          border: .all(color: AppColors.ghostButtonBorder),
          borderRadius: .circular(8.r),
        ),
        margin: po(l: 6),
        padding: pa(8),
        child: SvgPicture.asset(
          'assets/icons/filter.svg',
          color: AppColors.contentPrimary,
        ),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  final List<String> availableCountries;

  const _FilterSheet({required this.availableCountries});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  static const List<String> allProtocols = [
    'vless',
    'hysteria2',
    'vmess',
    'trojan',
    'wireguard',
    'shadowsocks',
  ];

  static const Map<String, String> protocolLabels = {
    'vless': 'VLESS',
    'hysteria2': 'Hysteria2',
    'vmess': 'VMess',
    'trojan': 'Trojan',
    'wireguard': 'WireGuard',
    'shadowsocks': 'Shadowsocks',
  };

  String sortValue = 'default';
  Set<String> selectedProtocols = {...allProtocols};
  String pingOrder = 'fast';
  Set<String> selectedCountries = {};

  final TextEditingController minCtrl = TextEditingController();
  final TextEditingController maxCtrl = TextEditingController();

  double _dragOffset = 0;

  @override
  void dispose() {
    minCtrl.dispose();
    maxCtrl.dispose();
    super.dispose();
  }

  void _closeSheet() => Navigator.of(context).pop();

  void _applyFilters() {
    Navigator.of(context).pop(
      FilterResult(
        sortValue: sortValue,
        protocols: selectedProtocols,
        pingOrder: pingOrder,
        minPing: int.tryParse(minCtrl.text),
        maxPing: int.tryParse(maxCtrl.text),
        countries: selectedCountries,
      ),
    );
  }

  void _resetAll() {
    setState(() {
      sortValue = 'default';
      selectedProtocols = {...allProtocols};
      pingOrder = 'fast';
      minCtrl.clear();
      maxCtrl.clear();
      selectedCountries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.88;

    return GestureDetector(
      behavior: .opaque,
      onTap: _closeSheet,
      child: SizedBox.expand(
        child: Align(
          alignment: .bottomCenter,
          child: GestureDetector(
            onTap: () {},
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                setState(() => _dragOffset += details.delta.dy);
              }
            },
            onVerticalDragEnd: (details) {
              final fastFling = details.primaryVelocity != null && details.primaryVelocity! > 700;
              if (_dragOffset > 100 || fastFling) {
                _closeSheet();
              } else {
                setState(() => _dragOffset = 0);
              }
            },
            child: Transform.translate(
              offset: Offset(0, _dragOffset),
              child: Container(
                constraints: BoxConstraints(maxHeight: maxHeight),
                decoration: BoxDecoration(
                  color: AppColors.surfaceBackground,
                  borderRadius: .vertical(top: .circular(24)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: .only(top: 10, bottom: 4),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: .circular(4),
                        ),
                      ),
                    ),


                    Padding(
                      padding: .fromLTRB(20, 8, 12, 4),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Filters',
                            style: TextStyle(
                              color: AppColors.contentPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: _closeSheet,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: .all(color: AppColors.ghostButtonBorder),
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: SingleChildScrollView(
                        padding: .fromLTRB(20, 8, 20, 20),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            _sectionTitle('SORT BY'),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _choiceChip(
                                  label: 'Default',
                                  selected: sortValue == 'default',
                                  onTap: () => setState(() => sortValue = 'default'),
                                ),
                                _choiceChip(
                                  label: 'Recent',
                                  selected: sortValue == 'fast',
                                  onTap: () => setState(() => sortValue = 'fast'),
                                ),
                                _choiceChip(
                                  label: 'Favorites',
                                  selected: sortValue == 'favs',
                                  onTap: () => setState(() => sortValue = 'favs'),
                                ),
                              ],
                            ),

                            _divider(),

                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                _sectionTitle('PROTOCOLS', bottomPadding: 0),
                                _textActionChip(
                                  label: selectedProtocols.length == allProtocols.length
                                      ? 'Deselect all'
                                      : 'Select all',
                                  onTap: () => setState(() {
                                    if (selectedProtocols.length == allProtocols.length) {
                                      selectedProtocols.clear();
                                    } else {
                                      selectedProtocols = {...allProtocols};
                                    }
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: allProtocols.map((p) {
                                final selected = selectedProtocols.contains(p);
                                return _toggleChip(
                                  label: protocolLabels[p]!,
                                  selected: selected,
                                  onTap: () => setState(() {
                                    if (selected) {
                                      selectedProtocols.remove(p);
                                    } else {
                                      selectedProtocols.add(p);
                                    }
                                  }),
                                );
                              }).toList(),
                            ),

                            _divider(),

                            _sectionTitle('PING'),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _choiceChip(
                                  label: 'Fast first',
                                  selected: pingOrder == 'fast',
                                  onTap: () => setState(() => pingOrder = 'fast'),
                                ),
                                _choiceChip(
                                  label: 'Slow first',
                                  selected: pingOrder == 'slow',
                                  onTap: () => setState(() => pingOrder = 'slow'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: _pingField(minCtrl, 'Min ms')),
                                Padding(
                                  padding: .symmetric(horizontal: 10),
                                  child: Text('—', style: TextStyle(color: AppColors.contentSecondary)),
                                ),
                                Expanded(child: _pingField(maxCtrl, 'Max ms')),
                              ],
                            ),

                            _divider(),

                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                _sectionTitle('COUNTRY', bottomPadding: 0),
                                _textActionChip(
                                  label: selectedCountries.length == widget.availableCountries.length &&
                                      widget.availableCountries.isNotEmpty
                                      ? 'Deselect all'
                                      : 'Select all',
                                  onTap: () => setState(() {
                                    final allSelected = selectedCountries.length ==
                                        widget.availableCountries.length &&
                                        widget.availableCountries.isNotEmpty;
                                    if (allSelected) {
                                      selectedCountries.clear();
                                    } else {
                                      selectedCountries = {...widget.availableCountries};
                                    }
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            if (widget.availableCountries.isEmpty)
                              Text(
                                'No countries available',
                                style: TextStyle(color: AppColors.contentDisabled, fontSize: 13),
                              )
                            else
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: widget.availableCountries.map((country) {
                                  final selected = selectedCountries.contains(country);
                                  return _toggleChip(
                                    label: country,
                                    selected: selected,
                                    onTap: () => setState(() {
                                      if (selected) {
                                        selectedCountries.remove(country);
                                      } else {
                                        selectedCountries.add(country);
                                      }
                                    }),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: .fromLTRB(
                        20,
                        12,
                        20,
                        12 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetAll,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.error),
                                padding: .symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(14),
                                ),
                              ),
                              child: Text(
                                'Reset all',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _applyFilters,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.selectedButtonBackground,
                                foregroundColor: AppColors.contentPrimary,
                                padding: .symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(14),
                                  side: BorderSide(
                                    color: AppColors.selectedButtonBorder,
                                  )
                                ),
                              ),
                              child: Text(
                                'Apply filters',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
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
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, {double bottomPadding = 10}) {
    return Padding(
      padding: .only(bottom: bottomPadding, top: 4),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _divider() => Padding(
    padding: EdgeInsets.symmetric(vertical: 18),
    child: Divider(height: 1, color: AppColors.ghostButtonBorder),
  );

  Widget _choiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 130),
        padding: .symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.selectedButtonBackground : AppColors.ghostButtonBackground,
          borderRadius: .circular(12),
          border: .all(color: selected ? AppColors.selectedButtonBorder : AppColors.ghostButtonBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.contentPrimary : AppColors.contentSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 130),
        padding: .symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.selectedButtonBackground : AppColors.ghostButtonBackground,
          borderRadius: .circular(12),
          border: .all(color: selected ? AppColors.selectedButtonBorder : AppColors.ghostButtonBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.contentPrimary : AppColors.contentSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  Widget _textActionChip({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 108,
        padding: .symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ghostButtonBackground,
          borderRadius: .circular(10),
          border: .all(color: AppColors.ghostButtonBorder),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.contentPrimary, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _pingField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: AppColors.contentPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.contentDisabled, fontSize: 14),
        filled: true,
        fillColor: AppColors.ghostButtonBackground,
        contentPadding: .symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: AppColors.ghostButtonBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: AppColors.ghostButtonBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: AppColors.ghostButtonBorder),
        ),
      ),
    );
  }
}