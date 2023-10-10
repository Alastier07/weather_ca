import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/util.dart';
import '../../screens/local_search.dart';

class LocationWidget extends StatelessWidget with Util {
  const LocationWidget({
    super.key,
    required this.city,
    required this.lastUpdate,
  });

  final String city;
  final String lastUpdate;

  @override
  Widget build(BuildContext context) {
    String lastUpdateDisplay = '';

    if (lastUpdate.isNotEmpty) {
      DateTime parseLastUpdate = DateTime.parse(lastUpdate);
      lastUpdateDisplay = DateFormat('MMMM d, y').format(parseLastUpdate);
    }

    return ListTile(
      minLeadingWidth: 0,
      leading: const Icon(
        Icons.location_pin,
        size: 30,
      ),
      title: Text(
        city,
        style: textTheme(context)
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(lastUpdateDisplay),
      trailing: const Icon(
        Icons.keyboard_arrow_right_outlined,
        size: 30,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return const LocalSearchScreen();
            },
          ),
        );
      },
    );
  }
}
