// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:beneesse_widgetbook/use_cases/atoms/be_button_use_cases.dart'
    as _beneesse_widgetbook_use_cases_atoms_be_button_use_cases;
import 'package:beneesse_widgetbook/use_cases/atoms/be_divider_use_cases.dart'
    as _beneesse_widgetbook_use_cases_atoms_be_divider_use_cases;
import 'package:beneesse_widgetbook/use_cases/atoms/be_icon_use_cases.dart'
    as _beneesse_widgetbook_use_cases_atoms_be_icon_use_cases;
import 'package:beneesse_widgetbook/use_cases/atoms/be_text_use_cases.dart'
    as _beneesse_widgetbook_use_cases_atoms_be_text_use_cases;
import 'package:beneesse_widgetbook/use_cases/molecules/be_app_bar_use_cases.dart'
    as _beneesse_widgetbook_use_cases_molecules_be_app_bar_use_cases;
import 'package:beneesse_widgetbook/use_cases/molecules/be_bottom_nav_bar_use_cases.dart'
    as _beneesse_widgetbook_use_cases_molecules_be_bottom_nav_bar_use_cases;
import 'package:beneesse_widgetbook/use_cases/molecules/be_card_use_cases.dart'
    as _beneesse_widgetbook_use_cases_molecules_be_card_use_cases;
import 'package:beneesse_widgetbook/use_cases/molecules/be_tab_bar_use_cases.dart'
    as _beneesse_widgetbook_use_cases_molecules_be_tab_bar_use_cases;
import 'package:beneesse_widgetbook/use_cases/molecules/be_text_field_use_cases.dart'
    as _beneesse_widgetbook_use_cases_molecules_be_text_field_use_cases;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Atoms',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'BeButton',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeButton',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Content modes',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonContentModes,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Disabled',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonDisabled,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Loading',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonLoading,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Sizes',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonSizes,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Variants',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_button_use_cases
                        .beButtonVariants,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeDivider',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeDivider',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _beneesse_widgetbook_use_cases_atoms_be_divider_use_cases
                        .beDividerDefault,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeIcon',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeIcon',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Size and color matrix',
                builder: _beneesse_widgetbook_use_cases_atoms_be_icon_use_cases
                    .beIconMatrix,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeText',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeText',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Color roles',
                builder: _beneesse_widgetbook_use_cases_atoms_be_text_use_cases
                    .beTextColorRoles,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Typography',
                builder: _beneesse_widgetbook_use_cases_atoms_be_text_use_cases
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
        name: 'BeAppBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeAppBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'With back button',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_app_bar_use_cases
                        .beAppBarWithBack,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Without back button',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_app_bar_use_cases
                        .beAppBarWithoutBack,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeBottomNavBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeBottomNavBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_bottom_nav_bar_use_cases
                        .beBottomNavBarInteractive,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeCard',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeCard',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_card_use_cases
                        .beCardDefault,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Tappable',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_card_use_cases
                        .beCardTappable,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeTabBar',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeTabBar',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Interactive',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_tab_bar_use_cases
                        .beTabBarInteractive,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_tab_bar_use_cases
                        .beTabBarKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Sizes',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_tab_bar_use_cases
                        .beTabBarSizes,
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'BeTextField',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'BeTextField',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'Default',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_text_field_use_cases
                        .beTextFieldDefault,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Disabled',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_text_field_use_cases
                        .beTextFieldDisabled,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'Knobs',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_text_field_use_cases
                        .beTextFieldKnobs,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'With error',
                builder:
                    _beneesse_widgetbook_use_cases_molecules_be_text_field_use_cases
                        .beTextFieldWithError,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
