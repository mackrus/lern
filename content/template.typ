// Global styles for Lern content
#let q_width = 28cm
#let q_size = 23pt
#let q_margin = 1cm

#let a_width = 10cm
#let a_size = 23pt
#let a_margin = 0.4cm

#let i_width = 28cm
#let i_size = 23pt
#let i_margin = 1cm

#let list_style = (
  indent: 1em,
  body-indent: 0.5em,
  spacing: 1.2em,
)

#let quiz_layout(doc) = {
  set page(width: q_width, height: auto, margin: q_margin)
  set text(size: q_size)
  doc
}

#let prereq_page(body) = {
  pagebreak()
  set page(width: i_width, height: auto, margin: i_margin)
  set text(size: i_size)
  body
}

#let expl_page(body) = {
  pagebreak()
  set page(width: q_width, height: auto, margin: q_margin)
  set text(size: q_size)
  body
}
