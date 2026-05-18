// Global styles for Lern content
#let q_width = 28cm
#let q_size = 20pt
#let q_margin = 1cm

#let a_width = auto
#let a_size = 20pt
#let a_margin = 0.6cm

#let i_width = 25cm
#let i_size = 20pt
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
