#!/bin/bash

# ============================================================
#  EL CASO TORVALD — Setup Script
#  Ejecutar con: bash setup.sh
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
GOLD='\033[0;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'

clear
echo ""
echo -e "${GOLD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║            EL CASO TORVALD — ESCAPE ROOM LINUX           ║${NC}"
echo -e "${GOLD}║                Preparando la entrada...                  ║${NC}"
echo -e "${GOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================
# SOLO SE CONSTRUYE LA ENTRADA.
# El resto de la mansión está cerrado: se abre con la palanca.
# ============================================================
mkdir -p mansion/entrada

echo -e "${GRAY}  Abriendo el portón de la mansión...${NC}"

# ── Bienvenida ──────────────────────────────────────────────
cat > mansion/entrada/bienvenida.txt << 'DOC'
╔══════════════════════════════════════════════════════════╗
║              MANSIÓN TORVALD — BIENVENIDO                ║
╚══════════════════════════════════════════════════════════╝

Son las 23:47 de la noche del 13 de octubre.

Lord Edmund Torvald, millonario y excéntrico coleccionista,
ha sido hallado muerto en su estudio. La policía local está
desconcertada. Solo tú puedes resolver este caso.

Eres el Detective Marcos Kernel.

Estás en el portón de la mansión. Las puertas interiores
siguen cerradas. Antes de entrar, oriéntate:
¿dónde estás? ¿quién eres en este sistema?

Hay cosas que no se ven a primera vista.
Cuando estés listo, lee: cuaderno_detective.txt
DOC

# ── Cuaderno del detective (guía del capítulo 1) ────────────
cat > mansion/entrada/cuaderno_detective.txt << 'DOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — La Entrada
 Objetivo: orientarte y abrir la mansión
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  pwd                  Muestra en qué carpeta estás.
  whoami               Muestra tu usuario en el sistema.
  ls                   Lista los archivos visibles.
  ls -la               Lista TODO, también lo oculto.
                       (en Linux, lo oculto empieza por un punto .)
  cat archivo.txt      Lee el contenido de un archivo.
  cd carpeta/          Entra en una carpeta.  cd ..  retrocede.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

El mayordomo dejó algo antes de marcharse, pero no a la vista.
En Linux, no todo lo que existe se muestra por defecto.
Busca lo que permanece oculto y léelo con calma.

Dentro encontrarás la PRIMERA CONTRASEÑA del caso.

──────────────────────────────────────────────────────────
LA PALANCA:

Las puertas de la mansión están selladas. Junto a ti hay
una palanca: el archivo  palanca.sh

Esa palanca solo cede ante quien conoce la primera
contraseña. Acciónala así (desde la carpeta entrada):

    bash palanca.sh LA_CONTRASEÑA

Si aciertas, la mansión entera se abrirá ante ti.
══════════════════════════════════════════════════════════
DOC

# ── Sobre sellado (OCULTO) — contiene la contraseña 1 ───────
cat > mansion/entrada/.sobre_sellado.txt << 'DOC'
╔══════════════════════════════════════════════════════════╗
║              SOBRE SELLADO — CONFIDENCIAL                ║
╚══════════════════════════════════════════════════════════╝

Detective Kernel:

Le entrego este sobre con discreción. Llevo 30 años
sirviendo en esta mansión y sé que algo oscuro ha ocurrido.
El Lord sospechaba de alguien muy cercano.

La noche del 12 de octubre vi una figura entrar al
laboratorio a las 23:00. No era el Lord.

Confíe en los documentos. Ellos no mienten.

                           — Thomas Bash, Mayordomo

La palanca de la entrada obedece a este nombre en clave.
Esta es, además, la primera contraseña que debe introducir
en la web del caso:

        DETECTIVE_KERNEL

DOC

# ── Decorado de la entrada ──────────────────────────────────
cat > mansion/entrada/felpudo.txt << 'DOC'
Un felpudo de yute gastado frente a la puerta principal.
La palabra WELCOME apenas es legible.
Nadie limpió los zapatos aquí desde hace semanas.
DOC

