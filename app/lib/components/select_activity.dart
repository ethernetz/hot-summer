import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';

class SelectActivity extends StatefulWidget {
  const SelectActivity({super.key});

  @override
  State<SelectActivity> createState() => _SelectActivityState();
}

class _SelectActivityState extends State<SelectActivity> {
  List<ActivityType> filteredActivites = ActivityType.values;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              // backgroundColor: CupertinoColors.systemGrey6,
              automaticallyImplyLeading: false,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: CupertinoColors.systemGrey2,
                ),
                onPressed: () => Navigator.pop(context, null),
              ),
              largeTitle: const Text(
                'Select Activity',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 40,
                maxHeight: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CupertinoSearchTextField(
                    placeholder: 'Search',
                    style: const TextStyle(color: Colors.white),
                    onChanged: (text) => _filterActivities(text),
                  ),
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.separated(
            itemCount: filteredActivites.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container();
              }
              var activity = filteredActivites[index - 1];
              return CupertinoListTile(
                title: Text(
                  activity.displayName,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context, activity);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: CupertinoColors.separator,
                thickness: 2,
              );
            },
          ),
        ),
      ),
    );
  }

  _filterActivities(String text) {
    setState(() {
      filteredActivites = ActivityType.values
          .where((activity) =>
              activity.displayName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFF1C1C1E), // Custom dark color
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
