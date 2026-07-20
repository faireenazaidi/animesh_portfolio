class ProjectModel {
  final String name;
  final String tagline;
  final String description;
  final List<String> stack;
  final String link;
  final String? githubLink;
  final List<String> imageUrls;
  final String index;

  const ProjectModel({
    required this.name,
    required this.tagline,
    required this.description,
    required this.stack,
    required this.link,
    this.githubLink,
    required this.imageUrls,
    required this.index,
  });
}

class SkillModel {
  final String name;
  final int percentage;

  const SkillModel({required this.name, required this.percentage});
}

class SkillCategoryModel {
  final String categoryName;
  final List<String> skills;

  const SkillCategoryModel({
    required this.categoryName,
    required this.skills,
  });
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

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String> highlights;
  final List<String> techStack;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    required this.highlights,
    required this.techStack,
  });
}

class CertificationModel {
  final String title;
  final String issuer;
  final String year;
  final String? credentialUrl;

  const CertificationModel({
    required this.title,
    required this.issuer,
    required this.year,
    this.credentialUrl,
  });
}

class TestimonialModel {
  final String quote;
  final String author;
  final String title;
  final String company;
  final String? avatarUrl;

  const TestimonialModel({
    required this.quote,
    required this.author,
    required this.title,
    required this.company,
    this.avatarUrl,
  });
}

class NowModel {
  final String projectTitle;
  final String status;
  final String description;
  final List<String> techStack;
  final String lastUpdated;

  const NowModel({
    required this.projectTitle,
    required this.status,
    required this.description,
    required this.techStack,
    required this.lastUpdated,
  });
}

class SocialLinkModel {
  final String platform;
  final String url;

  const SocialLinkModel({
    required this.platform,
    required this.url,
  });
}
