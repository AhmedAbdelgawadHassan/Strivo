import 'package:flutter_screenutil/flutter_screenutil.dart';
// file for global sizes used throughout the application.    done with chatgpt

class AppSizes {
  AppSizes._();

  // ============================================================
  // SPACING
  // ============================================================

  /// 4px
  static double get space4 => 4.w;

  /// 8px
  static double get space8 => 8.w;

  /// 12px
  static double get space12 => 12.w;

  /// 16px
  static double get space16 => 16.w;

  /// 20px
  static double get space20 => 20.w;

  /// 24px
  static double get space24 => 24.w;

  /// 28px
  static double get space28 => 28.w;

  /// 32px
  static double get space32 => 32.w;

  /// 40px
  static double get space40 => 40.w;

  /// 48px
  static double get space48 => 48.w;

  /// 56px
  static double get space56 => 56.w;

  /// 64px
  static double get space64 => 64.w;

  /// 80px
  static double get space80 => 80.w;


  // ============================================================
  // HORIZONTAL SPACING
  // ============================================================

  static double get horizontal4 => 4.w;
  static double get horizontal8 => 8.w;
  static double get horizontal12 => 12.w;
  static double get horizontal16 => 16.w;
  static double get horizontal20 => 20.w;
  static double get horizontal24 => 24.w;
  static double get horizontal32 => 32.w;


  // ============================================================
  // VERTICAL SPACING
  // ============================================================

  static double get vertical4 => 4.h;
  static double get vertical8 => 8.h;
  static double get vertical12 => 12.h;
  static double get vertical16 => 16.h;
  static double get vertical20 => 20.h;
  static double get vertical24 => 24.h;
  static double get vertical32 => 32.h;
  static double get vertical40 => 40.h;
  static double get vertical48 => 48.h;
  static double get vertical64 => 64.h;


  // ============================================================
  // BORDER RADIUS
  // ============================================================

  /// Small radius
  static double get radius4 => 4.r;

  static double get radius8 => 8.r;

  static double get radius10 => 10.r;

  static double get radius12 => 12.r;

  static double get radius16 => 16.r;

  static double get radius20 => 20.r;

  static double get radius24 => 24.r;

  /// Large radius
  static double get radius32 => 32.r;

  /// Fully rounded / pill shape
  static double get radius50 => 50.r;


  // ============================================================
  // ICON SIZES
  // ============================================================

  static double get icon12 => 12.w;

  static double get icon16 => 16.w;

  static double get icon20 => 20.w;

  static double get icon24 => 24.w;

  static double get icon28 => 28.w;

  static double get icon32 => 32.w;

  static double get icon40 => 40.w;

  static double get icon48 => 48.w;

  static double get icon56 => 56.w;

  static double get icon64 => 64.w;


  // ============================================================
  // FONT SIZES
  // ============================================================

  /// Caption / very small text
  static double get font10 => 10.sp;

  /// Small text
  static double get font12 => 12.sp;

  /// Body small
  static double get font14 => 14.sp;

  /// Body / normal text
  static double get font16 => 16.sp;

  /// Body large
  static double get font18 => 18.sp;

  /// Subtitle
  static double get font20 => 20.sp;

  /// Title
  static double get font24 => 24.sp;

  /// Large title
  static double get font28 => 28.sp;

  /// Extra large title
  static double get font32 => 32.sp;

  /// Hero title
  static double get font36 => 36.sp;

  static double get font40 => 40.sp;


  // ============================================================
  // BUTTONS
  // ============================================================

  static double get buttonHeightSmall => 40.h;

  static double get buttonHeightMedium => 48.h;

  static double get buttonHeightLarge => 56.h;

  static double get buttonRadius => 12.r;


  // ============================================================
  // TEXT FIELDS
  // ============================================================

  static double get textFieldHeight => 52.h;

  static double get textFieldRadius => 12.r;

  static double get textFieldHorizontalPadding => 16.w;

  static double get textFieldVerticalPadding => 14.h;


  // ============================================================
  // CARDS
  // ============================================================

  static double get cardRadius => 16.r;

  static double get cardPadding => 16.w;

  static double get cardSmallPadding => 12.w;

  static double get cardLargePadding => 20.w;


  // ============================================================
  // AVATAR
  // ============================================================

  static double get avatarSmall => 32.w;

  static double get avatarMedium => 40.w;

  static double get avatarLarge => 56.w;

  static double get avatarXLarge => 80.w;


  // ============================================================
  // APP BAR
  // ============================================================

  static double get appBarHeight => 56.h;


  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  static double get bottomNavHeight => 64.h;


  // ============================================================
  // DIVIDERS
  // ============================================================

  static double get dividerThickness => 1.h;


  // ============================================================
  // COMMON COMPONENTS
  // ============================================================

  static double get progressBarHeight => 8.h;

  static double get chipHeight => 32.h;

  static double get chipRadius => 16.r;

  static double get badgeSize => 20.w;

  static double get floatingButtonSize => 56.w;


  // ============================================================
  // IMAGES
  // ============================================================

  static double get imageSmall => 80.w;

  static double get imageMedium => 120.w;

  static double get imageLarge => 180.w;

  static double get imageXLarge => 240.w;


  // ============================================================
  // SCREEN PADDING
  // ============================================================

  static double get screenHorizontalPadding => 16.w;

  static double get screenHorizontalPaddingMedium => 20.w;

  static double get screenHorizontalPaddingLarge => 24.w;

  static double get screenVerticalPadding => 16.h;

  static double get screenVerticalPaddingMedium => 20.h;
  
  static double get screenVerticalPaddingLarge => 24.h;


  // ============================================================
  // RESPONSIVE SCREEN VALUES
  // ============================================================

  /// 50% of screen width
  static double get halfScreenWidth => 0.5.sw;

  /// 80% of screen width
  static double get eightyPercentScreenWidth => 0.8.sw;

  /// 90% of screen width
  static double get ninetyPercentScreenWidth => 0.9.sw;

  /// 50% of screen height
  static double get halfScreenHeight => 0.5.sh;

  /// 80% of screen height
  static double get eightyPercentScreenHeight => 0.8.sh;

  /// 90% of screen height
  static double get ninetyPercentScreenHeight => 0.9.sh;
}
