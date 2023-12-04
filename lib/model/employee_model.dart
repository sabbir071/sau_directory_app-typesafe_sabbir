class Employee {

  String name;
  dynamic about;
  dynamic designation;
  dynamic phone;
  dynamic mobile;
  dynamic email;

  Employee({

    required this.name,
    this.about,
    this.designation,
    this.phone,
    this.mobile,
    this.email,
  });

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(

        name: json["name"],
        about: json["about"],
        designation: json["designation"],
        phone: json["phone"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "about": about,
        "designation": designation,
        "phone": phone,
        "mobile": mobile,
        "email": email,
      };
}

List<Employee> searchEmployees(List<Employee> employees, String query) {
  return employees.where((employee) => employee.matchesQuery(query)).toList();
}

extension EmployeeSearch on Employee {
  bool matchesQuery(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
        about.toString().toLowerCase().contains(query.toLowerCase()) ||
        designation.toString().toLowerCase().contains(query.toLowerCase()) ||
        phone.toString().contains(query) ||
        mobile.toString().contains(query) ||
        email.toString().toLowerCase().contains(query.toLowerCase());
  }
}
