// https://github.com/kokkonisd/reading-group-theme
#import "@local/reading-group-theme:0.1.1": *

#show: reading-group-theme.with(
    config-info(
        title: "Simple presentation example",
        title-short: "Simple presentation example",
    )
)

#title-slide()


= Section 1

== Example slide
This is some text in the slide.

#pause

This appears later.


= Section 2

== Another slide
- One
- Two
- Three

== Final slide
In conclusion...
