MAKEFILE_LOC := $(shell Rscript -e "cat(system.file('Makefile',package='rflow'))" )
include ${MAKEFILE_LOC}
