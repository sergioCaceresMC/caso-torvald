import { PASSWORDS } from "../data/chapters";

const STORAGE_KEY = "blackwood_progress";

type Progress = { [key: string]: boolean };

// ── Storage ──────────────────────────────────────────────────
function loadProgress(): Progress {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY) ?? "{}");
  } catch {
    return {};
  }
}

function saveProgress(progress: Progress): void {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
}

// ── Elements ─────────────────────────────────────────────────
const cards = Array.from(
  document.querySelectorAll<HTMLElement>(".chapter-card"),
);
const certificate = document.getElementById("certificate");
const total = cards.length;

const prevBtn = document.getElementById("nav-prev") as HTMLButtonElement | null;
const nextBtn = document.getElementById("nav-next") as HTMLButtonElement | null;
const navLabel = document.getElementById("nav-label");
const navDots = document.getElementById("nav-dots");
const progressCount = document.getElementById("progress-count");

const progress: Progress = loadProgress();
let current = 0; // index into steps()

/** Chapter n is reachable/openable. Chapter 1 is always open. */
function isUnlocked(n: number): boolean {
  return n === 1 || !!progress[n];
}

/** The ordered list of pages currently shown in the stepper. */
function steps(): HTMLElement[] {
  const list: HTMLElement[] = [...cards];
  if (progress.certificate && certificate) list.push(certificate);
  return list;
}

// ── Rendering ────────────────────────────────────────────────
function syncCardLockClasses(): void {
  cards.forEach((card, i) => {
    const n = i + 1;
    card.classList.toggle("unlocked", isUnlocked(n));
    card.classList.toggle("locked", !isUnlocked(n));
  });
}

function updateProgressBar(): void {
  const unlocked = cards.filter((_, i) => isUnlocked(i + 1)).length;
  if (progressCount) progressCount.textContent = `${unlocked}/${total}`;
}

function buildDots(list: HTMLElement[]): void {
  if (!navDots) return;
  navDots.innerHTML = "";
  list.forEach((el, i) => {
    const dot = document.createElement("button");
    dot.type = "button";
    dot.className = "nav-dot";
    const isCert = el === certificate;
    const n = i + 1;

    if (i === current) dot.classList.add("is-active");
    if (!isCert && !isUnlocked(n)) dot.classList.add("is-locked");
    if (isCert) dot.classList.add("is-cert");

    dot.setAttribute(
      "aria-label",
      isCert ? "Caso cerrado" : `Ir al capítulo ${n}`,
    );
    dot.addEventListener("click", () => goTo(i));
    navDots.appendChild(dot);
  });
}

function render(): void {
  const list = steps();
  current = Math.max(0, Math.min(current, list.length - 1));

  // Hide every page, then show the active one.
  cards.forEach((c) => c.classList.remove("active"));
  certificate?.classList.remove("active");
  list[current]?.classList.add("active");

  // Reset internal scroll of the freshly shown page.
  const scroller = list[current]?.querySelector<HTMLElement>(".case-content");
  if (scroller) scroller.scrollTop = 0;
  if (list[current] === certificate) certificate!.scrollTop = 0;

  const onCert = list[current] === certificate;
  if (navLabel) {
    navLabel.textContent = onCert
      ? "Caso cerrado"
      : `Capítulo ${current + 1} de ${total}`;
  }
  if (prevBtn) prevBtn.disabled = current === 0;
  if (nextBtn) nextBtn.disabled = current === list.length - 1;

  buildDots(list);
}

function goTo(index: number): void {
  current = index;
  render();
}

function go(delta: number): void {
  goTo(current + delta);
}

// ── Password verification ────────────────────────────────────
function wireCard(card: HTMLElement): void {
  const input = card.querySelector<HTMLInputElement>(".pw-input");
  const btn = card.querySelector<HTMLButtonElement>(".pw-btn");
  const feedback = card.querySelector<HTMLElement>(".pw-feedback");
  const chapter = parseInt(card.dataset.chapter ?? "0");

  if (!input || !btn || !feedback || !chapter) return;

  // If the next chapter is already unlocked, this one was solved.
  const solved =
    (chapter < total && progress[chapter + 1]) ||
    (chapter === total && progress.certificate);
  if (solved) {
    input.disabled = true;
    btn.disabled = true;
    feedback.textContent = "Contraseña ya verificada.";
    feedback.className = "pw-feedback success";
  }

  function verify(): void {
    const entered = input!.value.trim().toUpperCase();
    const expected = PASSWORDS[chapter];

    if (!entered) {
      feedback!.textContent =
        "Escribe la contraseña encontrada en el terminal.";
      feedback!.className = "pw-feedback error";
      return;
    }

    if (entered !== expected) {
      feedback!.textContent = "Contraseña incorrecta. Sigue investigando…";
      feedback!.className = "pw-feedback error";
      input!.classList.add("shake");
      setTimeout(() => input!.classList.remove("shake"), 600);
      return;
    }

    feedback!.textContent = "¡Correcto! Siguiente expediente desbloqueado.";
    feedback!.className = "pw-feedback success";
    input!.disabled = true;
    btn!.disabled = true;

    if (chapter < total) {
      progress[chapter + 1] = true;
    } else {
      progress.certificate = true;
    }
    saveProgress(progress);

    syncCardLockClasses();
    updateProgressBar();

    // Advance to the page that was just revealed.
    setTimeout(() => goTo(chapter), 650);
  }

  btn.addEventListener("click", verify);
  input.addEventListener("keydown", (e: KeyboardEvent) => {
    if (e.key === "Enter") verify();
  });
}

// ── Command explanations ─────────────────────────────────────
function wireCommands(): void {
  document
    .querySelectorAll<HTMLElement>(".commands-section")
    .forEach((section) => {
      const panel = section.querySelector<HTMLElement>(".cmd-explain");
      const tags = section.querySelectorAll<HTMLButtonElement>(".cmd-tag");
      tags.forEach((tag) => {
        tag.addEventListener("click", () => {
          tags.forEach((t) => t.classList.remove("is-active"));
          tag.classList.add("is-active");
          if (panel) panel.textContent = tag.dataset.explain ?? "";
        });
      });
    });
}

// ── Reset ────────────────────────────────────────────────────
function wireReset(): void {
  document.getElementById("reset-btn")?.addEventListener("click", () => {
    if (
      confirm(
        "¿Seguro que quieres reiniciar el caso? Se borrará todo el progreso.",
      )
    ) {
      localStorage.removeItem(STORAGE_KEY);
      location.reload();
    }
  });
}

// ── Init ─────────────────────────────────────────────────────
function init(): void {
  syncCardLockClasses();
  updateProgressBar();
  cards.forEach(wireCard);
  wireCommands();
  wireReset();

  prevBtn?.addEventListener("click", () => go(-1));
  nextBtn?.addEventListener("click", () => go(1));

  // Start on the furthest unlocked chapter so returning players resume.
  const lastUnlocked = cards.reduce(
    (acc, _, i) => (isUnlocked(i + 1) ? i : acc),
    0,
  );
  current = lastUnlocked;
  render();
}

init();
