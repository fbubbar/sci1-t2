#import "@preview/diverential:0.2.0": *
#import "@preview/physica:0.9.4": *

#let par_indent = 0.5in
#let ind = h(par_indent)

#let eqr(r) = [(#ref(r, supplement: []))]
#let prcit(r) = cite(r, form: "prose")

#let mkcap = (sp, w, s) => it => block(width: w)[
  #set text(size: s)
  #set par(leading: 0.5em)
  #v(sp)
  #emph[#it.supplement #context it.counter.display(it.numbering)#it.separator] #it.body
]

// https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html#long-and-short-captions-for-the-outline
// for some reason the arguments have to be reversed for this to work properly
#let in-outline = state("in-outline", false)
#let short-caption(short, long) = context if in-outline.get() { short } else { long }

#let project(title: "", authors: (), body) = {
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "Libertinus Serif", lang: "en", size: 12pt)

  align(center + horizon)[
    #text(title, size: 1.5em, weight: 600)

    #pad(
      top: 3em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center)[
          #author.name \
          #author.email
        ]),
      )
    )
    \
    Science One Programme

    #v(3em)
    Supervised by Brian Marcus, PhD \
    Professor, Department of Mathematics

    #v(3em)
    March 5, 2025

    #sym.copyright Felix Bubbar and Leo Zhu, 2025
  ]
  
  pagebreak()

  set page(numbering: "i", number-align: right, columns: 1, margin: 2.5cm)
  counter(page).update(1) 
  outline()

  v(1em)
  in-outline.update(true)
  outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )
  in-outline.update(false)
  
  pagebreak()
  
  set page(numbering: "1")
  counter(page).update(1)

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
  set par(leading: 1.50em, spacing: 1.50em)
  set par(justify: true, first-line-indent: (amount: par_indent, all: false))
    
  show heading: set block(below: 1em)
  show heading.where(level: 1): set block(above: 2em)
  
  show figure.caption: mkcap(0em, 97%, 0.9em)

  body
}

#let bigsp = $quad quad$
#let pad = $space.narrow$
#let implies = $bigsp=>bigsp$

