import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_05/pages/home.dart';
import 'package:go2code_ad_05/pages/taskManager.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  int id;
  bool done;
  
  AddTask(this.id, this.done, {super.key});
 

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {




  String task = '';
   Future getTaskForCard(int id)async{ 
   List<Map<String, dynamic>> tasks = [];

   User? user = FirebaseAuth.instance.currentUser;
   if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Tasks')
          .where('UserId', isEqualTo: user.uid )
          .where('cardId', isEqualTo: id)
          .get();

     

      for (var doc in querySnapshot.docs) {
        tasks.add(doc.data() as Map<String, dynamic>);
      }
    }
    
      for (Map<String, dynamic> taskMap in tasks) {
  
    if (taskMap.containsKey('Task')) {
       task = taskMap['Task'].toString(); 
      break; 
    }
  }
    
   setState(() {
     _taskController.text = task;
   });
  }
    @override
  void initState() {
    super.initState();
    getTaskForCard(widget.id);
  }
  
   final TextEditingController _taskController = TextEditingController();
   TaskManager addTask = TaskManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child:  TextField(
          
                controller: _taskController,
                maxLines: null, 
                decoration:  InputDecoration(
                  hintText: 'Add Your Tasks',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17),
                 labelStyle: GoogleFonts.robotoCondensed(
                                fontSize: 17),
                  
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.black)
            ),
            onPressed: (){
            addTask.deleteTask(_taskController.text.trim(),widget.id, widget.done);
        
              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()), 
                          );
           
            }, 
            child:  Text('Done', 
           style: GoogleFonts.robotoCondensed(
                                fontSize: 17,
                                color: Colors.white
                                ),
            )),
            
        ],
      )
      ),
    );
  }
}