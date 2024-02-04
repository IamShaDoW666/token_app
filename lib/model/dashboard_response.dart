class DashboardResponse {
  List<dynamic>? today;
  List<dynamic>? yesterday;

  DashboardResponse({
    this.today,
    this.yesterday,
  });

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (today != null) data['today'] = today;
    if (yesterday != null) data['yesterday'] = yesterday;
    return data;
  }
}

class LanguageOption {
  String? flagImage;
  String? id;
  String? title;

  LanguageOption({this.flagImage, this.id, this.title});
  factory LanguageOption.fromJson(Map<String, dynamic> json) {
    return LanguageOption(
      flagImage: json['flag_image'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag_image'] = flagImage;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
