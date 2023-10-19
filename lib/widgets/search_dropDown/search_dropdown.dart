import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
class SearchDropdown extends StatefulWidget {
var itemType;
late List<dynamic>items;
double height,width;


SearchDropdown(this.itemType, this.items, this.height, this.width);

@override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: DropdownSearch<dynamic>(
        items: ['Head','Vice',"President","Vice President","Vice"],
        popupProps: const PopupPropsMultiSelection.menu(
          showSelectedItems: true,
        ),
      ),
    );
  }
}
