import 'package:contest_user_app/Model/participateusermodel.dart';
import 'package:contest_user_app/dbhelper/db.dart';
import 'package:contest_user_app/varibles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  bool check = false;
  Variables variables = Variables();

  String contestName;
  String description;
  final Database _firestore = Database();

  @override
  Widget build(BuildContext context) {
    String userid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "CONTESTS",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<UserContestModel>>(
                stream: _firestore.getUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserContestModel>> querySnapshot) {
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
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.amber),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      isThreeLine: true,
                                      // leading: CachedNetworkImage(
                                      //   imageUrl: list[index].imageUrl,
                                      //   imageBuilder: (context, imageProvider) =>
                                      //       Container(
                                      //     height: 50,
                                      //     width: 50,
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //         image: imageProvider,
                                      //         fit: BoxFit.cover,
                                      //         colorFilter: ColorFilter.mode(
                                      //             Colors.red,
                                      //             BlendMode.colorBurn),
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
                                        style: GoogleFonts.balooDa(fontSize: 30),
                                      ),
                                      subtitle: Text(
                                        list[index].email == null
                                            ? ""
                                            : list[index].email,
                                        style: GoogleFonts.workSans(fontSize: 15),
                                      ),
                                      trailing: FloatingActionButton(
                                        onPressed: () async => {
                                          userid = list[index].id,
                                          check = true,
                                          await _firestore.updateVote(
                                              variables.getContestID(),
                                              userid,
                                              list[index].votes),
                                        },
                                        child: Center(
                                          child: Text(
                                            " ${list[index].votes}",
                                            style: GoogleFonts.workSans(
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onTap: () async => {
                                        userid = list[index].id,
                                        check = true,
                                        await _firestore.updateVote(
                                            variables.getContestID(),
                                            userid,
                                            list[index].votes),
                                        Navigator.pop(context),
                                      },
                                    ),
                                  ),
                                ),
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
