# Architecture Decision Record (ADR)

## Título

Prueba de Concepto para integración de cámara y persistencia local en Flutter.

---

# Contexto

La aplicación ARMeasure requiere validar la viabilidad técnica
de acceso a hardware móvil utilizando la cámara del dispositivo
junto con persistencia local de mediciones.

El principal riesgo identificado corresponde a la correcta
integración asíncrona entre Flutter, plugins nativos y
almacenamiento persistente.

Además, la aplicación necesita mantener las mediciones
realizadas incluso después del cierre de la aplicación.

---

# Decisión

Se decidió utilizar las siguientes tecnologías:

- camera
- shared_preferences

La librería camera fue seleccionada debido a:

- soporte oficial Flutter
- compatibilidad Android
- integración simple con widgets Flutter
- manejo asíncrono compatible con Dart

La librería shared_preferences fue seleccionada debido a:

- facilidad de implementación
- almacenamiento persistente liviano
- bajo costo computacional
- compatibilidad multiplataforma

La arquitectura fue separada en capas para desacoplar
la interfaz gráfica de la lógica de negocio y de los
servicios externos.

---

# Consecuencias

La PoC permitió validar exitosamente:

- acceso al hardware de cámara
- inicialización asíncrona de servicios
- persistencia local de mediciones
- actualización dinámica de interfaz
- manejo de estados críticos
- almacenamiento entre sesiones

Limitaciones identificadas:

- la medición actual es simulada
- dependencia de hardware físico
- persistencia limitada para grandes volúmenes de datos

Trabajo futuro:

- implementación de medición AR real
- integración de sensores avanzados
- migración a base de datos local estructurada
- implementación de arquitectura MVVM completa
- sincronización cloud

# Diagrama Estructural

```mermaid
graph TD

A[Presentation Layer]

A --> A1[SplashScreen]
A --> A2[MainNavigation]
A --> A3[HomeScreen]
A --> A4[MeasurementScreen]
A --> A5[HistoryScreen]
A --> A6[DetailScreen]
A --> A7[AboutScreen]
A --> A8[HelpScreen]

A --> B[Domain Layer]

B --> B1[Measurement Logic]
B --> B2[Camera Initialization]
B --> B3[Measurement Flow]

B --> C[Data Layer]

C --> C1[MeasurementData]
C --> C2[CameraService]
C --> C3[StorageService]

C --> D[Infrastructure Layer]

D --> D1[Camera Plugin]
D --> D2[SharedPreferences]
D --> D3[Android Camera Hardware]
```

---

# Diagrama de Secuencia

```mermaid
sequenceDiagram

actor Usuario

participant MeasurementScreen
participant CameraService
participant CameraPlugin
participant Hardware
participant MeasurementLogic
participant StorageService
participant SharedPreferences

Usuario->>MeasurementScreen: Abrir pantalla Medir

MeasurementScreen->>CameraService: Inicializar cámara

CameraService->>CameraPlugin: Solicitar acceso

CameraPlugin->>Hardware: Acceder cámara

Hardware-->>CameraPlugin: Cámara inicializada

CameraPlugin-->>CameraService: Respuesta exitosa

CameraService-->>MeasurementScreen: Cámara lista

Usuario->>MeasurementScreen: Presionar botón Medir

MeasurementScreen->>MeasurementLogic: Generar medición

MeasurementLogic-->>MeasurementScreen: Distancia calculada

MeasurementScreen->>StorageService: Guardar medición

StorageService->>SharedPreferences: Persistir datos

SharedPreferences-->>StorageService: Guardado exitoso

StorageService-->>MeasurementScreen: Confirmación

MeasurementScreen-->>Usuario: Mostrar resultado
```

---

# Diagrama de Estados

```mermaid
stateDiagram-v2

[*] --> Idle

Idle --> InicializandoCamara

InicializandoCamara --> CamaraLista
InicializandoCamara --> ErrorCamara

ErrorCamara --> Retry
Retry --> InicializandoCamara

CamaraLista --> RealizandoMedicion

RealizandoMedicion --> GuardandoDatos

GuardandoDatos --> MedicionExitosa
GuardandoDatos --> ErrorPersistencia

ErrorPersistencia --> RetryPersistencia
RetryPersistencia --> GuardandoDatos

MedicionExitosa --> CamaraLista
```