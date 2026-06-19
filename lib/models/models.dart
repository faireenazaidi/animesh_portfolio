class ProjectModel {
  final String name;
  final String tagline;
  final String description;
  final List<String> stack;
  final String link;
  final List<String> imageUrls;
  final String index;

  const ProjectModel({
    required this.name,
    required this.tagline,
    required this.description,
    required this.stack,
    required this.link,
    required this.imageUrls,
    required this.index,
  });
}

class SkillModel {
  final String name;
  final int percentage;

  const SkillModel({required this.name, required this.percentage});
}

class EducationModel {
  final String degree;
  final String institute;
  final String year;
  final String score;

  const EducationModel({
    required this.degree,
    required this.institute,
    required this.year,
    required this.score,
  });
}