cat > mansion/entrada/cuadro_entrada.txt << 'DOC'
Retrato al óleo de Lord Edmund Torvald. Marco dorado y polvoriento.
En el latón del marco, grabado: "A los que buscan, que encuentren."
DOC

cat > mansion/entrada/paraguero.txt << 'DOC'
Un paragüero de hierro forjado: dos paraguas negros y un bastón
con empuñadura de plata. Los paraguas siguen mojados. Son de ella.
DOC

# ============================================================
#  LA PALANCA — genera el resto de la mansión al accionarse
#  (requiere la contraseña DETECTIVE_KERNEL)
# ============================================================
cat > mansion/entrada/palanca.sh << 'PALANCA'
#!/bin/bash
# Palanca de la mansión Torvald. Abre las puertas interiores.

PASS_OK="DETECTIVE_KERNEL"

if [ "$1" != "$PASS_OK" ]; then
  echo ""
  echo "  La palanca no cede. Un mecanismo pide una clave."
  echo "  Uso:  bash palanca.sh <CONTRASEÑA>"
  echo "  (La contraseña está en algún sobre que alguien dejó oculto.)"
  echo ""
  exit 1
fi

# Localiza la entrada y la raíz de la mansión sin importar desde dónde se ejecute
DIR="$(cd "$(dirname "$0")" && pwd)"
M="$(dirname "$DIR")"

if [ -d "$M/biblioteca" ]; then
  echo ""
  echo "  La mansión ya estaba abierta. Las puertas crujen, nada más."
  echo ""
  exit 0
fi

echo ""
echo "  *CLONK*  La palanca cede. Se oye un eco metálico..."
echo "  Las puertas de la mansión se abren una tras otra."
echo ""

mkdir -p "$M/biblioteca"
mkdir -p "$M/cocina/notas_revueltas"
mkdir -p "$M/salon_principal/laboratorio"

# ============================================================
# CAPÍTULO 2 — LA BIBLIOTECA  (objetivo: less y grep)
# ============================================================

cat > "$M/biblioteca/cuaderno_detective.txt" << 'DOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — La Biblioteca
 Objetivo: leer documentos largos (less) y buscar (grep)
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  less archivo.txt     Lee un archivo largo página a página.
                       Avanza con espacio, busca con /palabra, sal con q.
  grep "texto" arch    Muestra solo las líneas que contienen "texto".
  head -N / tail -N    Primeras / últimas N líneas.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

Sobre el escritorio hay un diario inmenso: 'diario_lord.txt'.
Es demasiado largo para leerlo de un tirón con cat.
Otros papeles de la sala te dirán DÓNDE mirar dentro de él.

El Lord nombró su mayor temor en una sola palabra, y la
escribió en minúsculas para que pasara desapercibida.
Esa palabra es la contraseña del capítulo.

──────────────────────────────────────────────────────────
EL MURO DE LIBROS:

Una pared de esta biblioteca es en realidad una estantería
giratoria: el archivo 'muro_libros.sh'. Esconde el estudio
del Lord, pero solo se abre si le pides EL LIBRO correcto.
Ese libro lo descubrirás más adelante, en el laboratorio.

    bash muro_libros.sh <NOMBRE_DEL_LIBRO>
══════════════════════════════════════════════════════════
DOC

