all: archives htmls

archives: archives/sem_010.zip
htmls: docs/seminar_010.html docs/hw_010.html docs/seminar_020.html

archives/sem_010.zip: docs/seminar_010.Rmd data/housing.wf1 data/housing.txt data/rus_utf8.csv data/rus_cp1251.csv data/cola.dta data/manipulate.sav data/cereal.csv docs/hw_010.Rmd
	zip -j archives/sem_010.zip docs/seminar_010.Rmd data/housing.wf1 data/housing.txt data/rus_utf8.csv data/rus_cp1251.csv data/cola.dta data/manipulate.sav data/cereal.csv docs/hw_010.Rmd

docs/seminar_010.html: docs/seminar_010.Rmd
	cp data/*.* docs/
	Rscript -e "rmarkdown::render('docs/seminar_010.Rmd')"
	-rm docs/*.wf1
	-rm docs/*.xlsx
	-rm docs/*.txt
	-rm docs/*.csv
	-rm docs/*.sav
	-rm docs/*.dta
	-rm docs/*.rds


docs/seminar_020.html: docs/seminar_020.Rmd
	cp data/adult.rds docs/
	cp data/gdp.xls docs/
	Rscript -e "rmarkdown::render('docs/seminar_020.Rmd')"
	-rm docs/adult.rds
	-rm docs/gdp.xls



docs/hw_010.html: docs/hw_010.Rmd
	Rscript -e "rmarkdown::render('docs/hw_010.Rmd')"
