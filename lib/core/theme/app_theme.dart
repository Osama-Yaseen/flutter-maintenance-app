// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Keep ScreenUtil for responsive font scaling if desired

class AppTheme {
  // --- Custom Color Palette ---
  // A fresh and vibrant primary blue for main branding and action
  static const Color primaryColor = Color(
    0xFF4C6EF5,
  ); // A strong, professional blue
  static const Color onPrimaryColor = Colors.white;

  // A complementary secondary color for accents, interactive elements, or secondary actions
  static const Color secondaryColor = Color(0xFF8B5CF6); // A vibrant purple
  static const Color onSecondaryColor = Colors.white;

  // A tertiary color for additional accents or highlight elements (e.g., warnings, important statuses)
  static const Color tertiaryColor = Color(
    0xFFFF7F32,
  ); // Your existing orange accent
  static const Color onTertiaryColor = Colors.white;

  // Background and Surface Colors
  // Light mode specific surfaces:
  static const Color lightBackgroundColor = Color(
    0xFFFDFBFE,
  ); // Very subtle off-white for main background
  static const Color lightSurfaceColor = Color(
    0xFFFDFBFE,
  ); // Clean white for general surfaces
  static const Color lightSurfaceVariantColor = Color(
    0xFFEADDFF,
  ); // A light, muted color for cards/containers
  static const Color lightOutlineColor = Color(0xFF7A7680); // For borders

  // Dark mode specific surfaces:
  static const Color darkBackgroundColor = Color(
    0xFF1B1B1F,
  ); // Deep dark background
  static const Color darkSurfaceColor = Color(
    0xFF1B1B1F,
  ); // Same as background for consistency
  static const Color darkSurfaceVariantColor = Color(
    0xFF47464F,
  ); // Darker variant for cards/containers
  static const Color darkOutlineColor = Color(
    0xFF948F99,
  ); // Lighter border in dark mode

  // Text Colors
  static const Color lightTextColor = Color(
    0xFF1B1B1F,
  ); // Dark grey for text on light backgrounds
  static const Color darkTextColor = Color(
    0xFFE3E3E7,
  ); // Light grey for text on dark backgrounds (onSurface)

  // Status Colors (from your original theme, slightly adjusted for Material 3 harmony)
  static const Color dangerColor = Color(0xFFBA1A1A); // Material 3 error red
  static const Color warningColor = Color(
    0xFFFFC107,
  ); // Amber (can be adjusted to Material 3 warning if needed)
  static const Color infoColor = Color(
    0xFF2196F3,
  ); // Blue (can be adjusted to Material 3 info if needed)
  static const Color successColor = Color(
    0xFF4CAF50,
  ); // Green (can be adjusted to Material 3 success if needed)
  static const Color errorColor = Color(
    0xFFBA1A1A,
  ); // Explicit Material 3 error
  static const Color onErrorColor = Colors.white;

  // --- Light Color Scheme ---
  static final ColorScheme _lightColorScheme = ColorScheme.light(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: const Color(
      0xFFDDE2FF,
    ), // Lighter shade of primary for containers
    onPrimaryContainer: const Color(0xFF00226B),

    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: const Color(0xFFEADBFF),
    onSecondaryContainer: const Color(0xFF2E006A),

    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    tertiaryContainer: const Color(0xFFFFDBCA),
    onTertiaryContainer: const Color(0xFF4C1000),

    error: errorColor,
    onError: onErrorColor,
    errorContainer: const Color(0xFFFFDAD6),
    onErrorContainer: const Color(0xFF410002),
    surface: lightSurfaceColor,
    onSurface: lightTextColor,
    surfaceContainerHighest: lightSurfaceVariantColor,
    onSurfaceVariant: const Color(0xFF47464F), // Text on surfaceVariant
    outline: lightOutlineColor,
    shadow: Colors.black.withOpacity(0.1), // Subtle shadow color
    inverseSurface:
        darkSurfaceColor, // For elements that invert theme (e.g., SnackBar in light mode)
    onInverseSurface: darkTextColor,
    inversePrimary: const Color(
      0xFFB9C3FF,
    ), // For primary elements in inverse theme
    scrim: Colors.black.withOpacity(0.2),
    brightness: Brightness.light,
  );

