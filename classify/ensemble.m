
    %%
    [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid, features_name,...
            response_name] = num_features('C:\kDD\Data');

%    include normalization
    classify;
    clear xTrainD xCVD;
    
    %%
    %parameter
    opts = [];
    opts.loss = 'exploss'; % can be logloss or exploss
    % gradient boost options
    opts.shrinkageFactor = 0.3;
    opts.subsamplingFactor = 0.5;
    opts.maxTreeDepth = uint32(2);  % this was the default before customization
    opts.randSeed = uint32(rand()*1000);
    opts.mtry = uint32(ceil(sqrt(size(NxTrainD,2)))); 
    
    %%
    %classify the subtasks
    model = {};
    x_all_train = NxTrainD;%[NxTrainD; NxCVD];
    y_all_train = yTrainD;%[yTrainD; yCVD];
    
    train_length = {};
    
    for i = 2:8
        %clean the missing_data
        
        if i < 9
            %categorical label
            clean_id = y_all_train(:,i) ~= 0;
        else
            clean_id = ~ismissing(table(y_all_train(:, i)));
        end
        Clean_Train_Data = x_all_train(clean_id, :);
        Train_Label = y_all_train(clean_id, i);
        train_length{i - 1} = sum(clean_id);
        model{i - 1} = SQBMatrixTrain(single(Clean_Train_Data), Train_Label, uint32(100),opts);
    end
    
    %%
    %Expand the feature
    Expanded_Training_Data = NxTrainD;
    Expanded_CV_Data = NxCVD;
    Expanded_Test_Data = NxTestD;
    
    for i = 2:8
       new_feature =  SQBMatrixPredict(model{i - 1}, single(NxTrainD));
       new_feature = (new_feature - min(new_feature)) / (max(new_feature) - min(new_feature));
       Expanded_Training_Data = [Expanded_Training_Data, new_feature];
       
       new_feature =  SQBMatrixPredict(model{i - 1}, single(NxCVD));
       new_feature = (new_feature - min(new_feature)) / (max(new_feature) - min(new_feature));
       Expanded_CV_Data = [Expanded_CV_Data, new_feature];
       
       new_feature =  SQBMatrixPredict(model{i - 1}, single(NxTestD));
       new_feature = (new_feature - min(new_feature)) / (max(new_feature) - min(new_feature));
       Expanded_Test_Data = [Expanded_Test_Data, new_feature];
    end
    
    %%
    %Training Based on new feature
    x_all_train = Expanded_Training_Data;%[Expanded_Training_Data;Expanded_CV_Data];
    primary_model = SQBMatrixTrain(single(x_all_train), y_all_train(:, 1), uint32(300),opts);
    
    %CV ROC
    cv_id = yCVD(:,1)~=0;
    prob = sigmf(SQBMatrixPredict(primary_model, single(Expanded_CV_Data(cv_id,:))), [1, 0]);
    roc = cv_roc(yCVD(cv_id, 1), prob);
    
    prob_Test = sigmf(SQBMatrixPredict(primary_model, single(Expanded_Test_Data)), [1, 0]);
    output_solution(Test_projectid, prob_Test);
    