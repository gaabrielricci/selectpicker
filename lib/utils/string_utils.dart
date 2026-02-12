/// Utility extensions for string manipulation.
extension StringNormalization on String {
  /// Normalizes a string by removing accents/diacritics.
  /// 
  /// This allows accent-insensitive searching. For example:
  /// "Médico" becomes "Medico", "São Paulo" becomes "Sao Paulo"
  String normalize() {
    const withAccents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
    const withoutAccents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn';
    
    String normalized = this;
    for (int i = 0; i < withAccents.length; i++) {
      normalized = normalized.replaceAll(withAccents[i], withoutAccents[i]);
    }
    return normalized;
  }
}
