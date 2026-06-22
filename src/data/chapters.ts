export interface Chapter {
  chapter: number;
  numeral: string;
  title: string;
  subtitle: string;
  room: string;
  /** Stock photo (Unsplash, free license — not AI generated). */
  image: string;
  /** Second "reference" photo, revealed behind the first on hover. */
  image2: string;
  /** Caption shown under the evidence photo. */
  evidence: string;
  commands: string[];
  story: string;
  hint: string;
  isFirst?: boolean;
}

/** Builds a sized Unsplash URL from a photo id. */
const photo = (id: string) =>
  `https://images.unsplash.com/${id}?w=900&q=70&auto=format&fit=crop`;

/** Password expected for each chapter (compared upper-cased & trimmed). */
export const PASSWORDS: Record<number, string> = {
  1: "DETECTIVE_KERNEL",
  2: "TRAICION",
  3: "ARSENIC_KITCHEN",
  4: "DIGITALINA",
  5: "HERENCIA",
  6: "ISOLDE_CULPABLE",
};

export const chapters: Chapter[] = [
  {
    chapter: 1,
    numeral: "I",
    title: "La Entrada",
    subtitle:
      "Tu primera noche en la mansión. Aprende a orientarte dentro del sistema, a saber quién eres y a descubrir los archivos que alguien quiso mantener fuera de la vista.",
    room: "entrada",
    image: photo("photo-1513584684374-8bab748fbf90"),
    image2: photo("photo-1481627834876-b7833e8f5570"),
    evidence: "Prueba A — Fachada de la mansión, 23:47 h",
    commands: ["pwd", "whoami", "ls", "ls -la", "cat", "cd"],
    story:
      "Son las 11:47 de la noche. Has sido convocado urgentemente a la <strong>Mansión Torvald</strong>. Lord Edmund Torvald ha sido hallado muerto en su estudio. La policía local está desconcertada. Solo tú puedes resolver este caso.<br><br>Eres el <strong>Detective Marcos Kernel</strong>. Antes de entrar a la mansión, necesitas orientarte: ¿dónde estás exactamente en el sistema? ¿con qué identidad operas? Y más importante aún: ¿hay archivos que no se ven a primera vista?",
    hint: "En Linux, los archivos que empiezan con un punto <code>.</code> están ocultos. No aparecen con <code>ls</code> normal. Usa <code>ls -la</code> para verlos todos.",
    isFirst: true,
  },
  {
    chapter: 2,
    numeral: "II",
    title: "La Biblioteca",
    subtitle:
      "Entre miles de páginas se esconde una confesión a medio escribir. Domina la lectura de documentos largos y la búsqueda de texto para encontrarla sin perderte en el camino.",
    room: "biblioteca",
    image: photo("photo-1507842217343-583bb7270b66"),
    image2: photo("photo-1457369804613-52c61a468e7d"),
    evidence: "Prueba B — Biblioteca privada del Lord",
    commands: ["cat", "less", "head -N", "tail -N", "grep"],
    story:
      "La biblioteca es el corazón de la mansión. Aquí el Lord pasaba sus días rodeado de libros y cartas. Sobre el escritorio hay un <strong>diario personal</strong> con decenas de páginas escritas a mano. En algún lugar de ese diario, el Lord dejó constancia de lo que sospechaba.<br><br>También hay una lista de cinco sospechosos y una carta que levanta muchas preguntas. Lee con atención. La verdad está en las palabras.",
    hint: 'Para archivos largos, <code>less</code> es mejor que <code>cat</code>. Usa <code>grep "TEXTO" archivo</code> para buscar una línea específica sin leer todo el documento.',
  },
  {
    chapter: 3,
    numeral: "III",
    title: "La Cocina",
    subtitle:
      "El veneno pudo servirse en una simple taza de té. Crea, copia, mueve y elimina archivos para separar las pruebas auténticas de las pistas falsas que sembró el asesino.",
    room: "cocina",
    image: photo("photo-1544787219-7f47ccb76574"),
    image2: photo("photo-1495474472287-4d71bcdd2085"),
    evidence: "Prueba C — La taza de té de la víctima",
    commands: ["echo", "touch", "mkdir", "cp", "mv", "rm", "rmdir"],
    story:
      "La cocina guarda uno de los secretos más importantes del caso. La noche del crimen, alguien preparó el té del Lord <em>en lugar del mayordomo</em>. Pero antes de poder leer las evidencias auténticas, tendrás que hacer limpieza: el asesino ha sembrado <strong>pistas falsas</strong> para confundir la investigación.<br><br>Organiza las pruebas reales, elimina las falsas y, cuando el ruido haya desaparecido, la verdad emergirá.",
    hint: "<code>rm</code> elimina archivos de forma <strong>permanente</strong>, sin papelera de reciclaje. No hay deshacer. <code>rmdir</code> solo funciona en carpetas vacías.",
  },
  {
    chapter: 4,
    numeral: "IV",
    title: "El Laboratorio",
    subtitle:
      "Un script de análisis toxicológico aguarda en un equipo bloqueado. Ajusta los permisos de ejecución y encadena tu primera tubería de comandos para revelar el resultado.",
    room: "laboratorio",
    image: photo("photo-1532187863486-abf9dbad1b69"),
    image2: photo("photo-1554475901-4538ddfbccc2"),
    evidence: "Prueba D — Instrumental del laboratorio",
    commands: [
      "nano",
      "chmod +x",
      "./script.sh",
      "cmd | grep",
      "cmd | grep | head",
    ],
    story:
      "El laboratorio privado del Lord es una habitación fría y ordenada. El registro de experimentos revela que alguien estuvo aquí hace semanas realizando pruebas con plantas del jardín. Hay un <strong>script de análisis toxicológico</strong>, pero no puedes ejecutarlo: los permisos están mal configurados.<br><br>Tendrás que editar tus notas de investigación con <code>nano</code>, arreglar los permisos y ejecutar el análisis. Aquí también aprenderás a combinar comandos con <strong>tuberías</strong>.",
    hint: "Los permisos se ven con <code>ls -la</code>. La <code>x</code> indica permiso de ejecución. Usa <code>chmod +x archivo</code> para añadirlo y <code>./archivo</code> para ejecutar.",
  },
  {
    chapter: 5,
    numeral: "V",
    title: "El Estudio",
    subtitle:
      "Testamentos, pólizas de seguro y cartas comprometedoras. Combina varias tuberías y filtra la salida de tus comandos para sacar a la luz los documentos que alguien escondió.",
    room: "estudio",
    image: photo("photo-1455390582262-044cdead277a"),
    image2: photo("photo-1524995997946-a1c2e315a42f"),
    evidence: "Prueba E — El escritorio y sus documentos",
    commands: [
      "ls -la carpeta/",
      "cat *.txt | grep",
      'ls | grep "^d"',
      "cmd | cmd | cmd",
    ],
    story:
      "El estudio del Lord guarda los documentos más importantes: el testamento, la póliza de seguro y cartas comprometedoras. Pero hay algo más: <strong>documentos escondidos</strong> en un lugar que no se ve a simple vista.<br><br>Aquí las tuberías se vuelven tu herramienta más poderosa. Aprenderás a buscar en múltiples archivos a la vez, a filtrar la salida de <code>ls</code> y a encadenar tres o más comandos en una sola línea.",
    hint: "Usa <code>ls -la</code> también dentro de subcarpetas: <code>ls -la documentos/</code>. Puede haber carpetas ocultas (que empiezan con <code>.</code>) con archivos dentro.",
  },
  {
    chapter: 6,
    numeral: "VI",
    title: "El Salón Principal",
    subtitle:
      "El momento de la verdad. Reúne todas las evidencias, localiza la conclusión dentro del informe final con una búsqueda certera y cierra de una vez por todas el caso Torvald.",
    room: "salon",
    image: photo("photo-1602080858428-57174f9431cf"),
    image2: photo("photo-1450101499163-c8848c66ca85"),
    evidence: "Prueba F — El salón principal a media luz",
    commands: ["grep", "ls -la", "cat | grep", "cat | tail | grep", "exit"],
    story:
      "Tienes todas las evidencias. Ahora es el momento de la verdad. En el salón principal encontrarás el <strong>informe final de la investigación</strong>, un documento extenso que resume todo lo descubierto. La conclusión está ahí, pero tendrás que encontrarla con <code>grep</code>.<br><br>Cuando tengas la contraseña, introdúcela aquí. El caso Torvald estará cerrado. Y no olvides: cuando termines tu sesión en el terminal, usa el comando <code>exit</code>.",
    hint: 'El informe es largo. Usa <code>grep "CULPABLE" informe_final.txt</code> para localizar directamente la conclusión. Después busca archivos ocultos con <code>ls -la</code>.',
  },
];

