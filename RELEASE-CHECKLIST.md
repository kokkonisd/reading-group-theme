# Release checklist
1. Ensure local `main` is up to date with respect to `origin/main`.
2. Update `VERSION` and the version field in `typst.toml`; this should simply be removing the
   `"-dev"` part.
3. Update `CHANGELOG.md`.
4. Install this version locally using the `install.sh` script, overwriting if needed:
   ```console
   $ yes | ./install.sh --offline
   ```
5. Update the examples (in `examples/`) to use the new version of the theme. Compile them both and
   inspect the generated PDFs:
   ```console
   $ typst c examples/simple/presentation.typ
   $ typst c examples/full/presentation.typ
   ```
6. Commit the changes and tag the commit with the version. For example, for version `X.Y.Z`, tag
   the commit with `git tag -a X.Y.Z`.
7. Push the commit and the tags.
8. Prepare for the next version by bumping the PATCH number in the version and appending `"-dev"`.
   This means that `"1.2.3"` should become `"1.2.4-dev"`.
