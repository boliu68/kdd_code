function [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid] = num_features(path)    

    [xTrain, yTrain, xCV, yCV, xTest, Test_projectid, features_name, response_name]...
        = features(path);
    
        %%
    %Convert the features
    xTrainD = zeros(height(xTrain),length(features_name));
    xCVD = zeros(height(xCV),length(features_name));
    xTestD = zeros(height(xTest),length(features_name));
    
    for j = 1:length(features_name)
        xTrainD(:,j) = double(xTrain.(features_name{j}));
        xCVD(:,j) = double(xCV.(features_name{j}));
        xTestD(:, j) = double(xTest.(features_name{j}));
    end
    
    %%
    %clean the missing data
    %record the missing position
    Train_miss = ismissing(xTrain);
    CV_miss = ismissing(xCV);
    Test_miss = ismissing(xTest);
    
    %replace the missing value with 0
    xTrainD(Train_miss) = 0;
    xCVD(CV_miss) = 0;
    xTestD(Test_miss) = 0;
    
    clear xTrain xCV xTest;
    
    %%
    %convert the label
    yTrainC = table2array(yTrain);
    yCVC = table2array(yCV);
    
    yTrainD = zeros(length(yTrainC), 1);
    yTrainD(yTrainC == 't') = 1;
    yTrainD(yTrainC == 'f') = -1;
    
    yCVD = zeros(length(yCVC), 1);
    yCVD(yCVC == 't') = 1;
    yCVD(yCVC == 'f') = -1;
    
    clear yTrain yCV yTrainC yCVC;

end