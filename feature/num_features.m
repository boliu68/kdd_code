function [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid, features_name, response_name] = num_features(path)    

     if exist([path, '\data.mat']) == 2
        load([path, '\data.mat']);
        disp('Load Finish\n');
     else
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
    
    end
    %%
    %convert the label
    %the categorial label
    yTrainC = table2array(yTrain(:, 1:8));
    yCVC = table2array(yCV(:,1:8));
    %the continious label
    yTrainCC = table2array(yTrain(:, 9:11));
    yCVCC = table2array(yCV(:, 9:11));
    
    yTrainD = zeros(size(yTrainC));
    yTrainD(yTrainC == 't') = 1;
    yTrainD(yTrainC == 'f') = -1;
    yTrainD = [yTrainD, yTrainCC];
    
    yCVD = zeros(size(yCVC));
    yCVD(yCVC == 't') = 1;
    yCVD(yCVC == 'f') = -1;
    yCVD = [yCVD, yCVCC]; 
    
    clear yTrain yCV yTrainC yCVC;

end