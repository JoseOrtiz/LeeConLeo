enum IssueLevel { error, warning }

class ValidationIssue {
  const ValidationIssue.error(this.message) : level = IssueLevel.error;

  const ValidationIssue.warning(this.message) : level = IssueLevel.warning;

  final IssueLevel level;
  final String message;

  bool get isError => level == IssueLevel.error;

  @override
  String toString() => '${level.name.toUpperCase()}: $message';
}
