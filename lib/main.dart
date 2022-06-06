import 'package:draggable_icons/social_icons.dart';
import 'package:draggable_icons/app_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Center(
                              child: Text(
                                "Long press to drag icon",
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ))),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              listSocialTitle = [
                                SocialIcons(title: "Facebook"),
                                SocialIcons(title: "Linkedin"),
                                SocialIcons(title: "Github"),
                                SocialIcons(title: "Fiver"),
                                SocialIcons(title: "Upwork"),
                                SocialIcons(title: "Twitter"),
                              ];
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const MyApp(),
                                ),
                                    (route) => false);
                          },
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: listIcons.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (c, i) {
                          title = listIcons[i].title ?? "";

                          return LongPressDraggable(
                              dragAnchorStrategy: pointerDragAnchorStrategy,
                              data: listIcons[i],
                              child: UpListofIcons(index: i),
                              feedback: DragView(index: i));
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Drop Here ",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: listSocialTitle.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (c, i) {
                          return DragTarget<SocialIcons>(
                              builder: (cxt, cadiateItem, rejected) {
                                print(listSocialTitle[i].title);
                                return DownDragSocialList(
                                  socialicons: listSocialTitle[i],
                                  index: i,
                                  highlighted: cadiateItem.isNotEmpty,
                                  hasItems: listSocialTitle.isNotEmpty,
                                );
                              }, onAccept: (item) {
                            setState(() {
                              if (item.title == listSocialTitle[i].title) {
                                listSocialTitle[i] = item;
                              }
                            });
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DownDragSocialList extends StatelessWidget {
  final SocialIcons socialicons;
  final bool highlighted;
  final bool hasItems;
  final int index;
  const DownDragSocialList({
    Key? key,
    required this.highlighted,
    required this.hasItems,
    required this.socialicons,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlighted
            ? socialicons.title == title
            ? Colors.green
            : Colors.red
            : Colors.transparent,
        border: const Border(
          top: BorderSide(width: 1),
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
          left: BorderSide(width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(socialicons.title ?? ""),
          Visibility(
              visible: hasItems,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: socialicons.imageUrl != null
                  ? Image.asset(
                socialicons.imageUrl ?? "",
                width: 100,
                height: 100,
              )
                  : Container())
        ],
      ),
    );
  }
}

class UpListofIcons extends StatelessWidget {
  final int index;
  const UpListofIcons({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
          left: BorderSide(width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(listIcons[index].title ?? ""),
          Visibility(
              visible: true,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Image.asset(
                listIcons[index].imageUrl ?? " ",
                width: 100,
                height: 100,
              ))
        ],
      ),
    );
  }
}

class DragView extends StatefulWidget {
  final int index;
  const DragView({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<DragView> createState() => _DragViewState();
}

class _DragViewState extends State<DragView> {
  @override
  void initState() {
    super.initState();
    title = listIcons[widget.index].title ?? "";
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: true,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Image.asset(
              listIcons[widget.index].imageUrl ?? " ",
              width: 80,
              height: 80,
            ))
      ],
    );
  }
}