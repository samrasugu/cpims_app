/// Capitalizes the first letter of a given text and returns the modified text.
///
/// If the input [text] is empty or null, the function returns the same text without modifications.
String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
