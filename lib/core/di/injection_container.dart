import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/dio_consumer.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:aura/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aura/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:aura/features/auth/domain/usecases/auth_change_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/logout_usecase.dart';
import 'package:aura/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:aura/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:aura/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:aura/features/auth/domain/usecases/verify_reset_otp_usecase.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:aura/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:aura/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:aura/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/apply_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/category/data/datasources/category_local_data_source.dart';
import 'package:aura/features/category/data/datasources/category_remote_data_source.dart';
import 'package:aura/features/category/data/repositories/category_repository_impl.dart';
import 'package:aura/features/category/domain/repositories/category_repository.dart';
import 'package:aura/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:aura/features/category/domain/usecases/get_category_details_usecase.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:aura/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:aura/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:aura/features/checkout/domain/usecases/apply_privilege_passcode_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/get_checkout_details_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_delivery_method_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_shipping_address_usecase.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:aura/features/home/data/datasources/home_local_data_source.dart';
import 'package:aura/features/home/data/datasources/home_remote_data_source.dart';
import 'package:aura/features/home/data/repositories/home_repository_impl.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:aura/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:aura/features/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:aura/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:aura/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:aura/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:aura/features/orders/domain/usecases/download_order_invoice_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_my_orders_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_order_details_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_order_tracking_usecase.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/product/data/datasources/product_local_data_source.dart';
import 'package:aura/features/product/data/datasources/product_remote_data_source.dart';
import 'package:aura/features/product/data/repositories/product_repository_impl.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:aura/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:aura/features/product/domain/usecases/get_product_reviews_usecase.dart';
import 'package:aura/features/product/domain/usecases/get_products_usecase.dart';
import 'package:aura/features/product/domain/usecases/submit_product_review_usecase.dart';
import 'package:aura/features/product/domain/usecases/toggle_product_favorite_usecase.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:aura/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:aura/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:aura/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:aura/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:aura/features/profile/domain/usecases/delete_avatar_usecase.dart';
import 'package:aura/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/send_phone_otp_usecase.dart';
import 'package:aura/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/verify_phone_otp_usecase.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:aura/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:aura/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/move_all_to_bag_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  // Home
  sl.registerFactory(
    () => HomeCubit(
      getHomeFeedUseCase: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetHomeFeedUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => const HomeLocalDataSourceImpl(),
  );

  // Cart
  sl.registerLazySingleton(
    () => CartCubit(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      updateCartQuantityUseCase: sl(),
      removeCartItemUseCase: sl(),
      clearCartUseCase: sl(),
      applyVoucherUseCase: sl(),
      removeVoucherUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  sl.registerLazySingleton(() => ApplyVoucherUseCase(sl()));
  sl.registerLazySingleton(() => RemoveVoucherUseCase(sl()));
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => const CartLocalDataSourceImpl(),
  );

  // Wishlist
  sl.registerLazySingleton(
    () => WishlistCubit(
      getWishlistUseCase: sl(),
      addToWishlistUseCase: sl(),
      removeFromWishlistUseCase: sl(),
      moveAllToBagUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));
  sl.registerLazySingleton(() => AddToWishlistUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl()));
  sl.registerLazySingleton(() => MoveAllToBagUseCase(sl()));
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => const WishlistLocalDataSourceImpl(),
  );

  // Profile
  sl.registerLazySingleton(
    () => ProfileCubit(
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      updateAvatarUseCase: sl(),
      deleteAvatarUseCase: sl(),
      sendPhoneOtpUseCase: sl(),
      verifyPhoneOtpUseCase: sl(),
      changePasswordUseCase: sl(),
      deleteAccountUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAvatarUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAvatarUseCase(sl()));
  sl.registerLazySingleton(() => SendPhoneOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneOtpUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => const ProfileLocalDataSourceImpl(),
  );

  // Product
  sl.registerFactory(
    () => ProductCubit(
      getProductDetailsUseCase: sl(),
      toggleProductFavoriteUseCase: sl(),
      getProductsUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReviewCubit(
      getProductReviewsUseCase: sl(),
      submitProductReviewUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductReviewsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitProductReviewUseCase(sl()));
  sl.registerLazySingleton(() => ToggleProductFavoriteUseCase(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => const ProductLocalDataSourceImpl(),
  );

  // Category
  sl.registerFactory(
    () => CategoryCubit(
      getCategoriesUseCase: sl(),
      getCategoryDetailsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryDetailsUseCase(sl()));
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => const CategoryLocalDataSourceImpl(),
  );

  // Orders
  sl.registerFactory(
    () => OrdersCubit(
      getMyOrdersUseCase: sl(),
      getOrderDetailsUseCase: sl(),
      cancelOrderUseCase: sl(),
      downloadOrderInvoiceUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetMyOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderTrackingUseCase(sl()));
  sl.registerLazySingleton(() => CancelOrderUseCase(sl()));
  sl.registerLazySingleton(() => DownloadOrderInvoiceUseCase(sl()));
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<OrdersLocalDataSource>(
    () => const OrdersLocalDataSourceImpl(),
  );

  // Checkout
  sl.registerFactory(
    () => CheckoutCubit(
      getCheckoutDetailsUseCase: sl(),
      selectShippingAddressUseCase: sl(),
      selectDeliveryMethodUseCase: sl(),
      applyPrivilegePasscodeUseCase: sl(),
      placeOrderUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCheckoutDetailsUseCase(sl()));
  sl.registerLazySingleton(() => SelectShippingAddressUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryMethodUseCase(sl()));
  sl.registerLazySingleton(() => ApplyPrivilegePasscodeUseCase(sl()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<CheckoutLocalDataSource>(
    () => const CheckoutLocalDataSourceImpl(),
  );

  // Auth
  sl.registerFactory(
    () => AuthCubit(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      forgotPasswordUseCase: sl(),
      resendOtpUseCase: sl(),
      verifyResetOtpUseCase: sl(),
      resetPasswordUseCase: sl(),
      refreshTokenUseCase: sl(),
      logoutUseCase: sl(),
      changePasswordUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyResetOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AuthChangePasswordUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => const AuthLocalDataSourceImpl(),
  );
}
