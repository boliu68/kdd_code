

    [xTrainD, yTrainD, xCVD, yCVD, xTestD, Test_projectid, features_name,...
        response_name] = num_features('C:\kDD\Data');

    classify;
    clear xTrainD xCVD;

    loss_type = {'exploss','logloss','squaredloss'};
    shinkage_factor = 0.1:0.1:0.4;
    subsampling_factor = [0.4, 0.5, 0.6];
    max_depth = [1,2,3];
    
    best_opt = [];
    best_model = [];
    best_roc = 0;
    
    for i = 1:length(loss_type)
        for j = 1:length(shinkage_factor)
            for k = 1:length(subsampling_factor)
                for h = 1:max_depth
    
                    opts = [];
                    opts.loss = loss_type{i}; % can be logloss or exploss
                    % gradient boost options
                    opts.shrinkageFactor = shinkage_factor(j);
                    opts.subsamplingFactor = subsampling_factor(k);
                    opts.maxTreeDepth = uint32(max_depth(h));  % this was the default before customization
                    opts.mtry = uint32(ceil(sqrt(size(NxTrainD,2))));
                    opts.randSeed = uint32(rand()*1000);

                    model = SQBMatrixTrain(single(NxTrainD), yTrainD(:, 1),uint32(100),opts);

                    %CV ROC
                    pred = SQBMatrixPredict(model, single(NxCVD));
                    prob = sigmf(pred, [1, 0]);
                    roc = cv_roc(yCVD(:, 1), prob);
                    if roc > best_roc
                        best_opt = opts;
                        best_model = model;
                        best_roc = roc;
                    end
                
                end
            end
        end
    end