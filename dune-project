(lang dune 3.16)

(name sandswarm)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name sandswarm)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune base stdio ppx_expect angstrom yojson)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
