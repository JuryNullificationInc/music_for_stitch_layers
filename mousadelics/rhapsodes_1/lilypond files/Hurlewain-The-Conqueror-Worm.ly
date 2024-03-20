\version "2.24.3"

\header {
  title = "The Conqueror Worm"
  instrument = "Piano"
  composer = "Hurlewain"
  arranger = "Hurlewain"
  poet = "Edgar Allan Poe"
  meter = "4/4"
  piece = "Triumph of the Eidolon"
  opus = "Rhapsodes #1"
}

\layout {
  \context {
    \Voice
    \consists "Melody_engraver"
    \override Stem #'neutral-direction = #'()
  }
}

global = {
  \key c \major
  \numericTimeSignature
  \time 4/4
  \tempo 4=100
}

right = \relative c'' {
  \global
  c c c e e e f g
  
}

left = \relative c' {
  \global
  g g g a a a a c
  
}

\score {
  \new PianoStaff \with {
    instrumentName = "Piano"
  } <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
    } \right
    \new Staff = "left" \with {
      midiInstrument = "acoustic grand"
    } { \clef bass \left }
  >>
  \layout { }
  \midi { }
}