{
  echo "CUADERNO DE REGISTRO DE LORD EDMUND TORVALD"
  echo "═══════════════════════════════════════════"
  echo ""

  meses="enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre"
  rel1="El jardín de Isolde florece. Cada hoja, cada raíz, las conoce ella."
  rel2="Victor volvió a pedir dinero. Mi sobrino siempre necesita más."
  rel3="Thomas me trae el té de las 22:30. Es el único ritual que me queda."
  rel4="Reunión con James Grub, mi abogado. Debería revisar el testamento."
  rel5="Dolores de estómago otra vez. La Dra. Fedora dice que es estrés."
  rel6="La póliza de vida vence pronto. Isolde es la beneficiaria."

  i=0
  for m in $meses; do
    for d in 3 11 19 27; do
      i=$((i+1))
      case $((i % 6)) in
        0) frase="$rel1" ;;
        1) frase="$rel2" ;;
        2) frase="$rel3" ;;
        3) frase="$rel4" ;;
        4) frase="$rel5" ;;
        5) frase="$rel6" ;;
      esac
      echo "[$d de $m de 2024]"
      echo "$frase"
      echo ""
    done
  done

  echo "20 de mayo de 2024: He comprendido al fin lo que ocurre. No es descuido ni mala suerte, es... <<traicion>>. Tengo miedo."

  echo ""
  echo "[5 de junio de 2024]"
  echo "He escondido mis pruebas en el estudio. Si lees esto, Detective, busca bien."
  echo ""

  i=0
  for m in $meses; do
    for d in 3 11 19 27; do
      i=$((i+1))
      case $((i % 6)) in
        0) frase="$rel3" ;;
        1) frase="$rel2" ;;
        2) frase="$rel5" ;;
        3) frase="$rel1" ;;
        4) frase="$rel4" ;;
        5) frase="$rel6" ;;
      esac
      echo "[$d de $m de 2024]"
      echo "$frase"
      echo ""
    done
  done

  echo "[10 de junio de 2024]"
  echo "Esta será mi última entrada. Lo presiento. Espero que la justicia haga su trabajo."
  echo ""
  echo "— Edmund Charles Torvald"
  echo ""
  echo "### EVIDENCIA E2"
} > "$M/biblioteca/diario_lord.txt"


cat > "$M/biblioteca/carta_sin_firma.txt" << 'DOC'
[Una cuartilla sin firma, deslizada entre dos tomos.]

Edmund:

Si algún día alguien investiga lo que aquí ocurre, que lea
lo que escribiste EL 20 DE MAYO. Ese día le pusiste nombre
a todo. Una sola palabra. La escribiste pequeña, en minúsculas,
como quien no quiere que la vean.

Búscala. No leas mil páginas: ve directo a esa fecha.

                                                   — M.
DOC

cat > "$M/biblioteca/marcapaginas.txt" << 'DOC'
Un marcapáginas de cuero asoma del diario.
Tiene una anotación a lápiz, casi borrada:

   "mayo · día 20 · en voz baja"
DOC

cat > "$M/biblioteca/chimenea.txt" << 'DOC'
Chimenea de mármol negro. En las cenizas hay restos de papel
quemado, con bordes chamuscados. Imposible leerlos: alguien
se aseguró de ello.
DOC

cat > "$M/biblioteca/taza_cafe.txt" << 'DOC'
Una taza de café fría sobre una pila de libros. El de abajo es
un tratado de toxicología victoriana. El marcador no es del Lord.
DOC

# El muro de libros: abre el estudio si le das el libro DIGITALINA
cat > "$M/biblioteca/muro_libros.sh" << 'MURO'
#!/bin/bash
# Estantería giratoria. Pide un libro para abrir el estudio.

LIBRO_OK="DIGITALINA"

DIR="$(cd "$(dirname "$0")" && pwd)"   # biblioteca

if [ "$1" != "$LIBRO_OK" ]; then
  echo ""
  echo "  Pasas el dedo por los lomos. La estantería no se mueve."
  echo "  Susurra un mecanismo: 'Pídeme el LIBRO correcto'."
  echo "  Uso:  bash muro_libros.sh <NOMBRE_DEL_LIBRO>"
  echo "  (El nombre lo revela la máquina del laboratorio.)"
  echo ""
  exit 1
fi

if [ -d "$DIR/estudio" ]; then
  echo ""
  echo "  El estudio ya está abierto. La estantería sigue girada."
  echo ""
  exit 0
fi

echo ""
echo "  Tomas el libro indicado. *CLACK* La pared gira sobre su eje."
echo "  Tras los estantes aparece el ESTUDIO del Lord."
echo ""

mkdir -p "$DIR/estudio"

cat > "$DIR/estudio/cuaderno_detective.txt" << 'EDOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — El Estudio
 Objetivo: tuberías (|) para filtrar documentos largos
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  cat archivo | grep "texto"     Filtra la salida con una tubería.
  grep "texto" archivo           Busca directamente en el archivo.
  cat a | grep x | head -N       Encadena varias tuberías.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

