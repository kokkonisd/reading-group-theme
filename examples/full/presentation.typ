#import "@local/reading-group-theme:0.1.0": *

#show: reading-group-theme.with(
    config-info(
        title: "Full presentation example",
        title-short: smallcaps("Full Presentation"),
        subtitle: "A detailed presentation with deep configuration",
        authors: (
            (
                name: "First Author",
                affiliation: (
                    "First University",
                    "First Company",
                ),
                email: "first.author@example.com",
                is-presenting: false,
            ),
            (
                name: "Second Author",
                affiliation: (
                    "Second University",
                    "Second Company",
                ),
                email: "second.author@example.com",
                is-presenting: true,
            ),
        ),
        authors-short: ("F. Author", "S. Author"),
        logos: (
            image("assets/logo1.svg"),
            image("assets/logo2.svg"),
            image("assets/logo3.svg"),
        ),
        date: datetime(day: 01, month: 02, year: 2003),
    ),
    config-colors(
        primary: rgb(20, 180, 130),
        neutral: rgb(250, 250, 100),
        secondary: rgb(200, 80, 20),
        tertiary: rgb(20, 80, 200),
    ),
)

#title-slide(title-size: 3em)


= Section 1

== Example slide
#slide(self => [
    This is some *text*
    #text(fill: self.colors.primary)[in]
    #text(fill: self.colors.secondary)[the]
    #text(fill: self.colors.tertiary)[slide].

    #pause
    This appears _later_.

    #meanwhile
    #v(1fr)
    This *persists* down here.
])


= Section 2

== Another slide
#slide(
    config: (page: (margin: (x: .2em))),
    [
        This slide has smaller horizontal margins!
        - One
        - Two
        - Three
    ]
)

== Final slide
#slide(
    config: (store: (footer: block(inset: (x: 1em))[Custom footer!])),
    [
        In conclusion...
    ]
)
