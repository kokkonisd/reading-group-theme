#import "imports.typ": *

#let title-slide(title-size: 2em, subtitle-size: 1.2em, ..args) = touying-slide-wrapper(self => {
    set text(size: self.info.size)
    let info = self.info + args.named()
    let body = {
        set align(center)
        v(2fr)

        // Title.
        block(text(size: title-size, fill: self.colors.primary, weight: "bold", info.title))
        // Subtitle.
        block(text(
            size: subtitle-size, fill: self.colors.neutral-darkest, weight: "bold", info.subtitle
        ))

        v(1fr)

        set text(fill: self.colors.neutral-darkest)
        // Display date.
        if info.date != none {
            block(utils.display-info-date(self))
        }

        v(1fr)

        if info.logos != none {
            stack(
                dir: ltr,
                spacing: 1em,
                ..info.logos
            )
        }

        v(1fr)

        // Display authors.
        set align(top)
        set text(size: .8em)
        if info.authors != none {
            stack(
                dir: ltr,
                spacing: 2em,
                ..for author in info.authors {
                    let author-name = text(author.name, weight: "bold")
                    // Underline the name(s) of the presenting author(s).
                    if author.is-presenting {
                        author-name = underline(
                            author-name, stroke: 1.5pt + self.colors.primary, offset: 2pt,
                        )
                    }
                    (
                        stack(
                            dir: ttb,
                            spacing: 8pt,
                            author-name,
                            ..for affiliation in author.affiliation {
                                (
                                    text(affiliation, size: .9em),
                                )
                            },
                            if author.email != none {
                                text(link("mailto:" + author.email), size: .8em)
                            }
                        ),
                    )
                }
            )
        }

        v(2fr)
    }
    touying-slide(self: self, body)
})


#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
    set text(size: self.info.size)
    self = utils.merge-dicts(
        self,
        config-page(
            fill: self.colors.primary,
            margin: 2em,
        ),
    )
    let body = {
        set align(center + horizon)
        set text(size: 2em, fill: self.colors.neutral-lightest, weight: "bold", style: "italic")
        utils.display-current-heading(level: 1)
        linebreak()
        set text(size: .5em, weight: "regular")
        body
    }
    touying-slide(self: self, body)
})


#let slide(title: auto, size: auto, ..args) = touying-slide-wrapper(self => {
    if title != auto {
        self.store.title = title
    }
    let size = if size == auto { self.info.size } else { size }
    set text(size: size)
    let header(self) = {
        set text(size: size)
        {
            set align(top)
            show: components.cell.with(fill: self.colors.primary, inset: 1em)
            set align(horizon)
            set text(fill: self.colors.neutral-lightest, size: 1.5em)
            if self.store.title != none {
                utils.call-or-display(self, self.store.title)
            } else {
                utils.display-current-heading(level: 2)
            }
            h(1fr)
            set text(size: 0.6em)
            utils.display-current-heading(level: 1)
        }
    }
    let footer(self) = {
        if self.store.footer != none {
            utils.call-or-display(self, self.store.footer)
        } else {
            set text(size: size)
            {
                set align(bottom)
                show: components.cell.with(fill: self.colors.primary, inset: .4em)
                set text(fill: self.colors.neutral, size: .8em)
                set align(horizon)
                // Display the title of the presentation, the section and the slide.
                if self.info.title-short != none {
                    self.info.title-short
                    " • "
                }
                utils.display-current-heading(level: 1)
                " • "
                utils.display-current-heading(level: 2)
                // Display the authors.
                h(6fr)
                text(self.info.authors-short.join(", "), size: .7em)
                // Display the slide number.
                h(1fr)
                context utils.slide-counter.display()
            }
        }
    }
    self = utils.merge-dicts(
        self,
        config-page(
            header: header,
            footer: footer,
        ),
    )
    touying-slide(self: self, ..args)
})


#let reading-group-theme(
    aspect-ratio: "16-9",
    title-short: none,
    authors: (
        (
            name: "John Doe",
            affiliation: ("Some University", "Some Company"),
            email: "john.doe@example.com",
            is-presenting: true,
        ),
    ),
    authors-short: ("J. Doe",),
    logos: none,
    size: 20pt,
    ..args,
    body,
) = {
    set text(size: size)
    show link: set text(fill: blue)
    show link: underline

    show: touying-slides.with(
        config-page(
            paper: "presentation-" + aspect-ratio,
            // These need to be absolute, otherwise they are impacted by the text size of the page.
            margin: (top: 60pt, bottom: 30pt, x: 20pt),
        ),
        config-methods(
            init: (self: none, body) => {
                set text(size: size)

                body
            }
        ),
        config-common(
            slide-fn: slide,
            new-section-slide-fn: new-section-slide,
        ),
        config-colors(
            primary: rgb(138, 15, 29),
            neutral: luma(240),
            secondary: rgb(255, 157, 28),
            tertiary: rgb(36, 181, 118),
        ),
        config-store(
            title: none,
            footer: none,
        ),
        config-info(
            title-short: title-short,
            authors: authors,
            authors-short: authors-short,
            logos: logos,
            size: size,
        ),
        ..args,
    )

    body
}
