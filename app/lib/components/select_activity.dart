import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspaces/classes/activity_type.dart';

class SelectActivity extends StatefulWidget {
  const SelectActivity({super.key});

  @override
  State<SelectActivity> createState() => _SelectActivityState();
}

class _SelectActivityState extends State<SelectActivity> {
  List<ActivityType> filteredActivites = activities;

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
                minHeight: 80,
                maxHeight: 80,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
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
            padding: const EdgeInsets.all(0),
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
              if (index == 0) {
                return const TextWithDivider('A');
              }
              var activity = filteredActivites[index - 1];
              var nextActivity = filteredActivites[index];
              if (activity.displayName[0] != nextActivity.displayName[0]) {
                return Column(
                  children: [
                    const Divider(
                      color: CupertinoColors.separator,
                      thickness: 2,
                    ),
                    const SizedBox(height: 20),
                    TextWithDivider(nextActivity.displayName[0]),
                  ],
                );
              }

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

  void _filterActivities(String text) {
    setState(() {
      filteredActivites = activities
          .where((activity) =>
              activity.displayName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }
}

class TextWithDivider extends StatelessWidget {
  final String text;
  const TextWithDivider(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: CupertinoTheme.of(context).textTheme.textStyle.merge(
                  TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
          ),
        ),
        const Divider(
          color: CupertinoColors.separator,
          thickness: 2,
        )
      ],
    );
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
