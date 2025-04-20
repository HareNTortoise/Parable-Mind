import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  String? selectedValue;
  final dropdownKey = GlobalKey<DropdownButton2State>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        key: dropdownKey,
        isExpanded: true,
        value: selectedValue ?? widget.items.first,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        customButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue ?? widget.items.first,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        items: widget.items.map(
              (item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(item, style: GoogleFonts.poppins(fontSize: 16)),
              ),
            );
          },
        ).toList(),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 60,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: GoogleFonts.jost(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
          },
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
