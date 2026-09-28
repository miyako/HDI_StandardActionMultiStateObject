# HDI_StandardActionMultiStateObject

A 4D **HDI** (How Do I) example demonstrating how to build a **4D Write Pro / styled-text toolbar** entirely out of **standard actions** bound to **multi-state icon objects** — no click-handling or state-tracking code required. Originally distributed as a binary `.4DB` database, it has been converted to the modern 4D project (`.4DProject`) architecture and modernised for current 4D language conventions with the help of **GitHub Copilot**.

## Overview

A standard action (`"action"` property) can be attached directly to a checkbox styled as a toolbar icon (`"style": "toolbar"`, `"iconFrames": 4`). 4D then drives the object's pressed/unpressed/disabled icon frame automatically to reflect the current selection state (bold, italic, underline, ...), and enables/disables it based on context — all without a single line of event-handling code. This example wires up such a toolbar once and shares it across two different text-editing engines (a styled-text `input` area and a 4D Write Pro `write` area), switching visibility per tab.

## Features

- **Multi-state toolbar buttons** — `Tb_bold`, `Tb_italic`, `Tb_underline` are checkboxes with `iconFrames: 4` and `"style": "toolbar"`, each bound to a standard action (`fontBold`, `fontItalic`, `fontUnderline`). 4D updates their pressed/depressed icon frame automatically to match the current text selection.
- **Standard-action dropdowns** — a font-size dropdown bound to `"action": "fontSize"`, plus font-color and background-color dropdowns populated from a hierarchical choice list (`Resources/.../lists.json`) instead of a hardcoded array.
- **One toolbar, two text engines** — the same toolbar is shown above both a styled-text area (`stText`, `"styledText": true`) and a 4D Write Pro area (`WriteProArea`), switching visibility with the tab control instead of duplicating the toolbar per page.
- **Tab-driven visibility** — `Tab Control.4dm` shows/hides the whole toolbar (`"Tb_@"` wildcard) depending on which tab is active, so the toolbar only appears where it's relevant.
- **Modern splash/startup flow** — the `00_Start` entry point uses `CALL WORKER`, a non-blocking `DIALOG(...;*)`, and window-reuse detection instead of spawning a new process or blocking on a modal dialog.

## Project structure

| Path | Contents |
|------|----------|
| `Project/Sources/Methods/00_Start.4dm` | Splash/startup entry point (worker dispatch, window reuse, non-blocking dialog). |
| `Project/Sources/Methods/InitText.4dm` | Loads localized sample text/JSON used to populate the demo areas. |
| `Project/Sources/Forms/HDI/` | Splash screen form, its `On Load` method, and the `BtnDemo` object method that opens the main demo. |
| `Project/Sources/Forms/HDI2/` | Main demo form: the toolbar of standard-action buttons, the tab control, the "Information" tab, the styled-text tab, and the 4D Write Pro tab. |
| `Project/Sources/TableForms/4/` | Default input/output forms for the `SAMPLE` table used to seed demo content. |
| `Project/Sources/menus.json` | Menu bar definition (File/Edit/Mode), using standard actions (e.g. `"action": "quit"`) where applicable. |
| `Project/Sources/lists.json` | Hierarchical choice lists backing the font-color/background-color dropdowns. |
| `Project/Sources/styleSheets*.css` | Cross-platform and macOS/Windows-specific form stylesheets (dark mode, Liquid Glass button sizing). |
| `Resources/{lang}.lproj/*.xlf` | XLIFF translation files (English source + Japanese), grouped by menu/form/messages. |

## Points of interest

| File | Why it's worth reading |
|------|-------------------------|
| `Project/Sources/Forms/HDI2/form.4DForm` | The toolbar itself: checkboxes with `iconFrames`/`"style": "toolbar"` bound to `fontBold`/`fontItalic`/`fontUnderline`/`fontSize`, next to plain dropdowns driven by `choiceList.$ref` into `lists.json`. |
| `Project/Sources/Forms/HDI2/ObjectMethods/Tab Control.4dm` | Shows how a form-wide group of objects (`"Tb_@"` wildcard) is shown/hidden together based on the active tab, rather than toggling each object individually. |
| `Project/Sources/Methods/00_Start.4dm` | The splash/startup pattern: worker dispatch, window reuse, non-blocking dialog. |
| `Project/Sources/Forms/HDI/ObjectMethods/BtnDemo.4dm` | Transition from the splash screen to the main demo, reusing `Form`-scoped state instead of interprocess variables. |
| `Project/Sources/styleSheets.css`, `styleSheets_mac.css` | Dark mode and Liquid Glass adaptation via `prefers-color-scheme`/`form-theme` media queries. |
| `Resources/*.lproj/*.xlf` | XLIFF localisation structure (menus, per-form, messages), in English and Japanese. |

## Modernisation notes

Beyond the standard-action demo itself, the codebase has been brought up to current 4D conventions:

- **Localisation** — all menu titles, form text/labels, and message strings use `:xliff:` references or `Localized string(...)`, backed by XLIFF files under `Resources/`.
- **Modern variable declarations** — legacy `C_LONGINT`/`C_TEXT`/etc. directives have been replaced with `var`/`#DECLARE`.
- **Standard menu actions** — the one-line `m_Quit` wrapper method was removed in favor of the built-in `"action": "quit"`.
- **Method visibility** — subroutines with no standalone entry-point purpose (e.g. `InitText`) are marked `"invisible": true` so only real entry points appear in the Run Method dialog.
- **Modern startup pattern** — `#DECLARE`, `CALL WORKER` (instead of `New process`), and non-blocking `DIALOG(...; *)`.
- **Dark mode & Liquid Glass** — forms use `"automatic"` colors and `prefers-color-scheme`/`form-theme` media queries instead of hardcoded hex colors, so the UI adapts to system appearance and to macOS Tahoe's Liquid Glass button styling.
- **List boxes** — not applicable; this project doesn't use any list box objects.

## Requirements

- 4D 21.1 or later (project uses `compatibilityVersion: 2101`).

## Getting started

1. Open `Project/HDI_StandardActionMultiStateObject.4DProject` in 4D.
2. Run the `00_Start` method (or use the **File > Demo...** menu item) to open the splash screen, then click **Demo** to open the main window.
3. Switch between the **Information**, **Styled Text**, and **4D Write Pro** tabs; the toolbar appears on the latter two and reflects/edits the current text selection's formatting.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16 R4. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (syntax, localisation, dark mode) with the help of **GitHub Copilot**.

- **Blog post:** https://blog.4d.com/easily-design-your-own-4d-write-pro-toolbar-with-standard-actions/
- **Original download:** https://download.4d.com/Demos/4D_v16_R4/HDI_StandardActionMultiStateObject.zip

## References

- Standard actions overview: https://blog.4d.com/discover-and-use-standard-actions/
- Form object properties reference (icon frames, toolbar style, actions): https://developer.4d.com/docs/FormObjects/propertiesReference
- CSS in 4D (dark mode, Liquid Glass): https://developer.4d.com/docs/FormEditor/stylesheets
- XLIFF localisation: https://developer.4d.com/docs/Notions/localization
