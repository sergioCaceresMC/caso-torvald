# Fonts

Place the **Hadassah Friedlaender** web font files here so the body typeface
loads. The stylesheet (`src/styles/global.css`) expects:

- `hadassah-friedlaender.woff2`
- `hadassah-friedlaender.woff`

Until these files are added, the body text falls back to the serif stack
(`Palatino Linotype → Palatino → Georgia → serif`).

**Poppins** (used for titles) is loaded from Google Fonts in
`src/layouts/BaseLayout.astro` and needs no local files.
