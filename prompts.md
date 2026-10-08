dentro de specs/001-reservas-sala/spec.md, Describe solo el QUÉ: sin widgets, `setState`, paquetes ni carpetas. Tiene **al menos tres escenarios nuevos**, en Dado/Cuando/Entonces, dedicados a la regla de solapamiento: los que consideres necesarios para que la regla no quede ambigua. Los dos escenarios que la spec ya trae no cuentan. Fija un mensaje de rechazo exacto.

puedes verificar que en lib/domain/crear_reserva.dart y sus pruebas en test/
La regla se cumple en todos los casos que la regla implica, no solo en los escenarios que escribiste. El mismo mensaje en la spec, en la prueba y en el código.
Si algo no te queda claro dime y de paso explicas porque no entiendo tampoco

Como lo arreglamos?

dentro de RESPUESTAS.md, Tres secciones con estos títulos exactos: `## Escenarios que elegí y por qué`, `## Riesgo más grave del repositorio`, `## ¿La regla protege la app real?`. Cada afirmación cita la evidencia como `ruta:línea` (por ejemplo, `lib/domain/crear_reserva.dart:12`) y explica qué muestra esa línea. Extensión recomendada: hasta **400 palabras** en total.

como compruebo que tengo 3 commits separados?

PS C:\reservas_sala\prueba1-reservas--Cachimuel-> git log --oneline --reverse
2bccf2f (HEAD -> prueba/solapamiento, origin/main, origin/HEAD, main) Initial commit
PS C:\reservas_sala\prueba1-reservas--Cachimuel-> git show --stat <hash>
At line:1 char:17
+ git show --stat <hash>
+                 ~
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : RedirectionNotSupported

PS C:\reservas_sala\prueba1-reservas--Cachimuel->

ahora cómo se hace eso

actualiza este entregable
