#
# coredb build file
#

all: tables procedures init

tables:
	@echo Enter MySQL root password when prompted
	@mysql -u root -p < tables.sql

procedures: tables
	@mysql -u prefiniti -pprefiniti < procedures.sql

init: procedures
	@mysql -u prefiniti -pprefiniti < init.sql
