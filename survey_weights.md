Вот что пишет про веса Help Stata:

Most Stata commands can deal with weighted data.  Stata allows four kinds of weights:

    1.  fweights, or frequency weights, are weights that indicate the number of duplicated observations.

    2.  pweights, or sampling weights, are weights that denote the inverse of the probability that the observation is included because of the sampling
        design.

То, о чем я говорю, это pweights. Их следует учитывать в регрессионном анализе и при расчете средних, вариации и т.д.

В стате работа с весами устроена очень просто. Например:

regress y x1 x2 x3 [pw=weights] {weights здесь - название переменной, в которой хранятся веса, а pw - сокращение от probability weights}

или

probit y x1 x2 x3 [pw=weights] 

или

mean x [pw=weights]

А как это делать в R?



примерно так,
library(tidyverse) # data manipulation
library(survey) # survey design

# simulate some data
set.seed(777)
pc <- mutate(cars, ipw = runif(nrow(cars), min = 1, max = 10),
             id = row_number(),
             d01 = sample(0:1, size = nrow(cars), replace = TRUE))
glimpse(pc)

# describe design
des_1 <- svydesign(id = ~1, weights = ~ipw, data = pc)
# id is for strata identifiers
# weights is for inverse probability weights (inside cluster, I think)

# mean
svymean(pc, design = des_1)
svymean(pc$speed, design = des_1)

# ols
ols_example <- svyglm(dist ~ speed, design = des_1)  
summary(ols_example)

# logit
logit_example <- svyglm(d01 ~ speed, design = des_1, 
                        family = binomial(link = "logit"))
summary(logit_example)

Пока нет возможности сравнить со статой, но я думаю, что должно быть ок :)

https://cran.r-project.org/web/packages/weights/
https://stats.idre.ucla.edu/r/faq/how-can-i-do-regression-estimation-with-survey-data/
