## Preface
<!-- Optional, the preface is not about the subject -->
An analysis of WorldSkills Russia 
competition events  

By  Aleksandr Gorbachev & David Langeveld  


A Research Paper  
Submitted to the lecturer of the subject ‘Programming with R’  
The Hague University of Applied Sciences PRO  
Master of Business Administration  
MBA Big Data Analytics  
November 2023

## Abstract
<!-- Contains the purpose of the research carried out, the research questions that are dealt with, the research method and the most important findings -->

## Table of contents

## Introduction
<!-- An introductory chapter in which the purpose and design of the (sub)study is explained and in which the research questions are described -->

[WorldSkills International](https://worldskills.org/) is a global organization dedicated to promoting excellence in vocational and technical education. It brings together young professionals from around the world to compete in skill-based competitions that showcase their talents and expertise in a wide range of fields, from engineering and technology to hospitality and creative arts. These competitions are assessed by a panel of expert judges who rigorously evaluate participants' performance, measuring their precision, creativity, and adherence to international industry standards.

[WorldSkills Russia](https://worldskills.ru/) as a member organization is in charge to govern and oversee that national and regional competition events comply with WorldSkills International standards as well as for collecting and aggregating results countrywide.

<!-- These qualification assessment standards and frameworks have also been adopted by WorldSkills Russia in the whole national vocational education and training system, so that college graduates have to pass the demonstration exam in exactly the same way as competitors in the WorldSkills competition, with the only difference that the final score is not converted into a medal but into an exam grade. -->

Current research is targeted to explore and analyze data from WorldSkills Russia competition events and demonstration exams to answer following questions:

<!-- 
- Does the regional training system have a significant impact on the competitor's performance?
- Whether the presence of a compatriot expert has a significant effect on a competitor's performance? 
-->
- Whether repeated participation in competitions significantly improves a competitor's average score?
- Whether repeated participation of a compatriot expert significantly improves his/her compatriot competitors' average results?

These questions are formulated as followed:

1. Impact of repeated participation on competitor's average score.

_null hypothesis (h0):  
The repeated participation in WorldSkills competitions does not significantly improve a competitor's average score._   

_alternative hypothesis (h1):  
The repeated participation in WorldSkills competitions significantly improves a competitor's average score._

2. Effect of repeated participation of a compatriot expert on competitor results

_null hypothesis (h0):  
The repeated participation of a compatriot expert does not significantly improve his/her competitor's (average) results in the competitions of WorldSkills Russia._  

_alternative hypothesis (h1):  
The repeated participation of a compatriot expert significantly improves his/her compatriot competitor's average results in the competitions of WorldSkills Russia._

## Operationalization of the research questions
<!-- Describe the data that will be used and how the questions will be answered on the basis of this data. The data analysis itself is not yet described here. So do tell ‘Data file [X] comes from [Y] and can answer the posed questions because [Z]’, but do not yet describe the data itself -->

Each competition event uses the Competition Information System (CIS) to record competition results. A separate instance of CIS is used for each event, so all event results are stored in a separate database instance. In order to have an overview of all competition events, WorldSkills Russia has developed its own aggregation system called Electronic System for Internet Monitoring (eSIM).

The raw data used for this research was kindly provided by the autonomous non-profit organization "Agency for the Development of Professional Excellence (WorldSkills Russia)" and is essentially a dump from the eSIM database, specifically from the competition results table. Therefore, the observation unit is a skills competition result for a given competitor for a given competition event.

The following steps will make sure to operationalize the data so that the research questions that are formulated will be answered:
- Data preparation  
- Data cleaning
- (!pending results!) Calculate initial summary statistics  
- Calculate the average scores of competitors  
  --> for each competitor, calculate the average score across competitions they have participated in  
  --> group the data by competitors and then calculate the mean of the marks for each group  
- Assess the impact of repeated participation
- Examine the influence of compatriot experts  
  --> analyze whether the presence of a compatriot expert has a significant impact on the competitor's average scores.  
  --> group competitors by the presence or absence of compatriot experts and compare their average scores  

<!-- ### Note on 500- and 700-scale marks

The conversion of 100-scale marks into 500-scale (outdated in 2017, 700-scale is used since 2019) marks in the Competition Information System (CIS) serves a crucial purpose in the context of WorldSkills competitions. This conversion allows for a more precise and consistent assessment of competitors' skills across a wide range of skill areas.

- **Uniformity and Comparability**: Different skills and competitions may have varying degrees of complexity and granularity. Converting scores to a 500-scale ensures that scores from various skills and competitions can be compared and ranked consistently. It levels the playing field and prevents bias in favor of any particular skill area.

- **Detailed Assessment**: The 500-scale offers greater granularity, allowing judges to provide more detailed feedback and assessment. It enables a finer distinction between competitors, which is especially important when skills are closely matched in terms of quality.

- **Eliminating Ties**: Using a 500-scale helps to minimize the chances of ties or draws in competitions. With more score points available, it's less likely that multiple competitors will end up with the same score.

- **Enhanced Feedback**: Competitors can benefit from more precise feedback on their performance. This feedback is valuable for their personal growth and development in their respective skills.

In essence, the conversion to a 500-scale mark in the CIS system ensures that the assessment process is fair, consistent, and capable of providing more nuanced feedback to competitors. It's an integral part of maintaining the high standards and integrity of WorldSkills competitions.

It's also worth noting that 500 (700) scale scores are mathematically dependent on the scores of all competitors in all skills within a given competition, and therefore cannot be used to compare scores across competitions. -->

### Matching provided data with posed questions

This dataset can be used to perform statistical analyses that will help provide evidence and insights into the impact of various factors on competitors' performance and whether these effects are statistically significant. To create a linear regression model based on the research questions, it is necessary to identify an outcome (dependent) variable and predictor (independent) variable(s) for each question.  

In mathematical terms this will form an equation, _Y = a + bX_.  

_Y_ is the outcome variable, _X_ will be the predictor, _a_ represents the intercept and _bX_ represents the slope associated with the predictor variable.

<!-- 
#### Does the regional training system have a significant impact on the competitor's performance?

Just as in Olympic competition - different teams have different approaches to the training systems of their competitors, which can have a significant impact on their performance in competition.

To answer this question, we can analyze the data by grouping competitors by their region of origin (regionID) and calculating the average performance (e.g., mark100) for each group. Then, we can use statistical tests to determine if there are significant differences in performance between regions. 

#### Whether the presence of a compatriot expert has a significant effect on a competitor's performance?

To investigate this, we can compare the average performance of competitors who had a compatriot expert (using the FK_COMPATRIOT column) with those who did not. Statistical tests can be used to assess if there are significant differences in performance between the two groups. 

It is worth noting that during competition events, all competitors must have a compatriot expert who should cooperate with other experts to ensure accuracy, transparency and fairness in recording and managing competition results. It is a rule that a compatriot expert can't participate in the evaluation process of his own compatriot, but there might be cases when during conflict situations and dispute resolution compatriot experts should advocate for their compatriot competitors, e.g. when other experts don't give a mark for some aspects due to biased evaluation process description.

Another scenario is the demonstration exams, which is not a competition itself and therefore participants don't have a compatriot experts so all results are assessed by a group of independent experts which are not affiliated with the college.

-->

#### Whether repeated participation in competitions significantly improves a competitor's average score?

WorldSkills Russia have different levels for local WorldSkills competitions:

- Regional competitions among regional colleges
- National competitions among regions
- University competitions for students of given university
- National inter-university competitions
- HiTech competition among employees of companies in industrial sector
- DigitalSkills competition among college students, university students and employees companies in IT sector

So there may be a case where a given competitor participates in a sequence of competitions at different levels (e.g. Regional, National, HiTech, DigitalSkills) or may be a guest competitor in other regional competitions (usually when preparing for National). It's reasonable to assume that the average score of such a competitor should improve each time he/she participates in the next competition.

To address this question, we can analyze the performance of competitors who have participated in multiple competitions over time. Group competitors into categories based on the number of competitions they've entered and calculate their average scores for each category. Then, use statistical tests or regression analysis to determine if there is a significant improvement in scores with repeated participation.  

Outcome Variable: Competitor's average score in skill competitions (for example the average grade/mark over multiple competitions).  
Predictor Variable: A variable representing participation (for example 0 for non-repeated participation, 1 for repeated participation).

#### Whether repeated participation of a compatriot expert significantly improves his/her compatriot competitors' average results?

It's often the case that a particular region has the same designated expert for a particular skill competition, who represents the region at nationals. It's reasonable to assume that, in this case, the preparation methodology of his compatriot competitors should improve over time, and thus the result of an average competitor should tend to improve over time as well.

To explore this, we can group competitors by the presence of a compatriot expert (``FK_COMPATRIOT``) and analyze the average performance of their compatriot competitors in each group. Statistical tests or regression analysis can help assess if the repeated participation of a compatriot expert significantly improves the average results of their compatriot competitors. 

Outcome Variable: Average results of competitors (average grade/mark)  
Predictor Variable: A variable representing the presence/absence of a compatriot expert who participated in multiple competitions.

## Description of the data used
<!-- Which data/variables were recorded/used for the study, something about any missing values, a graphical representation and summary statistics. Please note that this is about providing insight into the data used, not yet about (the method used for) answering the research questions -->

Raw data is provided as three XLSX tables:

- participants100.xlsx
- participants200.xlsx
- participants300.xlsx

The total number of observations in the three spreadsheets is 600.000. Due to the nature of the SQL scheme, some columns refer to other tables (fk, foreign keys) and due to local regulations, some of the related data (e.g. personal data such as competitor or expert name, age, gender, etc.) is not available for cross-border transfer, storage or processing.

Below is a table with the name and description of the original variables, an indication of whether the variable will be used in the final dataset and an indication of the new name (if applicable): 

|Variable name|Renamed to|Comment from owner|Will be used|
|---|---|---|---|
|**pk_participant**|result|ID of competition result record (primary key)|Yes|
|**fkUsers**|competitor|competitor reference (foreign key)|Yes|
|**fkChamp**|competition|competition event reference (foreign key)|Yes|
|**fkComp**|skill|skill trade reference (foreign key)|Yes|
|**ChampRole**|-|ID of the participant's role at the competition |No|
|**regionID**|region|code of participant's region origin |Yes|
|**mark100**|mark100|100-point scale|Yes|
|**mark500**|mark500|500-point scale|Yes|
|**medal**|medal|type of medal awarded|Yes|
|**timestamp**|timestamp|time when the result was locked in the system |Yes|
|**fkUserAdd**|-|User ID of the user who added the result to the system (foreign key)|No|
|**competitorMarker**|-|marker for group competition|No|
|**expertGroupMarker**|-|marker for specific expert group|No|
|**excludeFromResault**|-|marker for "out of contest" result |No|
|**fk_quotaCategory**|-|quota category for the competition (foreign key)|No|
|**fk_command**|team|reference for a team membership (foreign key)|Yes|
|**FK_USER_CP**|-|user ID in the digital platform (foreign key)|No|
|**ACCESS_RKC**|-|whether the regional competition center has access to the record|No|
|**FK_COMPATRIOT**|expert|reference for compatriot expert ID (foreign key)|Yes|
|**organization**|-|organization represented by the participant|No|
|**nok**|-|participation in an independent qualification assessment project (for demonstration exams)|No|
|**participant_updated_at**|-|time of last record update|No|
|**is_requested**|-|field for access in the business process|No|
|**is_accepted**|-|field for access in the business process|No|
|**mark700**|-|700-point scale|No|

Detailed customization steps are described in Appendix 1. After customizing original dataset we have a resulting dataframe with 11 variables and ```253 080``` unique results (~42% of original size):

```R
> glimpse(esim_data)
Rows: 253,080
Columns: 11
$ result      <dbl> 305, 307, 308, 315, 316, 320, 322, 343, 353, 354, 355, 369, 370, 371, 372, 3…
$ competitor  <dbl> 921, 1054, 1055, 856, 1061, 1096, 1098, 700, 705, 708, 703, 1150, 1149, 1151…
$ competition <dbl> 23, 23, 23, 23, 23, 23, 23, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, …
$ skill       <dbl> 176, 186, 186, 203, 203, 175, 203, 174, 174, 174, 174, 188, 188, 188, 188, 1…
$ region      <dbl> 82, 82, 82, 82, 82, 82, 82, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, …
$ mark100     <dbl> 45.82, 30.25, 26.00, 17.45, 63.25, 44.00, 41.70, 78.80, 74.10, 74.10, 78.80,…
$ mark500     <dbl> 544, 480, 473, 450, 511, 516, 482, 508, 497, 497, 508, 511, 474, 473, 528, 5…
$ medal       <chr> "GOLD", NA, NA, NA, "Medallion for Excellence", "BRONZE", NA, "BRONZE", NA, …
$ timestamp   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
$ team        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
$ expert      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
```

Number of unique and missing values for each column is provided below:

```R
> data.frame(unique=sapply(esim_data, function(x) sum(length(unique(x, na.rm = TRUE)))),
+            missing=sapply(esim_data, function(x) sum(is.na(x) | x == 0)))

            unique missing
result      253080       0
competitor  216341       0
competition  14339       0
skill          393       0
region         199       0
mark100       9505       0
mark500        262   14544
medal            5  117367
timestamp   117755   45628
team          6021  239617
expert       27477  204046
```


## Results of the data analysis
<!-- Results of the data analysis: The actual answer of the research questions based on data analysis, the use of specific graphs to gain insight into the answers to the questions and the results of the hypothesis testing -->

## Conclusions and recommendations
<!-- including recommendations for further research -->

## Brief description of the division of work
<!-- Who is responsible for which part of the report and script -->

## Appendix 1. Customizing the original dataset

The foremost step is to perform initial data analysis to spot useful variables and remove variables with inconsistent or useless values:

- take a brief look at the raw data
- transform dataset in the more convenient way for exploration purposes
- clean up observations which are missing important values for analysis

All data operations will be performed using [R language](https://posit.co/download/rstudio-desktop/). 

First we will load Excel tables into R, merge all tables in single dataframe and look at columns.

```R
# Loading required libraries
library(readxl)
library(tidyverse)
library(readr)

# Loading excel sheets 
frame1 <- read_excel("Datafiles/participants100.xlsx")
frame2 <- read_excel("Datafiles/participants200.xlsx")
frame3 <- read_excel("Datafiles/participants300.xlsx")

# Merging all sheets into a single dataframe
esim_data <- rbind(frame1, frame2, frame3)

# Exploring dataframe columns
glimpse(esim_data)

Rows: 600,000
Columns: 25
$ pk_participant         <dbl> 5, 6, 7, 9, 10, 11, 12, 13, 22, 24, 25, 26, 28, 29, 37, 40, 42,~
$ fkUsers                <dbl> 84, 81, 79, 82, 85, 87, 86, 84, 81, 82, 84, 87, 79, 80, 79, 110~
$ fkChamp                <dbl> 7, 7, 7, 7, 4, 4, 4, 4, 8, 11, 11, 11, 13, 13, 12, 14, 20, 12, ~
$ fkComp                 <dbl> 164, 164, 187, 164, 164, 164, 164, 164, 176, 165, 166, 166, 166~
$ ChampRole              <dbl> 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 5, 4, 5, 5, 5, 5, 5, ~
$ regionID               <dbl> 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 3, ~
$ mark100                <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ mark500                <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ medal                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ timestamp              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ fkUserAdd              <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ competitorMarker       <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ expertGroupMarker      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ excludeFromResault     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ fk_quotaCategory       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ fk_command             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ FK_USER_CP             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ ACCESS_RKC             <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ FK_COMPATRIOT          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ organization           <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ nok                    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ participant_updated_at <chr> "2020-12-07 11:50:38", "2020-12-07 11:50:38", "2020-12-07 11:50~
$ is_requested           <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ is_accepted            <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ mark700                <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
```

As we see, there are 600 000 observations and 25 columns total. There are many 0s and NA values at the first glance. 

Let's take a random sample of 20 rows.

```R
# Taking random 20 rows sample
sample <- esim_data[sample(nrow(esim_data), 20), ]
sample
# A tibble: 20 x 25
   pk_participant fkUsers fkChamp fkComp ChampRole regionID mark100 mark500 medal      timestamp
            <dbl>   <dbl>   <dbl>  <dbl>     <dbl>    <dbl>   <dbl>   <dbl> <chr>      <chr>    
 1         454464 1187314   13980    341         4       68    NA        NA NA         2019-11-~
 2         284414  122757    5471    203         4       49    NA        NA NA         2019-03-~
 3         412062 1133052    8831    186         5       76    11.6     455 NA         2019-06-~
 4          30299   25044     240    188         4        2     0         0 NA         NA       
 5         366107 1055466   12215    212         5       49    70       501 Medallion~ 2019-06-~
 6         295854    6514    6309    165         1       65    NA        NA NA         2019-03-~
 7         248032 1065927    4821    423         5       76    31.0     468 NA         2018-12-~
 8          76802   55518     622    345         4        4     0         0 NA         NA       
 9         213018     832    4444    373         1       76    NA        NA NA         2018-09-~
10         442016 1180196   13729    422         4       76    NA        NA NA         2019-10-~
11          37354   31490     300    203         4       58     0         0 NA         NA       
12         473468 1203706   15138    325         5       60    13.8     520 GOLD       2019-11-~
13          18777   15659     170    184         4       49     0         0 NA         NA       
14         160537  999571    3361    315         5       49    60.5     525 Medallion~ 2018-05-~
15          45294   37705     316    261         5        8    97.5     533 SILVER     NA       
16         257694   94043    4655    169         4        6    NA        NA NA         2019-01-~
17          64160   47841     435    203         5       76    64.8     504 Medallion~ NA       
18         100791    3149    1009    203         4       84    NA        NA NA         NA       
19         261426   19797    4461    250         4       65    NA        NA NA         2019-02-~
20         383233 1041131   10664    247         4       65    NA        NA NA         2019-06-~
# i 15 more variables: fkUserAdd <dbl>, competitorMarker <lgl>, expertGroupMarker <chr>,
#   excludeFromResault <chr>, fk_quotaCategory <dbl>, fk_command <dbl>, FK_USER_CP <dbl>,
#   ACCESS_RKC <dbl>, FK_COMPATRIOT <dbl>, organization <lgl>, nok <dbl>,
#   participant_updated_at <chr>, is_requested <dbl>, is_accepted <dbl>, mark700 <lgl>
```

From this sample we see some observations which are falls in our area of interest as well as some value which are missing the most important value ```mark100```, which is a main measure for performance evaluation to be used in all tested hypotesises.

### Exploring unique values for variables 

Next step is to figure out which values of provided variables might be useful for results explainnation, as well as which variables are useless and can be discarded.

Based on raw data samples and provided description from data owner, there are some columns which are:

- clearly related to the context of research, such as
    - **pk_participant**: ID of competition result record (primary key)
    - **fkUsers**: competitor reference (foreign key)
    - **fkChamp**: competition event reference (foreign key)
    - **fkComp**: skill trade reference (foreign key)
    - **regionID**: code of participant's region origin 
    - **mark100**: 100-point scale
    - **mark500**: 500-point scale
    - **medal**: type of medal awarded
    - **FK_COMPATRIOT**: reference for compatriot expert ID (foreign key)
    - **timestamp**: time when the result was locked in the system 
    - **mark700**: 700-point scale

- used only for internal purposes of eSIM and can be easily discarded:
    - **fk_quotaCategory**: quota category for the competition (foreign key)
    - **FK_USER_CP**: user ID in the digital platform (foreign key)
    - **ACCESS_RKC**: whether the regional competition center has access to the record
    - **fkUserAdd**: User ID of the user who added the result to the system (foreign key)
    - **participant_updated_at**: time of last record update
    - **is_requested**: field for access in the business process
    - **is_accepted**: field for access in the business process

- not clear so it's good to take a closer look to thse values:
    - **ChampRole**: ID of the participant's role at the competition 
    - **fk_command**: reference for a team membership (foreign key)
    - **organization**: organization represented by the participant
    - **nok**: participation in an independent qualification assessment project (for demonstration exams)
    - **excludeFromResault**: marker for "out of contest" result 
    - **competitorMarker**: marker for group competition
    - **expertGroupMarker**: marker for specific expert group

<!-- 
Let's start from ```medal``` variable:

```R
# How many different values for medals
length(unique(esim_data$medal))

[1] 5

# What are the types of medals 
unique(esim_data$medal)

[1] NA                         "GOLD"                     "Medallion for Excellence"
[4] "BRONZE"                   "SILVER"   
```

Here values are clear and represent types of medal awarded to competitors. Note that ```Medallion for Excellence``` is the medal awarded for competitors who are *above the avarage level across all skills within one competition*, e.g. who have score >=500 in ```mark500``` (or >=700 in ```mark700``` since 2019). This variable is clearly useful for analysis.

-->

---

So let's take a look at ```ChampRole``` first:

```R
# How many different values for roles?
length(unique(esim_data$ChampRole))
[1] 18

# What are the competition roles?
unique(esim_data$ChampRole)
[1]  4  5  1  7  2  3  6 28 29 22 20 30 31 33 34 35  8 36
```

There are some identifiers for competition roles for participants (required to be entered in CIS), but since these values might not be consistant across all CIS instances (and therefore inside eSIM), given that we don't have actual values for these identifiers we can easily discard this column.

---

Next we will look at ```fk_command``` column:

```R
# How many teams identifiers in the dataset
length(unique(esim_data$fk_command)) 
[1] 6145

# What are the values
head(unique(esim_data$fk_command),n = 10)
[1]  0 21 30 29 28 26 27 33 46 35
```

It seems that there are some team identifiers which are linked to another tables. Due to absence of linked table these values are not very useful but we can keep the column to identify whether this is a team or personal result. 

---

Next, we explore is there any ```organization``` represented by competitors:

```R
# How many organizations represented by competitors in the dataset?
length(unique(esim_data$organization))
[1] 1

unique(esim_data$organization) 
[1] NA
```

The column is empty and clearly can be discarded.

---

Now let's investigate ```nok``` values:

```R
# How many unique values in nok column?
length(unique(esim_data$nok))
[1] 2

# What are these unique values?
unique(esim_data$nok)
[1] 0 1

# Is there any results marked with nok=1 identifier?
length(esim_data$nok[esim_data$nok == "1"]) 
[1] 207
```

So we do have at least 207 values which are clearly represent demonstration exams. Note that it's not necesserily that evety DE marked with nok value, but either way it can be useful for future assumptions.

---

Next, look at the ```excludeFromResault``` variable:

```R
# How many unique values?
length(unique(esim_data$excludeFromResault))
[1] 3

# What are the values?
unique(esim_data$excludeFromResault)
[1] NA    "YES" "N"  

# How many results with non-NA value?
nrow(esim_data %>% filter(!is.na(excludeFromResault)))
[1] 13086

# Check consistency between provided values
tail(esim_data  %>% 
       filter(excludeFromResault == "YES") %>% 
       select(mark100, mark500, mark700, excludeFromResault))
# A tibble: 6 x 4
  mark100 mark500 mark700 excludeFromResault
    <dbl>   <dbl> <lgl>   <chr>             
1   81.9       NA NA      YES   # These results are look consistent enough            
2    9.24      NA NA      YES   # since they are excluded and therefore            
3   11.6       NA NA      YES   # mark500/mark700 scores are not present           
4   21.4       NA NA      YES   #            
5   40.5       NA NA      YES   #            
6   20.2       NA NA      YES   #   

tail(esim_data  %>% 
       filter(excludeFromResault == "N") %>% 
       select(mark100, mark500, mark700, excludeFromResault))
# A tibble: 6 x 4
  mark100 mark500 mark700 excludeFromResault
    <dbl>   <dbl> <lgl>   <chr>             
1    41.5     529 NA      N                 
2    24.8     471 NA      N                 
3     0         0 NA      N                 
4    49.3      NA NA      N      # Note that these results should not be 
5    47.8      NA NA      N      # excluded but mark500/mark700 is missing
6     0         0 NA      N    

tail(esim_data  %>% 
       filter(is.na(excludeFromResault)) %>% 
       select(mark100, mark500, mark700, excludeFromResault))
# A tibble: 6 x 4
  mark100 mark500 mark700 excludeFromResault
    <dbl>   <dbl> <lgl>   <chr>             
1    NA        NA NA      NA     # Also note that there are some rows where          
2    NA        NA NA      NA     # mark100 is missing. We will take it into          
3    NA        NA NA      NA     # account later on.          
4    NA        NA NA      NA     #            
5    28.4     529 NA      NA     # These results clearly not excluded          
6    20.4     476 NA      NA     # but marker is not present
```

So here we see that ~13k results are marked with ```excludeFromResault```, which basically should mean that result is performed by a guest competitor, which doesn't add any valuable insights in our research context. Also we see that some observations marked with ```excludeFromResault``` are inconsistent, probably due to human error, therefore we won't keep this variable.

---

We also noted that column types of ```mark500``` and ```mark700``` are different. If we saw reasonable values for ```mark500```, let's check whether we do have any values in ```mark700``` other than ```NA```:

```R
# Check non-NA unique values for mark700
length(unique(esim_data$mark700))
[1] 1

unique(esim_data$mark700) 
[1] NA
```

Clearly there are no 700-scale marks, most likely because it was introduced by WSI just in 2019 in CIS 4.0, but WSR were using older CIS 3.x for backward compatibility up until 2022, which had no support for 700-scale. So clearly we can get rid of this column as well.

---

Next we go over ```competitorMarker``` variable:

```R
# Is there any valuable group markers for competitors?
length(unique(esim_data$competitorMarker))
[1] 1

unique(esim_data$competitorMarker) 
[1] NA
```

Column is empty and can be easily discarded.

---

Finally, we explore valuses for ```expertGroupMarker``` column:

```R
# Is there any group markers for experts?
length(unique(esim_data$expertGroupMarker))
[1] 8

unique(esim_data$expertGroupMarker) 
[1] NA     "CERT" "NO"   "Н"    "С"    "N"    "W"    "S"   
```

There are some markers which are not really meaningful in context of our research, so this variable can be discarded. 

### Transforming dataframe for brevity

After a brief clarification of unique variables values which were not clear at first sight, we now can remove meaningless columns from our initial dataframe:

```R
# Removing columns which won't be used for research
esim_data <- subset(esim_data, 
                   select = -c(ChampRole,
                               fkUserAdd,
                               competitorMarker,
                               expertGroupMarker,
                               fk_quotaCategory,
                               FK_USER_CP,
                               ACCESS_RKC,
                               organization,
                               nok,
                               excludeFromResault,
                               participant_updated_at,
                               is_requested,
                               is_accepted,
                               mark700))
```

To not confuse with some of the variable names, we will rename some columns for clearer reference:

```R
colnames(esim_data) <- c("result", 
                         "competitor", 
                         "competition", 
                         "skill", 
                         "region", 
                         "mark100", 
                         "mark500", 
                         "medal", 
                         "timestamp", 
                         "team", 
                         "expert")
```

So now our dataframe looks more clear and concise:

```R
glimpse(esim_data)
Rows: 600,000
Columns: 13
$ result      <dbl> 5, 6, 7, 9, 10, 11, 12, 13, 22, 24, 25, 26, 28, 29, 37, 40, 42, 51, 52, 53,~
$ competitor  <dbl> 84, 81, 79, 82, 85, 87, 86, 84, 81, 82, 84, 87, 79, 80, 79, 110, 138, 308, ~
$ competition <dbl> 7, 7, 7, 7, 4, 4, 4, 4, 8, 11, 11, 11, 13, 13, 12, 14, 20, 12, 12, 12, 21, ~
$ skill       <dbl> 164, 164, 187, 164, 164, 164, 164, 164, 176, 165, 166, 166, 166, 166, 193, ~
$ region      <dbl> 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 3, 85, 16, 16, ~
$ mark100     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ mark500     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ medal       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ timestamp   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
$ team        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
$ expert      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ~
```

### Cleaning up observations

As we still have many observations with missing values on our main variable of interest ```mark100```, which might be a human/migration error or test records, we would like to get rid of those observations where ```mark100``` is 0 or NA:

```R
# How many observations where mark100 is missing?
nrow(esim_data[is.na(esim_data$mark100), ])
[1] 250734

# How many observations where mark100 is 0?
nrow(esim_data %>% filter(mark100 == 0))
[1] 51901

# Removing observations where mark100 is missing (NA or 0)
esim_data <- esim_data %>% 
  drop_na(mark100) %>% 
  filter(mark100 > 0)
```

We also would like to check whether there are any duplicate rows after export of raw data from eSIM:

```R
# Check for duplicate result IDs
length(unique(esim_data$result)) == nrow(esim_data)
[1] FALSE
```

So clearly there are some duplicate values which we would like to remove:

```R
# Removing duplicate rows from dataframe
esim_data <- distinct(esim_data)
length(unique(esim_data$result)) == nrow(esim_data)
[1] TRUE

nrow(esim_data)
[1] 253080
```

