import 'package:flutter/material.dart';
import 'package:myapp/models/call.dart';
import 'package:myapp/theme.dart';

class CallView extends StatelessWidget{
  const CallView({super.key});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: callList.length,
      itemBuilder: (context, index) {
        final status = callList[index];
        return ListTile(
          leading: const Icon(Icons.supervisor_account_rounded, color: Colors.black45,size: 58),
          title: Text(
            status.name,
            style: customTextStyle,
          ),
          subtitle: Text(
            status.callDate,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 16
            ),
          ),
         trailing: const Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Icon(Icons.call, color: Colors.green)
          )
        );
      }
    );
  }
}