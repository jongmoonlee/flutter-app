import 'package:flash_chat/screens/play_screen.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longPressCallback
     });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      contentPadding: EdgeInsets.only(top: 0,bottom: 0),
      title: Text(
        isChecked ? ('$taskTitle (need proof?  tab here)') : taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.none : null,
            fontSize: 15.0,

            ),
      ),
//      trailing: IconButton(
//        icon: Icon(Icons.check),
//        onPressed: (){},
//      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                backgroundColor: Colors.white,
                  content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                        color: Colors.white,
                        child: Image.asset('images/yum_${taskTitle.trim()}.gif'),
                        height: 400.0,
                        width: 500,
                        padding: EdgeInsets.all(3))
                  ]
              ));
            });
        print(taskTitle);
//        Navigator.push(
//          context,
//          new MaterialPageRoute(
//            builder: (context) => new PlayScreen(),
//          ),
//        );
      },
    );
  }
}
