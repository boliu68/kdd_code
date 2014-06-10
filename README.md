
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



> Written with [StackEdit](https://stackedit.io/).