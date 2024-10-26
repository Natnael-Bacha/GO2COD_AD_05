import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_05/pages/card.dart';
import 'package:go2code_ad_05/pages/lists.dart';
import 'package:go2code_ad_05/pages/readTask.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  User? user = FirebaseAuth.instance.currentUser;

  String? Name = 'user';
  late bool trss = false;
  double numberOfTasks = 0;
  double numberOfDoneTasks = 0;
  int count = 0;
  Future Logout() async {
    await FirebaseAuth.instance.signOut();
  }

  double getDocumentCount() {
    FirebaseFirestore.instance
        .collection('Tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      int documentCount = querySnapshot.size;
      return documentCount;
    });
    return 0;
  }

  int id = 1;

  Future getList(int i) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Tasks')
        .doc(i.toString())
        .get();

    if (docSnapshot.exists) {
      bool isDoneValue = docSnapshot.get('isDone');
      if (isDoneValue) {
        numberOfDoneTasks++;
      }
      trss = isDoneValue;
    }
  }

  void addCard(int i) async {
    setState(() {
      cardsTask[id] = Task(i, trss);
      cardId.add(id);
      id = i + 1;
      if (trss) {
        trss = false;
      }
    });
    print('id is at $id');
  }

  void autoAdd() async {
    User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Tasks')  .where('UserId', isEqualTo: currentUserId).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        dynamic fieldValue = doc.get('cardId');

        numberOfTasks++;
        await getList(fieldValue);
        addCard(fieldValue);
      }
    } else {}
  }

  double getNumberOfChecked() {
    FirebaseFirestore.instance
        .collection('Tasks')
        .where('isDone', isEqualTo: 'true')
        .get()
        .then((QuerySnapshot querySnapshot) {
      count = querySnapshot.size;

      return count;
    });
    return 0;
  }

  void refreshPage() async {
    setState(() {
      cardsTask.clear();
    });
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Tasks').get();

    if (querySnapshot.docs.isNotEmpty) {
      double i = getDocumentCount();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        i--;
        dynamic fieldValue = doc.get('cardId');
        if (i > 0) {
          print(fieldValue);
          await getList(fieldValue);
          addCard(fieldValue);
        }
      }
    } else {}
  }

  void get() {
    numberOfTasks = getDocumentCount();
    print(' Number of tasks $numberOfTasks');
  }

  Future getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('User Info')
        .doc(user?.uid)
        .get();
    if (docSnapshot.exists) {
      Name = docSnapshot['Username'];
    }
  }

  double gg = 0;
  @override
  void initState() {
    super.initState();
    Name = user!.email;
    autoAdd();
    refreshPage();
    gg = getNumberOfChecked();
    get();
    print(numberOfTasks);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Home.png',
            fit: BoxFit.cover,
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const Home()),
                            (route) => false,
                          );
                        },
                        child: const Icon(Icons.refresh,
                            size: 30, color: Colors.white)),
                    GestureDetector(
                      onTap: Logout,
                      child: Center(
                        child: Text(
                          'Sign out',
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 17,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
  
            Expanded(
              child: ListView.builder(
                itemCount: cardsTask.length,
                itemBuilder: (context, index) {
                  final card = cardsTask.values.toList()[index];
                  return card;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: DashedCircularProgressBar.aspectRatio(
                      aspectRatio: 0,
                      valueNotifier: _valueNotifier,
                      progress: numberOfDoneTasks,
                      maxProgress: numberOfTasks,
                      corners: StrokeCap.butt,
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xffeeeeee),
                      foregroundStrokeWidth: 10,
                      backgroundStrokeWidth: 16,
                      animation: true,
                      child: Center(
                        child: ValueListenableBuilder(
                          valueListenable: _valueNotifier,
                          builder: (_, double value, __) => Text(
                            '${value.toInt()}',
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 17,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        addCard(id);
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(35),
                        elevation: 15,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(35)),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }
}
