class Schedule {
  String id;
  String name;
  int startTime;
  int endTime;
  int studentsLimit;
  String shift;
  bool? isFull;

  Schedule({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.studentsLimit,
    required this.shift,
    this.isFull = false,
  });

  factory Schedule.fromJSON(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      studentsLimit: json['studentLimit'],
      shift: json['shift'],
      isFull: json['isFull']
    );
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['studentLimit'] = studentsLimit;
    data['shift'] = shift;
    data['isFull'] = isFull;
    return data;
  }
}

class User {
  String id;
  String name;
  int age;
  String userName;
  String password;
  String mobileNumber;
  String address;
  String photo;
  bool isAdmin;
  Schedule? schedule;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.userName,
    required this.password,
    required this.mobileNumber,
    required this.address,
    required this.isAdmin,
    this.photo = 'https://placehold.co/600x800/png',
    this.schedule,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      userName: json['userName'],
      password: json['password'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      isAdmin: json['isAdmin'],
      photo: json['photo'],
      schedule: json['schedule'] != null ? Schedule.fromJSON(json['schedule']) : null,
    );
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['userName'] = userName;
    data['password'] = password;
    data['mobileNumber'] = mobileNumber;
    data['address'] = address;
    data['isAdmin'] = isAdmin;
    if(photo.isEmpty || photo == ''){
      data['photo'] = 'https://placehold.co/600x800/png';
    }
    if (schedule != null) {
      data['schedule'] = schedule!.toJSON();
    }
    return data;
  }
}

class Student {
  String id;
  String name;
  int age;
  String mobilePhone;
  String? ci;
  DateTime dateIn;
  String photo;
  Schedule? schedule;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.dateIn,
    this.ci,
    required this.mobilePhone,
    this.photo = 'https://placehold.co/600x800/png',
    this.schedule,
  });

  factory Student.fromJSON(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      dateIn: DateTime.parse(json['dateIn'].toString()),
      ci: json['ci'],
      mobilePhone: json['mobilePhone'],
      photo: json['photo'],
      schedule: Schedule.fromJSON(json['schedule']),
    );
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['dateIn'] = dateIn.toIso8601String();
    data['ci'] = ci;
    data['mobilePhone'] = mobilePhone;
    data['photo'] = photo;
    if (schedule != null) {
      data['schedule'] = schedule!.toJSON();
    }
    return data;
  }
}
