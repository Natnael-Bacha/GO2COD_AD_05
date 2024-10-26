import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReadTask{
int id; 


ReadTask(this.id);
 Future getTaskForCard(int id)async{ 
   List<Map<String, dynamic>> tasks = [];
  String task = '';
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
    return task;
   
  }
  
  }