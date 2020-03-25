# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

#
# https://rjw57.github.io/notes/technical/github-pages/
#

CURRENT_BRANCH = $(shell git name-rev --name-only HEAD)
ifndef CURRENT_BRANCH
CURRENT_BRANCH = $(error Could not get current branch.)
endif

DATE=$(shell date)

deploy: clean dirhtml
	git checkout gh-pages
	-rsync -a --delete --exclude=.* --exclude=.git --exclude=$(BUILDDIR)/* $(BUILDDIR)/dirhtml/ .
	-git add .
	-git add -u
	-git commit -m 'Automatic build commit on $(DATE).'
	git checkout ${CURRENT_BRANCH}
