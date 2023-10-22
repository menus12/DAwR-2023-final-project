## Preface
<!-- Optional, the preface is not about the subject -->

## Abstract
<!-- Contains the purpose of the research carried out, the research questions that are dealt with, the research method and the most important findings -->

## Table of contents

## Introduction
<!-- An introductory chapter in which the purpose and design of the (sub)study is explained and in which the research questions are described -->

WorldSkills International is a global organization dedicated to promoting excellence in vocational and technical education. It brings together young professionals from around the world to compete in skill-based competitions that showcase their talents and expertise in a wide range of fields, from engineering and technology to hospitality and creative arts. These competitions are assessed by a panel of expert judges who rigorously evaluate participants' performance, measuring their precision, creativity, and adherence to international industry standards.

WorldSkills Russia as a member organization is in charge for govern and oversee that national and regional competition events are comply with WorldSkills International standards as well as for collecting and aggregating results countrywide.

These qualification assessment standards and frameworks have also been adopted by WorldSkills Russia in the whole national vocational education and training system, so that college graduates have to pass the demonstration exam in exactly the same way as competitors in the WorldSkills competition, with the only difference that the final score is not converted into a medal but into an exam grade.

Current research is targeted to explore and analyze data from WorldSkills Russia competition events and demonstration exams to answer following questions:

- Does the regional training system have a significant impact on the competitor's performance?
- Whether the presence of a compatriot expert has a significant effect on a competitor's performance?
- Whether repeated participation in competitions significantly improves a competitor's average score?
- Whether repeated participation of a compatriot expert significantly improves his/her compatriot competitors' average results?

## Operationalization of the research questions
<!-- Describe the data that will be used and how the questions will be answered on the basis of this data. The data analysis itself is not yet described here. So do tell ‘Data file [X] comes from [Y] and can answer the posed questions because [Z]’, but do not yet describe the data itself -->

Each competition event (or demonstration exam) uses the Competition Information System (CIS) to record competition (exam) results. A separate instance of CIS is used for each event, so all event results are stored in a separate database instance. In order to have an overview of all competition and exam events, WorldSkills Russia has developed its own aggregation system called Electronic System for Internet Monitoring (eSIM).

The raw data used for this research was kindly provided by the autonomous non-profit organisation "Agency for the Development of Professional Excellence (WorldSkills Russia)" and is essentially a dump from the eSIM database, specifically from the competition results table. Therefore, the observation unit is a skills competition result for a given competitor for a given competition event.

Due to the nature of the SQL scheme, some columns refer to other tables (fk, foreign keys) and due to local regulations, some of the related data (e.g. personal data such as competitor or expert name, age, gender, etc.) is not available for cross-border transfer, storage or processing.

### Description of raw data variables with comments from data owner

- **pk_participant**: ID of competition result record (primary key)
- **fkUsers**: competitor reference (foreign key)
- **fkChamp**: competition event reference (foreign key)
- **fkComp**: skill trade reference (foreign key)
- **ChampRole**: ID of the participant's role at the competition 
- **regionID**: code of participant's region origin 
- **mark100**: 100-point scale
- **mark500**: 500-point scale
- **medal**: type of medal awarded
- **timestamp**: time when the result was locked in the system 
- **fkUserAdd**: User ID of the user who added the result to the system (foreign key)
- **competitorMarker**: marker for group competition
- **expertGroupMarker**: marker for specific expert group
- **excludeFromResault**: marker for "out of contest" result 
- **fk_quotaCategory**: quota category for the competition (foreign key)
- **fk_command**: reference for a team membership (foreign key)
- **FK_USER_CP**: user ID in the digital platform (foreign key)
- **ACCESS_RKC**: whether the regional competition center has access to the record
- **FK_COMPATRIOT**: reference for compatriot expert ID (foreign key)
- **organization**: organization represented by the participant
- **nok**: participation in an independent qualification assessment project (for demonstration exams)
- **participant_updated_at**: time of last record update
- **is_requested**: field for access in the business process
- **is_accepted**: field for access in the business process
- **mark700**: 700-point scale

### Note on 500- and 700-scale marks

The conversion of 100-scale marks into 500-scale (outdated in 2017, 700-scale is used since 2019) marks in the Competition Information System (CIS) serves a crucial purpose in the context of WorldSkills competitions. This conversion allows for a more precise and consistent assessment of competitors' skills across a wide range of skill areas.

