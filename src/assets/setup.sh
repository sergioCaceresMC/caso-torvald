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
echo -e "${GOLD}║          EL CASO TORVALD — ESCAPE ROOM LINUX             ║${NC}"
echo -e "${GOLD}║              Preparando la mansión...                    ║${NC}"
echo -e "${GOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================
# CREAR ESTRUCTURA DE DIRECTORIOS
# ============================================================
mkdir -p mansion/entrada
mkdir -p mansion/biblioteca
mkdir -p mansion/cocina/pistas_falsas
mkdir -p mansion/laboratorio
mkdir -p mansion/estudio/documentos/.archivos_privados
mkdir -p mansion/estudio/documentos/cartas
mkdir -p mansion/salon_principal/sospechosos

echo -e "${GRAY}  Construyendo la mansión...${NC}"

# ============================================================
# CAPÍTULO 1 — LA ENTRADA
# Comandos: pwd, whoami, ls, ls -la, cat, cd
# ============================================================

cat > mansion/entrada/bienvenida.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║              MANSIÓN TORVALD — BIENVENIDO                ║
╚══════════════════════════════════════════════════════════╝

Son las 11:47 de la noche del 13 de octubre.

Lord Edmund Torvald, millonario y excéntrico coleccionista,
ha sido hallado muerto en su estudio. La policía local está
desconcertada. Solo tú puedes resolver este caso.

Eres el Detective Marcos Kernel.

Antes de adentrarte en la mansión, oriéntate.
¿Sabes dónde estás? ¿Sabes quién eres en este sistema?

Hay respuestas a esas preguntas. Búscalas.

Cuando estés listo, lee el archivo: instrucciones.txt
HEREDOC

cat > mansion/entrada/instrucciones.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║                  INSTRUCCIONES DEL CASO                  ║
╚══════════════════════════════════════════════════════════╝

La mansión Torvald tiene 6 habitaciones que investigar.
Cada habitación es una carpeta del sistema.

En cada habitación encontrarás:
  pista.txt     → Explica qué comandos usar y cómo usarlos
  Otros archivos → Evidencias, pistas y secretos del caso

TU OBJETIVO:
  Encontrar la CONTRASEÑA de cada habitación e
  introducirla en la web del caso para avanzar.

HABITACIONES:
  mansion/entrada/          ← estás aquí ahora
  mansion/biblioteca/
  mansion/cocina/
  mansion/laboratorio/
  mansion/estudio/
  mansion/salon_principal/

Para moverte entre habitaciones:
  cd nombre_carpeta/    → entra en una carpeta
  cd ..                 → vuelve a la carpeta anterior
  cd ../biblioteca      → ve directamente a biblioteca

Lee el archivo pista.txt para saber qué hacer aquí.
HEREDOC

cat > mansion/entrada/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║           PISTA — CAPÍTULO 1: La Entrada                 ║
╚══════════════════════════════════════════════════════════╝

COMANDOS DE ESTE CAPÍTULO:

  pwd
    Muestra la ruta completa de tu carpeta actual.
    Ejemplo: /home/usuario/mansion/entrada

  whoami
    Muestra tu nombre de usuario en el sistema.

  ls
    Lista los archivos visibles de la carpeta actual.

  ls -la
    Lista TODOS los archivos, incluyendo los ocultos.
    Los archivos ocultos en Linux empiezan con un punto (.)
    y no aparecen con 'ls' normal. Necesitas 'ls -la'.

  cat nombre_archivo.txt
    Muestra el contenido de un archivo en la pantalla.

  cd nombre_carpeta/
    Entra en una carpeta.

  cd ..
    Vuelve a la carpeta anterior.

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

El mayordomo dejó algo antes de marcharse.
Dijo que hay más de lo que parece en esta entrada.

En Linux no todo lo que existe se muestra por defecto.
¿Sabes cómo ver lo que permanece oculto?
¿Sabes quién eres en este sistema? ¿Dónde estás?

La contraseña aguarda donde los ojos no miran.
────────────────────────────────────────────────────────────
Para avanzar al siguiente capítulo: cd ../biblioteca
HEREDOC

cat > mansion/entrada/.sobre_sellado.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║              SOBRE SELLADO — CONFIDENCIAL                ║
╚══════════════════════════════════════════════════════════╝

Detective Kernel:

Le entrego este sobre con discreción.
Llevo 30 años sirviendo en esta mansión y sé que algo
oscuro ha ocurrido aquí. El Lord sospechaba de alguien
muy cercano, pero no quiso decirme nada más.

La noche del 12 de octubre vi una figura entrar al
laboratorio a las 23:00. No era el Lord.

Confíe en los documentos. Ellos no mienten.

                           — Thomas Bash, Mayordomo

╔══════════════════════════════════════════════════════════╗
║         CONTRASEÑA DEL CAPÍTULO 1: DETECTIVE_KERNEL      ║
║   Introdúcela en la web para desbloquear la Biblioteca   ║
╚══════════════════════════════════════════════════════════╝
HEREDOC

# ============================================================
# CAPÍTULO 2 — LA BIBLIOTECA
# Comandos: cat, less, head, tail, grep
# ============================================================

cat > mansion/biblioteca/notas_investigacion.txt << 'HEREDOC'
NOTAS DE INVESTIGACIÓN — Habitación: Biblioteca
================================================
Hora de entrada: 00:13
Estado: Estantes llenos de libros. Escritorio con papeles.
Observación inicial: Hay un diario personal sobre el escritorio.

El diario es extenso. Puede contener información clave
enterrada en algún lugar del texto.

Hay también varias cartas y una lista de sospechosos.
HEREDOC

cat > mansion/biblioteca/diario_lord.txt << 'HEREDOC'
DIARIO PERSONAL DE LORD EDMUND TORVALD
═════════════════════════════════════════

1 de enero de 2024
Año nuevo. Isolde y yo apenas nos hablamos ya.
Paso la mayoría del tiempo en esta biblioteca.
Los libros son más honestos que las personas.

5 de enero de 2024
Victor vino a visitarme. Mi sobrino siempre necesita dinero.
Le di £500 esta vez. Me preocupa su situación económica.

