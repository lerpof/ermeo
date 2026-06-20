// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ermeo_widgetbook/use_cases/atoms/er_badge_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_badge_use_cases;
import 'package:ermeo_widgetbook/use_cases/atoms/er_button_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_button_use_cases;
import 'package:ermeo_widgetbook/use_cases/atoms/er_divider_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_divider_use_cases;
import 'package:ermeo_widgetbook/use_cases/atoms/er_icon_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_icon_use_cases;
import 'package:ermeo_widgetbook/use_cases/atoms/er_keycap_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_keycap_use_cases;
import 'package:ermeo_widgetbook/use_cases/atoms/er_text_use_cases.dart'
    as _ermeo_widgetbook_use_cases_atoms_er_text_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_app_bar_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_app_bar_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_bottom_nav_bar_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_bottom_nav_bar_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_card_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_card_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_pill_tab_bar_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_pill_tab_bar_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_tab_bar_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_tab_bar_use_cases;
import 'package:ermeo_widgetbook/use_cases/molecules/er_text_field_use_cases.dart'
    as _ermeo_widgetbook_use_cases_molecules_er_text_field_use_cases;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Atoms',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'ErBadge',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErBadge',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder: _ermeo_widgetbook_use_cases_atoms_er_badge_use_cases
                    .beBadgeVariants,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErButton',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Content modes',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonContentModes,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Disabled',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonDisabled,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Loading',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonLoading,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Sizes',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonSizes,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder: _ermeo_widgetbook_use_cases_atoms_er_button_use_cases
                    .beButtonVariants,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErDivider',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErDivider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _ermeo_widgetbook_use_cases_atoms_er_divider_use_cases
                    .beDividerDefault,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErIcon',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErIcon',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Size and color matrix',
                builder: _ermeo_widgetbook_use_cases_atoms_er_icon_use_cases
                    .beIconMatrix,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErKeycap',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErKeycap',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _ermeo_widgetbook_use_cases_atoms_er_keycap_use_cases
                    .beKeycapDefault,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErText',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErText',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Color roles',
                builder: _ermeo_widgetbook_use_cases_atoms_er_text_use_cases
                    .beTextColorRoles,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Typography',
                builder: _ermeo_widgetbook_use_cases_atoms_er_text_use_cases
                    .beTextTypography,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookCategory(
    name: 'Molecules',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'ErAppBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErAppBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'With back button',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_app_bar_use_cases
                        .beAppBarWithBack,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Without back button',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_app_bar_use_cases
                        .beAppBarWithoutBack,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErBottomNavBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErBottomNavBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_bottom_nav_bar_use_cases
                        .beBottomNavBarInteractive,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErCard',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder: _ermeo_widgetbook_use_cases_molecules_er_card_use_cases
                    .beCardDefault,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Tappable',
                builder: _ermeo_widgetbook_use_cases_molecules_er_card_use_cases
                    .beCardTappable,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErPillTabBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErPillTabBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_pill_tab_bar_use_cases
                        .bePillTabBarDefault,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_pill_tab_bar_use_cases
                        .bePillTabBarKnobs,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErTabBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErTabBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_tab_bar_use_cases
                        .beTabBarInteractive,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_tab_bar_use_cases
                        .beTabBarKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Sizes',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_tab_bar_use_cases
                        .beTabBarSizes,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'ErTextField',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'ErTextField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_text_field_use_cases
                        .beTextFieldDefault,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Disabled',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_text_field_use_cases
                        .beTextFieldDisabled,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_text_field_use_cases
                        .beTextFieldKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With error',
                builder:
                    _ermeo_widgetbook_use_cases_molecules_er_text_field_use_cases
                        .beTextFieldWithError,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
