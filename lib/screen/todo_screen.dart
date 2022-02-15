import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  var todoTitleControlller = TextEditingController();
  var todoDescriptionControlller = TextEditingController();
  var todoDateControlller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: Column(
        children: [
          TextField(
            controller: todoTitleControlller,
            decoration: InputDecoration(
              labelText: "Title", 
              hintText: "Write to do Title"
            ),
          ),
          TextField(
            controller: todoDescriptionControlller,
            decoration: InputDecoration(
                labelText: "Descriptions",
                hintText: "Write to do Description"
            ),
          ),

          TextField(
            controller: todoDateControlller,
            decoration: InputDecoration(
                labelText: "Date",
                hintText: "Write to do Date",
              prefixIcon: InkWell(
                onTap: () {},
                child: Icon(Icons.calendar_today),
              )
            ),
          ),
        ],
      ),
    );
  }
}
