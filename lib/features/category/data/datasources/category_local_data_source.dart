import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/category/data/models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<CategoryModel?> getCachedCategoryDetails(int id);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  const CategoryLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedCategoriesKey = 'CACHED_CATEGORIES';

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    final cachedData = CacheHelper.getData(key: cachedCategoriesKey);
    if (cachedData != null && cachedData is String && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as List<dynamic>;
        final list = decoded
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
        if (list.isNotEmpty) return list;
      } catch (_) {}
    }
    return _buildDefaultCategories();
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      final jsonList = categories.map((e) => e.toJson()).toList();
      await CacheHelper.saveData(
        key: cachedCategoriesKey,
        value: jsonEncode(jsonList),
      );
    } catch (_) {}
  }

  @override
  Future<CategoryModel?> getCachedCategoryDetails(int id) async {
    final list = await getCachedCategories();
    try {
      return list.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }

  List<CategoryModel> _buildDefaultCategories() {
    return const [
      CategoryModel(
        id: 1,
        name: 'Haute Parfumerie',
        slug: 'haute-parfumerie',
        description: 'Extraits, pure attars & discovery sets',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 01',
        creationsCount: '48 CREATIONS',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCxe61H0SHlioRhymTGfT7Rq5xCq0A0sxiC01-sqlc1uDRxUUyUCXGcU82dZalHBGQGHZfz6MOAEjAVh0VmiW5CY_ouf8cHu2eU74u5sd9xLHD56WPw0smDv0NhbjYhCHCStMcmyqXroklhc3yQlDg62QnISCP3lj8leTzGyF5Lwdd1kqlVjt0E1BNmD_QR8gEa90dOcTcucrZKSrOHeR3_4O_YYqqD6ekGJvaH0l2BVSzxH4e9oKeO',
        subDepartments: [
          SubDepartmentModel(
            id: 101,
            name: 'Extraits de Parfum',
            badge: 'SIGNATURE LINE',
            description: 'Rare amber, aged Taif rose & vintage oud',
            editionsCount: '22 Editions',
            image:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCxe61H0SHlioRhymTGfT7Rq5xCq0A0sxiC01-sqlc1uDRxUUyUCXGcU82dZalHBGQGHZfz6MOAEjAVh0VmiW5CY_ouf8cHu2eU74u5sd9xLHD56WPw0smDv0NhbjYhCHCStMcmyqXroklhc3yQlDg62QnISCP3lj8leTzGyF5Lwdd1kqlVjt0E1BNmD_QR8gEa90dOcTcucrZKSrOHeR3_4O_YYqqD6ekGJvaH0l2BVSzxH4e9oKeO',
          ),
          SubDepartmentModel(
            id: 102,
            name: 'Pure Attars & Concentrates',
            badge: 'ARTISANAL VAULT',
            description: 'Alcohol-free botanical extracts & resin oils',
            editionsCount: '12 Editions',
            iconKey: 'water_drop',
          ),
          SubDepartmentModel(
            id: 103,
            name: 'Discovery Coffrets & Sets',
            badge: 'NUMBERED',
            description: 'Hand-bound leather travel vials & pipettes',
            editionsCount: '8 Box Sets',
            iconKey: 'auto_awesome_motion',
          ),
          SubDepartmentModel(
            id: 104,
            name: 'Bespoke Flacons & Refills',
            badge: 'EXCLUSIVE',
            description: 'Monogrammed crystal vessels & 250ml decants',
            editionsCount: '6 Editions',
            iconKey: 'diamond',
          ),
        ],
      ),
      CategoryModel(
        id: 2,
        name: 'High Horlogerie',
        slug: 'high-horlogerie',
        description: 'Skeletons, perpetuals & tourbillons',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 02',
        creationsCount: '19 COMPLICATIONS',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBTCYEjF7eyY7S0KFl3G6vGFiI0bK9eLLVyOOutUx9Kz5QB5D-bGvSVkpNJp212d4OODGUcEFJsU3dcPpULYOIBvwOmnlby3dQuqMMKdGlVCX-hyQnIhqEk8XHTHDXZllNc4Oyd6mbucaLvZ2BCjcB6zO4UpCDxNMXvf_vnm8LAcXsFXiTm2QNmLKw-70RxZFuQnd8MriwK9WKTECC4-ucjVJxvvKKf-Bazc1dI4-5FCYcnA9UKRNdA',
        subDepartments: [
          SubDepartmentModel(
            id: 201,
            name: 'Tourbillons',
            badge: '3 LEFT',
            description: 'Flying double-axis tourbillon masterworks',
            editionsCount: '5 Editions',
          ),
          SubDepartmentModel(
            id: 202,
            name: 'Skeleton Chronos',
            badge: 'COMPLICATION',
            description: 'Hand-chamfered openwork column wheels',
            editionsCount: '8 Editions',
          ),
          SubDepartmentModel(
            id: 203,
            name: 'Bespoke Straps',
            badge: 'ALLIGATOR',
            description: 'Saddle-stitched exotic skins with gold tangs',
            editionsCount: '14 Editions',
          ),
          SubDepartmentModel(
            id: 204,
            name: 'Horology Winders',
            badge: 'VAULT',
            description: 'Italian walnut dual-axis gyro winders',
            editionsCount: '4 Editions',
          ),
        ],
      ),
      CategoryModel(
        id: 3,
        name: 'Fine Leather Goods',
        slug: 'fine-leather-goods',
        description: 'Saddle-stitched trunks & clutches',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 03',
        creationsCount: '32 PIECES',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDzsvx3vQ95Lpp3x8b4Dj0fW2Gzx4nRNUDE9Dt4j0WKs9ETBuEg250IiQxDs5JEB1tgtE6vFKvtBMgzhc1DNJ9M6l6gyQoEGklvbXNsiWdqovcOq4UbiI8FgGgL80sqk9km3m3I7GIYg2avv-S3HrwbHvGuaXak3MjR7hcBeNQEt6Oz5OqXOPWa8Iq-R-gKjFTPE6eS1x5Mm9kTfBJs487NhalJZQMAv8skiv0OR_k8EeUti6v96GEh',
        subDepartments: [
          SubDepartmentModel(
            id: 301,
            name: 'Nappa Clutches',
            badge: 'SIGNATURE',
            description: 'Buttery calfskin with brass lock hardware',
            editionsCount: '12 Editions',
          ),
          SubDepartmentModel(
            id: 302,
            name: 'Artisan Briefcases',
            badge: 'HERITAGE',
            description: 'Structured bridle leather with suede lining',
            editionsCount: '7 Editions',
          ),
          SubDepartmentModel(
            id: 303,
            name: 'Watch Rolls',
            badge: 'ESSENTIAL',
            description: 'Triple-cushion suede interior rolls',
            editionsCount: '9 Editions',
          ),
          SubDepartmentModel(
            id: 304,
            name: 'Monogram Trunks',
            badge: 'BESPOKE',
            description: 'Handcrafted weekend steam trunks',
            editionsCount: '4 Editions',
          ),
        ],
      ),
      CategoryModel(
        id: 4,
        name: 'Cellular Skin Care',
        slug: 'cellular-skin-care',
        description: 'Molecular elixirs & gold infusions',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 04',
        creationsCount: '26 FORMULATIONS',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBRj4RhpIT5bOkxmbL6DC5E2gQC5U32seY0Ia_lFooAwaKRgoPCA_Z1BxbnUucnuEGsipR64ALcbiKTPLRdPxipf3lqo82fBBtpkYjkIynxmncv2blnup9Ii0TszMVgZkSH4N5HU81d0ZHMPgxnH6hPtVHjHPsrq_Ktr0c1QFOIYW5EP6mgMtd79ZRiq9dcYWBmWyZeICAXpWO38sqSeu7zPCvrUU04z0hugFTEFma26d8xt7BZG3bx',
        subDepartments: [
          SubDepartmentModel(
            id: 401,
            name: 'Vitamin C Elixirs',
            badge: 'FERULIC',
            description: 'High-potency pure ascorbic concentrate',
            editionsCount: '6 Editions',
          ),
          SubDepartmentModel(
            id: 402,
            name: 'Active Retinoids',
            badge: 'NIGHT REPAIR',
            description: 'Encapsulated midnight renewal lipid droplets',
            editionsCount: '8 Editions',
          ),
          SubDepartmentModel(
            id: 403,
            name: '24k Gold Infusions',
            badge: 'EXCLUSIVE',
            description: 'Colloidal gold suspended in botanical squalane',
            editionsCount: '4 Editions',
          ),
          SubDepartmentModel(
            id: 404,
            name: 'Stem Cell Balms',
            badge: 'CELLULAR',
            description: 'Alpine rose stem cell barrier restore balm',
            editionsCount: '8 Editions',
          ),
        ],
      ),
      CategoryModel(
        id: 5,
        name: 'Fine Jewelry & Gems',
        slug: 'fine-jewelry-gems',
        description: 'Solitaires, emeralds & bracelets',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 05',
        creationsCount: '15 RARITIES',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD2Ot4Ak9NfrttDceCQWnVBkbi2or6x9bSvnUdidzcgj1DORjvw0ac8nwLsuTeCXE-GWqYn8JS0KWWAsdcG4WXavT9I-8wlD5Fa0kCMoJS9eWtS6q0JVAcWtsIcK-OxDex1Su8WVmYQreMXmQlPLfvsLAHuKCENTdwymGRF0HCeDK_5pYRCYNQOy3o7hRNDiTf7hg11eBjo0Z1vUiLucG7jM7DgnikPY_VwWySd4WqOIIsRm1ocgYCB',
        subDepartments: [
          SubDepartmentModel(
            id: 501,
            name: 'Solitaire Rings',
            badge: 'UNHEATED',
            description: 'Rare Colombian emerald & platinum baguettes',
            editionsCount: '5 Editions',
          ),
          SubDepartmentModel(
            id: 502,
            name: 'Tennis Bracelets',
            badge: 'D-COLOR',
            description: '18k white gold continuous brilliant cuts',
            editionsCount: '4 Editions',
          ),
          SubDepartmentModel(
            id: 503,
            name: 'Emerald Chokers',
            badge: 'HIGH JEWELRY',
            description: 'Cabochon emerald drops with diamond halos',
            editionsCount: '3 Editions',
          ),
          SubDepartmentModel(
            id: 504,
            name: 'Bespoke Pendants',
            badge: 'PRIVATE',
            description: 'Custom stone selection & hand engraving',
            editionsCount: '3 Editions',
          ),
        ],
      ),
      CategoryModel(
        id: 6,
        name: 'Artisanal Home & Scents',
        slug: 'artisanal-home-scents',
        description: 'Marble candles & sonic diffusers',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 06',
        creationsCount: '18 AMBIANCES',
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAdLUmZkA-rbO9miVtBbFgz3Fu9JM9uDZutMZGF6umaAkv7kii7r2KtomO5cce3Ul1IE0HzvEln5eRcNOvg59pdKv6vB9aysdJd3DXYr7LwEvNT_rOQevmCejx4MEGMPHJBr_ExAE4ZeR3xsS858e49V8G7uBNe7i9pKXbH0H9hzItoDCGxm-0o8F3zm9LidsgxUqJTJ5vKxnsbHimL8jmXtriD_37PArg574SOqPATFcWa9-hShbMH',
        subDepartments: [
          SubDepartmentModel(
            id: 601,
            name: 'Marble Candles',
            badge: 'CARRARA',
            description: 'Hand-carved solid marble vessel with wax refill',
            editionsCount: '7 Editions',
          ),
          SubDepartmentModel(
            id: 602,
            name: 'Sonic Diffusers',
            badge: 'CERAMIC',
            description: 'Whisper-quiet cold ultrasonic nebulization',
            editionsCount: '5 Editions',
          ),
          SubDepartmentModel(
            id: 603,
            name: 'Room Mists',
            badge: 'BOTANICAL',
            description: 'Organic cedar, hinoki and white amber mists',
            editionsCount: '6 Editions',
          ),
        ],
      ),
    ];
  }
}
