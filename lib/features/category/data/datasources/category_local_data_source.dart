import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/category/data/models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<CategoryModel?> getCachedCategoryDetails(int id);
  Future<void> cacheCategoryDetails(CategoryModel category);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  const CategoryLocalDataSourceImpl();

  static const String cachedCategoriesKey = 'CACHED_CATEGORIES';
  static const String cachedCategoryDetailsPrefix = 'CACHED_CATEGORY_DETAILS_';

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
  Future<void> cacheCategoryDetails(CategoryModel category) async {
    try {
      await CacheHelper.saveData(
        key: '$cachedCategoryDetailsPrefix${category.id}',
        value: jsonEncode(category.toJson()),
      );
    } catch (_) {}
  }

  @override
  Future<CategoryModel?> getCachedCategoryDetails(int id) async {
    try {
      final cachedData = CacheHelper.getDataString(key: '$cachedCategoryDetailsPrefix$id');
      if (cachedData != null && cachedData.isNotEmpty) {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return CategoryModel.fromJson(decoded);
      }
    } catch (_) {}
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
        name: 'Electronics',
        slug: 'electronics',
        description: 'Acoustics, smart wearables & connected luxury',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 01',
        creationsCount: '18 EDITIONS',
        image:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80',
        subDepartments: [
          SubDepartmentModel(
            id: 101,
            name: 'Audio & Acoustics',
            badge: 'LOSSLESS',
            description: 'Wireless headphones, monitors & studio DACs',
            editionsCount: '14 Editions',
            image:
                'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80',
            iconKey: 'headphones',
          ),
          SubDepartmentModel(
            id: 102,
            name: 'Smart Wearables',
            badge: 'TITANIUM',
            description: 'Connected horology & biometric trackers',
            editionsCount: '8 Editions',
            image:
                'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=300&q=80',
            iconKey: 'watch',
          ),
          SubDepartmentModel(
            id: 103,
            name: 'Vision & Displays',
            badge: '4K OLED',
            description: 'Curved monitors, lenses & studio lighting',
            editionsCount: '6 Editions',
            image:
                'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=300&q=80',
            iconKey: 'tv',
          ),
          SubDepartmentModel(
            id: 104,
            name: 'Tech Accessories',
            badge: 'BESPOKE',
            description: 'MagSafe stands, braided cords & titanium cases',
            editionsCount: '12 Editions',
            image:
                'https://images.unsplash.com/photo-1583394838336-acd977736f90?auto=format&fit=crop&w=300&q=80',
            iconKey: 'cable',
          ),
        ],
      ),
      CategoryModel(
        id: 2,
        name: 'Clothing',
        slug: 'clothing',
        description: 'Haute couture, tailoring & virgin cashmere',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 02',
        creationsCount: '32 CREATIONS',
        image:
            'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=800&q=80',
        subDepartments: [
          SubDepartmentModel(
            id: 201,
            name: 'Coats & Outerwear',
            badge: 'CASHMERE',
            description: 'Tailored trench coats, blazers & overcoats',
            editionsCount: '18 Editions',
            image:
                'https://images.unsplash.com/photo-1544022613-e87ca75a784a?auto=format&fit=crop&w=300&q=80',
            iconKey: 'checkroom',
          ),
          SubDepartmentModel(
            id: 202,
            name: 'Tailored Suits',
            badge: 'ITALIAN WOOL',
            description: 'Two-piece bespoke suits & pleated trousers',
            editionsCount: '12 Editions',
            image:
                'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?auto=format&fit=crop&w=300&q=80',
            iconKey: 'work',
          ),
          SubDepartmentModel(
            id: 203,
            name: 'Evening & Silk',
            badge: 'ATELIER',
            description: 'Mulberry silk dresses, evening slip & tuxedos',
            editionsCount: '10 Editions',
            image:
                'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?auto=format&fit=crop&w=300&q=80',
            iconKey: 'auto_awesome',
          ),
          SubDepartmentModel(
            id: 204,
            name: 'Knitwear & Tops',
            badge: 'SIGNATURE',
            description: 'Fine ribbed turtlenecks & relaxed shirts',
            editionsCount: '14 Editions',
            image:
                'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?auto=format&fit=crop&w=300&q=80',
            iconKey: 'style',
          ),
        ],
      ),
      CategoryModel(
        id: 3,
        name: 'Beauty',
        slug: 'beauty',
        description: 'Cellular elixirs, attars & botanical formulations',
        parentCategoryId: null,
        isActive: true,
        collectionLabel: 'Collection 03',
        creationsCount: '26 FORMULATIONS',
        image:
            'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=800&q=80',
        subDepartments: [
          SubDepartmentModel(
            id: 301,
            name: 'Cellular Elixirs',
            badge: 'FERULIC',
            description: 'Pure 24k gold and active vitamin C concentrates',
            editionsCount: '8 Editions',
            image:
                'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=300&q=80',
            iconKey: 'science',
          ),
          SubDepartmentModel(
            id: 302,
            name: 'Haute Parfumerie',
            badge: 'EXTRAIT',
            description: 'Rare aged Taif rose & vintage private oud',
            editionsCount: '12 Editions',
            image:
                'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=300&q=80',
            iconKey: 'sanitizer',
          ),
          SubDepartmentModel(
            id: 303,
            name: 'Botanical Oils',
            badge: 'ORGANIC',
            description: 'Cold-pressed squalane and rosehip face oils',
            editionsCount: '6 Editions',
            image:
                'https://images.unsplash.com/photo-1608248597359-52e043329f79?auto=format&fit=crop&w=300&q=80',
            iconKey: 'eco',
          ),
          SubDepartmentModel(
            id: 304,
            name: 'Bath & Sanctuary',
            badge: 'RITUAL',
            description: 'Aromatic soaks, body lotions & scrub minerals',
            editionsCount: '7 Editions',
            image:
                'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&w=300&q=80',
            iconKey: 'bathtub',
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
