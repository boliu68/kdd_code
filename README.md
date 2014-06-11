
#Introducton to KDD Code Use

###Attention:
The reading function utilize the table varible in Matlab which requires Matlab R2013b or later.

```
function  [xTrain, yTrain, xCV, yCV, xTest, Test_projectid, features_name, response_name] = features(path) 

Input: The absolute path for csv files sotred.
Output:
    xTrain: the feature table for training data
    yTrain: the label table for training data
    xCV: the feature table for Cross Validation data
    yCV: the label table for Cross Validation Data
    xTest: the feature table for test data
    Test_projectid: the stored project id for each test data
    features_name: the stored name of all the features
    response_name: the stored name of the label
    
Structure:
    1. Declare the features that are needed to be read from CSV files in the variable of *_attribute.
    2. call the function to extract features from the read data. And stored it again in *_data in table variable form.
    3. Join the tables using projectid as identifier such that the features for one project is merged into one instance.
```

```
function [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid] = num_features(path)    
Usage: Call the above function and convert the data in table variable form to numerical.
Input: the absolute path for stored CSV files.
Output:
    Very similar as previous function except the output is in numerical form.
```

```
function roc = cv_roc(yCV, y_pred)
Usage: Calculate the ROC for Cross Validation Data
Input: 
    yCV: the groundtruth for CV data.
    y_pred: the predicted probalibity for CV data

Output:
    ROC
```

```
function output_solution(projectid, pred)
Usage: Save the format result in my_submission_yy_mm_dd_hh_mm.txt
Input: 
    projectid: the project id for each test data
    pred: the predcited probablity for test data is exciting.

```

----

##Feature List
```
1. is_charter
2. not_charter
3. is_magnet
4. not_charter
5. is_year_round
6. not_year_round
7. is_nlns
8. not_nlns
9. is_kipp
10. not_kipp
11. is_charter_ready
12. not_charter_ready
13. teacher_prefix_Dr
14. teacher_prefix_Mr
15. teacher_prefix_MrMrs
16. teacher_prefix_Mrs
17. teacher_prefix_Ms
18. is_teacher_america
19. not_teacher_america
20. is_ny_fellow
21. not_ny_fellow
22. primary_sub_ppliedSciences
23. primary_sub_ChrcterEduction
24. primary_sub_CivicsGovernment
25. primary_sub_CollegeCreerPrep
26. primary_sub_CommunityService
27. primary_sub_ESL
28. primary_sub_ErlyDevelopment
29. primary_sub_Economics
30. primary_sub_EnvironmentlScience
31. primary_sub_Extrcurriculr
32. primary_sub_ForeignLnguges
33. primary_sub_GymFitness
34. primary_sub_HelthLifeScience
35. primary_sub_HelthWellness
36. primary_sub_HistoryGeogrphy
37. primary_sub_Litercy
38. primary_sub_LitertureWriting
39. primary_sub_Mthemtics
40. primary_sub_Music
41. primary_sub_Nutrition
42. primary_sub_Other
43. primary_sub_PrentInvolvement
44. primary_sub_Performingrts
45. primary_sub_SocilSciences
46. primary_sub_SpecilNeeds
47. primary_sub_Sports
48. primary_sub_Visulrts
49. primary_area_ppliedLerning
50. primary_area_HelthSports
51. primary_area_HistoryCivics
52. primary_area_LitercyLnguge
53. primary_area_MthScience
54. primary_area_MusicTherts
55. primary_area_SpecilNeeds
56. second_sub_ppliedSciences
57. second_sub_ChrcterEduction
58. second_sub_CivicsGovernment
59. second_sub_CollegeCreerPrep
60. second_sub_CommunityService
61. second_sub_ESL
62. second_sub_ErlyDevelopment
63. second_sub_Economics
64. second_sub_EnvironmentlScience
65. second_sub_Extrcurriculr
66. second_sub_ForeignLnguges
67. second_sub_GymFitness
68. second_sub_HelthLifeScience
69. second_sub_HelthWellness
70. second_sub_HistoryGeogrphy
71. second_sub_Litercy
72. second_sub_LitertureWriting
73. second_sub_Mthemtics
74. second_sub_Music
75. second_sub_Nutrition
76. second_sub_Other
77. second_sub_PrentInvolvement
78. second_sub_Performingrts
79. second_sub_SocilSciences
80. second_sub_SpecilNeeds
81. second_sub_Sports
82. second_sub_Visulrts
83. second_area_ppliedLerning
84. second_area_HelthSports
85. second_area_HistoryCivics
86. second_area_LitercyLnguge
87. second_area_MthScience
88. second_area_MusicTherts
89. second_area_SpecilNeeds
90. res_type_Books
91. res_type_Other
92. res_type_Supplies
93. res_type_Technology
94. res_type_Trips
95. res_type_Visitors
96. num_poverty
97. grade_level_Grdes35
98. grade_level_Grdes68
99. grade_level_Grdes12
100. grade_level_GrdesPreK2
101. fulfillment_labor_materials
102. is_double_match
103. not_double_match
104. is_home_match
105. not_home_match
106. total_price_including_optional_support
107. students_reached
108. need_statement_length
109. essay_length
```



> Written with [StackEdit](https://stackedit.io/).