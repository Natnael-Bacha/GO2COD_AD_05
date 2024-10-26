import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go2code_ad_05/pages/lists.dart';
class TaskManager {
  Future addTask(String task, int cardId, bool done) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    await FirebaseFirestore.instance.collection('Tasks').doc(cardId.toString()) .set({
      'UserId': userId,
      'Task': task,
      'Time': Timestamp.now(),
      'cardId': cardId,
      'isDone': done
    });
  }

  Future addUserName(String name) async{
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    await FirebaseFirestore.instance.collection('Tasks').doc().set({
      'User Id' : userId,
      'Username' : name
    });
  }

    Future doneTask(bool done) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    await FirebaseFirestore.instance.collection('Tasks').add({
    
      'isDone': done
    });
  }

  Future deleteTask(String task,int taskId, bool done) async {
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Tasks')
          .where('UserId', isEqualTo: user!.uid)
          .where('cardId', isEqualTo: taskId)
          .get();

    if (querySnapshot.docs.isNotEmpty) {
      
      DocumentReference ref = querySnapshot.docs.first.reference;

      ref.delete();
      addTask(task, taskId, done);
    } else{
       addTask(task, taskId, done);
       
    }
  }
  
    Future issDone(int taskId, bool done) async {
    User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('Tasks')
          .doc(taskId.toString())
          .update({
          'isDone': done,  
          });
  }

  
  Future deleteTaskForever(int taskId) async {
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Tasks')
          .where('UserId', isEqualTo: user!.uid)
          .where('cardId', isEqualTo: taskId)
          .get();

    if (querySnapshot.docs.isNotEmpty) {
      
      DocumentReference ref = querySnapshot.docs.first.reference;

      ref.delete();
      
      
    } 
  }

    void popCard(int id){
        print(cardsTask.length);
      
       if (id >= 0 ) {
   
    cardsTask.remove(id);
    print('Delete called');
    print(cardsTask.length);
  } else {
   print('Delete Not called');
   print(cardsTask.length);
  }

  }

}
