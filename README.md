# El Caso Torvald — Linux Escape Room

Sitio estático en Astro que enseña comandos de terminal Linux mediante un escape room de investigación criminal. El jugador resuelve el asesinato del Lord Edmund Torvald atravesando seis "salas" (capítulos), cada una bloqueada por una contraseña que debe descubrir ejecutando comandos reales en su propia terminal Linux.

El elenco sigue la temática del mundo Linux: la víctima es Lord Edmund **Torvald**, el detective es Marcos **Kernel**, y los sospechosos llevan apellidos de distribuciones y comandos (Gentoo, Bash, Fedora, Grub, Cron, Debian).

El sitio está íntegramente en **español**.

---

## Cómo funciona

El juego tiene dos mitades que deben permanecer sincronizadas:

1. **Web**: esta app Astro muestra los capítulos, el argumento y los comandos que el jugador debe aprender. El jugador introduce la contraseña en la web para desbloquear el siguiente capítulo.
2. **Terminal** (`src/assets/setup.sh`): el jugador ejecuta este script en su máquina Linux. Construye la `mansion/` con ficheros y scripts anidados que esconden las contraseñas. El jugador las descubre aplicando los comandos del capítulo correspondiente.

### Capítulos y comandos

| # | Sala | Comandos clave | Contraseña |
|---|------|---------------|------------|
| I | La Entrada | `pwd`, `whoami`, `ls -la`, `cat`, `bash script.sh` | `DETECTIVE_KERNEL` |
| II | La Biblioteca | `less`, `grep`, `head`, `tail` | `TRAICION` |
| III | La Cocina | `cp`, `cp -r`, `mv` | `ARSENIC_KITCHEN` |
| IV | El Laboratorio | `nano`, `chmod +x`, `./script.sh` | `DIGITALINA` |
| V | El Estudio | `cat \| grep` | `HERENCIA` |
| VI | El Salón Principal | `cat`, tuberías, `chmod +x` | `ISOLDE_CULPABLE` |

Código del certificado final: `CASO_RESUELTO_TORVALD_2024`

---

## Desarrollo

```bash
npm install
npm run dev      # servidor local en http://localhost:4321
npm run build    # build estático a ./dist
npm run preview  # previsualizar el build de producción
```

Linting y formato (no están conectados a npm scripts, ejecutar directamente):

```bash
npx eslint .
npx prettier --write .
```

No hay suite de tests.

---

## Stack

- **Astro 4** (`output: 'static'`): solo componentes `.astro`, sin framework de UI.
- **TypeScript** vanilla para la lógica cliente (`src/scripts/escapeRoom.ts`).
- **CSS** puro con variables custom (`src/styles/global.css`): sin framework CSS.

---

## Estructura del proyecto

```
src/
  data/
    chapters.ts        # Contenido de los capítulos + PASSWORDS + COMMAND_INFO
  styles/
    global.css         # Tokens de diseño, @font-face, resets
  layouts/
    BaseLayout.astro   # Shell HTML, <head>, fuentes
  components/
    SiteHeader.astro   # Cabecera compartida
    ChapterCard.astro  # Una página del juego (foto + contenido)
    Certificate.astro  # Página de "caso resuelto"
  scripts/
    escapeRoom.ts      # Lógica cliente: navegación, desbloqueo, localStorage
  pages/
    index.astro        # Landing: intro + descarga de setup.sh
    caso.astro         # La app del juego
  assets/
    setup.sh           # Script que construye la mansion/ en la máquina del jugador
```

---

## Deploy en GitHub Pages

El workflow `.github/workflows/deploy.yml` hace el build y publica en GitHub Pages automáticamente al hacer push a `main`.

Antes del primer deploy, verificar en `astro.config.mjs`:

```js
site: "https://<tu-usuario>.github.io",
base: "caso-torvald",
```

---

## Tipografía

- **Poppins**: títulos. Cargada desde Google Fonts.
- **Hadassah Friedlaender**: cuerpo de texto. Añadir los archivos a `public/fonts/` (`hadassah-friedlaender.woff2` / `.woff`); hasta entonces utiliza el stack serif de fallback.
- **Monospace**: comandos, stamps, inputs de contraseña.

---

## Invariante crítica

Las contraseñas en `PASSWORDS` (`src/data/chapters.ts`) deben coincidir **exactamente** con las que `setup.sh` escribe en los ficheros de la `mansion/`. Si cambias una contraseña o un personaje, actualiza **ambos archivos** o el juego quedará sin solución.
