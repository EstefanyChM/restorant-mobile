import 'package:flutter/material.dart';
import 'package:riccos/components/list_tile/divider_list_tile.dart';

class ProfileMenuListTile extends StatelessWidget {
  const ProfileMenuListTile({
    super.key,
    required this.text,
    required this.icon, // Cambio de svgSrc a icon
    required this.press,
    this.isShowDivider = true,
  });

  final String text;
  final IconData icon; // Uso de IconData en lugar de SVG
  final VoidCallback press;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return DividerListTile(
      minLeadingWidth: 24,
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).iconTheme.color, // Aplica el color del tema
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1),
      ),
      press: press,
      isShowDivider: isShowDivider,
    );
  }
}
