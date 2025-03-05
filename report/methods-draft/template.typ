#import "@preview/diverential:0.2.0": *
#import "@preview/physica:0.9.4": *

#let mkcap = (sp, w, s) => it => block(width: w)[
  #set text(size: s)
  #v(sp)
  #emph[#it.supplement #context it.counter.display(it.numbering)#it.separator] #it.body
]

#let project(title: "", authors: (), body) = {
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center, columns: 1)
  set text(font: "Libertinus Serif", lang: "en")

  place(top + center, float: true, scope: "parent", [
    // Title
    #text(weight: 700, 1.75em, title)

    // Author information
    #pad(
      top: 0.8em,
      bottom: 0.8em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center)[
          *#author.name* \
          #author.email
        ]),
      )
    )
  ])

  // equation numbering
  // https://forum.typst.app/t/977/13
  set math.equation(numbering: "(1)")
  show math.equation: it => {
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)#label("")
    ] else {
      it
    }
  }
  show math.equation.where(block: true): set par(leading: 0.75em)

  // Main body
  set par(justify: true, leading: 1.50em, spacing: 1.50em, first-line-indent: (amount: 0.5in, all: false))
  show heading: set block(below: 1em, above: 2em)
  show figure.caption: mkcap(0em, 97%, 0.9em)

  body
}

#let bigsp = $quad quad$
#let pad = $space.narrow$
#let implies = $bigsp=>bigsp$

