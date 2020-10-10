import 'package:cached_network_image/cached_network_image.dart';
import 'package:contest_user_app/Model/participateusermodel.dart';
import 'package:contest_user_app/dbhelper/db.dart';
import 'package:contest_user_app/varibles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWinner extends StatefulWidget {
  @override
  _UserWinnerState createState() => _UserWinnerState();
}

class _UserWinnerState extends State<UserWinner> {
  final Variables vari = Variables();
  final Database _firestore = Database();
  String contestName;
  String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(
          "WINNER OF CONTEST",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<UserContestModel>>(
                stream: _firestore.getWinner(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserContestModel>> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState == ConnectionState.active) {
                    final list = querySnapshot.data;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) => list.length == 0
                          ? Text("No Data Found")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].imageUrlUser,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.red,
                                                    BlendMode.colorBurn),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.red,
                                      thickness: 2,
                                      height: 2,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        selected: true,
                                        isThreeLine: true,
                                        // leading: CachedNetworkImage(
                                        //   imageUrl: list[index].imageUrl,
                                        //   imageBuilder:
                                        //       (context, imageProvider) =>
                                        //           Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         bottom: 7),
                                        //     child: Container(
                                        //       height: 90,
                                        //       width: 60,
                                        //       decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(30),
                                        //         image: DecorationImage(
                                        //           alignment: Alignment.center,
                                        //           image: imageProvider,
                                        //           fit: BoxFit.cover,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   placeholder: (context, url) =>
                                        //       CircularProgressIndicator(),
                                        //   errorWidget: (context, url, error) =>
                                        //       Icon(Icons.error),
                                        // ),
                                        title: Text(
                                          list[index].username == null
                                              ? ""
                                              : list[index].username,
                                          style: GoogleFonts.acme(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle:Text(
                                          list[index].username == null
                                              ? ""
                                              : list[index].username,
                                          style: GoogleFonts.acme(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () => {
                                          _firestore.getWinner(),
                                        },
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(width: 2, color: Colors.red),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                              ),
                            ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("TURN ON YOUR INTERNET")
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