12 de enero de 2024
El jardín luce espléndido. Isolde ganó otro premio de
horticultura del condado. Conoce cada planta de esta finca.
Cada flor, cada hoja, cada raíz.

20 de enero de 2024
Reunión con James Grub, mi abogado. Debería revisar
el testamento. Hay cosas que han cambiado.

3 de febrero de 2024
Dolor de cabeza persistente esta semana. Thomas me trae el
té de las 22:30 como siempre. Es el único ritual que me
queda de cuando Isolde y yo éramos felices.

14 de febrero de 2024
San Valentín. Isolde me regaló flores del jardín.
Dedaleras. "Tus favoritas", dijo. Nunca me han gustado
las dedaleras. ¿Por qué diría eso?

1 de marzo de 2024
He empezado a sospechar. Los números de mis cuentas
no cuadran. Alguien ha revisado mis documentos privados.
El armario del estudio estaba abierto y yo siempre lo cierro.

15 de marzo de 2024
Victor vino de nuevo. Pidió otro préstamo. Se lo negué.
Se marchó furioso. Entiendo su frustración, pero tiene límites.

22 de marzo de 2024
La póliza de seguro de vida vence pronto. Debo renovarla.
Isolde es la beneficiaria. Quizás debería revisarlo.

1 de abril de 2024
Descubrí algo perturbador en el laboratorio esta mañana.
Alguien ha estado usando mis instrumentos de química.
Hay rastros de un experimento reciente que yo no hice.

10 de abril de 2024
Thomas me advirtió con la mirada esta mañana.
No dijo nada en voz alta, pero entendí su mensaje.
Debo tener cuidado. Mucho cuidado.

18 de abril de 2024
He tomado una decisión: cambiaré el testamento la semana
que viene. Victor recibirá la mansión. Isolde tiene el
apartamento de Londres y es suficiente para ella.

25 de abril de 2024
No he podido hablar con el abogado. Siempre hay algo
que lo impide. Una cena, una visita, un compromiso social
que Isolde organiza sin consultarme.

2 de mayo de 2024
El dolor de estómago ha empeorado. El médico dice que es
estrés. Quizás tiene razón. Quizás no.

10 de mayo de 2024
Encontré una nota sin firma en mi escritorio:
"Hay personas que preferirían que no cambiaras ese testamento."
La quemé. No quiero pensar en sus implicaciones.

20 de mayo de 2024
He tomado nota de todo. Si algo me ocurre, quiero que
quede constancia de lo que realmente está pasando aquí.
La situación que vivo en esta casa no tiene otro nombre:

Es TRAICION.

No puedo escribir más por ahora. Tengo miedo.

5 de junio de 2024
He escondido las pruebas importantes en el estudio.
En un lugar que solo un buen detective podrá encontrar.
Si lees esto, Detective, busca bien. No te rindas.

8 de junio de 2024
Isolde preparó ella misma el té esta noche.
Thomas estaba fuera. El sabor era diferente.
Probablemente sea mi imaginación.
Probablemente.

10 de junio de 2024
Esta será mi última entrada. Lo presiento con claridad.
Espero que la justicia haga su trabajo.

                              — Edmund Charles Torvald
HEREDOC

cat > mansion/biblioteca/carta_isolde.txt << 'HEREDOC'
Mi querido Edmund:

No te preocupes por los documentos del abogado.
Todo está en orden. Yo me encargo de gestionar todo.

Esta noche te prepararé tu té de las 22:30 yo misma.
Thomas tiene la noche libre. Quiero hacerlo yo.
Añadiré esa hierba especial del jardín que tanto
te gusta. Te sentirás mucho mejor, ya lo verás.

Con todo mi amor,
Isolde

P.D. He renovado la póliza de seguro. Por si acaso.
     No es necesario que te molestes en revisarla.
HEREDOC

cat > mansion/biblioteca/lista_sospechosos.txt << 'HEREDOC'
LISTA DE SOSPECHOSOS — CASO TORVALD
══════════════════════════════════════

1. LADY ISOLDE TORVALD (esposa del difunto)
   Habitación: Suite Norte
   Conocimientos: Botánica y horticultura. Premio del condado 2019.
   Beneficiaria: Póliza de seguro de vida — £2,000,000
   Presente la noche del crimen: SÍ
   Coartada: "Estaba en su suite leyendo." Sin testigos.

2. VICTOR GENTOO (sobrino del difunto)
   Última visita: 1 de octubre
   Situación económica: Deudas documentadas
   Conflicto: El Lord le negó dinero recientemente
   Coartada: "Estaba en Londres." Pendiente de verificación.

3. THOMAS BASH (mayordomo, 30 años de servicio)
   Acceso: Todas las habitaciones de la mansión
   Observación: Actitud nerviosa y evasiva con la policía
   Nota: Preparaba el té del Lord cada noche a las 22:30
   Coartada: "Salí a las 21:00 por indicación de Lady Isolde."

4. DRA. MARGARET FEDORA (médico personal del Lord)
   Última visita: 11 de octubre
   Acceso a: Sustancias médicas y registros de salud
   Coartada: Guardia nocturna en el hospital. Verificada.

5. JAMES GRUB (abogado del Lord)
   Citado para el 14 de octubre: cambiar el testamento
   Pregunta clave: ¿Alguien quería evitar ese cambio?
   Coartada: Viaje a Edimburgo. Verificada.
HEREDOC

cat > mansion/biblioteca/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║          PISTA — CAPÍTULO 2: La Biblioteca               ║
╚══════════════════════════════════════════════════════════╝

COMANDOS DE ESTE CAPÍTULO:

  cat archivo.txt
    Muestra el contenido completo de un archivo.
    Ideal para archivos cortos.

  less archivo.txt
    Abre el archivo para leerlo con desplazamiento.
    → Flechas arriba/abajo para moverte
    → 'q' para salir
    Ideal para archivos largos.

  head -N archivo.txt
    Muestra solo las primeras N líneas del archivo.
    Ejemplo: head -10 diario_lord.txt

  tail -N archivo.txt
    Muestra solo las últimas N líneas del archivo.
    Ejemplo: tail -5 diario_lord.txt

  grep "texto" archivo.txt
    Busca y muestra solo las líneas que contienen "texto".
    Ejemplo: grep "sospecha" diario_lord.txt

