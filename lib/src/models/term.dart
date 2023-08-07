/// Model used to store data related to the unused terms present in the `.json`
/// files in the project.
class Term {
  Term({required this.key, required this.value, required this.filename});

  /// Name of the translation
  final String key;

  /// Value of the translation
  final String value;

  /// Name of the file where the translation is located
  final String filename;
  int? _hashcode;

  /// Necessary override for [Set] to compare [Term] objects and determine
  /// equality
  @override
  bool operator ==(other) {
    if (other is! Term) {
      return false;
    }
    final otherTerm = other;
    return otherTerm.key == key && otherTerm.value == value;
  }

  @override
  int get hashCode {
    _hashcode ??= key.hashCode;
    return _hashcode!;
  }

  @override
  String toString() => 'Term(key: $key => value: $value)\n';
}