  // --- Dark Color Scheme ---
  static final ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: const Color(0xFF00226B),
    onPrimaryContainer: const Color(0xFFDDE2FF),

    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: const Color(0xFF2E006A),
    onSecondaryContainer: const Color(0xFFEADBFF),

    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    tertiaryContainer: const Color(0xFF4C1000),
    onTertiaryContainer: const Color(0xFFFFDBCA),

    error: errorColor,
    onError: onErrorColor,
    errorContainer: const Color(
      0xFFBA1A1A,
    ), // Use the same error color as light for consistency
    onErrorContainer: const Color(0xFFFFDAD6),
    surface: darkSurfaceColor,
    onSurface: darkTextColor,
    surfaceContainerHighest: darkSurfaceVariantColor,
    onSurfaceVariant: const Color(
      0xFFC8C5CD,
    ), // Text on surfaceVariant in dark mode
    outline: darkOutlineColor,
    shadow: Colors.black.withOpacity(0.5),
    inverseSurface: lightSurfaceColor,
    onInverseSurface: lightTextColor,
    inversePrimary: const Color(0xFF4C6EF5),
    scrim: Colors.black.withOpacity(0.5),
    brightness: Brightness.dark,
  );

  // --- Text Styles (using 'Cairo' font family) ---
  // Note: For 'sp' values, ensure you have initialized ScreenUtil in your main.dart
  // Example: ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),
      displayMedium: TextStyle(
        fontSize: 45.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),
      displaySmall: TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),

      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ),

      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // App bar title, section titles
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Card titles, important labels
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Subtitles, small headings

      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Main body text
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Secondary text, descriptions
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
        fontFamily: 'Cairo',
      ), // Smallest text, hints

      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Buttons, large labels
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
        fontFamily: 'Cairo',
      ), // Small labels, tags
      labelSmall: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
        fontFamily: 'Cairo',
      ), // Smallest labels, captions
    );
  }

  // --- Light Theme Data ---
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Enable Material 3
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    fontFamily: 'Cairo',
    textTheme: _buildTextTheme(_lightColorScheme),

    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary, // Icon and text color
      elevation: 4, // Subtle shadow for AppBar
      scrolledUnderElevation: 8, // More shadow when scrolled under
      titleTextStyle: _buildTextTheme(
        _lightColorScheme,
      ).titleLarge?.copyWith(color: _lightColorScheme.onPrimary),
      iconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightColorScheme.primary,
        foregroundColor: _lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        textStyle: _buildTextTheme(
          _lightColorScheme,
        ).labelLarge?.copyWith(color: _lightColorScheme.onPrimary),
        elevation: 3, // Subtle elevation
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        textStyle: _buildTextTheme(
          _lightColorScheme,
        ).labelLarge?.copyWith(color: _lightColorScheme.primary),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        side: BorderSide(color: _lightColorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        textStyle: _buildTextTheme(
          _lightColorScheme,
        ).labelLarge?.copyWith(color: _lightColorScheme.primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightColorScheme.surfaceContainerHighest.withOpacity(
        0.3,
      ), // Lighter fill for input fields
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: _lightColorScheme.outline.withOpacity(0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: _lightColorScheme.outline.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _lightColorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _lightColorScheme.error, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _lightColorScheme.error, width: 2.0),
      ),
      labelStyle: _buildTextTheme(
        _lightColorScheme,
      ).bodyMedium?.copyWith(color: _lightColorScheme.onSurfaceVariant),
      hintStyle: _buildTextTheme(
        _lightColorScheme,
      ).bodySmall?.copyWith(color: _lightColorScheme.outline),
    ),

    cardTheme: CardTheme(
      color:
          _lightColorScheme
              .surfaceContainerHighest, // Cards use surfaceVariant for distinctness
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.r,
        ), // More rounded corners for cards
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _lightColorScheme.primary,
      unselectedItemColor: _lightColorScheme.onSurfaceVariant,
      showUnselectedLabels: true,
      backgroundColor: _lightColorScheme.surface,
      elevation: 8, // Add a slight elevation
      type: BottomNavigationBarType.fixed, // Ensure consistent sizing
      selectedLabelStyle: _buildTextTheme(
        _lightColorScheme,
      ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _buildTextTheme(_lightColorScheme).labelSmall,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: _lightColorScheme.primary,
      unselectedLabelColor: _lightColorScheme.onSurfaceVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: _lightColorScheme.tertiary, width: 3.0),
        borderRadius: BorderRadius.circular(2.r),
      ),
      labelStyle: _buildTextTheme(
        _lightColorScheme,
      ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _buildTextTheme(_lightColorScheme).titleSmall,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor:
          _lightColorScheme.inverseSurface, // Invert for better contrast
      contentTextStyle: _buildTextTheme(
        _lightColorScheme,
      ).bodyMedium?.copyWith(color: _lightColorScheme.onInverseSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    ),
  );

  // --- Dark Theme Data ---
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
    fontFamily: 'Cairo',
    textTheme: _buildTextTheme(_darkColorScheme),

    appBarTheme: AppBarTheme(
      backgroundColor:
          _darkColorScheme.surface, // Use a deep surface for dark app bars
      foregroundColor: _darkColorScheme.onSurface,
      elevation: 4,
      scrolledUnderElevation: 8,
      titleTextStyle: _buildTextTheme(
        _darkColorScheme,
      ).titleLarge?.copyWith(color: _darkColorScheme.onSurface),
      iconTheme: IconThemeData(color: _darkColorScheme.onSurface),
      actionsIconTheme: IconThemeData(color: _darkColorScheme.onSurface),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkColorScheme.primary,
        foregroundColor: _darkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        textStyle: _buildTextTheme(
          _darkColorScheme,
        ).labelLarge?.copyWith(color: _darkColorScheme.onPrimary),
        elevation: 3,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _darkColorScheme.primary,
        textStyle: _buildTextTheme(
          _darkColorScheme,
        ).labelLarge?.copyWith(color: _darkColorScheme.primary),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkColorScheme.primary,
        side: BorderSide(color: _darkColorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        textStyle: _buildTextTheme(
          _darkColorScheme,
        ).labelLarge?.copyWith(color: _darkColorScheme.primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkColorScheme.surfaceContainerHighest.withOpacity(0.3),
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: _darkColorScheme.outline.withOpacity(0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: _darkColorScheme.outline.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _darkColorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _darkColorScheme.error, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: _darkColorScheme.error, width: 2.0),
      ),
      labelStyle: _buildTextTheme(
        _darkColorScheme,
      ).bodyMedium?.copyWith(color: _darkColorScheme.onSurfaceVariant),
      hintStyle: _buildTextTheme(
        _darkColorScheme,
      ).bodySmall?.copyWith(color: _darkColorScheme.outline),
    ),

    cardTheme: CardTheme(
      color: _darkColorScheme.surfaceContainerHighest,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _darkColorScheme.primary,
      unselectedItemColor: _darkColorScheme.onSurfaceVariant,
      showUnselectedLabels: true,
      backgroundColor: _darkColorScheme.surface,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: _buildTextTheme(
        _darkColorScheme,
      ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _buildTextTheme(_darkColorScheme).labelSmall,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: _darkColorScheme.primary,
      unselectedLabelColor: _darkColorScheme.onSurfaceVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: _darkColorScheme.tertiary, width: 3.0),
        borderRadius: BorderRadius.circular(2.r),
      ),
      labelStyle: _buildTextTheme(
        _darkColorScheme,
      ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _buildTextTheme(_darkColorScheme).titleSmall,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: _darkColorScheme.inverseSurface,
      contentTextStyle: _buildTextTheme(
        _darkColorScheme,
      ).bodyMedium?.copyWith(color: _darkColorScheme.onInverseSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    ),
  );
}