────────────────────────────────────────────────────────────
CUÁNDO USAR CADA COMANDO:
  Archivo corto  → cat
  Archivo largo  → less (o head/tail para ver partes)
  Buscar algo    → grep

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

El Lord escribió con obsesión durante meses.
Su diario tiene muchas páginas — demasiadas para leerlas
de un golpe. Hay formas de asomarse a un texto largo:
ver solo el principio, solo el final, o ir directamente
a buscar una palabra que sabes que tiene que estar ahí.

El Lord usó una sola palabra para describir
lo que ocurría en su propia casa.
Esa palabra es la contraseña.
────────────────────────────────────────────────────────────
Para avanzar: cd ../cocina
HEREDOC

# ============================================================
# CAPÍTULO 3 — LA COCINA
# Comandos: echo, touch, mkdir, cp, mv, rm, rmdir, cat, grep
# ============================================================

cat > mansion/cocina/receta_te.txt << 'HEREDOC'
RECETA OFICIAL DEL TÉ DE LORD TORVALD
════════════════════════════════════════
A cargo de: Thomas Bash, Mayordomo
Servicio desde: 1994

Ingredientes:
  - 2 cucharadas de té Earl Grey (origen: Ceilán)
  - 300 ml de agua mineral a 90°C exactos
  - Una rodaja fina de limón
  - Media cucharada de miel de acacia

Preparación:
  1. Calentar el agua a exactamente 90°C (nunca hervir)
  2. Infusionar el té durante exactamente 4 minutos
  3. Retirar las hojas. Añadir limón y miel.
  4. Servir en la taza de porcelana azul del Lord.

Hora de servicio: 22:30 en punto, cada noche.

NOTA IMPORTANTE:
El Lord es muy estricto con esta receta.
No modificar bajo ningún concepto sin su autorización.
HEREDOC

cat > mansion/cocina/pistas_falsas/falsa1.txt << 'HEREDOC'
INFORME RESERVADO — CASO TORVALD

El asesino fue Victor Gentoo.
Prueba: guante con sus iniciales encontrado junto al cuerpo.
El móvil es claro: deudas y rencor familiar.

Contraseña de acceso: VICTOR_CULPABLE

— Inspector H. Colton, Scotland Yard
HEREDOC

cat > mansion/cocina/pistas_falsas/falsa2.txt << 'HEREDOC'
DECLARACIÓN JURADA

Yo, Thomas Bash, declaro haber visto a Victor Gentoo
en los jardines de la mansión la noche del 12 de octubre.
Portaba algo bajo el brazo. Se marchó antes de medianoche.

Firmado: T. Bash
HEREDOC

cat > mansion/cocina/pistas_falsas/falsa3.txt << 'HEREDOC'
CERTIFICADO MÉDICO OFICIAL

Médico responsable: Dr. Margaret Fedora
Paciente: Lord Edmund Torvald

Causa de la muerte: paro cardíaco de origen natural.
No se detectaron sustancias externas en el organismo.
No hay indicios de intervención de terceros.

Caso cerrado. No se requiere investigación adicional.
HEREDOC

cat > mansion/cocina/nota_chef.txt << 'HEREDOC'
NOTA DEJADA POR THOMAS BASH (EL MAYORDOMO)
════════════════════════════════════════════

Detective Kernel, si has llegado hasta aquí es que
sabes lo que estás haciendo. Le dejo esta nota.

Llevo 30 años preparando el té del Lord.
Siempre la misma receta. Siempre a las 22:30.
Pero la noche del 12 de octubre, yo no lo preparé.

Cuando llegué a la cocina, el té ya estaba hecho.
Alguien se me adelantó. Lady Isolde me dijo que
me tomara la noche libre "como regalo". Nunca hace eso.

Encontrará pistas falsas por esta cocina. Alguien
las colocó para confundir. Elimínelas. Quédese solo
con las evidencias reales.

Una vez que haya limpiado el ruido, la señal aparecerá.
Esta nota esconde algo entre sus líneas.
Hay formas de buscar sin leer todo el texto.

Contraseña de acceso al laboratorio: ARSENIC_KITCHEN

Cuide sus espaldas, Detective.
                              — Thomas
HEREDOC

cat > mansion/cocina/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║            PISTA — CAPÍTULO 3: La Cocina                 ║
╚══════════════════════════════════════════════════════════╝

COMANDOS DE ESTE CAPÍTULO:

  echo "texto" > archivo.txt
    Escribe "texto" en un archivo.
    ¡CUIDADO! Si el archivo ya existe, lo SOBREESCRIBE.

  echo "texto" >> archivo.txt
    Añade "texto" al final de un archivo existente.

  cat archivo.txt
    Verifica el contenido de un archivo.

  touch archivo.txt
    Crea un archivo vacío (o actualiza su fecha si existe).

  mkdir nombre_carpeta
    Crea una nueva carpeta.

  cp origen destino
    Copia un archivo o carpeta.
    Ejemplo: cp receta_te.txt copia_receta.txt

  mv origen destino
    Mueve o renombra un archivo.
    Ejemplo: mv archivo.txt nueva_carpeta/archivo.txt

  rm archivo.txt
    Elimina un archivo. ¡SIN PAPELERA! No hay deshacer.

  rmdir nombre_carpeta
    Elimina una carpeta. Solo funciona si está VACÍA.

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

Alguien sembró documentos falsos en esta cocina.
Como detective debes distinguir lo auténtico de lo inventado,
preservar las pruebas reales y destruir el ruido.

Deja constancia de tu presencia. Organiza lo que importa.
Mueve, copia, crea — pero piénsalo antes de borrar:
en Linux, lo que se elimina no regresa.

Cuando la cocina esté en orden, Thomas tiene algo
que decirte. Sabe buscar. Quizás tú también.

NOTA: 'rm' elimina sin papelera. No hay deshacer.
────────────────────────────────────────────────────────────
Para avanzar: cd ../laboratorio
HEREDOC

# ============================================================
# CAPÍTULO 4 — EL LABORATORIO
# Comandos: nano, chmod, ./, pipes intro (cat | grep | head)
# ============================================================

