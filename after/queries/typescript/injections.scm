; extends
((template_string) @sql (#match? @sql "^`\n*( )*-{2,}( )*[sS][qQ][lL]( )*\n"))

(((comment) @_comment (#match? @_comment "sql") (lexical_declaration(variable_declarator[(string(string_fragment)@sql)(template_string)@sql]))) @sql)
