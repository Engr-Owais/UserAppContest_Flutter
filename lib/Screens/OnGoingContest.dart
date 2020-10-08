import 'package:cached_network_image/cached_network_image.dart';
import 'package:contest_user_app/Model/Contest_Model.dart';
import 'package:contest_user_app/dbhelper/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnGoingContest extends StatefulWidget {
  @override
  _OnGoingContestState createState() => _OnGoingContestState();
}

class _OnGoingContestState extends State<OnGoingContest> {
  final Database _firestore = Database();
  String _contestid;
  String contestName;
  String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(
          "CONTESTS",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<List<ContestModel>>(
                stream: _firestore.getUserList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ContestModel>> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => list.length == 0
                            ? Text("No Data Found")
                            : Card(
                                child: ListTile(
                                    isThreeLine: true,
                                    leading: CachedNetworkImage(
                                      imageUrl: list[index].imageUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    title: Text(
                                      list[index].content == null
                                          ? ""
                                          : list[index].content,
                                      style: GoogleFonts.balooDa(fontSize: 30),
                                    ),
                                    subtitle: Text(
                                      list[index].description == null
                                          ? ""
                                          : list[index].description,
                                      style: GoogleFonts.workSans(fontSize: 15),
                                    )),
                              ));
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
