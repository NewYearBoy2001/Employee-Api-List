import 'package:employe_json/model/data.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Employes employees;

  const DetailsPage({Key? key, required this.employees}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: NetworkImage(widget.employees.profileImage!),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.name.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.email,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Username",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.username.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${widget.employees.address.street}, ${widget.employees.address.city}",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Phone",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.phone.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Website",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.website.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Company",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.employees.company.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
