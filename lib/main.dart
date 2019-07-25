import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Text('Flutter Demo Home Page'),
    );
  }
}
class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Widget子类中的字段往往都会定义为"final"

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 78.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      padding: const EdgeInsets.only( left:16.0,top:25.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row 是水平方向的线性布局（linear layout）
      child: new Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),
          // Expanded expands its child to fill the available space.
          new Expanded(
            child: title,
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material 是UI呈现的“一张纸”
    return new Material(
      // Column is 垂直方向的线性布局.
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Example title1',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold是Material中主要的布局组件.
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: new Text('Example title'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      //body占屏幕的大部分
      body: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
        children: [
//          Padding(
//            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//            child: Text('Esri'),
//          ),
          Flexible(
            child:IFlutterMap()
          )
        ])),

    );
  }
}

class NewRoute extends StatelessWidget{
  NewRoute({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body:Center(
        child: Text(text),
      )
    );
  }
}

class IFlutterMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   // print(LatLng(45.5231, -122.6765));


    return new FlutterMap(
      options: new MapOptions(
        center: LatLng(45.5231, 122.6765),
        zoom: 3.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: 'https://t0.tianditu.gov.cn/DataServer?T=vec_w&X={x}&Y={y}&L={z}&tk=a10b5d58603d9a7abfe4731e8360fa91',
        ),
        new TileLayerOptions(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          urlTemplate: 'https://t0.tianditu.gov.cn/DataServer?T=cva_w&X={x}&Y={y}&L={z}&tk=a10b5d58603d9a7abfe4731e8360fa91',
        ),
//        OverlayImageLayerOptions(overlayImages: <OverlayImage>[
//          OverlayImage(
//              bounds: LatLngBounds(LatLng(50.5, 70.09), LatLng(35.8566, 132.3522)),
//              opacity: 0.8,
//              imageProvider: NetworkImage(
//                  'http://image.data.cma.cn/vis/IMG_SURF_TEM_MAX_24H_08_yb_nbg_mct/20190725/Guip_nmic_mct_yb_cpas_TH24_08_achn_nnn_1700_201907251700.png')),
//        ]),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(51.5,120.09),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(colors:Colors.purple),
              ),
            ),
          ],
        ),


      ],
    );
  }
}
void main() {
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    routes: {
      'page1':(context)=>NewRoute(text:'this is page1'),
      'page2':(context)=>NewRoute(text:'this is page2')
    },
    home: new TutorialHome(),
  ));
}