import 'package:flutter/material.dart';
import 'package:random_social_network/Data/FirebaseProcess.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_social_network/Statics/statics.dart';
import 'package:random_social_network/components/Client.dart';

class HamePage extends StatefulWidget {
  const HamePage({Key? key}) : super(key: key);

  @override
  _HamePageState createState() => _HamePageState();
}

late Future<List<Map<String, dynamic>>> dsa;

class _HamePageState extends State<HamePage> {
  Future<List<Map<String, dynamic>>> _loadHomeImages() async {
    return await FirebaseProcess().loadImages('/HomePage');
  }

  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dsa = _loadHomeImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 50,
        title: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: ClipRRect(
                  child: Image.network(
                    Statics.account!.photoUrl!,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                Statics.account!.displayName!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: dsa,
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // return ListView.builder(
                //   itemCount: snapshot.data?.length ?? 0,
                //   itemBuilder: (context, index) {
                //     final Map<String, dynamic> image = snapshot.data![index];

                //     return Card(
                //       margin: EdgeInsets.symmetric(vertical: 10),
                //       child: ListTile(
                //         dense: false,
                //         leading: Image.network(image['url']),
                //         title: Text(image['uploaded_by']),
                //         subtitle: Text(image['description']),
                //         trailing: IconButton(
                //           onPressed: () => {},
                //           icon: Icon(
                //             Icons.delete,
                //             color: Colors.red,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
                return Padding(
                  padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                  child: CarouselSlider.builder(
                    itemCount:
                        snapshot.data!.length != 0 ? snapshot.data!.length : 0,
                    itemBuilder: (BuildContext context, index, int) {
                      Map getImage = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffA22447).withOpacity(.05),
                              offset: Offset(0, 50),
                              blurRadius: 20,
                              spreadRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            getImage['url'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      autoPlay: true,
                      height: 200,
                      onPageChanged: (int i, carouselPageChangedReason) {
                        _index = i;
                      },
                    ),
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
