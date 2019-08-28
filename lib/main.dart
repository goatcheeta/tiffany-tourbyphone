//TourByPhone - Tiffany 7/31/2019 5am
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:connectivity/connectivity.dart';


void main() {
  runApp(new MaterialApp(
    home: new HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

  
class BottomList{
  String titlebottom="" ;
  String urlbottom="" ;
  BottomList(this.titlebottom,this.urlbottom);
}
List<BottomList> blist = new List<BottomList>();


class HomePageState extends State<HomePage> {
 WebViewController  _controller;

  int _currentIndex = 0;
  List<int> _children = [0, 1, 2, 3,4,5];
  List data;
  String url="";
  bool isLaunch;
  String _myapptitle2;
  String _mytourtitle2;
  String _mblisttitle0 ;
  String _mblisttitle1 ;
  String _mblisttitle2 ;
  String _mblisttitle3 ;
  String _mblisttitle4 ;
  String _mblist0;
  String _mblist1;
  String _mblist2;
  String _mblist3;
  String _mblist4;
  String mbeginurl;
 
   
  Future<String> getData() async {
    var response = await http.get(
    Uri.encodeFull("https://churchsp.org/tbp/tiffany/tiffany.json"),
     headers: {
        "Accept": "application/json"
      }
    );
    //data=null;
   this.setState(() {
      data = json.decode(response.body);
      _myapptitle2=data[0]["myapptitle"];
      _mytourtitle2=data[0]["mytourtitle"];
      _mblisttitle0=data[0]["mblisttitle"];
      _mblisttitle1=data[1]["mblisttitle"];
      _mblisttitle2=data[2]["mblisttitle"];
      _mblisttitle3=data[3]["mblisttitle"];
      _mblisttitle4=data[4]["mblisttitle"];
      _mblist0=data[0]["mblist"];
      _mblist1=data[1]["mblist"];
      _mblist2=data[2]["mblist"];
      _mblist3=data[3]["mblist"];
      _mblist4=data[4]["mblist"];
   
     mbeginurl=data[0]["beginurl"];
     url=data[0]["beginurl"];
   
         
    _controller.loadUrl(url);  
    _fill_leading();

     //tourlength=data.length;
                      
    }
    );
        
    return "";

    }  //getdata

    _loadHtmlFromAssets(url) async {
   
   url=mbeginurl;
  _controller.loadUrl(url);
  _fill_leading();  
    
   isLaunch=false ;
   blist.clear();
   blist.add(new BottomList('$_mblisttitle0','$_mblist0'));
  blist.add(new BottomList('$_mblisttitle1','$_mblist1'));
  blist.add(new BottomList('$_mblisttitle2','$_mblist2'));
  blist.add(new BottomList('$_mblisttitle3','$_mblist3'));
  blist.add(new BottomList('$_mblisttitle4','$_mblist4'));
  setState(() { 

 });

    }  
    
  @override
  void initState(){
    checkinternet();
    this.getData();
    
   }

 var ledlist = new List<String>() ;
    
void _fill_leading()  {
     int i, tourlength ;
     tourlength=data.length;
     for (var i = 0; i < tourlength; i++) 
      { 
     ledlist.add(data[i]["leading"]);
     } ;   
       
  }

checkinternet() async {
   String connectmessage ;
   var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      connectmessage="No Internet. You are not connected to a newwork"     ;
      _showAlert(context, connectmessage);
    } else if (result == ConnectivityResult.mobile) {
      //connectmessage="Internet. You are connected over mobile data"     ;
     // _showAlert(context, connectmessage);
      
    } else if (result == ConnectivityResult.wifi) {
      //connectmessage="Internet. You are connected over wifi"     ;
      //_showAlert(context, connectmessage);
     
    }
    return "" ;
  }

  void _showAlert(BuildContext context, $message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Notification"),
              content: Text($message),
            actions: <Widget>[
            
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],

            ));
  }


  void onTabTapped(int index) {
 
 setState(() {
     _currentIndex = index;
   });

     
  isLaunch=false ;
  blist.clear();
  blist.add(new BottomList('$_mblisttitle0','$_mblist0'));
  blist.add(new BottomList('$_mblisttitle1','$_mblist1'));
  blist.add(new BottomList('$_mblisttitle2','$_mblist2'));
  blist.add(new BottomList('$_mblisttitle3','$_mblist3'));
  blist.add(new BottomList('$_mblisttitle4','$_mblist4'));

  switch (_currentIndex) {
    case 0:
     break;

    case 1:
    url='mailto:goatcheeta@gmail.com?subject=Tour by Phone';
     
    isLaunch=true ;
    launch(url)   ;  
    break;

    case 2:
    break;
    case 3:
    break;
    case 4:
    break;
    
   }
   

 if(isLaunch){
       //Execute this part of the code if the condition is true.
 } else{
 

Navigator.push(
  context,
  new MaterialPageRoute( builder: (BuildContext context) =>
new ThirdPage(blist[_currentIndex])
)
);
} //isLaunch ;

}

  @override
  Widget build(BuildContext context){

    return new Scaffold(
    
    appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: new AppBar(
              backgroundColor: const Color(0xFF0099a9),
              centerTitle: true,
              title:Text('Tour by Phone - $_myapptitle2',
              style:new TextStyle(fontSize: 16.0, color: Colors.white)
              ),

                            
            ) //Appbar
             ),  //Preferred Size
    
          bottomNavigationBar: BottomNavigationBar(
               
          type: BottomNavigationBarType.fixed,
          currentIndex: _children[_currentIndex],
          onTap: onTabTapped,
                    
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.map), title: Text('$_mblisttitle0')),
            BottomNavigationBarItem(
                icon: Icon(Icons.email), title: Text('$_mblisttitle1')),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('$_mblisttitle2')),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), title: Text('$_mblisttitle3')),
            BottomNavigationBarItem(
               icon: Icon(Icons.announcement), title: Text('$_mblisttitle4'))
          ]  
          
          ), //COMMA!

     
     body: WebView(
         // initialUrl: 'https://churchsp.org/tbp/tiffany/front.html',    
            key: Key("webview"),
            initialUrl: url,        
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
             _controller = webViewController;
          
             _loadHtmlFromAssets(url);
              
          }
      ),

     
      
     drawer: new Drawer(
                      
              child: Column(
                children: <Widget>[

              Container( 
              height: 85.0,
              width: 400.0,
                 child: DrawerHeader(
                child: Text(
                  '$_mytourtitle2',
                  style: new TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),


               new Expanded(
               child:ListView.builder(
                
                padding: EdgeInsets.zero,
                 scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int i) {
                   return new ListTile(               
                                     
                    title: new Text(
                    data[i]["Title"],
                    
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ), //title
                   
                    leading: CircleAvatar(backgroundImage: NetworkImage(ledlist[i])
                    ),
                   
                   onTap: () {
                     Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new SecondPage(data[i])));
                      } //onTap
                     );
                }  //itembuilder
                 
              ),
             ),
            ],
              
           ),
    )
    );    
                  
  }     //itembuilder
    
  }//homepage state

class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
      title: new Text(data["Title"]),
      backgroundColor: Colors.green,
      ),
      body: WebView(
          initialUrl: data["URL"],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.clearCache();
          }));
}

class ThirdPage extends StatelessWidget {
  
    ThirdPage(this.bottomlist2);
    final BottomList bottomlist2;
         
     @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
      //title: new Text(data["Title"]),
      title: new Text(bottomlist2.titlebottom),
      backgroundColor: Colors.green,
      ),
      body: WebviewScaffold(
          //initialUrl: bottomlist2.urlbottom,
          url:bottomlist2.urlbottom,
          allowFileURLs: true ,
          clearCache: true ,
          )
          );
}