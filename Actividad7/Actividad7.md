# Completely Fair Scheduler (CFS) de Linux

El **Completely Fair Scheduler (CFS)** es el algoritmo de planificación por defecto del kernel de Linux, introducido en la versión 2.6.23 del kernel. Está diseñado para ofrecer una forma más equitativa y eficiente de distribuir el tiempo de CPU entre los procesos que se ejecutan en el sistema

## Características principales del CFS:

1. **Equidad**: CFS se basa en el concepto de equidad, buscando asignar a cada proceso una cantidad justa de tiempo de CPU. El objetivo es que ningún proceso monopolice los recursos y que todos los procesos reciban tiempo de CPU de manera proporcional a su prioridad

2. **Árbol Rojo-Negro**: El CFS utiliza una estructura de datos llamada **árbol rojo-negro** (Red-Black Tree) para almacenar los procesos en espera de ejecución. Esta estructura permite realizar búsquedas, inserciones y eliminaciones de forma eficiente, con una complejidad de O(log n), donde *n* es el número de procesos

3. **Tiempo Virtual**: En lugar de manejar los tiempos de espera y ejecución como en otros planificadores, el CFS utiliza un concepto llamado **tiempo virtual** para hacer un seguimiento de cuánto tiempo ha ejecutado cada proceso en relación con otros procesos. Cada proceso tiene un valor llamado *vruntime*, que representa cuánto tiempo de CPU ha usado en términos virtuales

4. **Prioridades ponderadas**: El CFS asigna diferentes pesos a los procesos según su prioridad. Los procesos con mayor prioridad (menor peso) incrementan su *vruntime* más lentamente, lo que significa que pueden ejecutar más tiempo antes de ser preemptados. Los procesos con menor prioridad (mayor peso) incrementan su *vruntime* más rápido y son preemptados más pronto

5. **Preemptivo**: El CFS es un planificador preemptivo, lo que significa que puede interrumpir un proceso en ejecución para dar paso a otro que tenga un menor *vruntime* y, por tanto, más "derecho" a ejecutar

6. **Tiempo de ráfaga limitado**: El CFS impone un límite al tiempo de ráfaga máxima que un proceso puede ejecutar antes de que otro proceso tenga la oportunidad de ejecutarse, esto garantiza que incluso los procesos de menor prioridad tengan oportunidades de utilizar la CPU

## Funcionamiento del CFS:

1. **Asignación de CPU basada en vruntime**: Los procesos se colocan en el árbol rojo-negro basado en su valor de *vruntime*. El proceso con el menor valor de *vruntime* es el que se ejecutará primero. Conforme un proceso se ejecuta, su *vruntime* aumenta, lo que eventualmente hará que otro proceso con menor *vruntime* sea seleccionado para ejecutar

2. **Actualización dinámica del vruntime**: A medida que un proceso usa la CPU, su *vruntime* se incrementa en función de su peso (determinada por su prioridad). Este sistema asegura que los procesos con mayor prioridad ejecuten más tiempo en proporción a los procesos de menor prioridad

3. **Preemisión**: Si un proceso con menor *vruntime* entra en la cola de ejecución mientras otro proceso está ejecutando, el planificador puede interrumpir el proceso actual y pasar a ejecutar el nuevo proceso que tiene menor *vruntime*

4. **Periodo de tiempo de ejecución**: El CFS también introduce el concepto de periodo de tiempo de ejecución (o **granularity**), lo que significa que la CPU no cambia de proceso constantemente sino que se asegura que cada proceso tenga suficiente tiempo para ejecutar tareas significativas antes de ser preemptado

