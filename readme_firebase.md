## firebase config

document link Depura eventos https://firebase.google.com/docs/analytics/debugview?hl=es-419#ios+

document register event https://firebase.google.com/docs/analytics/events?hl=es-419&platform=flutter

## iOS+ Habilita el modo de depuración

Para habilitar el modo de depuración de Analytics en tu dispositivo de desarrollo, especifica el siguiente argumento de línea de comandos en Xcode:

```
-FIRDebugEnabled
```

Este comportamiento persiste hasta que inhabilites el modo de depuración explícitamente a través del siguiente argumento de línea de comandos:

```
-FIRDebugDisabled
```

Para agregar estos argumentos, edita el esquema de tu proyecto y agrega una entrada nueva a “Arguments Passed On Launch”.

## Andorid

Para habilitar el modo de depuración de Analytics en un dispositivo Android, ejecuta los siguientes comandos:

```
adb shell setprop debug.firebase.analytics.app 
```

Este comportamiento persiste hasta que inhabilites explícitamente el modo de depuración a través del siguiente comando:

```
adb shell setprop debug.firebase.analytics.app .none.
```