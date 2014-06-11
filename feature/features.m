function [xTrain, yTrain, xCV, yCV, xTest, Test_projectid, features_name, response_name] = features(path)    
    
    %%
    %read the data
    %the feature needed to be read
    project_attribute = {'projectid', 'school_charter', 'school_magnet',...
        'school_year_round','school_nlns','school_kipp','school_charter_ready_promise',...
        'teacher_prefix','teacher_teach_for_america','teacher_ny_teaching_fellow',...
        'primary_focus_subject','primary_focus_area','secondary_focus_subject',...
        'secondary_focus_area','resource_type','poverty_level','grade_level',...
        'fulfillment_labor_materials','students_reached',...
        'total_price_excluding_optional_support', 'total_price_including_optional_support',...
        'eligible_double_your_impact_match','eligible_almost_home_match',...
        'date_posted'};
    
    %%essay attribute
    essay_attribute = {'projectid','need_statement','essay'};
    
    %%
    %outcome attribute all is binary true or false
    outcome_attribute = {'projectid','is_exciting', 'fully_funded', ...
        'at_least_1_green_donation','great_chat','three_or_more_non_teacher_referred_donors',...
        'one_non_teacher_referred_donor_giving_100_plus','donation_from_thoughtful_donor'};
    
    %%
    %donation attribute not known how to use these
    donation_attribute = {'projectid','donation_total'};

    if exist([path, '\data.mat']) == 2
        load([path, '\data.mat']);
        essay_data = Load_Essays(essay_attribute, path);
        disp('Load Finish\n');
    else
    [project_data, outcome_data, essay_data, donation_data] = load_data(path, project_attribute, essay_attribute,...
        outcome_attribute, donation_attribute);
    end
    
    %%
    %extract all kinds of features
    %Use the following as example
	%call function to extract features
%     project_data.is_charter = (project_data.school_charter == 't');
%     project_data.not_charter = (project_data.school_charter == 'f');
    
    [project_data, outcome_data, essay_data, donation_data, features_name] = ...
    basic(project_data, outcome_data, essay_data, donation_data);

    essay_data.need_statement_length = cellfun(@length, essay_data.need_statement);
    essay_data.essay_length = cellfun(@length, essay_data.essay);
    essay_data.need_statement = [];
    essay_data.essay = [];
    
    %%
    %Merge the files
    Training_Data = join(project_data, essay_data, 'LeftKeys', 'projectid',...
        'RightKeys', 'projectid');
    Training_Data = innerjoin(Training_Data, outcome_data, 'LeftKeys',...
        'projectid', 'RightKeys', 'projectid');
    
    %Find the test data which is not in Training_Data
    [~, test_id] = setdiff(project_data.projectid, Training_Data.projectid);
    
    Test_Data = project_data(test_id, :);
    Test_Data = innerjoin(Test_Data, essay_data, 'LeftKeys', 'projectid',...
        'RightKeys', 'projectid');
    
    clear essay_data outcome_data project_data donation_data;
    
    %%
    %eliminate the data before 2010 which does not contain exciting data
    training_set = Training_Data.date_posted >= datenum('2010-04-14') ...
        & Training_Data.date_posted < datenum('2014-01-01');
    Training_Data = Training_Data(training_set, :);
    
    %%
    %select the features and predict label
    features_name = {features_name{:}, 'total_price_including_optional_support','students_reached',...
     'need_statement_length','essay_length'};
    response_name = {'is_exciting'};
    
    %%
    %Cut the Cross Val
    cv_id = cvpartition(height(Training_Data), 'holdout', 0.1);
    xTrain = Training_Data(training(cv_id), features_name);
    yTrain = Training_Data(training(cv_id), response_name);
    
    xCV = Training_Data(test(cv_id), features_name);
    yCV = Training_Data(test(cv_id), response_name);
    
    xTest = Test_Data(:, features_name);
    Test_projectid = Test_Data.projectid;
end