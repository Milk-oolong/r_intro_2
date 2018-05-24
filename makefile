all: archives htmls

archives: archives/sem_010.zip
htmls: docs/seminar_010.html docs/hw_010.html

archives/sem_010.zip: docs/seminar_010.Rmd data/housing.wf1 data/rus_utf8.csv data/rus_cp1251.csv
	zip archives/sem_010.zip docs/seminar_010.Rmd data/housing.wf1 data/rus_utf8.csv data/rus_cp1251.csv

docs/seminar_010.html: docs/seminar_010.Rmd
	cp data/*.* docs/
	Rscript -e "knitr::knit2html('docs/seminar_010.Rmd')"
	-rm docs/*.wf1
	-rm docs/*.xlsx
	-rm docs/*.txt
	-rm docs/*.csv
	-rm docs/*.sav
	-rm docs/*.dta

docs/hw_010.html: docs/hw_010.Rmd
	Rscript -e "knitr::knit2html('docs/hw_010.Rmd')"