El cuerpo del Lord está aquí. Sobre la mesa, el
'expediente_herencia.txt': páginas y páginas de claves
candidatas. Casi todas son BORRADORES descartados: señuelos.

Solo una clave es real: la que validó el NOTARIO.
Lee 'nota_del_notario.txt' y filtra el expediente con una
tubería para quedarte únicamente con esa línea.

La confesión manuscrita ('confesion_manuscrita.txt') tendrás
que llevarla al salón principal al final del caso.
══════════════════════════════════════════════════════════
EDOC

cat > "$DIR/estudio/nota_del_notario.txt" << 'EDOC'
[Tarjeta del despacho de James Grub, notario]

No te fíes de los borradores: el Lord ensayó decenas de claves
falsas para despistar. La ÚNICA válida lleva el sello del notario.

Truco de archivero: une el expediente a un filtro con una tubería
y quédate solo con lo que diga NOTARIO. Por ejemplo:

    cat expediente_herencia.txt | grep "NOTARIO"
EDOC

# Expediente largo (>100 líneas): muchos BORRADOR falsos + 1 NOTARIO real
{
  echo "EXPEDIENTE DE LA HERENCIA — MANSIÓN TORVALD"
  echo "════════════════════════════════════════════"
  echo "Documento de trabajo. Contiene borradores descartados."
  echo ""
  falsas="LEGADO PATRIMONIO USUFRUCTO ALBACEA FIDEICOMISO CAUDAL TESTAMENTO DONACION VINCULO MAYORAZGO"
  n=0
  for round in 1 2 3 4 5 6 7 8 9 10; do
    for f in $falsas; do
      n=$((n+1))
      echo "CLAVE BORRADOR (descartada) #$n: ${f}_$round"
    done
  done
  echo "------------------------------------------------------------"
  echo "CLAVE NOTARIO (validada y única): HERENCIA"
  echo "------------------------------------------------------------"
  for extra in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28; do
    echo "Anexo BORRADOR $extra: clave provisional ANULADA_$extra"
  done
} > "$DIR/estudio/expediente_herencia.txt"

cat > "$DIR/estudio/confesion_manuscrita.txt" << 'EDOC'
[Papel hallado dentro del marco del cuadro de la pared oeste.
 Letra femenina, sin fecha.]

"Lo hice por el dinero. Siempre fue por el dinero.
Dos millones de libras es más de lo que él me daría en vida.
La dedalera del jardín hizo el resto. Llevo meses con la dosis.
Nadie mirará en el invernadero. Nadie lo sabrá.

                                                       I.B."

Nota del Detective: las iniciales I.B. son de Isolde.

EDOC

cat > "$DIR/estudio/reloj_pared.txt" << 'EDOC'
Un reloj de pared suizo, detenido. Las agujas marcan las 22:30.
¿Se paró solo, o alguien lo detuvo?
EDOC

cat > "$DIR/estudio/pluma_tintero.txt" << 'EDOC'
Pluma estilográfica con tinta fresca en la punta. Alguien escribió
algo aquí hace pocas horas. No hay papel a la vista.
EDOC

echo "  Entra a investigar:  cd estudio"
echo ""
MURO

chmod 644 "$M/biblioteca/muro_libros.sh"

# ============================================================
# CAPÍTULO 3 — LA COCINA  (objetivo: mv y cp)
# ============================================================

cat > "$M/cocina/cuaderno_detective.txt" << 'DOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — La Cocina
 Objetivo: mover (mv) y copiar (cp) archivos
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  cp origen destino        Copia un archivo.
  cp -r carpeta destino    Copia una carpeta entera.
  mv origen destino        Mueve (o renombra) un archivo o carpeta.
  ls / cat                 Listar y leer.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

Alguien revolvió notas verdaderas y falsas en la carpeta
'notas_revueltas/'. Varias repiten lo mismo: que la contraseña
está en la etiqueta de un frasco. Pero solo UNA dice en cuál.

