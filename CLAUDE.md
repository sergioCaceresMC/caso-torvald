# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# El Caso Torvald — Linux Escape Room (web)

An Astro static site that teaches Linux terminal commands through a detective
escape room. The player investigates the murder of Lord Edmund Torvald across
six "rooms" (chapters). Each chapter is unlocked by entering a password the
player discovers by running real commands in their own Linux terminal; progress
is persisted in `localStorage`.

The cast is themed after the Linux world: the victim is Lord Edmund **Torvald**,
the detective is Marcos **Kernel**, and the suspects carry distro/command
surnames (Gentoo, Bash, Fedora, Grub, Cron, Debian).

The site is in **Spanish**. All UI copy and story text should stay in Spanish.

## The game has two halves — keep them in sync

The web app is only one half. The other half is **`src/assets/setup.sh`**, the
bash script the player runs in their own Linux terminal. **Each chapter's password
is embedded in the generated files** — the player finds it with the commands that
chapter teaches, then types it into the web app.

The terminal half is itself an interactive program, not just static files.
`setup.sh` builds **only `mansion/entrada/`** (welcome, detective notebook,
hidden `.sobre_sellado.txt` with password 1, and the lever). The rest of the
mansion is generated on demand by nested helper scripts that each gate progress:

- `entrada/palanca.sh <pass>` — the lever; needs `DETECTIVE_KERNEL`, then builds
  `biblioteca/`, `cocina/`, and `salon_principal/laboratorio/`.
- `biblioteca/muro_libros.sh <libro>` — book-wall; needs `DIGITALINA`, then
  reveals the hidden `biblioteca/estudio/`.
- `cocina/olla.sh` — must be `mv`'d to `entrada/` and run there; deletes the fake
  notes from `notas_revueltas/`, leaving the two real ones.
- `laboratorio/maquina_huellas.sh` — needs `placa.txt` edited to `ESTADO: LISTA`
  (nano) and `chmod +x`; emits `huellas_reveladas.txt` (names + `DIGITALINA`).
- `salon_principal/inspector.sh` — reads the 5 clue files piped in order
  **5-1-2-3-4** (matched via `### EVIDENCIA E1..E5` tags); needs `chmod +x`;
  reveals `ISOLDE_CULPABLE` + the final code.

The map (parentheses = generated later): `entrada → {biblioteca → (estudio),
cocina, salon_principal → laboratorio}`. Map order ≠ chapter order: chapters run
entrada(1) · biblioteca(2) · cocina(3) · laboratorio(4) · estudio(5) · salon(6).
Clue/evidence files use in-world names (`diario_lord.txt`, `frasco_arsenico.txt`,
`confesion_manuscrita.txt`…), never literal `pista`/`falsa`; per-room guidance
lives in `cuaderno_detective.txt`. Long decoy docs (diary, expediente) are
generated with bash loops to exceed 100 lines so `cat` is impractical.

> **Critical invariant:** the passwords in `PASSWORDS` (`src/data/chapters.ts`)
> MUST exactly match the ones written into the files by `setup.sh`
> (e.g. `DETECTIVE_KERNEL`, `TRAICION`, `ARSENIC_KITCHEN`, `DIGITALINA`,
> `HERENCIA`, `ISOLDE_CULPABLE`; final certificate code `CASO_RESUELTO_TORVALD_2024`).
> Renaming a character also touches names embedded in `setup.sh` ASCII banner
> boxes (58-column inner width) — re-pad those lines if the length changes.
> Each chapter's taught `commands` must also
> actually surface its password in that room. If you change a password, a story
> beat, or which commands a chapter teaches, update **both** files together —
> otherwise the game becomes unsolvable.

## Commands

```bash
npm run dev      # local dev server (http://localhost:4321)
npm run build    # static build to ./dist
npm run preview  # preview the production build
```

There is no test suite. ESLint (`eslint.config.js`, flat config: JS +
typescript-eslint + eslint-plugin-astro) and Prettier (`.prettierrc`, with
`prettier-plugin-astro`) are configured but **not wired to npm scripts** — run
them directly with `npx eslint .` / `npx prettier --write .`.

## Tech stack

- **Astro 4** (`output: 'static'`) — no UI framework, just `.astro` components.
- Vanilla TypeScript for the small amount of client-side logic.
- No CSS framework: styling is hand-written CSS using design tokens (CSS
  custom properties) defined in `src/styles/global.css`.

## Project structure

```
src/
  data/
    chapters.ts        # Chapter[] content (stock image + image2 + evidence) + PASSWORDS + COMMAND_INFO
  styles/
    global.css         # design tokens (:root vars), @font-face, resets, base type
  layouts/
    BaseLayout.astro   # <html> shell, <head>, font loading, imports global.css
  components/
    SiteHeader.astro   # shared header on ALL pages: logo (links home) + MITHA link;
                       #   game controls (progress + reset) only when showGameControls
    ChapterCard.astro  # one chapter PAGE (evidence photo left, case content right)
    Certificate.astro  # final "case solved" page (shown after ch. 6 is solved)
  scripts/
    escapeRoom.ts      # client logic: stepper navigation, unlock flow, localStorage
  pages/
    index.astro        # LANDING page: intro + how-it-works + install + setup.sh download
    caso.astro         # the game: app shell (header + deck + chapter-nav); imports escapeRoom.ts
  assets/
    setup.sh           # player-run script that builds the mansion/ + embeds the passwords;
                       #   downloaded from the landing page via `import ... from './setup.sh?url'`
    brand.jpg          # landing-page hero image
    MithaMiniWeb.png   # logo/brand image
public/
  fonts/               # drop Hadassah Friedlaender web fonts here (see README)
```

