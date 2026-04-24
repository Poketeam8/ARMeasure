Aplicación móvil desarrollada en Flutter que utiliza realidad aumentada (AR) para medir distancias, objetos y superficies en el mundo real a través de la cámara del dispositivo.

El usuario puede apuntar con su teléfono a un objeto o espacio y obtener medidas precisas sin necesidad de herramientas físicas como reglas o cintas métricas.

Camara: para capturar el entorno en tiempo real
Sensores(giroscopio y acelerometro): para posicionamiento espacial
Procesamiento AR: deteccion de planos
Pantalla tactil: seleccionar puntos de medicion
Almacenamiento: guardar mediciones

Historias de Usuario
Como usuario, quiero medir la distancia entre dos puntos usando la cámara para evitar usar una regla física ya que no siempre ando con ella.
Como usuario, quiero visualizar las medidas en pantalla en tiempo real para facilitarme la vida.
Como usuario, quiero guardar mediciones para consultarlas después y no tener que andar con ellas anotadas en mi libreta.
Como usuario, quiero una interfaz simple para medir rápidamente, odio las apps con interfaces complicadas para tareas simples.

RF1: Detectar superficies planas mediante AR.
RF2: Permitir seleccionar puntos en pantalla.
RF3: Calcular distancia entre puntos seleccionados.
RF4: Mostrar resultados en unidades métricas (cm, m).
RF5: Permitir reiniciar la medición

RNF1: Interfaz intuitiva y fácil de usar.
RNF2: Tiempo de respuesta corto.
RNF3: Precisión aceptable.
RNF4: Compatible con dispositivos que soporten ARCore.

```mermaid
flowchart TD
    A[Iniciar App] --> B[Activar Cámara]
    B --> C[Detectar superficie]
    C --> D[Seleccionar punto inicial]
    D --> E[Seleccionar punto final]
    E --> F[Calcular distancia]
    F --> G[Mostrar resultado]
    G --> H{¿Nueva medición?}
    H -->|Sí| D
    H -->|No| I[Finalizar]