/** Short explanation shown when a command tag is clicked. Keyed by the exact
 *  command string used in each chapter's `commands` array. */
export const COMMAND_INFO: Record<string, string> = {
  pwd: "«print working directory». Muestra la ruta de la carpeta en la que te encuentras ahora mismo.",
  whoami: "Muestra el nombre del usuario con el que estás operando en el sistema.",
  ls: "Lista los archivos y carpetas visibles del directorio actual.",
  "ls -la":
    "Lista TODO en formato largo: incluye los archivos ocultos (los que empiezan por un punto) y sus permisos.",
  cat: "Muestra de una sola vez todo el contenido de un archivo en pantalla.",
  cd: "«change directory». Te mueve de una carpeta a otra.",
  less: "Abre un archivo largo página a página. Avanza con la barra espaciadora y sal con la tecla q.",
  "head -N": "Muestra solo las primeras N líneas de un archivo.",
  "tail -N": "Muestra solo las últimas N líneas de un archivo.",
  grep: "Busca y muestra únicamente las líneas que contienen el texto indicado.",
  echo: "Escribe en pantalla el texto que le pases; con > puede volcarlo a un archivo.",
  touch: "Crea un archivo vacío (o actualiza la fecha de uno que ya existe).",
  mkdir: "«make directory». Crea una carpeta nueva.",
  cp: "Copia un archivo o carpeta a otro lugar.",
  mv: "Mueve un archivo o carpeta, o lo renombra.",
  rm: "Elimina archivos de forma permanente. No hay papelera de reciclaje.",
  rmdir: "Elimina una carpeta, pero solo si está vacía.",
  nano: "Abre un editor de texto sencillo dentro del terminal para modificar archivos.",
  "chmod +x":
    "Da permiso de ejecución a un archivo para poder lanzarlo como un programa.",
  "./script.sh":
    "Ejecuta el script que está en el directorio actual (el ./ significa «aquí mismo»).",
  "cmd | grep":
    "La tubería | envía la salida de un comando a grep, que se queda con las líneas que te interesan.",
  "cmd | grep | head":
    "Encadena tres pasos: genera una salida, la filtra con grep y se queda con las primeras líneas con head.",
  "ls -la carpeta/":
    "Lista en detalle el contenido de una carpeta concreta, incluidos sus archivos ocultos.",
  "cat *.txt | grep":
    "Junta el contenido de todos los archivos .txt y busca en ellos a la vez con grep.",
  'ls | grep "^d"':
    "Filtra la salida de ls para mostrar solo las carpetas (las líneas que empiezan por d).",
  "cmd | cmd | cmd":
    "Varias tuberías seguidas: la salida de cada comando alimenta directamente al siguiente.",
  "cat | grep":
    "Pasa el contenido de un archivo (cat) directamente a grep para filtrarlo.",
  "cat | tail | grep":
    "Lee un archivo, se queda con su parte final (tail) y filtra ahí con grep.",
  exit: "Cierra la sesión del terminal cuando has terminado tu trabajo.",
};

