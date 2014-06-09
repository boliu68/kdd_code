%% Predicting Excitement at DonorsChoose.org
% * Load in data for projects, essays, and outcomes. 
% * Do some data management (separate into training and test, join)
% * Fit a classification tree to the training data
% * Evaluate tree on the test data
% * Write results to a submission file

%% Load csv files into MATLAB tables (specify which variables to import)
projectdata = Load_Projects({'projectid','school_charter',...
    'primary_focus_subject','total_price_including_optional_support',...
    'students_reached','date_posted'});
essaydata = Load_Essays({'projectid','need_statement','essay'});
outcomedata = Load_Outcomes({'projectid','is_exciting'});
% donordata = Load_Donations({'projectid','donation_total'});

%% Sort tables
projectdata = sortrows(projectdata,'projectid');
essaydata = sortrows(essaydata,'projectid');
outcomedata = sortrows(outcomedata,'projectid');

%% Add a new variable essaylength to essaydata
essaydata.need_statement_length = cellfun(@length,essaydata.need_statement);
essaydata.essay_length = cellfun(@length,essaydata.essay);
essaydata.need_statement = []; % Not planning to use this, so free up some space
essaydata.essay = []; % Not planning to use this, so free up some space

%% Merge the data
% Use the "projectid" variable as the key.
TrainingData = join(projectdata,essaydata,...
    'LeftKeys','projectid','RightKeys','projectid');
TrainingData = innerjoin(TrainingData,outcomedata,...
    'LeftKeys','projectid','RightKeys','projectid');
% TestingData: every project in projectdata that isn't in TrainingData.
[~,ia] = setdiff(projectdata.projectid,TrainingData.projectid);
TestingData = projectdata(ia,:);
TestingData = innerjoin(TestingData,essaydata,...
    'LeftKeys','projectid','RightKeys','projectid');

clearvars('projectdata','essaydata','outcomedata');   

%% Visualize the data
% It looks like only projects that were posted in 2010 and later are
% classified as "exciting".  We might want to discard projects before 2010
% from the training set.
gscatter(TrainingData.date_posted,...
    TrainingData.essay_length,...
    TrainingData.is_exciting);
datetick;
ylabel('Essay Length (characters)');
title('Exciting Projects');

%% Filter out projects in training set
% Want all projects on and after 2010-04-14, and before 2014-01-01
trainingset = TrainingData.date_posted >= datenum('2010-04-14') & ...
    TrainingData.date_posted < datenum('2014-01-01');
TrainingData = TrainingData(trainingset,:);

%% Split the TrainingData into Local Training and Test Data
% We'll use this for training and validating our classifier.
cv = cvpartition(height(TrainingData),'holdout',0.1);
predictors = {'school_charter','primary_focus_subject',...
    'total_price_including_optional_support','students_reached',...
    'need_statement_length','essay_length'};
response = {'is_exciting'};

xTrain = TrainingData(training(cv),predictors);
yTrain = TrainingData{training(cv),response};
xTest = TrainingData(test(cv),predictors);
yTest = TrainingData{test(cv),response};

% Convert to doubles
xTrainD = zeros(height(xTrain),length(predictors));
xTestD = zeros(height(xTest),length(predictors));
for j = 1:length(predictors)
    xTrainD(:,j) = double(xTrain.(predictors{j}));
    xTestD(:,j) = double(xTest.(predictors{j}));
end

%% Fit model
% The goal is to maximize the area under the ROC curve.  We'll loop through
% several different numbers of minimum leafs, and fit a tree for each
% value.  After fitting the tree, evaluate it on the local test set and
% calculate the ROC curve.  Keep track of the best performing tree.
minleaf = 2.^(0:15); % Vector of minimum leaf sizes to try
nfits = length(minleaf);
bestAOC = 0;
for i = 1:nfits  
    % Fit the tree
    tree = fitctree(xTrainD,yTrain,'CategoricalPredictors',[1 2],...
        'MinLeaf',minleaf(i));  
    % Predict on our local test set
    [ytestpred,probability] = predict(tree,xTestD); 
    % ROC Curve
    [X,Y] = perfcurve(yTest,probability(:,2),'t'); 
    % Trapezoidal integration to calculate area under curve
    AOC = trapz(X,Y);
    % Keep track of the best performer
    if AOC > bestAOC
        bestAOC = AOC;
        besttree = tree;
    end
    fprintf('MinLeaf: %d  This AOC: %f  Best AOC: %f\n',minleaf(i),AOC,bestAOC);
end 

%% Use the best performing tree to predict on the submission test data
submission_x_test = zeros(height(TestingData),length(predictors));
for i = 1:length(predictors)
    submission_x_test(:,i) = double(TestingData.(predictors{i}));
end
[submission_y_test,probability] = predict(besttree,submission_x_test);

%% Transform results into format required for submission file
outData = [TestingData.projectid num2cell(probability(:,2))]';

%% Write the file to be submitted
formatSpec = '%s,%f\n';
fileID = fopen('my_submission.txt','w');
fprintf(fileID,'projectid,is_exciting\n'); % Header line
fprintf(fileID,formatSpec,outData{:,:}); % Data
fclose(fileID);
