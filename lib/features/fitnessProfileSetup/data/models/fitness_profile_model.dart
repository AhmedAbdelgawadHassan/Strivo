class FitnessProfileModel {
  final String? gender;        
  final int? age;
  final double? height;          
  final double? weight;          
  final String? goal;            // 'lose_weight' / 'build_muscle' / 'stay_fit'
  final String? activityLevel;   // 'sedentary' ... 'very_active'
  final bool isCompleted;

  const FitnessProfileModel({
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.goal,
    this.activityLevel,
    this.isCompleted = false,
  });

  // BMI محسوب تلقائي
  double? get bmi {
    if (height == null || weight == null) return null;
    final m = height! / 100; // height in meter
    return double.parse((weight! / (m * m)).toStringAsFixed(1));
    // toStringAsFixed method to convert the number to Strind with one 1 decimal  تحوله لاسترينج برقم عشري واحد فقط
  }

  FitnessProfileModel copyWith({   // copy with to can change data after create object عشان المستخدم يقدر يغير بياناته فيما بعد حتي لو الفيم final
                                   // to enable user to change his data
    String? gender,
    int? age,
    double? height,
    double? weight,
    String? goal,
    String? activityLevel,
    bool? isCompleted,
  }) {
    return FitnessProfileModel(
      gender: gender ?? this.gender, 
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // to convert model to map
  Map<String, dynamic> toMap() => {  // we should convert model (object) to map as database shape in firebase in Map <Key,value>
        'gender': gender,
        'age': age,
        'height': height,
        'weight': weight,
        'goal': goal,
        'activityLevel': activityLevel,
        'bmi': bmi,
        'isProfileCompleted': isCompleted,
      };

  // to read from map to model
  factory FitnessProfileModel.fromMap(Map<String, dynamic> map) {   // factory constructor to recieve the data from firebase (in Map ) and convert it to model saved here
    return FitnessProfileModel(
      gender: map['gender'],
      age: map['age'],
      height: (map['height'] as num?)?.toDouble(),
      weight: (map['weight'] as num?)?.toDouble(),
      goal: map['goal'],
      activityLevel: map['activityLevel'],
      isCompleted: map['isProfileCompleted'] ?? false,
    );
  }

 FitnessProfileModel copyWithMeasurements({
  int? age,
  double? height,
  double? weight,
}) {
  return FitnessProfileModel(
    gender: gender,
    age: age,          // بتتحط مباشرة حتى لو null (لما المستخدم يمسح الحقل)
    height: height,
    weight: weight,
    goal: goal,
    activityLevel: activityLevel,
    isCompleted: isCompleted,
  );
}
}