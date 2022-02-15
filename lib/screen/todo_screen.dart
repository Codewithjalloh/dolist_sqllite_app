import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleControlller = TextEditingController();

  var todoDescriptionControlller = TextEditingController();

  var todoDateControlller = TextEditingController();

  var _selectedValue;

  var _categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoTitleControlller,
              decoration: InputDecoration(
                  labelText: "Title", hintText: "Write to do Title"),
            ),
            TextField(
              controller: todoDescriptionControlller,
              decoration: InputDecoration(
                  labelText: "Descriptions", hintText: "Write to do Description"),
            ),
            TextField(
              controller: todoDateControlller,
              decoration: InputDecoration(
                  labelText: "Date",
                  hintText: "Pick a Date",
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: Icon(Icons.calendar_today),
                  )),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              items: _categories,
              hint: Text("Category"),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
