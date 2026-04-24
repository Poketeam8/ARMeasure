Google Measure
Usa ARCore para detectar superficies planas (suelo, mesas, paredes).
El usuario apunta con la cámara.
Se colocan puntos en pantalla para medir distancias.
Calcula la distancia usando coordenadas en el espacio 3D.
Medición de largo y alto
Detección automática de planos
Interfaz simple
Google dejó de darle soporte, pero sigue siendo referencia técnica.

AR Ruler App
Utiliza ARCore (Android) o ARKit (iOS).
Permite seleccionar múltiples puntos en el espacio.
Calcula distancias, áreas y volúmenes
Medición de:
    Distancias
    Áreas
    Volúmenes
    Altura
Permite guardar mediciones
Más completa que otras apps

Measure (iOS)
Usa ARKit de Apple.
Detecta automáticamente objetos rectangulares.
Puede medir objetos automáticamente sin marcar puntos manualmente.
Medición automática de objetos
Nivel (herramienta tipo burbuja)
Alta precisión en dispositivos Apple

Similitudes: 
Usan realidad aumentada (AR)
Se basan en la cámara del móvil
Detectan superficies en 3D
Permiten medir distancias sin herramientas físicas
Usan sensores del dispositivo (giroscopio, acelerómetro)

Diferencias:
    Plataforma:
        Google Measure solo está disponible en Android
        AR Ruler App está disponible en Android y iOS
        Measure es exclusiva de iOS

    Tecnología utilizada:
        Google Measure usa ARCore
        AR Ruler App usa ARCore y ARKit
        Measure usa ARKit (optimizado para dispositivos Apple)

    Nivel de funcionalidades:
        Google Measure es más básica (solo distancias)
        AR Ruler App es la más completa (distancia, área, volumen, altura)
        Measure tiene funciones automáticas pero menos opciones avanzadas
    
    Automatización:
        Google Measure requiere seleccionar puntos manualmente
        AR Ruler App también es principalmente manual
        Measure puede detectar objetos automáticamente sin marcar puntos

    Precisión:
        Google Measure tiene precisión media
        AR Ruler App tiene precisión media a alta
        Measure suele ser más precisa gracias al hardware/software de Apple

    Funciones adicionales:
        Google Measure no guarda mediciones
        AR Ruler App permite guardar y gestionar mediciones
        Measure incluye herramientas extra como nivel (burbuja)

Como implementarlo en mi trabajo:
    Plugins principales:
        arcore_flutter_plugin → Android (ARCore)
        arkit_plugin → iOS (ARKit)
        Flutter no tiene AR nativo, necesitas estos plugins.
    ARCore / ARKit usan:
        Cámara
        Sensores del dispositivo
        SLAM (Simultaneous Localization and Mapping)
    Para detectar planos como:
        Suelo
        Mesas
        Paredes
    Cuando el usuario toca la pantalla:
        Se lanza un raycast desde la cámara
        Se detecta dónde ese rayo intersecta un plano
        Se obtiene una coordenada 3D (x, y, z)
    Para que el usuario vea lo que mide:
        Colocar esferas en los puntos
        Dibujar una línea entre ellos