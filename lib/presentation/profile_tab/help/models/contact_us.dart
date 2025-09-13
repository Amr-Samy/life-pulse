class ContactUs {
  String? map;
  String? twitter;
  String? website;
  String? facebook;
  String? whatsapp;
  String? instagram;

  ContactUs(
      {this.map,
        this.twitter,
        this.website,
        this.facebook,
        this.whatsapp,
        this.instagram});

  ContactUs.fromJson(Map<String, dynamic> json) {
    map = json['map'];
    twitter = json['twitter'];
    website = json['website'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['map'] = map;
    data['twitter'] = twitter;
    data['website'] = website;
    data['facebook'] = facebook;
    data['whatsapp'] = whatsapp;
    data['instagram'] = instagram;
    return data;
  }
}
