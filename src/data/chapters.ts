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
    commands: ["pwd", "whoami", "ls", "ls -la", "cat", "cd", "bash script.sh"],
    story:
      "Son las 23:47 de la noche. Has sido convocado urgentemente a la <strong>Mansión Torvald</strong>. Lord Edmund Torvald ha sido hallado muerto en su estudio, pero las puertas interiores siguen selladas.<br><br>Eres el <strong>Detective Marcos Kernel</strong>. Estás en el portón. Oriéntate primero: ¿dónde estás en el sistema? ¿quién eres? El mayordomo dejó un <strong>sobre oculto</strong> con la primera contraseña. Encuéntralo y úsalo para accionar la <strong>palanca</strong> (<code>palanca.sh</code>) que abre la mansión entera.",
    hint: "Los archivos que empiezan por un punto <code>.</code> están ocultos: usa <code>ls -la</code> para ver el sobre sellado y <code>cat</code> para leerlo. Luego acciona la palanca con <code>bash palanca.sh LA_CONTRASEÑA</code>.",
    isFirst: true,
  },
  {
    chapter: 2,
    numeral: "II",
    title: "La Biblioteca",
    subtitle:
      "Un diario de cientos de líneas guarda una sola palabra delatora, escrita en minúsculas para pasar desapercibida. Domina la lectura de documentos largos y la búsqueda de texto para encontrarla sin perderte.",
    room: "biblioteca",
    image: photo("photo-1507842217343-583bb7270b66"),
    image2: photo("photo-1457369804613-52c61a468e7d"),
    evidence: "Prueba B — Biblioteca privada del Lord",
    commands: ["less", "grep", "head -N", "tail -N", "cat"],
    story:
      "Tras accionar la palanca, la mansión se abre. La biblioteca es el corazón de la casa. Sobre el escritorio hay un <strong>diario inmenso</strong> (<code>diario_lord.txt</code>): demasiado largo para leerlo de un tirón con <code>cat</code>.<br><br>Otros papeles de la sala te susurran <em>dónde</em> mirar: una fecha concreta. Ese día, el Lord nombró su mayor temor en una sola palabra, escrita en minúsculas. Esa palabra es la contraseña. (Aquí también descubrirás un <strong>muro de libros</strong> que oculta el estudio, pero solo se abre con un libro que hallarás más tarde.)",
    hint: 'No lo leas entero: usa <code>less diario_lord.txt</code> y busca con <code>/</code>, o ve directo con <code>grep "20 de mayo" diario_lord.txt</code>. La palabra está en minúsculas.',
  },
  {
    chapter: 3,
    numeral: "III",
    title: "La Cocina",
    subtitle:
      "Notas verdaderas y falsas, revueltas, y varios frascos con etiquetas distintas. Aprende a copiar (cp) y a mover (mv) para llevar las pruebas al sitio donde la verdad se revela.",
    room: "cocina",
    image: photo("photo-1544787219-7f47ccb76574"),
    image2: photo("photo-1495474472287-4d71bcdd2085"),
    evidence: "Prueba C — La taza de té de la víctima",
    commands: ["cp", "cp -r", "mv", "ls", "cat"],
    story:
      "En la cocina, alguien revolvió notas auténticas y falsas en una carpeta. Varias repiten lo mismo —que la contraseña está en la etiqueta de un frasco—, pero solo una dice <em>en cuál</em>.<br><br>Un documento explica el método de la cocinera: haz primero una <strong>copia de seguridad</strong> (<code>cp -r</code>), <strong>mueve</strong> las notas y la <em>olla reveladora</em> (<code>olla.sh</code>) hasta la entrada y hiérvela allí. El vapor borra lo falso y deja dos notas reales: el frasco correcto (con <code>ARSENIC_KITCHEN</code>) y la habitación siguiente.",
    hint: "Respalda antes de arriesgar: <code>cp -r notas_revueltas notas_respaldo</code>. Luego <code>mv</code> la carpeta y <code>olla.sh</code> a <code>../entrada/</code> y ejecútala allí con <code>bash olla.sh</code>.",
  },
  {
    chapter: 4,
    numeral: "IV",
    title: "El Laboratorio",
    subtitle:
      "Una máquina reveladora de huellas espera apagada. Prepara su placa con un editor de texto y dale permiso de ejecución para que delate quién estuvo aquí.",
    room: "laboratorio",
    image: photo("photo-1532187863486-abf9dbad1b69"),
    image2: photo("photo-1554475901-4538ddfbccc2"),
    evidence: "Prueba D — Instrumental del laboratorio",
    commands: ["nano", "ls -la", "chmod +x", "./script.sh"],
    story:
      "El laboratorio está en el salón principal. Aquí hay una <strong>máquina reveladora de huellas</strong> (<code>maquina_huellas.sh</code>), pero está apagada y necesita una placa preparada.<br><br>Edita <code>placa.txt</code> con <code>nano</code> y deja su estado exactamente como <code>ESTADO: LISTA</code>. Después dale permiso de ejecución con <code>chmod +x</code> y lánzala con <code>./</code>. Generará un informe con los nombres y la contraseña <code>DIGITALINA</code>, que además es <strong>el libro</strong> que abre el muro de la biblioteca.",
    hint: "Edita con <code>nano placa.txt</code> (guarda con Ctrl+O, sal con Ctrl+X). Luego <code>chmod +x maquina_huellas.sh</code> y ejecútala con <code>./maquina_huellas.sh</code>.",
  },
  {
    chapter: 5,
    numeral: "V",
    title: "El Estudio",
    subtitle:
      "El estudio oculto guarda el cuerpo y un expediente plagado de claves falsas. Usa tuberías para filtrar el documento y quedarte solo con la única clave válida.",
    room: "estudio",
    image: photo("photo-1455390582262-044cdead277a"),
    image2: photo("photo-1524995997946-a1c2e315a42f"),
    evidence: "Prueba E — El escritorio y sus documentos",
    commands: ["bash script.sh", "cat | grep", "grep", "cmd | grep | head"],
    story:
      "Con el libro <code>DIGITALINA</code>, el <strong>muro de la biblioteca</strong> gira y aparece el estudio: <code>bash muro_libros.sh DIGITALINA</code>. Dentro está el cuerpo del Lord y un <strong>expediente</strong> enorme con decenas de claves candidatas… casi todas señuelos marcados como BORRADOR.<br><br>Solo una clave es real: la que validó el <strong>notario</strong>. Lee la nota del notario y <em>filtra</em> el expediente con una tubería para quedarte únicamente con esa línea.",
    hint: 'Filtra con una tubería: <code>cat expediente_herencia.txt | grep "NOTARIO"</code>. Ignora todo lo que diga BORRADOR.',
  },
  {
    chapter: 6,
    numeral: "VI",
    title: "El Salón Principal",
    subtitle:
      "Todos los implicados, reunidos con un agente. Combina todo lo aprendido: reúne las cinco pruebas, únelas en el orden correcto con una tubería y da permiso al agente para deducir al culpable.",
    room: "salon",
    image: photo("photo-1602080858428-57174f9431cf"),
    image2: photo("photo-1450101499163-c8848c66ca85"),
    evidence: "Prueba F — El salón principal a media luz",
    commands: ["cp", "cat", "cmd | cmd | cmd", "chmod +x", "./script.sh"],
    story:
      "En el salón principal está el <strong>agente de policía</strong> con todos los sospechosos. Solo deducirá al culpable si le entregas <strong>las cinco pruebas</strong>: el sobre de la entrada, el diario, el frasco correcto, las huellas del laboratorio y la confesión del estudio.<br><br>Reúnelas aquí con <code>cp</code>, <strong>únelas con una tubería</strong> hacia el agente en su orden de deducción —<code>5-1-2-3-4</code>— y dale permiso para revisarlas con <code>chmod +x</code>. Anunciará a la culpable, <strong>Lady Isolde Torvald</strong>, y te dará la contraseña final.",
    hint: 'Une las pruebas en orden y pásalas por una tubería: <code>cat confesion_manuscrita.txt .sobre_sellado.txt diario_lord.txt frasco_arsenico.txt huellas_reveladas.txt | ./inspector.sh</code>. Antes, dale permiso con <code>chmod +x inspector.sh</code>.',
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
  "cp -r": "Copia una carpeta entera con todo su contenido (útil para hacer copias de seguridad).",
  mv: "Mueve un archivo o carpeta, o lo renombra.",
  "bash script.sh":
    "Ejecuta un guion (script) de shell. Puedes pasarle datos, como una contraseña: bash script.sh CLAVE.",
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

