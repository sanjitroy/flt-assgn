import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/data/dtos/menu_item.dto.dart';
import 'package:purr/mocks/mockData.dart';

class MenuRepository {
  Future<List<MenuItem>> fetchMenuItems() async {
    final response = await MockMenuService().fetchMenu();

    List<MenuItemDto> dtoList =
        (response as List).map((json) => MenuItemDto.fromJson(json)).toList();

    List<MenuItem> menuItems =
        dtoList.map((dto) => MenuItem.fromDto(dto)).toList();
    return menuItems;
  }
}
