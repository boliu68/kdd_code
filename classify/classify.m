
%%
%     [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid] = ...
%         num_features('C:\KDD\Data');
   
%%
%normalize
min_data = min([xTrainD; xCVD; xTestD]);
max_data = max([xTrainD; xCVD; xTestD]);
% 
 NxTrainD = (xTrainD - repmat(min_data, size(xTrainD, 1), 1)) ./ repmat((max_data - min_data), size(xTrainD, 1), 1);
 NxCVD = (xCVD - repmat(min_data, size(xCVD, 1), 1)) ./ repmat((max_data - min_data), size(xCVD, 1), 1);
 NxTestD = (xTestD - repmat(min_data, size(xTestD, 1), 1)) ./ repmat((max_data - min_data), size(xTestD, 1), 1);

%%    
%fit a logistic regression model
    
   
    
    
    