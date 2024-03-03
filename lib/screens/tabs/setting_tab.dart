import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        children: [
          GestureDetector(
              child: box(Icons.favorite, "Favourite"),
              onTap: () {
                print('open mail');
              }),
          const SizedBox(height: 6),
          GestureDetector(
              child: box(Icons.contact_support_rounded, "Contact-Us"),
              onTap: () {
                print('open mail');
              }),
          const SizedBox(height: 6),
          GestureDetector(
              child: box(Icons.privacy_tip, "Privacy Policy"),
              onTap: () {
                print('open mail');
              }),
          const SizedBox(height: 6),
          box(Icons.info, "Version")
        ],
      ),
    );
  }

  Widget box(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          const Spacer(),
          if (title == "Version") ...[
            const Text(
              "0.1.0",
              style: TextStyle(color: Colors.white),
            ),
          ] else ...[
            const Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: 20,
            )
          ]
        ],
      ),
    );
  }
}
