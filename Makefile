DEPENDENCIES=shards install 
LANG=crystal build
FILE=src/trigger.cr


all:
	$(DEPENDENCIES) && $(LANG) $(FILE); echo COMPILAÇÃO FINALIZADA