cat > mansion/laboratorio/notas_lab.txt << 'HEREDOC'
CUADERNO DE NOTAS — LABORATORIO TORVALD
══════════════════════════════════════════

[ Páginas en blanco ]

Un detective no debería pasar por un lugar
sin dejar constancia de su visita.
¿Tienes algún editor a mano?
HEREDOC

# Create the analysis script WITHOUT execute permission
cat > mansion/laboratorio/analizar_muestra.sh << 'HEREDOC'
#!/bin/bash
echo ""
echo "════════════════════════════════════════════════"
echo "   ANÁLISIS TOXICOLÓGICO — LABORATORIO TORVALD"
echo "════════════════════════════════════════════════"
echo ""
echo "  Muestra: Residuos en taza de porcelana azul"
echo "  Fecha:   13/10/2024 — 01:30"
echo ""
echo "  SUSTANCIA DETECTADA:"
echo "    Nombre:  Digitalina (glucósido cardíaco)"
echo "    Origen:  Digitalis purpurea — planta dedalera"
echo "    Dosis:   8.3 mg (DOSIS LETAL confirmada)"
echo ""
echo "  CONCLUSIÓN:"
echo "    La víctima ingirió digitalina disuelta en té."
echo "    El compuesto es estable a 90°C: no se destruye"
echo "    al preparar infusiones calientes."
echo ""
echo "════════════════════════════════════════════════"
echo "  CONTRASEÑA DEL CAPÍTULO 4: DIGITALINA"
echo "════════════════════════════════════════════════"
HEREDOC
chmod 644 mansion/laboratorio/analizar_muestra.sh

# Create experiment register (long file, for pipe practice)
cat > mansion/laboratorio/registro_experimentos.txt << 'HEREDOC'
REGISTRO DE EXPERIMENTOS — LABORATORIO TORVALD
═════════════════════════════════════════════════
Responsable: Lord Edmund Torvald
Año: 2024

Experimento #001 — 05/01/2024
  Tipo: Extracción de aceites esenciales
  Material: Lavanda del jardín norte
  Resultado: Exitoso. Rendimiento: 15ml por kilo.

Experimento #002 — 12/01/2024
  Tipo: Análisis de composición del suelo
  Material: Muestra zona jardín este
  Resultado: pH 6.2. Apto para cultivo.

Experimento #003 — 20/01/2024
  Tipo: Destilación simple
  Material: Romero fresco
  Resultado: Exitoso. Fragancia limpia.

Experimento #004 — 03/02/2024
  Tipo: Cromatografía de papel
  Material: Pigmentos de diversas flores
  Resultado: 4 bandas de color identificadas.

Experimento #005 — 14/02/2024
  Tipo: Extracción de compuesto activo
  Material: Muestra sin etiquetar (aportada externamente)
  Nota: experimento con extracción de veneno potencial
  Resultado: Compuesto activo aislado con éxito.

Experimento #006 — 01/03/2024
  Tipo: Análisis espectroscópico
  Material: Muestra líquida amarillenta
  Resultado: Pendiente de revisión.

Experimento #007 — 10/03/2024
  Tipo: Titulación ácido-base
  Material: Agua del pozo de la finca
  Resultado: Normal. Sin anomalías.

Experimento #008 — 22/03/2024
  Tipo: Síntesis orgánica avanzada
  Material: Hojas y tallos de Digitalis purpurea (dedalera)
  Nota: extracción de veneno natural completada
  Resultado: Digitalina obtenida en forma concentrada.

Experimento #009 — 01/04/2024
  Tipo: Purificación por recristalización
  Material: Extracto bruto de dedalera
  Nota: veneno purificado al 98%. Dosis letal: 5-10mg.
  Resultado: Producto almacenado en frasco azul etiquetado.

Experimento #010 — 15/04/2024
  Tipo: Prueba de estabilidad térmica
  Material: Digitalina purificada en solución acuosa
  Nota: veneno estable a 90°C. No se degrada en infusiones.
  Resultado: Compuesto activo al 100% tras 10 min a 90°C.

Experimento #011 — 01/05/2024
  Tipo: Control de calidad final
  Material: Lote completo de digitalina
  Resultado: Producto aprobado para uso.

Experimento #012 — 10/05/2024
  Tipo: Preparación de dosis individuales
  Material: Extracto final purificado
  Resultado: 3 dosis de 8mg preparadas y almacenadas.

[El registro se interrumpe aquí. Páginas siguientes arrancadas.]
HEREDOC

cat > mansion/laboratorio/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║          PISTA — CAPÍTULO 4: El Laboratorio              ║
╚══════════════════════════════════════════════════════════╝

COMANDOS DE ESTE CAPÍTULO:

  nano archivo.txt
    Abre un editor de texto en la terminal.
    → Ctrl+O para guardar
    → Enter para confirmar el nombre
    → Ctrl+X para salir

  ls -la
    Muestra los permisos de los archivos.
    La columna de la izquierda indica los permisos:
      -rwxr-xr-x  → tiene permisos de ejecución (x)
      -rw-r--r--  → NO tiene permisos de ejecución

  chmod +x archivo.sh
    Da permiso de ejecución a un archivo (script).

  chmod -x archivo.sh
    Quita el permiso de ejecución.

  ./archivo.sh
    Ejecuta un script en la carpeta actual.
    (El ./ indica "en esta carpeta")

────────────────────────────────────────────────────────────
TUBERÍAS | — Primer contacto

Un "pipe" conecta la salida de un comando con la entrada
del siguiente. Se escribe con el símbolo |

  Ejemplo básico:
    cat registro_experimentos.txt | grep "veneno"
    → Lee el archivo Y filtra solo las líneas con "veneno"

  Doble tubería:
    cat registro_experimentos.txt | grep "veneno" | head -3
    → Lee → filtra por "veneno" → muestra solo las 3 primeras

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

Hay un análisis toxicológico que no puedes ver todavía.
Los archivos tienen permisos — quién puede leer,
quién puede ejecutar, quién no puede hacer nada.
La columna de la izquierda de 'ls -la' lo revela todo.

El cuaderno de notas está en blanco.
Todo detective que se precie deja huella de su paso.

