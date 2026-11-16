# Actividad 2 — Comparación de módulos del kernel cargados

Ejecutamos `lsmod` y `uname -rm` en las PCs de Lautaro, Renata y Tomás. Los tres equipos usan la arquitectura `x86_64` y ejecutan distintas versiones del kernel.

| Integrante | Kernel | Módulos cargados |
|---|---|---:|
| [Lautaro](lsmod-lautaro.txt) | `5.15.0-198-generic` | 163 |
| [Renata](lsmod-renata.txt) | `7.0.0-38-generic` | 150 |
| [Tomás](lsmod-tomasfaro-ctrl.txt) | `7.0.0-42-generic` | 201 |

Las versiones se registraron con `uname -rm`. [Lautaro](kernel-lautaro.txt) · [Renata](uname%20rm%20renata.jpeg) · [Tomás](kernel-tomasfaro-ctrl.txt).

## Resultados del diff

El anexo reúne las tres comparaciones realizadas con `diff -u` sobre las salidas originales. Para contar qué módulos comparte cada par, comparamos únicamente los nombres de la primera columna. Así, un cambio de orden, tamaño o contador de uso no altera el recuento. [Anexo con los tres diffs](actividad-2-diff.txt)

| Comparación | En ambos | Solo en el primer equipo | Solo en el segundo equipo |
|---|---:|---:|---:|
| Lautaro y Renata | 84 | 79 | 66 |
| Lautaro y Tomás | 119 | 44 | 82 |
| Renata y Tomás | 98 | 52 | 103 |

Los tres listados tienen **76 módulos en común**, entre ellos `bluetooth` y `nvme`. Por ejemplo, `bluetooth` figura en los tres con distintos valores en `Size` y `Used by`.

## Diferencias observadas

- **Lautaro.** Solo en su listado aparece `ideapad_laptop`, el controlador de plataforma para Lenovo IdeaPad. Su presencia es coherente con las funciones específicas que Linux maneja en esa familia de equipos. [Código fuente de Linux](https://github.com/torvalds/linux/blob/master/drivers/platform/x86/lenovo/ideapad-laptop.c)
- **Renata.** Solo en su listado aparece `amdgpu`, un controlador gráfico para hardware AMD. El listado registra el controlador cargado y deja sin identificar el modelo exacto de GPU. [Documentación de AMDGPU del kernel](https://docs.kernel.org/gpu/amdgpu/index.html)
- **Tomás.** Solo en su listado aparece `ntfs3`, el controlador de lectura y escritura para NTFS. Tiene un contador de uso de 1 y su presencia es compatible con el acceso a un volumen NTFS. El listado por sí solo no identifica qué volumen se usó. [Documentación de NTFS3 del kernel](https://docs.kernel.org/filesystems/ntfs3.html)

Los ejemplos muestran cómo influyen el hardware y los sistemas de archivos en los módulos que se cargan. También pueden influir la configuración del kernel y el estado de cada PC al tomar la muestra. `lsmod` refleja los módulos cargados en ese momento.
