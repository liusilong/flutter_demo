import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:screen_orientation/screen_orientation.dart';

class NavigationBarWidget extends StatefulWidget {
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget>
    with WidgetsBindingObserver {
  List<Widget> pageList = [];
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    print('_NavigationBarWidgetState init');
    WidgetsBinding.instance.addObserver(this);
    pageList
      ..add(FirstPage())
      ..add(SecondPage())
      ..add(ThirdPage(
        itemClickListener: (value) => print('$value'),
      ));
  }

  @override
  void dispose() {
    super.dispose();
    print('_NavigationBarWidgetState dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('${state.index}');
  }

  final pageController = PageController();

  void onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pageList,
        controller: pageController,
        onPageChanged: onPageChanged, // PageView 滑动监听
        physics: NeverScrollableScrollPhysics(), // 禁止 PageView 滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getItem(),
        fixedColor: Colors.red,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getItem() {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: Colors.lightBlueAccent,
          ),
          title: Text('First'),
          activeIcon: Icon(
            Icons.add,
            color: Colors.red,
          )),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
            color: Colors.lightBlueAccent,
          ),
          title: Text('Second'),
          activeIcon: Icon(
            Icons.list,
            color: Colors.red,
          )),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.unarchive,
            color: Colors.lightBlueAccent,
          ),
          title: Text('Third'),
          activeIcon: Icon(
            Icons.unarchive,
            color: Colors.red,
          ))
    ];
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin {
  int num = 0;

  final List<String> _tabTitles = ["One", "Two", "Three"];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    print('first init...');
    num = Random().nextInt(100);
    _controller = TabController(
      length: _tabTitles.length,
      initialIndex: 1, // 设置 tabBar 的初始 index
      vsync: ScrollableState(),
    );

    _controller.addListener(() {
      if (_controller.indexIsChanging) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar'),
        bottom: TabBar(
          tabs: _tabTitles
              .map((value) => Container(
                    width: 60,
                    child: Center(
                      child: Text(value),
                    ),
                  ))
              .toList(),
          controller: _controller,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 3.0,
          labelStyle: TextStyle(height: 2),
          onTap: (index) {
            print('current tab is $index');
          },
        ),
      ),
      body: TabBarView(
          controller: _controller, children: _getTabPages(_tabTitles.length)),
    );
  }

  @override
  bool get wantKeepAlive => true;

  List<TabPage> _getTabPages(int length) {
    List<TabPage> pages = [];
    for (int i = 0; i < length; i++) {
      pages.add(TabPage(i));
    }
    return pages;
  }
}

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with AutomaticKeepAliveClientMixin {
  int num = 0;

  @override
  void initState() {
    super.initState();
    print('second init...');
    num = Random().nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    /// 必须重写
    super.build(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Second page $num",
            style: _getStyle,
          ),
        ),
      ),
    );
  }

  /// 必须重写
  @override
  bool get wantKeepAlive => true;
}

class ThirdPage extends StatefulWidget {
  final ValueChanged<String> itemClickListener;

  ThirdPage({this.itemClickListener});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with AutomaticKeepAliveClientMixin {
  List<String> dataList = [];
  int num = 0;

  @override
  void initState() {
    super.initState();
    num = Random().nextInt(100);
    for (int i = 0; i < 20; i++) {
      dataList.add('Item $i');
    }
    print('third page init...');
  }

  @override
  Widget build(BuildContext context) {
    /// 需要重写
    super.build(context);
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => widget.itemClickListener(dataList[index]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: window.physicalSize.width,
                    color: Colors.orange,
                    height: 120.0,
                    child: Center(
                      child: Text(
                        dataList[index],
                        style: _getStyle,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  /// 保存当前页面的状态
  @override
  bool get wantKeepAlive => true;
}

class TabPage extends StatefulWidget {
  final Key key;
  final int index;

  TabPage(this.index, {this.key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

/// tab 页面
class _TabPageState extends State<TabPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  int num = 0;
  Random _random = Random();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('11111111111');
  }

  @override
  void didUpdateWidget(TabPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('22222222222');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('33333333333');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    print('0000000000');

    num = _random.nextInt(100);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('${state.index}');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                navigator(index, context);
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: window.physicalSize.width,
                  height: 120,
                  color: Colors.green,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 跳转的页面
class ShowResultWidget extends StatefulWidget {
  final int index;

  ShowResultWidget({this.index});

  @override
  _ShowResultWidgetState createState() => _ShowResultWidgetState();
}

class _ShowResultWidgetState extends State<ShowResultWidget> {
  @override
  void initState() {
    super.initState();
    int value = widget.index;
    if (value != null) {
      if (value % 2 == 0) {
        PluginScreenOrientation.setScreenOrientation(
            ScreenOrientation.landscape);
      } else {
        PluginScreenOrientation.setScreenOrientation(
            ScreenOrientation.portrait);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        child: Scaffold(
          body: Container(
            child: Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop({'selection': 'lsl'});
                },
                child: Text(
                  'Item ${widget.index}',
                  style: _getStyle,
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          print('poppopopoppppo');
          Navigator.of(context).pop({'selection': 'lsl'});
        },
      ),
    );
  }
}

void navigator(int index, BuildContext context) async {
  Map result =
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return ShowResultWidget(index: index);
  }));
  print('result is ${result['selection']}');
  if (result != null && result.containsKey('selection')) {
    // do sth...
    if (result['selection'] == 'lsl') {
      PluginScreenOrientation.setScreenOrientation(ScreenOrientation.portrait);
    }
  }
}

/// 产生一个随机的颜色
Color _getRandomColor() {
  Random _random = Random();
  return Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
      _random.nextInt(256), _random.nextInt(256));
}

get _getStyle => TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