### Conventions

- **Each component owns its styles** via a scoped `<style>` block. Only truly
  global concerns (design tokens, fonts, resets, base element typography) live
  in `src/styles/global.css`.
- **Content is data, not markup.** Chapter text/commands/hints live in
  `src/data/chapters.ts`. To edit a chapter's wording, edit that file — not the
  components. `ChapterCard` takes a `Chapter` object via `{...ch}` spread.
- **Passwords** live in `PASSWORDS` in `src/data/chapters.ts`. They are compared
  trimmed and upper-cased. Chapter N's correct password unlocks chapter N+1;
  chapter 6's password reveals the certificate.
- **Client logic** stays in `src/scripts/escapeRoom.ts`, imported once from
  `caso.astro` (the game page, not the landing page). It selects elements by class/id (`.chapter-card`, `.case-content`,
  `.pw-input`, `.pw-btn`, `.pw-feedback`, `#progress-count`, `#certificate`,
  `#reset-btn`, and the nav: `#nav-prev`, `#nav-next`, `#nav-label`, `#nav-dots`).
  It toggles `locked`/`unlocked` (unlock state) and `active` (which page is shown)
  on `.chapter-card`/`#certificate`. Keep these hooks in sync if you rename things.

## Navigation model (one chapter = one page)

The app is a **single-screen stepper**, not a scrolling list. The body is a
fixed-height flex column (header · stage · nav) and never scrolls on desktop;
only the active card's `.case-content` scrolls internally if it overflows.

- Exactly one page is visible at a time — the element with `.active`. The
  `chapter-nav` bar (prev / next / numbered dots) switches pages.
- `steps()` in `escapeRoom.ts` is the ordered page list: the 6 chapter cards,
  plus the certificate once `progress.certificate` is set.
- Solving a chapter unlocks the next one and auto-advances to it. Locked
  chapters remain viewable (sealed) so players can look ahead.
- On narrow screens (≤760px) the layout stacks and the page scrolls normally.

## Design system

Modern, warm "Claude"-style aesthetic (ivory paper + ink) where each section is
dressed as a **detective case file / manuscript**: aged-paper cards with a faint
grain texture, dashed rules, a red "Exp. Nº" stamp, and a framed evidence photo.
The signature accent is **amber `#F8AE2E`** (used in place of Claude's clay
orange). All colors are CSS variables in `:root` (`src/styles/global.css`) —
prefer the tokens over hard-coded hex values.

- Surfaces: `--paper`, `--paper-2`, `--card`, `--card-2`.
- Borders: `--border`, `--border-strong`, `--border-ink`.
- Ink (near-black, warm): `--ink`, `--ink-soft`, `--ink-muted`, `--ink-faint`.
- Amber accent: `--amber` (#F8AE2E), `--amber-deep`, `--amber-dark`,
  `--amber-soft`, `--amber-tint`.
- Yellow: `--yellow`, `--yellow-deep` — reserved for the chapter NUMBER chip.
- Feedback / stamp: `--success-text`, `--error-text`, `--ink-stamp` (red).
- `--paper-grain` is an inline SVG noise texture applied to the body and cards.

**House rules** (per the current design direction):

- **Square corners everywhere except the password box.** Only `.pw-row`/inputs
  use `--radius-sm`; the nav dots stay circular as indicators. Everything else
  (cards, photo, tags, hint, stamps, chips) has straight corners.
- **Chapter number** = `--yellow` background, black text (`.chapter-pill`).
  **Chapter name** = `--amber` (orange) background, black text (`.title-mark`).
- **No emojis** anywhere — use text labels or CSS-drawn marks (e.g. the header
  logo and the "case closed" seal are pure CSS / text).
- A chapter's **story** lives in the right column and is revealed (with the rest
  of `.case-body`) only when the chapter is unlocked; the longer `subtitle`
  shows beforehand.

### Motion & shadows

- **Hover motion is intentional**: cards lift (`translateY`), the evidence photo
  straightens (`rotate(0)`) and zooms (`scale`) while its sepia tint clears,
  command tags lift, the emblem rotates. Keep transitions smooth and subtle.
- **Avoid heavy/colored shadows.** The only shadow tokens are `--lift` /
  `--lift-sm` (a single soft neutral shadow), used sparingly on hover. Prefer
  borders over shadows for definition.
- All motion is wrapped by a `prefers-reduced-motion` reset in `global.css`.

### Imagery

- Each chapter carries a **stock photo** (`image`) and an `evidence` caption in
  `src/data/chapters.ts`. Photos are free-license **Unsplash** images (real
  photographs, not AI-generated), built via the `photo(id)` helper.
- `ChapterCard` adds an `onerror` hook that tags the figure `.img-failed`, which
  hides the broken `<img>` and reveals a textured fallback with the room emoji —
  so a missing photo never looks broken.

### Typography

- **Poppins** (`--font-title`) — headings and prominent titles. Loaded from
  Google Fonts in `BaseLayout.astro`.
- **Hadassah Friedlaender** (`--font-body`) — body text, declared via
  `@font-face` in `global.css`. Add the font files to `public/fonts/`
  (`hadassah-friedlaender.woff2` / `.woff`); falls back to a serif stack until
  then.
- **Monospace** (`--font-mono`) — commands, stamps, captions, password inputs.

## Notes

- `astro.config.mjs` has commented-out `site` / `base` settings for GitHub
  Pages deploy — fill these in before deploying to a project subpath.
- Everything is client-rendered progress on top of a static build; there is no
  backend and no real auth. The passwords are visible in the shipped JS by
  design (it's a learning game, not a secret).
