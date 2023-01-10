class CheckBoxListModel{
  final String reason;
  final bool? value;
  final void Function(bool?) onChanged;

  CheckBoxListModel({required this.reason, required this.value, required this.onChanged});
}