El registro de experimentos es largo.
Hay entradas que mencionan algo particular.
Las tuberías te permiten filtrar sin leer línea a línea.
────────────────────────────────────────────────────────────
Para avanzar: cd ../estudio
HEREDOC

# ============================================================
# CAPÍTULO 5 — EL ESTUDIO
# Comandos: tuberías avanzadas, ls -la, cd, cat, grep
# ============================================================

cat > mansion/estudio/documentos/testamento.txt << 'HEREDOC'
TESTAMENTO DE LORD EDMUND TORVALD
════════════════════════════════════
Redactado en Londres, 15 de septiembre de 2024

Yo, Edmund Charles Torvald, en plenas facultades
mentales y físicas, declaro que en caso de fallecimiento
mis bienes se distribuirán como sigue:

HEREDERO PRINCIPAL:
  Victor James Gentoo (sobrino)
  Recibirá: La Mansión Torvald y todos sus contenidos,
  incluyendo colección de arte y vehículos.

HEREDERA SECUNDARIA:
  Lady Isolde Torvald (esposa)
  Recibirá: El apartamento de Mayfair, Londres.
  Y la suma de £50,000 como liquidación definitiva.

Firmado: Edmund Torvald
Testigo: James Grub, Solicitor

─────────────────────────────────────────────────────
NOTA PERICIAL: Este documento presenta irregularidades.
La firma NO coincide con testamentos anteriores.
Se detectaron alteraciones mediante luz ultravioleta.
El nombre "Victor James Gentoo" fue añadido posteriormente.
El texto original fue modificado.
─────────────────────────────────────────────────────
HEREDOC

cat > mansion/estudio/documentos/poliza_seguro.txt << 'HEREDOC'
PÓLIZA DE SEGURO DE VIDA
TORVALD INSURANCE GROUP
══════════════════════════

Asegurado:        Lord Edmund Torvald
Número de póliza: BIG-4471-B
Fecha de emisión: 1 de enero de 2020
Última renovación: 1 de octubre de 2024

BENEFICIARIA ÚNICA:
  Lady Isolde Torvald (esposa legal)

COBERTURA:
  Muerte por cualquier causa: £2,000,000
  (DOS MILLONES DE LIBRAS ESTERLINAS)

══════════════════════════════════════════════
NOTA INTERNA DEL ARCHIVO:
La renovación del 1 de octubre fue solicitada
en persona por Lady Isolde Torvald.
Lord Torvald no fue informado de la renovación.
El cambio de beneficiario previsto para el 14 de
octubre (cita con el abogado) nunca llegó a realizarse.
══════════════════════════════════════════════
HEREDOC

# Create 10 letters, only carta_10 is relevant
for i in 1 2 3 4 5 6 7 8 9; do
cat > "mansion/estudio/documentos/cartas/carta_0${i}.txt" << HEREDOC
CORRESPONDENCIA PERSONAL #${i}
══════════════════════════════
Estimado Edmund:

Espero que esta carta te encuentre en buen estado de salud.
Los asuntos del Club de Coleccionistas continúan su curso.
Quedamos el próximo mes para la reunión habitual del trimestre.

Ha sido un placer como siempre.

Atentamente,
Lord Arthur Debian
HEREDOC
done

cat > mansion/estudio/documentos/cartas/carta_10.txt << 'HEREDOC'
CORRESPONDENCIA PERSONAL #10 — CONFIDENCIAL
═════════════════════════════════════════════

Edmund:

He investigado con discreción lo que me pediste el mes pasado.

Lo que he encontrado me alarma profundamente.

En febrero y marzo, Isolde adquirió libros de toxicología
en tres librerías distintas de Londres, pagando siempre en
efectivo. También visitó el laboratorio de la finca en al
menos dos ocasiones cuando tú no estabas en casa.

Accedí (con mucha dificultad) a sus notas personales.
Había cantidades, dosis, horarios y nombres de compuestos.
Todo muy calculado. Todo muy premeditado.

Destruye esta carta después de leerla.
No le menciones a nadie que me escribiste.

Ten mucho cuidado, Edmund.

                                             — M.
HEREDOC

cat > mansion/estudio/documentos/.archivos_privados/confesion.txt << 'HEREDOC'
DOCUMENTO HALLADO EN EL INTERIOR DEL MARCO DEL CUADRO
═══════════════════════════════════════════════════════
(Cuadro del salón principal, pared oeste)

Papel arrancado de un cuaderno. Letra femenina.
Sin fecha. Sin firma completa.

────────────────────────────────────────────────
"Lo hice por el dinero. Siempre fue por el dinero.

£2,000,000 es más de lo que él me daría en vida.
Cambiar el testamento era solo cuestión de tiempo.
Ya hablaba de darle todo a Victor. A ese inútil.
No podía permitirme quedarme sin nada.

La dedalera del jardín hizo el resto.
Llevo meses perfeccionando la dosis exacta.
Nadie mirará en el invernadero. Nadie lo sabrá.

I.B."
────────────────────────────────────────────────

Nota del Detective:
Las iniciales "I.B." corresponden a Isolde Torvald.

╔══════════════════════════════════════════════════════════╗
║          CONTRASEÑA DEL CAPÍTULO 5: HERENCIA             ║
║    Introdúcela en la web para desbloquear el Salón       ║
╚══════════════════════════════════════════════════════════╝
HEREDOC

cat > mansion/estudio/informe_pericial.txt << 'HEREDOC'
INFORME PERICIAL — CASO TORVALD
════════════════════════════════════
Referencia: INV-2024-1013
Perito forense: Dr. Arthur Cron, F.R.C.Path.
Fecha: 13 de octubre de 2024

────────────────────────────────────────────────
ANÁLISIS DE LA ESCENA DEL CRIMEN (Estudio)
────────────────────────────────────────────────
El estudio presenta signos de revisión reciente.
El cajón izquierdo del escritorio fue forzado.
Se hallaron huellas parciales en el marco del cuadro
de la pared oeste (coinciden con Lady Isolde Torvald).

────────────────────────────────────────────────
ANÁLISIS DEL TESTAMENTO
────────────────────────────────────────────────
La firma del testamento no coincide con documentos previos.
Análisis de tinta: el nombre "Victor James Gentoo" fue escrito
con una pluma diferente al resto del documento.
Conclusión: testamento alterado de forma fraudulenta.
El documento original nombra a Lady Isolde como heredera única.

