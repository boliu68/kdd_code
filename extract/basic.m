function [project_data, outcome_data, essay_data, donation_data, feature_name] = ...
    basic(project_data, outcome_data, essay_data, donation_data)

    feature_name = {};
    %%
    %extract the basic features for KDD cup
    %Author: Bo Liu
    %Time: 06-10-2014 6liubo8@gmail.com
    
    %%
    %Basic features for project data
    project_data.is_charter = (project_data.school_charter == 't');
    project_data.not_charter = (project_data.school_charter == 'f');
    feature_name{length(feature_name) + 1} = 'is_charter';
    feature_name{length(feature_name) + 1} = 'not_charter';
    
    project_data.is_magnet = (project_data.school_magnet == 't');
    project_data.not_magnet = (project_data.school_magnet == 'f');
    feature_name{length(feature_name) + 1} = 'is_magnet';
    feature_name{length(feature_name) + 1} = 'not_charter';
    
    project_data.is_year_round = (project_data.school_year_round == 't');
    project_data.not_year_round = (project_data.school_year_round == 'f');
    feature_name{length(feature_name) + 1} = 'is_year_round';
    feature_name{length(feature_name) + 1} = 'not_year_round';
    
    project_data.is_nlns = (project_data.school_nlns == 't');
    project_data.not_nlns = (project_data.school_nlns == 'f');
    feature_name{length(feature_name) + 1} = 'is_nlns';
    feature_name{length(feature_name) + 1} = 'not_nlns';
    
    project_data.is_kipp = (project_data.school_kipp == 't');
    project_data.not_kipp = (project_data.school_kipp == 'f');
    feature_name{length(feature_name) + 1} = 'is_kipp';
    feature_name{length(feature_name) + 1} = 'not_kipp';
    
    project_data.is_charter_ready = (project_data.school_charter_ready_promise == 't');
    project_data.not_charter_ready = (project_data.school_charter_ready_promise == 'f');
    feature_name{length(feature_name) + 1} = 'is_charter_ready';
    feature_name{length(feature_name) + 1} = 'not_charter_ready';
    
    %%
    %teacher prefix
    teacher_prefix_dict = unique(project_data.teacher_prefix);
    miss_prefix = ~ismissing(array2table(teacher_prefix_dict));
    for i = 1:length(miss_prefix)
       if miss_prefix(i) == 1
           prefix_name = keep_caps(teacher_prefix_dict(i));
           prefix_name = strcat('teacher_prefix_', prefix_name);

           eval(['project_data.',prefix_name,' = (project_data.teacher_prefix == teacher_prefix_dict(i));']);
           feature_name{length(feature_name) + 1} = prefix_name;
       end
    end
    clear teacher_prefix_dict miss_prefix prefix_name;
    
    %%
    project_data.is_teacher_america = (project_data.teacher_teach_for_america == 't');
    project_data.not_teacher_america = (project_data.teacher_teach_for_america == 'f');
    feature_name{length(feature_name) + 1} = 'is_teacher_america';
    feature_name{length(feature_name) + 1} = 'not_teacher_america';
    
    project_data.is_ny_fellow = (project_data.teacher_ny_teaching_fellow == 't');
    project_data.not_ny_fellow = (project_data.teacher_ny_teaching_fellow == 'f');
    feature_name{length(feature_name) + 1} = 'is_ny_fellow';
    feature_name{length(feature_name) + 1} = 'not_ny_fellow';
    
    %%
    %primary focus subject
    subject_dict = unique(project_data.primary_focus_subject);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('primary_sub_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.primary_focus_subject == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
    
    %%
    %primary focus area
    subject_dict = unique(project_data.primary_focus_area);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('primary_area_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.primary_focus_area == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
    
    
    %%
    %secondary_focus_subject
    subject_dict = unique(project_data.secondary_focus_subject);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('second_sub_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.secondary_focus_subject == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
    
    %%
    %second focus area
    subject_dict = unique(project_data.secondary_focus_area);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('second_area_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.secondary_focus_area == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
   
    %%
    %resouce type
    subject_dict = unique(project_data.resource_type);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('res_type_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.resource_type == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
    
    %%
    %poverty_level to continous level
    poverty = zeros(height(project_data), 1);
    poverty(project_data.poverty_level == categorical(cellstr('highest poverty'))) = 1;
    poverty(project_data.poverty_level == categorical(cellstr('high poverty'))) = 0.75;
    poverty(project_data.poverty_level == categorical(cellstr('moderate poverty'))) = 0.5;
    poverty(project_data.poverty_level == categorical(cellstr('low poverty'))) = 0.25;
    project_data.num_poverty = poverty;
    clear poverty;
    feature_name{length(feature_name) + 1} = 'num_poverty';
    
    %%
    %grade level
    subject_dict = unique(project_data.grade_level);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('grade_level_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.grade_level == subject_dict(i));']);
            feature_name{length(feature_name) + 1} = prefix_name;
        end
    end
    clear subject_dict miss_dict prefix_name;
    
    %%
    %fulfillment_labor_materials
    project_data.fulfillment_labor_materials(ismissing(array2table(project_data.fulfillment_labor_materials))) = 0;
    feature_name{length(feature_name) + 1} = 'fulfillment_labor_materials';
    
    %%
    %double_matlab
    project_data.is_double_match = (project_data.eligible_double_your_impact_match == 't');
    project_data.not_double_match = (project_data.eligible_double_your_impact_match == 'f');
    feature_name{length(feature_name) + 1} = 'is_double_match';
    feature_name{length(feature_name) + 1} = 'not_double_match';
    
    %%
    %eligible_almost_home_match
    project_data.is_home_match = (project_data.eligible_almost_home_match == 't');
    project_data.not_home_match = (project_data.eligible_almost_home_match == 'f');
    feature_name{length(feature_name) + 1} = 'is_home_match';
    feature_name{length(feature_name) + 1} = 'not_home_match';
    
end