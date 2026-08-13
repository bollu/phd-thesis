# Build via latexmk; configuration lives in .latexmkrc.

all: .latexminted_config
	latexmk thesis.tex

# Submission build: thesis-submission.pdf, with draft \sid/\grosser notes disabled.
submission: .latexminted_config
	latexmk thesis-submission.tex

# Draft + submission.
both: all submission

watch: .latexminted_config
	latexmk -pvc thesis.tex

# Generate the SHA hashes of the custom lexers for minted.
# NOTE: any new lexer added under tools/lexers/ must be listed as a dependency
#       here, or its hash will not be refreshed when it changes.
.latexminted_config: tools/lexers/Lean4Lexer.py
	bash ./tools/check_latexminted_config_exists.sh
	python3 ./tools/generate_lexers_json.py

clean:
	latexmk -C
	latexmk -C thesis-submission.tex
	rm -rf _minted _minted-thesis
	# If .latexminted_config exists, refresh the lexer SHAs. We do this here,
	# since clean is a natural response to caching issues, such as outdated
	# lexer SHAs in the minted config.
	[ -f ".latexminted_config" ] && python3 ./tools/generate_lexers_json.py || true

.PHONY: all submission both watch clean
