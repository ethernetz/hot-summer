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
      backgroundColor: CupertinoColors.darkBackgroundGray,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.darkBackgroundGray,
              automaticallyImplyLeading: false,
              trailing: CupertinoButton(
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
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CupertinoSearchTextField(
                placeholder: 'Search',
                style: const TextStyle(color: Colors.white),
                onChanged: (text) => _filterActivities(text),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredActivites.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container();
                    }
                    var activity = filteredActivites[index - 1];
                    return CupertinoListTile(
                      backgroundColor: CupertinoColors.darkBackgroundGray,
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
                      color: CupertinoColors.systemGrey,
                      thickness: 1,
                    );
                  },
                ),
              ),
            ],
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
