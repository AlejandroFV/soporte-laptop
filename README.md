# Soporte Dual Escalonado Plegable para Laptop y Tablet (OpenSCAD)

Diseño paramétrico en **OpenSCAD** para impresión 3D (100% libre de soportes) de un soporte dual tipo *waterfall* (escalonado) para:
- **Laptop principal**: Dell Latitude 7650 (16", ~2.0 kg, apertura a 180°) y MacBook Pro de 13" (apertura hasta 135°).
- **Tablet principal**: Samsung Galaxy Tab S11 Ultra (14.6", ~730 g) y tablets compactas.

---

## 📸 Vistas de la Versión 1 (`v1/`)

| Dell Latitude 7650 Vertical (75°) + Tab S11 Ultra | MacBook Pro 13" (38°) + Tab S11 Ultra |
| :---: | :---: |
| ![Dell Vertical](v1/renders/dell_vertical_working.png) | ![MacBook Ergonómica](v1/renders/macbook_working.png) |

| Estructura Abierta con 3 Ranuras | Soporte Plegado Compacto |
| :---: | :---: |
| ![Estructura 3 Ranuras](v1/renders/dual_slots_structure.png) | ![Soporte Plegado](v1/renders/stand_folded.png) |

---

## 📂 Organización del Repositorio

Toda la implementación de la primera versión funcional e impresa físicamente se encuentra organizada dentro de **[`v1/`](v1/)**:

- **[`v1/soporte-laptop.3mf`](v1/soporte-laptop.3mf)**: Proyecto de impresión para Bambu Studio actualizado con la geometría final de la V1.
- **[`v1/src/`](v1/src/)**: Código fuente paramétrico en OpenSCAD:
  - [`stand_config.scad`](v1/src/stand_config.scad) — Parámetros maestros del soporte.
  - [`bracket.scad`](v1/src/bracket.scad) — Soportes laterales monolíticos con 3 ranuras independientes (Tablet a 55°, MacBook a 38° y Dell vertical a 75°).
  - [`folding_link.scad`](v1/src/folding_link.scad) — Barras articuladas tipo tijera a dos niveles (cierran de 180° a 15° sin colisión).
  - [`printed_pin.scad`](v1/src/printed_pin.scad) — Sistema de pasadores enrasados (`flush_bracket_pin`), autoblocantes (`snap_pin`) y con C-clip (`hinge_pin_grip` + `retainer_clip`).
  - [`assembly.scad`](v1/src/assembly.scad) — Ensamble interactivo 3D con cinemática de plegado y maquetas de dispositivos.
  - [`print_plate.scad`](v1/src/print_plate.scad) y [`plate_accessories_folding.scad`](v1/src/plate_accessories_folding.scad) — Bandejas de impresión listas para laminar.
- **[`v1/stl/`](v1/stl/)**: Modelos STL individuales y por bandejas listos para laminar:
  - [`single_plate_complete.stl`](v1/stl/single_plate_complete.stl) — Bandeja completa todo-en-uno (2 soportes + 4 barras tijera + pasadores).
  - [`plate_accessories_folding.stl`](v1/stl/plate_accessories_folding.stl) — Bandeja de accesorios plegables (4 barras tijera + 4 pasadores enrasados + 2 pasadores snap-fit centrales + juego con C-clips).
  - [`bracket_left.stl`](v1/stl/bracket_left.stl) / [`bracket_right.stl`](v1/stl/bracket_right.stl) — Soportes laterales individuales.
  - [`folding_links_x4.stl`](v1/stl/folding_links_x4.stl) — Las 4 barras articuladas tipo tijera.
  - [`flush_pins_x4.stl`](v1/stl/flush_pins_x4.stl) — Los 4 pasadores enrasados para las orejetas de la base (cero saliente inferior).
  - [`pins_and_clips.stl`](v1/stl/pins_and_clips.stl) — Juego de pasadores snap-fit y C-clips.
- **[`v1/renders/`](v1/renders/)**: Renders de referencia del soporte abierto, plegado y con dispositivos.

👉 Consulta **[`v1/README.md`](v1/README.md)** para más detalles sobre cada pieza y cómo regenerar los STL.

---

## 🖨️ Parámetros Recomendados de Impresión 3D

| Parámetro | Valor Recomendado | Notas |
| :--- | :--- | :--- |
| **Material** | **PETG** o **PLA+ / PLA Pro** | PETG es ideal por su flexibilidad elástica en los pasadores snap-fit y resistencia mecánica. |
| **Altura de Capa** | `0.20 mm` | Equilibrio óptimo entre resistencia y precisión dimensional. |
| **Paredes / Perímetros** | **4 paredes** | Aporta la mayor rigidez estructural en las torres y vigas. |
| **Capas Superior / Inferior**| **5 superiores / 4 inferiores** | Proporciona caras planas sólidas. |
| **Relleno (Infill)** | **25% - 30%** | Patrón Gyroid, Rectilinear o Cubic. |
| **Soportes** | **DESACTIVADOS (None)** | 100% imprimible sin soportes. |

---

## 📄 Licencia

Este proyecto y todos sus archivos 3D (`.scad`, `.stl`, `.3mf`) están bajo la licencia **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International ([CC BY-NC-SA 4.0](LICENSE))**:
- **Uso personal libre**: Puedes imprimir, modificar y compartir el diseño libremente dando crédito al autor.
- **No Comercial**: Queda prohibida la venta comercial de los archivos digitales o de las piezas físicas impresas sin autorización.
- **Compartir Igual**: Las mejoras o derivados deben compartirse bajo la misma licencia.
