import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand palette.
///
/// Primary #101820 (deep charcoal navy) anchors the dark theme and provides
/// the ink of the light theme; accent #F2AA4C (warm amber) is used with
/// restraint for primary actions, highlights and focus. Surfaces are stepped,
/// slightly warm navies so cards read as layered panels rather than flat fills.
abstract final class AppColors {
  static const primary = Color(0xFF101820);
  static const accent = Color(0xFFF2AA4C);
  static const accentBright = Color(0xFFFFC46B); // hover / emphasis
  static const accentDim = Color(0xFFB97A22); // light-theme accent (contrast)

  // Dark surfaces — stepped elevations above the primary navy.
  static const darkBackground = Color(0xFF0C131B);
  static const darkSurface = Color(0xFF161F2A);
  static const darkSurfaceHigh = Color(0xFF1E2A38);
  static const darkOutline = Color(0xFF2B3B4D);
  static const darkOutlineSoft = Color(0xFF1F2C3A);

  // Light surfaces.
  static const lightBackground = Color(0xFFF6F7F9);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceHigh = Color(0xFFEEF1F4);
  static const lightOutline = Color(0xFFDFE3E9);
  static const lightOutlineSoft = Color(0xFFEBEEF2);

  static const success = Color(0xFF4CAF7D);
  static const danger = Color(0xFFE5646E);

  // Text tones.
  static const darkText = Color(0xFFEAF0F6);
  static const darkTextMuted = Color(0xFF9DB0C2);
  static const lightText = Color(0xFF101820);
  static const lightTextMuted = Color(0xFF5B6B7B);
}

/// Shared radii so every surface in the app rounds consistently.
abstract final class AppRadii {
  static const card = 20.0;
  static const control = 14.0;
  static const pill = 999.0;
}

abstract final class AppTheme {
  static ThemeData dark() {
    final scheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: AppColors.accent,
      onPrimary: AppColors.primary,
      primaryContainer: AppColors.accent,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.accent,
      onSecondary: AppColors.primary,
      tertiary: AppColors.accentBright,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkTextMuted,
      surfaceContainerLowest: AppColors.darkBackground,
      surfaceContainerLow: Color(0xFF121B24),
      surfaceContainer: AppColors.darkSurface,
      surfaceContainerHigh: AppColors.darkSurfaceHigh,
      surfaceContainerHighest: Color(0xFF243342),
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineSoft,
      error: AppColors.danger,
      onError: Colors.white,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }

  static ThemeData light() {
    final scheme = const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.accentDim,
      onSecondary: Colors.white,
      tertiary: AppColors.accent,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      onSurfaceVariant: AppColors.lightTextMuted,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: AppColors.lightBackground,
      surfaceContainer: AppColors.lightSurface,
      surfaceContainerHigh: AppColors.lightSurfaceHigh,
      surfaceContainerHighest: Color(0xFFE7EBF0),
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineSoft,
      error: AppColors.danger,
      onError: Colors.white,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.lightBackground,
    );
  }

  static ThemeData _base(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;

    // Body text: Inter (clean, neutral, excellent on screens).
    final baseText = GoogleFonts.interTextTheme(
      ThemeData(brightness: scheme.brightness).textTheme,
    );
    // Display face: Sora — geometric, a little characterful, pairs well with
    // Inter and gives headings a distinct voice rather than the default look.
    final display = GoogleFonts.soraTextTheme(baseText);

    final textTheme = baseText.copyWith(
      displaySmall: display.displaySmall
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.8),
      headlineMedium: display.headlineMedium
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.6),
      headlineSmall: display.headlineSmall
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
      titleLarge: display.titleLarge
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
      titleMedium: baseText.titleMedium
          ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.1),
      titleSmall: baseText.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: baseText.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyMedium: baseText.bodyMedium?.copyWith(height: 1.45),
      bodyLarge: baseText.bodyLarge?.copyWith(height: 1.5),
    ).apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: scheme.brightness,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
          fontSize: 22,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: isDark ? 0.5 : 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor:
        isDark ? scheme.surfaceContainerHigh : scheme.surface,
        selectedColor: scheme.secondary.withValues(alpha: isDark ? 0.22 : 0.16),
        checkmarkColor: scheme.secondary,
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        pressElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.secondary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
          highlightColor: scheme.secondary.withValues(alpha: 0.12),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.secondary.withValues(alpha: isDark ? 0.22 : 0.16);
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return scheme.secondary;
            return scheme.onSurfaceVariant;
          }),
          side: WidgetStatePropertyAll(BorderSide(color: scheme.outlineVariant)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          )),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? scheme.surfaceContainerLow : scheme.surface,
        hintStyle: textTheme.bodyMedium
            ?.copyWith(color: scheme.onSurfaceVariant.withValues(alpha: 0.7)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(color: scheme.secondary, width: 1.8),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 66,
        backgroundColor: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.96)
            : scheme.surface,
        indicatorColor: scheme.secondary.withValues(alpha: isDark ? 0.22 : 0.16),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? scheme.secondary : scheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? scheme.secondary : scheme.onSurfaceVariant,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor:
        isDark ? AppColors.darkBackground : scheme.surface,
        indicatorColor: scheme.secondary.withValues(alpha: isDark ? 0.22 : 0.16),
        selectedIconTheme: IconThemeData(color: scheme.secondary),
        unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
        selectedLabelTextStyle: textTheme.labelMedium
            ?.copyWith(color: scheme.secondary, fontWeight: FontWeight.w700),
        unselectedLabelTextStyle: textTheme.labelMedium
            ?.copyWith(color: scheme.onSurfaceVariant),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.secondary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
        indicatorColor: scheme.secondary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: scheme.outlineVariant,
        overlayColor: WidgetStatePropertyAll(
            scheme.secondary.withValues(alpha: 0.06)),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.surfaceContainerHighest,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.labelSmall?.copyWith(color: scheme.onInverseSurface),
      ),
    );
  }
}