En la encimera hay varios frascos etiquetados ('frasco_*.txt'),
cada uno con una clave distinta. Solo una es la correcta.

Lee 'metodo_revelado.txt': te explica cómo separar lo verdadero
de lo falso usando la olla reveladora ('olla.sh').
══════════════════════════════════════════════════════════
DOC

cat > "$M/cocina/metodo_revelado.txt" << 'DOC'
MÉTODO DE LA COCINERA PARA DISTINGUIR LO FALSO DE LO REAL
═════════════════════════════════════════════════════════

La tinta falsa se disuelve con el vapor de la olla reveladora.
Pero la olla solo reacciona EN LA ENTRADA de la mansión.

PASOS:

  1) Por seguridad, haz primero una COPIA de las notas:
        cp -r notas_revueltas notas_respaldo

  2) Lleva las notas y la olla a la entrada (MOVER, no copiar):
        mv notas_revueltas ../entrada/
        mv olla.sh ../entrada/

  3) Ve a la entrada y hierve la olla allí:
        cd ../entrada
        bash olla.sh

El vapor borrará las notas falsas. Solo quedarán las dos
notas auténticas: una dirá en QUÉ frasco está la contraseña,
y otra dirá A QUÉ HABITACIÓN ir después.
DOC

# Notas revueltas: falsas + 2 reales (nombres disfrazados)
cat > "$M/cocina/notas_revueltas/recorte_periodico.txt" << 'DOC'
[Recorte de periódico, amarillento]
"...el sobrino, Victor Gentoo, acumulaba deudas de juego..."
La contraseña está en la etiqueta de un frasco. (Recorte sin firmar.)
DOC

cat > "$M/cocina/notas_revueltas/carta_anonima.txt" << 'DOC'
[Carta anónima, letra temblorosa]
Yo que tú miraría el frasco del azúcar. La contraseña está en
la etiqueta de un frasco, créeme.
DOC

cat > "$M/cocina/notas_revueltas/grabacion_transcrita.txt" << 'DOC'
[Transcripción de una grabación de mala calidad]
"...no busques en la cocina... ve directo al desván..."
La contraseña está en la etiqueta de un frasco. (Voz no identificada.)
DOC

cat > "$M/cocina/notas_revueltas/nota_arrugada.txt" << 'DOC'
[Papel arrugado en el fondo de un cajón]
El frasco de la pimienta lo dice todo. La contraseña está en la
etiqueta de un frasco.
DOC

cat > "$M/cocina/notas_revueltas/factura_vinos.txt" << 'DOC'
[Factura de una bodega]
12 botellas de Burdeos, 1998. Pagado en efectivo.
(Nada que ver con el caso, pero alguien la dejó aquí para confundir.)
DOC

cat > "$M/cocina/notas_revueltas/fragmento_de_carta.txt" << 'DOC'
[Una carta rota por la mitad]
Yo fregué esa taza az... 
Antes vi lo que llevaba...
Que conste: Está en la etiqueta del frasco de arsé...

                                            — Ros...
DOC

cat > "$M/cocina/notas_revueltas/itinerario.txt" << 'DOC'
[Nota auténtica del mayordomo]
Cuando tengas la clave de la cocina, no pierdas tiempo:
el siguiente paso está en el LABORATORIO, dentro del salón principal.

    cd ../salon_principal/laboratorio
DOC

# La olla reveladora: borra las notas falsas en la entrada
cat > "$M/cocina/olla.sh" << 'OLLA'
#!/bin/bash
# Olla reveladora. Solo reacciona en la ENTRADA, con las notas presentes.

if [ ! -f "bienvenida.txt" ] || [ ! -f ".sobre_sellado.txt" ]; then
  echo ""
  echo "  El líquido no reacciona. La olla solo hierve en la ENTRADA."
  echo "  Lleva la olla y las notas a la entrada y vuelve a intentarlo."
  echo ""
  exit 1
fi

if [ ! -d "notas_revueltas" ]; then
  echo ""
  echo "  No hay nada que revelar. Trae aquí la carpeta 'notas_revueltas'."
  echo ""
  exit 1
