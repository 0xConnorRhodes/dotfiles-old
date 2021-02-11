:syn match markdownIgnore "\v\w_\w"
"syn match kramdownId "{#[^}]*}"
"syn cluster markdownInline add=kramdownId
highlight def link kramdownId Identifier