CLAVE PERICIAL: HERENCIA_ALTERADA

────────────────────────────────────────────────
ANÁLISIS TOXICOLÓGICO
────────────────────────────────────────────────
Muestra: Residuos en taza de porcelana azul.
Resultado: POSITIVO en digitalina (glucósido cardíaco).
Concentración hallada: 8.3 mg (dosis letal confirmada: 5-10mg).
Tiempo estimado de actuación: 2-4 horas tras ingestión.
El Lord habría fallecido entre las 00:30 y las 02:30.

Estabilidad del compuesto: la digitalina NO se degrada
a 90°C, temperatura del agua para infusión de té.

────────────────────────────────────────────────
ANÁLISIS DEL JARDÍN E INVERNADERO
────────────────────────────────────────────────
Se hallaron plantas de Digitalis purpurea (dedalera)
recientemente cortadas en el invernadero privado.
Las tijeras de jardinería presentan residuos del mismo compuesto.
Huellas en el invernadero: coinciden con Lady Isolde Torvald.

────────────────────────────────────────────────
CONCLUSIÓN PRELIMINAR
────────────────────────────────────────────────
Todas las evidencias apuntan a homicidio premeditado.
La escena fue manipulada para simular muerte natural.
Recomiendo la detención inmediata para interrogatorio.

Firmado: Dr. Arthur Cron
HEREDOC

cat > mansion/estudio/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║            PISTA — CAPÍTULO 5: El Estudio                ║
╚══════════════════════════════════════════════════════════╝

TUBERÍAS AVANZADAS — La verdadera potencia de Linux

Recuerda: el símbolo | conecta la salida de un comando
con la entrada del siguiente. Puedes encadenarlos.

