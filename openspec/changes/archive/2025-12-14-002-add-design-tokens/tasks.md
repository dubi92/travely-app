# Implementation Tasks

## 1. Analyze Designs (HTML = tokens & structure, PNG = visual reference)
- [x] 1.1 Read `travely-design/welcome_/_value_proposition/code.html` - extract tailwind config (colors, fonts, radius)
- [x] 1.2 Read `travely-design/sign_up_/_login/code.html` - extract input styles, social button markup
- [x] 1.3 Read `travely-design/trips_list_3/code.html` - extract card styles, badge colors, avatar sizes
- [x] 1.4 Read `travely-design/itinerary_overview_(timeline_view)/code.html` - extract timeline styles, status colors
- [x] 1.5 Read `travely-design/expenses_overview/code.html` - extract chart colors, progress bar styles
- [x] 1.6 Read `travely-design/split_overview_1/code.html` - extract balance colors (success/error)
- [x] 1.7 Read `travely-design/add_expense_-_production_ready_v3_4/code.html` - extract form styles, segmented controls
- [x] 1.8 (Optional) Read corresponding `screen.png` files for visual verification

## 2. Create Color Tokens
- [x] 2.1 Create `lib/core/theme/app_colors.dart`
- [x] 2.2 Define primary color and variants (light, dark)
- [x] 2.3 Define semantic colors (success, warning, error)
- [x] 2.4 Define neutral colors (background, surface, border)
- [x] 2.5 Define text colors (primary, secondary, disabled)

## 3. Create Typography Tokens
- [x] 3.1 Create `lib/core/theme/app_typography.dart`
- [x] 3.2 Define heading styles (h1, h2, h3)
- [x] 3.3 Define body styles (large, regular, small)
- [x] 3.4 Define caption and button text styles
- [x] 3.5 Create TextTheme extension

## 4. Create Spacing Tokens
- [x] 4.1 Create `lib/core/theme/app_spacing.dart`
- [x] 4.2 Define spacing scale (xs, sm, md, lg, xl, xxl)
- [x] 4.3 Define common padding presets
- [x] 4.4 Define common margin presets

## 5. Create Additional Tokens
- [x] 5.1 Create `lib/core/theme/app_shadows.dart` - shadow definitions
- [x] 5.2 Create `lib/core/theme/app_radius.dart` - border radius values
- [x] 5.3 Create `lib/core/theme/app_durations.dart` - animation durations

## 6. Create Theme Configuration
- [x] 6.1 Create `lib/core/theme/app_theme.dart`
- [x] 6.2 Configure light ThemeData with all tokens
- [x] 6.3 Create theme extension for custom tokens
- [x] 6.4 Export all theme files from barrel file

## 7. Update Spec
- [x] 7.1 Update `openspec/specs/design-system/spec.md` with extracted values
- [x] 7.2 Validate all hex codes match designs
- [x] 7.3 Document any design inconsistencies found

## 8. Validation
- [x] 8.1 Run `openspec validate add-design-tokens --strict`
- [x] 8.2 Ensure all files compile without errors