fi

echo ""
echo "  El vapor sube y la tinta falsa se disuelve..."

cd notas_revueltas || exit 1
rm -f recorte_periodico.txt
rm -f carta_anonima.txt
rm -f grabacion_transcrita.txt
rm -f nota_arrugada.txt
rm -f factura_vinos.txt

echo "  Las notas falsas se han borrado. Quedan las auténticas:"
echo ""
ls -1
echo ""
echo "  Léelas: una te dice EN QUÉ FRASCO está la contraseña,"
echo "  y otra A QUÉ HABITACIÓN ir después."
echo ""
OLLA

chmod 644 "$M/cocina/olla.sh"

# Frascos etiquetados: solo el de arsénico tiene la clave correcta
cat > "$M/cocina/frasco_sal.txt" << 'DOC'
FRASCO — SAL MARINA
Perfecta para condimentar
Etiqueta inferior, clave grabada:  SAL_KITCHEN
DOC

cat > "$M/cocina/frasco_azucar.txt" << 'DOC'
FRASCO — AZÚCAR GLAS
Demasiado dulce
Etiqueta inferior, clave grabada:  AZUCAR_KITCHEN
DOC

cat > "$M/cocina/frasco_pimienta.txt" << 'DOC'
FRASCO — PIMIENTA NEGRA
Pica mucho
Etiqueta inferior, clave grabada:  PEPPER_KITCHEN
DOC

cat > "$M/cocina/frasco_arsen.txt" << 'DOC'
FRASCO — "POLVO BLANCO" (sin etiqueta comercial)
Huele a almendras amargas.
Etiqueta inferior, clave grabada:  ARSENIC_KITCHEN
DOC

cat > "$M/cocina/taza_azul.txt" << 'DOC'
La taza de porcelana azul del Lord. Está lavada. Demasiado lavada.
DOC

cat > "$M/cocina/calendario.txt" << 'DOC'
Calendario de octubre. El día 12 tiene un círculo rojo y, escrito
a mano: "22:30 — té". La caligrafía no es la del Lord.
DOC

# ============================================================
# CAPÍTULO 6 — EL SALÓN PRINCIPAL  (objetivo: combinar todo)
# ============================================================

cat > "$M/salon_principal/cuaderno_detective.txt" << 'DOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — El Salón Principal
 Objetivo: combinar todo lo aprendido
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  cp origen destino        Reúne aquí las pruebas.
  cat a b c                Une varios archivos en orden.
  comando | comando        Tubería: pasa una salida a otro programa.
  chmod +x archivo         Da permiso de ejecución.
  ./archivo                Ejecuta un programa de esta carpeta.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

Todos los implicados están reunidos aquí, con un agente de
policía. Lee 'nota_oficial.txt': el agente solo deducirá al
culpable si le entregas TODAS las pruebas, unidas en el orden
correcto, y le das permiso para revisarlas.
══════════════════════════════════════════════════════════
DOC

cat > "$M/salon_principal/nota_oficial.txt" << 'DOC'
══════════════════════════════════════════════════════════
 AGENTE DE POLICÍA — INSTRUCCIONES PARA EL DETECTIVE
══════════════════════════════════════════════════════════

Detective Kernel: tráigame todas las pruebas del caso y las
deduciré delante de los sospechosos. Necesito CINCO documentos:

  (1) El sobre sellado de la ENTRADA
  (2) El diario de la BIBLIOTECA
  (3) El frasco correcto de la COCINA
  (4) Las huellas del LABORATORIO
  (5) La confesión del ESTUDIO

PASO 1 — Reúnalas aquí, en el salón, con cp. Por ejemplo:
  cp ../entrada/.sobre_sellado.txt .

PASO 2 — Únalas con una TUBERÍA, pero en MI orden de deducción:
primero la confesión (5), luego el sobre (1), el diario (2),
el frasco (3) y, por último, las huellas (4). Es decir: 5-1-2-3-4.

  cat archivo5.txt archivo1.txt ... archivoN.txt | ./inspector.sh

