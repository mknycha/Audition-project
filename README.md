# Audition-project
Efficacy analytics audition project :: Oct 2016 - submission

The purpose of this project is to explore the related dataset, and prepare a
presentation of findings and/or actionable insights that are relevant.

The following files are included in this repository:
- data.csv - contains the data used for analysis. Short data description below.
- pearsonProject.R - 'raw' code used for the analysis with comments
- pearsonProjectFinal.Rmd - markdown file with code used for analysis prepared in a more readable version, clear comments and conclusions
- pearsonProjectFinal.html - the same as above but compiled into a html file

The dataset comes from a Pearson e-learning platform, an online workbook that is
used alongside a paper textbook. Students complete activities, either assigned by the
teacher or chosen by themselves.
● learner_id​: anonymized student identifier
● country​: country code of the student
● in_course​: “t” if the student belongs to course taught by a teacher (as opposed
to studying alone)
● unit​: number or name of a unit (chapter) in the workbook
● avg_score​: average percentage score on all activities within a given unit
● completion​: the percentage of activities completed in a given unit, out of all
activities available in that unit
● inv_rate​: This is the extent to which a student deviates from the suggested
order of activities by the pedagogy experts within a given unit. A value of zero
indicates no departure from the suggested order, a value of one indicates a
complete reversal of the order.