EJERCICIOS DE TUBERÍAS:

  1. Filtrar la salida de ls:
     ls -la documentos/ | grep "^d"
     → Solo muestra líneas que empiezan por 'd' (directorios)

  2. Buscar en múltiples archivos a la vez:
     cat documentos/cartas/*.txt | grep "Isolde"
     → Lee TODAS las cartas y filtra las que mencionan a Isolde

  3. Ver un informe largo filtrando lo relevante:
     cat informe_pericial.txt | grep "CLAVE"
     → Muestra solo la línea con la clave pericial

  4. Encadenar tres comandos:
     cat informe_pericial.txt | grep "Torvald" | head -5
     → Lee → filtra → muestra solo las 5 primeras coincidencias

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

El Lord escondió sus pruebas más comprometedoras.
En Linux, las carpetas también pueden ocultarse.
Mira con detenimiento dentro de documentos/ —
puede haber más capas de las que parecen.

Una vez que encuentres lo que buscas,
practica encadenar comandos con tuberías:
diez cartas a la vez, informes de cien líneas,
listados filtrados. La información dispersa
se vuelve poderosa cuando la canalizas.
────────────────────────────────────────────────────────────
Para avanzar: cd ../salon_principal
HEREDOC

# ============================================================
# CAPÍTULO 6 — EL SALÓN PRINCIPAL
# Comandos: grep, ls -la, cat, pipes, exit
# ============================================================

cat > mansion/salon_principal/lista_evidencias.txt << 'HEREDOC'
RESUMEN DE EVIDENCIAS RECOPILADAS
════════════════════════════════════
Detective Marcos Kernel — Caso Torvald

Comprueba que tienes las contraseñas de cada capítulo:

  Capítulo 1 — La Entrada:       _______________________
  Capítulo 2 — La Biblioteca:    _______________________
  Capítulo 3 — La Cocina:        _______________________
  Capítulo 4 — El Laboratorio:   _______________________
  Capítulo 5 — El Estudio:       _______________________

Si has introducido las 5 contraseñas en la web del caso,
el Capítulo 6 ya debería estar desbloqueado.

A continuación, lee el informe final y descubre al culpable.

  grep "CULPABLE" informe_final.txt
HEREDOC

cat > mansion/salon_principal/informe_final.txt << 'HEREDOC'
INFORME FINAL DE INVESTIGACIÓN
════════════════════════════════
CASO:       Muerte de Lord Edmund Torvald
DETECTIVE:  Marcos Kernel — Placa DMV-2024-447
FECHA:      13 de octubre de 2024, 03:47


RESUMEN EJECUTIVO
─────────────────
Lord Edmund Torvald, 67 años, fue hallado inconsciente
en su estudio a las 23:55 del 12 de octubre de 2024.
Declarado muerto en el lugar a las 00:30 del día 13.
Causa oficial inicial: paro cardíaco.
Resultado de esta investigación: HOMICIDIO PREMEDITADO.


CRONOLOGÍA COMPLETA DE LOS HECHOS
────────────────────────────────────

  Febrero — Marzo 2024:
    Lady Isolde adquiere libros de toxicología.
    Experimenta en el laboratorio con Digitalis purpurea.
    Obtiene y purifica digitalina. Calcula dosis letal.

  1 de octubre de 2024:
    Lady Isolde renueva la póliza de seguro de vida
    (beneficiaria: ella misma, £2,000,000) sin informar al Lord.

  10 de octubre de 2024:
    El Lord comunica a su abogado su intención de cambiar
    el testamento. Cita fijada para el 14 de octubre.

  12 de octubre de 2024:
    21:00 — Lady Isolde envía al mayordomo Thomas fuera
            de la mansión con el pretexto de "darle la noche libre".
    22:30 — Lady Isolde prepara el té del Lord. Añade 8mg
            de digitalina disuelta. Lo sirve en la taza azul.
    22:47 — El Lord nota un sabor ligeramente diferente.
            No dice nada.
    23:45 — El Lord pierde el conocimiento en su estudio.
    23:55 — Thomas regresa y encuentra al Lord inconsciente.
            Llama al médico de urgencias.
    00:30 — El Dr. Fedora declara el fallecimiento.

  13 de octubre de 2024:
    01:30 — Análisis toxicológico: digitalina detectada.
    02:00 — Detective Kernel asume el caso.
    03:47 — Investigación completada.


ANÁLISIS DE EVIDENCIAS
────────────────────────

  Evidencia 1 — Diario del Lord (Biblioteca):
    El Lord expresó sus sospechas. Usó la palabra "TRAICION"
    para describir lo que vivía. Planificaba cambiar el testamento.

  Evidencia 2 — Registro del Laboratorio:
    Experimentos con dedalera realizados en secreto.
    Cálculo de dosis letales. Producto purificado al 98%.

  Evidencia 3 — Análisis Toxicológico (Laboratorio):
    8.3mg de digitalina en la taza de porcelana azul del Lord.
    Solo Lady Isolde preparó el té esa noche.

  Evidencia 4 — Documentos Legales (Estudio):
    Testamento alterado fraudulentamente.
    Póliza de vida (£2,000,000) renovada sin conocimiento del Lord.

  Evidencia 5 — Carta de Confesión (Estudio):
    Papel con iniciales "I.B." encontrado en el marco del cuadro.
    Describe el móvil, el método y la premeditación.


CONCLUSIÓN FINAL
────────────────

Tras analizar la totalidad de las evidencias recopiladas
en las seis habitaciones de la Mansión Torvald, el autor
material e intelectual del asesinato de Lord Edmund Torvald es:

  LADY ISOLDE TORVALD — CULPABLE

  Móvil:          Cobrar la póliza de vida (£2,000,000) antes
                  de que el Lord cambiara el testamento a su perjuicio.

  Método:         Digitalina (Digitalis purpurea) disuelta en té.

  Premeditación:  Mínimo 8 meses de planificación documentada.

  Oportunidad:    Única persona que preparó el té la noche del crimen.

CONTRASEÑA: ISOLDE_CULPABLE


Se ordena la detención inmediata de Lady Isolde Torvald.

                              — Detective Marcos Kernel
                                Placa DMV-2024-447
HEREDOC

# Suspect files
cat > mansion/salon_principal/sospechosos/isolde_blackwood.txt << 'HEREDOC'
FICHA: Lady Isolde Torvald
══════════════════════════════
Estado: DETENIDA — CULPABLE

Móvil:        £2,000,000 (póliza de seguro de vida)
Método:       Digitalina en el té de las 22:30
Premeditación: 8 meses documentados
Veredicto:    CULPABLE de homicidio en primer grado
HEREDOC

for name in victor_ashby thomas_wells margaret_fenn james_holt; do
cat > "mansion/salon_principal/sospechosos/${name}.txt" << HEREDOC
FICHA: ${name//_/ }
══════════════════════════
Estado: DESCARTADO

Coartada verificada.
Sin evidencias que lo vinculen al crimen.
Móvil insuficiente.
HEREDOC
done

cat > mansion/salon_principal/.codigo_acceso.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║              ¡ENHORABUENA, DETECTIVE KERNEL!             ║
╚══════════════════════════════════════════════════════════╝

Has resuelto el Caso Torvald.

Lady Isolde Torvald ha sido detenida esta madrugada.
La justicia seguirá su curso.

Tu código de caso cerrado es:

         CASO_RESUELTO_TORVALD_2024

Este código aparecerá en tu certificado de detective
cuando completes la investigación en la web del caso.

Cuando termines, puedes cerrar el terminal con:
  exit

Gracias por tu dedicación, Detective.

              — Comisaría Central de Scotland Yard
HEREDOC

cat > mansion/salon_principal/pista.txt << 'HEREDOC'
╔══════════════════════════════════════════════════════════╗
║         PISTA — CAPÍTULO 6: El Salón Principal           ║
╚══════════════════════════════════════════════════════════╝

COMANDOS FINALES:

  grep "CULPABLE" informe_final.txt
    Busca la línea con la conclusión del caso.

  ls -la
    Recuerda: ¿hay archivos ocultos en este salón?

  cat .codigo_acceso.txt
    Lee el código de acceso final.

  exit
    Cierra la sesión del terminal.
    Úsalo cuando hayas terminado la investigación.

────────────────────────────────────────────────────────────
REPASO DE TUBERÍAS:

  Tubería simple:
    grep "CULPABLE" informe_final.txt
    cat informe_final.txt | grep "CULPABLE"
    (ambas hacen lo mismo — la segunda usa tubería)

  Tubería doble:
    cat informe_final.txt | grep "Evidencia" | head -3

  Buscar en múltiples archivos:
    cat sospechosos/*.txt | grep "CULPABLE"

────────────────────────────────────────────────────────────
INVESTIGACIÓN:

El informe lo dice todo. Pero tiene muchas líneas
y son las tres de la madrugada. No las necesitas todas.
Sabes qué palabra estás buscando.

Cuando lo tengas, mira también lo que no se ve a simple vista.
Este salón, como cada habitación de la mansión,
guarda algo oculto para quien sabe mirar.

Y cuando el caso esté cerrado... toda sesión tiene un cierre.
────────────────────────────────────────────────────────────
HEREDOC

# ============================================================
# ARCHIVOS DECORATIVOS — ATMÓSFERA DE LA MANSIÓN
# ============================================================

# — ENTRADA —

cat > mansion/entrada/felpudo.txt << 'HEREDOC'
Un felpudo de yute gastado frente a la puerta principal.
La palabra WELCOME apenas es legible.
Nadie limpió los zapatos aquí desde hace semanas.
HEREDOC

cat > mansion/entrada/cuadro_entrada.txt << 'HEREDOC'
Retrato al óleo de Lord Edmund Torvald.
Marco dorado, algo polvoriento.
El Lord tiene la mirada severa y las manos cruzadas sobre el regazo.
En la parte inferior del marco, grabado en latón:
  "A los que buscan, que encuentren."
Tiene unos 50 años en el cuadro. El Lord murió con 67.
HEREDOC

cat > mansion/entrada/paragüero.txt << 'HEREDOC'
Un paragüero de hierro forjado junto a la puerta.
Contiene: dos paraguas negros y un bastón con empuñadura de plata.
El bastón pertenecía al Lord — lo usaba desde el accidente de 2018.
Los paraguas son de ella. Siguen mojados.
HEREDOC

# — BIBLIOTECA —

cat > mansion/biblioteca/globo_terraqueo.txt << 'HEREDOC'
Globo terráqueo de madera y latón, sobre un pedestal de caoba.
Gira con suavidad al tocarlo.
Alguien ha marcado una X con tinta roja en el Polo Norte.
No hay ningún país allí. Solo hielo.
HEREDOC

cat > mansion/biblioteca/chimenea.txt << 'HEREDOC'
Chimenea de mármol negro que ocupa casi toda la pared norte.
Está apagada. El mármol está frío.
En las cenizas se distinguen restos de papel quemado —
bordes chamuscados, trozos de letra manuscrita.
Imposible leerlos. Alguien se aseguró de ello.
HEREDOC

cat > mansion/biblioteca/taza_cafe.txt << 'HEREDOC'
Una taza de café a medio beber sobre una pila de libros.
Completamente fría. Abandonada hace horas.
El libro de abajo es un tratado de toxicología victoriana.
No pertenece al Lord — la letra del marcador no es la suya.
HEREDOC

# — COCINA —

cat > mansion/cocina/taza_azul.txt << 'HEREDOC'
La taza de porcelana azul del Lord.
La reconocería en cualquier parte — es la única de ese color.
Está lavada. Muy lavada.
Más de lo que alguien lavaría una taza normal después de usarla.
HEREDOC

cat > mansion/cocina/especiero.txt << 'HEREDOC'
Un especiero de madera con doce frascos de cristal.
Once están etiquetados: sal, pimienta, nuez moscada...
El duodécimo frasco no tiene etiqueta.
Está vacío. Huele a algo vegetal y ligeramente amargo.
HEREDOC

cat > mansion/cocina/calendario.txt << 'HEREDOC'
Calendario de pared. Octubre de 2024.
La mayoría de los días están en blanco.
El día 12 tiene un círculo en rojo
y las palabras escritas a mano: "22:30 — té".
La caligrafía no es la del Lord.
HEREDOC

# — LABORATORIO —

cat > mansion/laboratorio/frasco_azul.txt << 'HEREDOC'
Un frasco de cristal azul cobalto, pequeño, sin etiqueta.
Tapón de corcho. Completamente vacío.
Si acercas la nariz al interior:
algo vegetal. Dulce al principio. Amargo después.
HEREDOC

cat > mansion/laboratorio/microscopio.txt << 'HEREDOC'
Microscopio óptico de latón y acero, modelo antiguo pero en buen estado.
En el portaobjetos hay una preparación: tejido vegetal, células largas.
El polvo que cubre el microscopio termina de golpe en los oculares
— alguien lo usó recientemente.
HEREDOC

cat > mansion/laboratorio/manual_botanica.txt << 'HEREDOC'
Manual de Botánica Aplicada, tercera edición, 1987.
Abierto por la página 247: Digitalis purpurea (dedalera).
Varias líneas subrayadas en lápiz:
  "Glucósido cardíaco. Dosis terapéutica vs. letal: margen estrecho."
  "Estable en soluciones acuosas a temperaturas de infusión."
En el margen hay anotaciones. La letra no es la del Lord.
HEREDOC

# — ESTUDIO —

cat > mansion/estudio/reloj_pared.txt << 'HEREDOC'
Un reloj de pared de madera oscura, fabricado en Suiza.
Las agujas están detenidas.
Marcan las 22:30.
¿Se paró solo? ¿O alguien lo detuvo?
HEREDOC

cat > mansion/estudio/cuadro_pared_oeste.txt << 'HEREDOC'
Cuadro al óleo. Paisaje escocés: niebla, páramo, un río.
Firmado en 1923 por un artista cuyo nombre es ilegible.
El marco está ligeramente torcido — separado de la pared
unos dos centímetros en la esquina inferior derecha.
Como si alguien lo hubiera movido hace poco y no lo hubiera
vuelto a colocar bien.
HEREDOC

cat > mansion/estudio/pluma_tintero.txt << 'HEREDOC'
Pluma estilográfica Parker sobre el escritorio.
Tintero de cristal a su lado, abierto.
La pluma tiene tinta fresca en la punta.
Alguien escribió algo aquí hace pocas horas.
No hay papel a la vista.
HEREDOC

# — SALÓN PRINCIPAL —

cat > mansion/salon_principal/candelabro.txt << 'HEREDOC'
Candelabro de plata para cinco velas, en el centro de la mesa principal.
Tres velas consumidas hasta el final — la cera desbordada y fría.
Las otras dos apenas usadas.
Cinco personas. Tres que esperaron. Dos que se marcharon pronto.
HEREDOC

cat > mansion/salon_principal/piano.txt << 'HEREDOC'
Piano de cola cubierto con una sábana blanca.
Marca Bösendorfer, principios del siglo XX.
Levantas la sábana: el teclado está intacto, sin polvo.
Pulsas la tecla más alta del registro.
Suena un semitono más bajo de lo que debería.
HEREDOC

cat > mansion/salon_principal/retrato_isolde.txt << 'HEREDOC'
Retrato de Lady Isolde Torvald. Pintado en 2019.
Está de pie junto al invernadero, con guantes de jardinería blancos.
Sonrisa calculada. Ojos que no sonríen.
En el cabello: flores de dedalera morada.
Al pie del cuadro, en letras pequeñas:
  "Premio de Horticultura del Condado, 2019."
HEREDOC

# ============================================================
# MENSAJE FINAL
# ============================================================
echo ""
echo -e "${GREEN}  ✓ Habitaciones creadas${NC}"
echo -e "${GREEN}  ✓ Archivos de evidencias generados${NC}"
echo -e "${GREEN}  ✓ Pistas ocultas instaladas${NC}"
echo -e "${GREEN}  ✓ Permisos configurados${NC}"
echo ""
echo -e "${GOLD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║          LA MANSIÓN TORVALD ESTÁ LISTA                   ║${NC}"
echo -e "${GOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Empieza tu investigación:"
echo ""
echo -e "    ${CYAN}cd mansion/entrada${NC}"
echo -e "    ${CYAN}cat bienvenida.txt${NC}"
echo ""
echo -e "  Recuerda: en cada habitación hay un ${GOLD}pista.txt${NC}"
echo -e "  que te explica exactamente qué comandos usar."
echo ""
