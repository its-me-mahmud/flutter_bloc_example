import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Company company;

  const UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      company: Company.fromMap(map['company']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company?.toMap(),
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      email,
      phone,
      website,
      company,
    ];
  }
}

class Company extends Equatable {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'],
      catchPhrase: map['catchPhrase'],
      bs: map['bs'],
    );
  }

  @override
  List<Object> get props => [name, catchPhrase, bs];
}