PASO 3 — Deme permiso para revisarlas (sin permiso no puedo
ejecutar mi análisis):

  chmod +x inspector.sh

Con las pruebas en ese orden y el permiso dado, anunciaré al
culpable y le daré el código del caso cerrado.
══════════════════════════════════════════════════════════
DOC

# El inspector: valida el orden 5-1-2-3-4 y revela el desenlace
cat > "$M/salon_principal/inspector.sh" << 'INSPECTOR'
#!/bin/bash
# Agente de policía. Lee las pruebas unidas por la entrada estándar.

if [ -n "$1" ] && [ -f "$1" ]; then
  DATA="$(cat "$1")"
else
  DATA="$(cat)"
fi

ORDEN="$(printf '%s\n' "$DATA" | grep -oE 'EVIDENCIA E[1-5]' | sed 's/EVIDENCIA //' | tr '\n' ' ' | sed 's/ *$//')"
ESPERADO="E5 E1 E2 E3 E4"

if [ -z "$ORDEN" ]; then
  echo ""
  echo "  Agente: no me has dado ninguna prueba que revisar."
  echo "  Únelas con cat y pásamelas por una tubería."
  echo ""
  exit 1
fi

if [ "$ORDEN" != "$ESPERADO" ]; then
  echo ""
  echo "  Agente: estas pruebas no cuentan una historia coherente."
  echo "  Recibí el orden: $ORDEN"
  echo "  Necesito el orden 5-1-2-3-4. Vuelve a unirlas."
  echo ""
  exit 1
fi

echo ""
echo "  El agente extiende las cinco pruebas sobre la mesa."
echo "  Las lee en orden, una tras otra, y levanta la vista."
echo ""
echo "  -- DEDUCCION FINAL -------------------------------------"
echo "   Movil:        2.000.000 de la poliza de vida."
echo "   Metodo:       digitalina (dedalera) disuelta en el te."
echo "   Oportunidad:  fue la unica que preparo el te esa noche."
echo ""
echo "   CULPABLE:     Lady Isolde Torvald"
echo "  -------------------------------------------------------"
echo ""
echo "  Contrasena final (capitulo 6, introducela en la web):"
echo "       ISOLDE_CULPABLE"
echo ""
echo "  Codigo de caso cerrado:"
echo "       CASO_RESUELTO_TORVALD_2024"
echo ""
INSPECTOR

chmod 644 "$M/salon_principal/inspector.sh"

cat > "$M/salon_principal/candelabro.txt" << 'DOC'
Candelabro de plata para cinco velas. Tres consumidas, dos casi nuevas.
Cinco personas. Tres esperaron. Dos se marcharon pronto.
DOC

cat > "$M/salon_principal/retrato_isolde.txt" << 'DOC'
Retrato de Lady Isolde Torvald, 2019. Guantes blancos de jardinería
y, en el cabello, flores de dedalera morada. Sonrisa calculada.
DOC

# ============================================================
# CAPÍTULO 4 — EL LABORATORIO  (objetivo: nano y chmod +x)
# ============================================================

cat > "$M/salon_principal/laboratorio/cuaderno_detective.txt" << 'DOC'
══════════════════════════════════════════════════════════
 CUADERNO DEL DETECTIVE — El Laboratorio
 Objetivo: editar con nano y dar permisos con chmod
══════════════════════════════════════════════════════════

COMANDOS DE ESTE CAPÍTULO:

  nano archivo.txt     Edita un archivo en el terminal.
                       Guardar: Ctrl+O y Enter.  Salir: Ctrl+X.
  ls -la               Muestra los permisos (la x = ejecutable).
  chmod +x archivo.sh  Da permiso de ejecución.
  ./archivo.sh         Ejecuta un programa de la carpeta actual.

──────────────────────────────────────────────────────────
INVESTIGACIÓN:

Aquí hay una máquina reveladora de huellas: 'maquina_huellas.sh'.
Está apagada y necesita una placa preparada.

  PASO 1 — Prepara la placa con nano. Abre 'placa.txt' y deja
           la línea de estado EXACTAMENTE así:
               ESTADO: LISTA
           (ahora pone EN_BLANCO; cámbiala y guarda con Ctrl+O).

  PASO 2 — Enciende la máquina dándole permiso de ejecución:
               chmod +x maquina_huellas.sh

  PASO 3 — Ejecútala:
               ./maquina_huellas.sh

