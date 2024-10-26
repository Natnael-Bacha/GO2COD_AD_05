import 'package:flutter/material.dart';
import 'package:go2code_ad_05/main.dart';
import 'package:go2code_ad_05/pages/addTask.dart';
import 'package:go2code_ad_05/pages/home.dart';
import 'package:go2code_ad_05/pages/lists.dart';
import 'package:go2code_ad_05/pages/loading.dart';
import 'package:go2code_ad_05/pages/readTask.dart';
import 'package:go2code_ad_05/pages/taskManager.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatefulWidget {
  int id;
  bool done;
  Task(this.id, this.done, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

   TaskManager aTask = TaskManager();

  void getId(){
    int cardId = widget.id;
  }





    
  




  @override
  void initState() {
    super.initState();
    getId();
   
   
  }
   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTask(
                    widget.id, widget.done)), // Assuming AddTask is a MaterialPageRoute.
          );
        },
        child: Card(
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTask(widget
                              .id, widget.done)), 
                    );
                  },
                  child: SizedBox(
                      width: 185,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTask(widget
                                    .id, widget.done)), // Assuming AddTask is a MaterialPageRoute.
                          );
                        },
                        child: FutureBuilder<dynamic>(
                          future: ReadTask(widget.id).getTaskForCard(widget.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading', style: TextStyle(color: Colors.black, fontSize: 20),);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('${snapshot.data}', 
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 17,
                             
                              )
                              );
                            }
                          },
                        ),
                      )),
                ),
                Checkbox(
                  value: widget.done,
                  onChanged: (bool? value) { 
                    setState(() {
                     widget.done = !widget.done;
                     
                    });
                    aTask.issDone(widget.id, widget.done);
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap:(){
            
              aTask.deleteTaskForever(widget.id);
           
             
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
