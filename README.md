# <center>CIU - Práctica 7</center>

## Contenidos

* [Autoría](#autoría)
* [Introducción](#introducción)
* [Controles](#controles)
* [Implementación](#implementación)
* [Animación del programa](#animación-del-programa)
* [Referencias](#referencias)

## Autoría

Esta obra es un trabajo realizado por Benearo Semidan Páez para la asignatura de Creación de Interfaces de Usuario cursada en la ULPGC.

## Introducción

El objetivo de esta práctica consiste en implementar en Processing el manejo de audio. Por ello, el trabajo consiste en un escenario con elementos que cambian de tamaño en base a la ondas sonoras recogidas, gracias a la librería Minim.

## Controles

| Acción | Resultado |
| -- | -- |
| Pulsar cualquier tecla | Reproduce/para/reanuda la música |

## Implementación

La implementación consta de las siguientes partes:

* Cambio de tamaño de un conjunto de flores en el escenario

```java
int value = (int) (mean + player.left.get((int)random(0, player.bufferSize()-1))*100);

imageMode(CENTER);
image(flowers, width/2, height - 150, value, value);
image(flowers, width/2 - 150, height - 120, value, value);
image(flowers, width/2 + 200, height - 75, value, value);
image(flowers, width/2 - 50, height - 130, value, value);
image(flowers, width/2 + 250, height - 55, value, value);
image(flowers, width/2 - 10, height - 150, value, value);
```

* Muestra de las frecuencias sonoras, tanto del lado izquierdo como el derecho (si el audio es mono, se solapan)

```java
float mean = 0;
for (int i = 0; i < player.bufferSize() - 1; i++) {
  float x1 = map( i, 0, player.bufferSize(), 0, width );
  float x2 = map( i+1, 0, player.bufferSize(), 0, width );
  line( x1, height + player.left.get(i)*100, x2, height + player.left.get(i+1)*100 );
  line( x1, height + player.right.get(i)*100, x2, height + player.right.get(i+1)*100 );
  mean += player.left.get(i);
}
```

* Posibilidad de parar/reanudar el audio, además de mostrar de manera visual una representación del tiempo escuchado del tema.

Barra de reproducción:
```java
float posx = map(player.position(), 0, player.length(), 0, width);
stroke(0, 200, 0);
line(posx, 0, posx, height);
```

Pausar/reanudar reproducción:

```java
void keyPressed() {
  if (player.isPlaying()) {
    player.pause();
  } else if (player.position() == player.length()) {
    player.rewind();
    player.play();
  } else {
    player.play();
  }
}
```

## Animación del programa

![GIF](animation/animation.gif)

## Referencias

- La canción usada viene dada por Windows 7 como audio de muestra. Se trata de una obra de Richard Stoltzman, titulada <i>Maid with the Flaxen Hair</i>.

- <b>[[Imagen de fondo]](https://analiticapublica.es/wp-content/uploads/2015/05/campo-verde-intenso-768x576.jpg)</b>

- <b>[[Imagen de las flores]](http://ekladata.com/91-YGzZuMngr_DPKq2utzHMXXUI@500x568.png)</b>

- <b>[[Referencia de Processing]](https://processing.org/reference/)</b>
