import 'package:flutter/material.dart';


  List<Map<String, dynamic>> tasks = [];
  // todo change this to a map having a key of cardId and Value of widget then when we delete it we can easily search for the key only
  List<int>cardId = [];
  
  Map<int, Widget>  cardsTask = {};
  Map<int, bool> isDone = {};

  int isdone = 0;
  

    