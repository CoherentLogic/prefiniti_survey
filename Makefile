#
# Makefile
# 
# Prefiniti Survey
#

VERSION=`cat prefiniti/CURRENT_VERSION`

all: db

db: coredb socialdb surveydb timecarddb

coredb:
	@echo Building core database for $(VERSION)...
	@cd prefiniti/core/sql/$(VERSION); make

socialdb: coredb
	@echo Building social database for $(VERSION)...
	@cd prefiniti/apps/social/sql/$(VERSION); make

surveydb: coredb
	@echo Building survey database for $(VERSION)...
	@cd prefiniti/apps/survey/sql/$(VERSION); make

timecarddb: coredb
	@echo Building timecard database for $(VERSION)...
	@cd prefiniti/apps/timecard/sql/$(VERSION); make