La máquina generará un informe con los nombres de quienes
estuvieron aquí y la contraseña del capítulo. Esa contraseña
es, además, EL LIBRO que abre el muro de la biblioteca.
══════════════════════════════════════════════════════════
DOC

cat > "$M/salon_principal/laboratorio/placa.txt" << 'DOC'
PLACA DE REVELADO
MUESTRA: residuos de la taza azul
ESTADO: EN_BLANCO
DOC

# La máquina: requiere placa LISTA, luego genera el informe con DIGITALINA
cat > "$M/salon_principal/laboratorio/maquina_huellas.sh" << 'MAQUINA'
#!/bin/bash
# Máquina reveladora de huellas dactilares.

if [ ! -f "placa.txt" ]; then
  echo "  No encuentro la placa. Debes ejecutarme en el laboratorio."
  exit 1
fi

if ! grep -q '^ESTADO: LISTA$' placa.txt; then
  echo ""
  echo "  La máquina zumba y se apaga: la placa no está preparada."
  echo "  Edita 'placa.txt' con nano y deja la línea:  ESTADO: LISTA"
  echo ""
  exit 1
fi

echo ""
echo "  La placa encaja. La máquina revela las huellas latentes..."
echo ""

cat > huellas_reveladas.txt << 'HDOC'
INFORME DE HUELLAS — LABORATORIO TORVALD
═════════════════════════════════════════
Superficie analizada: taza de porcelana azul y frasco azul.

Huellas identificadas:
  - Thomas Bash (mayordomo) ....... en el asa de la taza (servicio)
  - Edmund Torvald (victima) ...... en el borde de la taza
  - Isolde Torvald (esposa) ....... en el FRASCO del veneno

Sustancia detectada: DIGITALINA (glucosido de la dedalera).
Estable a 90 grados: no se destruye al preparar el te.

Contrasena del capitulo 4: DIGITALINA

NOTA: 'DIGITALINA' es tambien EL LIBRO que pide el muro de la
biblioteca. Vuelve alli y ejecuta:  bash muro_libros.sh DIGITALINA
HDOC

echo "  Informe generado:  huellas_reveladas.txt"
echo "  Léelo con:  cat huellas_reveladas.txt"
echo ""
MAQUINA

chmod 644 "$M/salon_principal/laboratorio/maquina_huellas.sh"

cat > "$M/salon_principal/laboratorio/microscopio.txt" << 'DOC'
Microscopio de latón. El polvo termina de golpe en los oculares:
alguien lo usó hace poco.
DOC

cat > "$M/salon_principal/laboratorio/manual_botanica.txt" << 'DOC'
Manual de Botánica, abierto en Digitalis purpurea (dedalera).
Subrayado: "Glucósido cardíaco. Margen estrecho entre dosis y muerte."
La letra del margen no es la del Lord.
DOC

echo "  Capítulos disponibles: biblioteca, cocina, salón principal."
echo "  Empieza por la biblioteca:  cd ../biblioteca"
echo ""
PALANCA

chmod 644 mansion/entrada/palanca.sh

# ============================================================
# MENSAJE FINAL
# ============================================================
echo ""
echo -e "${GREEN}  ✓ Entrada de la mansión preparada${NC}"
echo -e "${GREEN}  ✓ Palanca instalada (esperando la contraseña)${NC}"
echo ""
echo -e "${GOLD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║             EL PORTÓN TORVALD ESTÁ ABIERTO               ║${NC}"
echo -e "${GOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Empieza tu investigación:"
echo ""
echo -e "    ${CYAN}cd mansion/entrada${NC}"
echo -e "    ${CYAN}cat bienvenida.txt${NC}"
echo ""
echo -e "  En cada habitación hay un ${GOLD}cuaderno_detective.txt${NC}"
echo -e "  que te explica qué comandos usar."
echo ""