- **Uniformity and Comparability**: Different skills and competitions may have varying degrees of complexity and granularity. Converting scores to a 500-scale ensures that scores from various skills and competitions can be compared and ranked consistently. It levels the playing field and prevents bias in favor of any particular skill area.

- **Detailed Assessment**: The 500-scale offers greater granularity, allowing judges to provide more detailed feedback and assessment. It enables a finer distinction between competitors, which is especially important when skills are closely matched in terms of quality.

- **Eliminating Ties**: Using a 500-scale helps to minimize the chances of ties or draws in competitions. With more score points available, it's less likely that multiple competitors will end up with the same score.

- **Enhanced Feedback**: Competitors can benefit from more precise feedback on their performance. This feedback is valuable for their personal growth and development in their respective skills.

In essence, the conversion to a 500-scale mark in the CIS system ensures that the assessment process is fair, consistent, and capable of providing more nuanced feedback to competitors. It's an integral part of maintaining the high standards and integrity of WorldSkills competitions.

It's also worth noting that 500 (700) scale scores are mathematically dependent on the scores of all competitors in all skills within a given competition, and therefore cannot be used to compare scores across competitions.

### Matching provided data with posed questions

This dataset can be used to perform statistical analyses that will help provide evidence and insights into the impact of various factors on competitors' performance and whether these effects are statistically significant:

#### Does the regional training system have a significant impact on the competitor's performance?

Just as in Olympic competition - different teams have different approaches to the training systems of their competitors, which can have a significant impact on their performance in competition.

To answer this question, we can analyze the data by grouping competitors by their region of origin (regionID) and calculating the average performance (e.g., mark100) for each group. Then, we can use statistical tests to determine if there are significant differences in performance between regions. 

#### Whether the presence of a compatriot expert has a significant effect on a competitor's performance?

To investigate this, we can compare the average performance of competitors who had a compatriot expert (using the FK_COMPATRIOT column) with those who did not. Statistical tests can be used to assess if there are significant differences in performance between the two groups. 

It is worth noting that during competition events, all competitors must have a compatriot expert who should cooperate with other experts to ensure accuracy, transparency and fairness in recording and managing competition results. It is a rule that a compatriot expert can't participate in the evaluation process of his own compatriot, but there might be cases when during conflict situations and dispute resolution compatriot experts should advocate for their compatriot competitors, e.g. when other experts don't give a mark for some aspects due to biased evaluation process description.

Another scenario is the demonstration exams, which is not a competition itself and therefore participants don't have a compatriot experts so all results are assessed but group of independent experts which are not affiliated with the college.

#### Whether repeated participation in competitions significantly improves a competitor's average score?

In Russia there are different levels for local WorldSkills competitions:

- Regional competitions among regional colleges
- National competitions among regions
- University competitions for students of given university
- National inter-university competitions
- HiTech competition among employees of companies in industrial sector
- DigitalSkills competition among college students, university students and employees companies in IT sector

So there may be a case where a given competitor participates in a sequence of competitions at different levels (e.g. Regional, National, HiTech, DigitalSkills) or may be a guest competitor in other regional competitions (usually when preparing for National). It's reasonable to assume that the average score of such a competitor should improve each time he/she participates in the next competition.

To address this question, we can analyze the performance of competitors who have participated in multiple competitions over time. Group competitors into categories based on the number of competitions they've entered and calculate their average scores for each category. Then, use statistical tests or regression analysis to determine if there is a significant improvement in scores with repeated participation.

#### Whether repeated participation of a compatriot expert significantly improves his/her compatriot competitors' average results?

It's often the case that a particular region has same designated expert for a particular skill competition, who represents the region at nationals. It's reasonable to assume that, in this case, the preparation methodology of his compatriot competitors should improve over time, and thus the result of an avarege competitor should tend to improve over time as well.

To explore this, we can group competitors by the presence of a compatriot expert (FK_COMPATRIOT) and analyze the average performance of their compatriot competitors in each group. Statistical tests or regression analysis can help assess if the repeated participation of a compatriot expert significantly improves the average results of their compatriot competitors. 

## Description of the data used
<!-- Which data/variables were recorded/used for the study, something about any missing values, a graphical representation and summary statistics. Please note that this is about providing insight into the data used, not yet about (the method used for) answering the research questions -->

## Results of the data analysis
<!-- Results of the data analysis: The actual answer of the research questions based on data analysis, the use of specific graphs to gain insight into the answers to the questions and the results of the hypothesis testing -->

## Conclusions and recommendations
<!-- including recommendations for further research -->

## Brief description of the division of work
<!-- Who is responsible for which part of the report and script -->