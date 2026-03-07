class User {
    String? id;
    String? phone;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.phone,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phone: json["phone"],
        name: json["name"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}