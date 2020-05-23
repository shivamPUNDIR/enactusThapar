class CoronaModel {
  Cases cases;
  Deaths deaths;
  Tests tests;

  CoronaModel({this.cases, this.deaths, this.tests});

  factory CoronaModel.fromMap(Map<String, dynamic> map) {
    return CoronaModel(
        cases: Cases.fromJson(map['cases']),
        deaths: Deaths.fromJson(map['deaths']),
        tests: Tests.fromJson(map['tests']));
  }
}

class Cases {
  String newCases;
  String active;
  String critical;
  String recovered;
  String total;
  Cases(
      {this.active, this.critical, this.newCases, this.recovered, this.total});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
        newCases: 'new',
        active: 'active',
        critical: 'critical',
        recovered: 'recovered',
        total: 'total');
  }
}

class Deaths {
  String newDeath;
  String total;
  Deaths({this.newDeath, this.total});
  factory Deaths.fromJson(Map<String, dynamic> json) {
    return Deaths(newDeath: 'new', total: 'total');
  }
}

class Tests {
  String total;
  Tests({this.total});
  factory Tests.fromJson(Map<String, dynamic> json) {
    return Tests(total: 'total');
  }
}
