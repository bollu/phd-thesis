# Build with pdflatex; -shell-escape is required by minted.
$pdf_mode = 1;
$pdflatex = 'pdflatex -shell-escape -synctex=1 -interaction=nonstopmode %O %S';
$bibtex_use = 2;
@default_files = ('thesis.tex');

# glossaries support
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
  my ($base) = @_;
  return system("makeglossaries '$base'");
}
push @generated_exts, 'glo', 'gls', 'glg', 'ist', 'acn', 'acr', 'alg';
