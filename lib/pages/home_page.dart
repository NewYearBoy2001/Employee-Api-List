import 'package:employe_json/model/data.dart';
import 'package:employe_json/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employes>? employees;
  List<Employes>? filteredEmployees;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<Employes>?> getPost() async {
    var client = http.Client();
    var uri = Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return employesFromJson(json);
    } else {
      throw Exception("Failed to load data");
    }
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      employees = await getPost();
      filteredEmployees = employees;
    } catch (e) {
      // Handle error, show error message or retry logic
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterList(String query) {
    setState(() {
      filteredEmployees = employees
          ?.where((employee) =>
      employee.name.toLowerCase().contains(query.toLowerCase()) ||
          employee.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        title: const Text(
          'Employee List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmployeeSearchDelegate(filteredEmployees),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: filteredEmployees?.length ?? 0,
        itemBuilder: (context, index) => getRow(index),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(employees: filteredEmployees![index]),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(filteredEmployees![index].profileImage.toString()),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filteredEmployees![index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              Text(
                filteredEmployees![index].email,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeSearchDelegate extends SearchDelegate {
  final List<Employes>? employees;

  EmployeeSearchDelegate(this.employees);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(employees);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = employees
        ?.where((employee) =>
    employee.name.toLowerCase().contains(query.toLowerCase()) ||
        employee.email.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(suggestionList);
  }

  Widget _buildList(List<Employes>? employees) {
    if (employees == null || employees.isEmpty) {
      return Center(
        child: Text("No results found."),
      );
    }

    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) =>  Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(employees: employees![index]),
                ),
              );
            },
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(employees![index].profileImage.toString()),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employees![index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  employees![index].email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
