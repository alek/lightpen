# lightpen
A minimal javascript-based SVG DSL / REPL

Toy DSL made for the purpose of demonstrating Kolmogorov Complexity as applied to Graphic Design ([presentation](https://www.slideshare.net/alekbr/kolmogorov-complexity-art-and-all-that))

## Getting Started

Install package dependencies:

```console
npm install
```

Start node:

```console
node bin/www
```


Open the REPL in your browser:

```console
http://localhost:3100/
```

## Usage Examples

```console
loop(20000..1,50) circle $CNT/10 $CNT%1200 ($CNT/17)%23 black white ($CNT/50)%13
```

```console
loop(1200..1,30) circle 500 500 $CNT white black 3
```

```console
loop(500..1, 17) circle 500 500 $CNT white black $CNT%13
```