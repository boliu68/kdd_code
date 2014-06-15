function [project_data, outcome_data, essay_data, donation_data, feature_name] = ...
    basic(project_data, outcome_data, essay_data, donation_data)

    feature_name = {'school_latitude','school_longitude'};
    %%
    %extract the basic features for KDD cup
    %Author: Bo Liu
    %Time: 06-10-2014 6liubo8@gmail.com
    
    %%
    %Basic features for project data
    project_data.is_charter = (project_data.school_charter == 't');
    project_data.not_charter = (project_data.school_charter == 'f');
    project_data.school_charter = [];
    feature_name = [feature_name, {'is_charter'}];
    feature_name = [feature_name, {'not_charter'}];
    
    project_data.is_magnet = (project_data.school_magnet == 't');
    project_data.not_magnet = (project_data.school_magnet == 'f');
    project_data.school_magnet = [];
    feature_name = [feature_name, {'is_magnet'}];
    feature_name = [feature_name, {'not_magnet'}];
    
    project_data.is_year_round = (project_data.school_year_round == 't');
    project_data.not_year_round = (project_data.school_year_round == 'f');
    project_data.school_year_round = [];
    feature_name = [feature_name, {'is_year_round'}];
    feature_name = [feature_name, {'not_year_round'}];
    
    project_data.is_nlns = (project_data.school_nlns == 't');
    project_data.not_nlns = (project_data.school_nlns == 'f');
    project_data.school_nlns = [];
    feature_name = [feature_name, {'is_nlns'}];
    feature_name = [feature_name, {'not_nlns'}];
    
    project_data.is_kipp = (project_data.school_kipp == 't');
    project_data.not_kipp = (project_data.school_kipp == 'f');
    project_data.school_kipp = [];
    feature_name = [feature_name, {'is_kipp'}];
    feature_name = [feature_name, {'not_kipp'}];
    
    project_data.is_charter_ready = (project_data.school_charter_ready_promise == 't');
    project_data.not_charter_ready = (project_data.school_charter_ready_promise == 'f');
    project_data.school_charter_ready_promise = [];
    feature_name = [feature_name, {'is_charter_ready'}];
    feature_name = [feature_name, {'not_charter_ready'}];
    
    %%
    %feature of city
%     unique_city = unique(project_data.school_city);
%     hist_sum = [];
%     cate = categorical(project_data.school_city);
%     
%     for i = 1:length(unique_city)
%         hist_sum = [hist_sum, sum(cate == (unique_city(i)))];
%     end
    
    %choose top 14 city whose hist_sum > 5000
%     top_city = unique_city(hist_sum > 10000);
%     not_top_city_id = ones(height(project_data), 1);
%     miss_prefix = ~ismissing(array2table(top_city));
%     for i = 1:length(miss_prefix)
%        if miss_prefix(i) == 1
%            prefix_name = keep_caps(top_city(i));
%            prefix_name = strcat('top_city', prefix_name);
% 
%            eval(['project_data.',prefix_name,' = (cate == (top_city(i)));']);
%            not_top_city_id = (not_top_city_id & ~(cate == (top_city(i))));
%            feature_name = [feature_name, {prefix_name}];
%        end
%     end
%     
%     project_data.is_top_city = ~not_top_city_id;
%     project_data.not_top_city = not_top_city_id;
%     feature_name = [feature_name, {'is_top_city', 'not_top_city'}];
%     project_data.school_city = [];
%     
%     clear cate hist_sum unique_city top_city miss_prefix prefix_name not_top_city_id;
    
    
    %%
    %state data
%     subject_dict = unique(project_data.school_state);
%     miss_dict = ~ismissing(array2table(subject_dict));
%     for i = 1:length(miss_dict)
%         if miss_dict(i) == 1
%             prefix_name = keep_caps(subject_dict(i));
%             prefix_name = strcat('state_', prefix_name);
% 
%             eval(['project_data.',prefix_name,' = (project_data.school_state == subject_dict(i));']);
%             feature_name = [feature_name, {prefix_name}];
%         end
%     end
%     project_data.school_state = [];
%     clear subject_dict miss_dict prefix_name;
    
    %%
    %district data
%     unique_district = unique(project_data.school_district);
%     hist_sum = [];
%     cate = categorical(project_data.school_district);
%     for i = 1:length(unique_district)
%         hist_sum = [hist_sum, sum(cate == (unique_district(i)))];
%     end
%     
%     %choose top 10 district whose hist_sum > 5000
%     top_district = unique_district(hist_sum > 10000);
%     not_top_district_id = ones(height(project_data), 1);
%     miss_prefix = ~ismissing(array2table(top_district));
%     for i = 1:length(miss_prefix)
%        if miss_prefix(i) == 1
%            prefix_name = keep_caps(top_district(i));
%            prefix_name = strcat('top_district', prefix_name);
% 
%            eval(['project_data.',prefix_name,' = (cate == (top_district(i)));']);
%            not_top_district_id = (not_top_district_id & ~(cate == (top_district(i))));
%            feature_name = [feature_name, {prefix_name}];
%        end
%     end
%     
%     project_data.is_top_district = ~not_top_district_id;
%     project_data.not_top_district = not_top_district_id;
%     feature_name = [feature_name, {'is_top_district', 'not_top_district'}];
%     project_data.school_district = [];
%     
%     clear cate hist_sum unique_district top_district miss_prefix prefix_name not_top_district_id;
    
    %%
    %metro data
    subject_dict = unique(project_data.school_metro);
    miss_dict = ~ismissing(array2table(subject_dict));

    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('metro_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.school_metro == subject_dict(i));']);
            feature_name = [feature_name, {prefix_name}];
        end
    end
    project_data.school_metro = [];
    clear subject_dict miss_dict prefix_name;
    
    %%
    %county data
%     unique_county = unique(project_data.school_county);
%     hist_sum = [];
%     cate = categorical(project_data.school_county);
%     for i = 1:length(unique_county)
%         hist_sum = [hist_sum, sum(cate == (unique_county(i)))];
%     end
%     
%     %choose top 13 county whose hist_sum > 8000
%     top_county = unique_county(hist_sum > 10000);
%     not_top_county_id = ones(height(project_data), 1);
%     miss_prefix = ~ismissing(array2table(top_county));
%     for i = 1:length(miss_prefix)
%        if miss_prefix(i) == 1
%            prefix_name = keep_caps(top_county(i));
%            prefix_name = strcat('top_county', prefix_name);
% 
%            eval(['project_data.',prefix_name,' = (cate == (top_county(i)));']);
%            not_top_county_id = (not_top_county_id & ~(cate == (top_county(i))));
%            feature_name = [feature_name, {prefix_name}];
%        end
%     end
%     
%     project_data.is_top_county = ~not_top_county_id;
%     project_data.not_top_county = not_top_county_id;
%     feature_name = [feature_name, {'is_top_county', 'not_top_county'}];
%     project_data.school_county = [];
%     
%     clear cate hist_sum unique_district top_district miss_prefix prefix_name not_top_district_id;
    
    %%
    %teacher prefix
    teacher_prefix_dict = unique(project_data.teacher_prefix);
    miss_prefix = ~ismissing(array2table(teacher_prefix_dict));
    for i = 1:length(miss_prefix)
       if miss_prefix(i) == 1
           prefix_name = keep_caps(teacher_prefix_dict(i));
           prefix_name = strcat('teacher_prefix_', prefix_name);

           eval(['project_data.',prefix_name,' = (project_data.teacher_prefix == teacher_prefix_dict(i));']);
           feature_name = [feature_name, {prefix_name}];
       end
    end
    project_data.teacher_prefix = [];
    clear teacher_prefix_dict miss_prefix prefix_name;
    
    %%
    project_data.is_teacher_america = (project_data.teacher_teach_for_america == 't');
    project_data.not_teacher_america = (project_data.teacher_teach_for_america == 'f');
    feature_name = [feature_name, {'is_teacher_america'}];
    feature_name = [feature_name, {'not_teacher_america'}];
    project_data.teacher_teach_for_america = [];
    
    project_data.is_ny_fellow = (project_data.teacher_ny_teaching_fellow == 't');
    project_data.not_ny_fellow = (project_data.teacher_ny_teaching_fellow == 'f');
    feature_name = [feature_name, {'is_ny_fellow'}];
    feature_name = [feature_name, {'not_ny_fellow'}];
    project_data.teacher_ny_teaching_fellow = [];
    
    %%
    %primary focus subject
%     subject_dict = unique(project_data.primary_focus_subject);
%     miss_dict = ~ismissing(array2table(subject_dict));
%     for i = 1:length(miss_dict)
%         if miss_dict(i) == 1
%             prefix_name = keep_caps(subject_dict(i));
%             prefix_name = strcat('primary_sub_', prefix_name);
% 
%             eval(['project_data.',prefix_name,' = (project_data.primary_focus_subject == subject_dict(i));']);
%             feature_name = [feature_name, {prefix_name}];
%         end
%     end
%     project_data.primary_focus_subject = [];
%     clear subject_dict miss_dict prefix_name;
    
    %%
    %primary focus area
%     subject_dict = unique(project_data.primary_focus_area);
%     miss_dict = ~ismissing(array2table(subject_dict));
%     for i = 1:length(miss_dict)
%         if miss_dict(i) == 1
%             prefix_name = keep_caps(subject_dict(i));
%             prefix_name = strcat('primary_area_', prefix_name);
% 
%             eval(['project_data.',prefix_name,' = (project_data.primary_focus_area == subject_dict(i));']);
%             feature_name = [feature_name, {prefix_name}];
%         end
%     end
%     project_data.primary_focus_area = [];
%     clear subject_dict miss_dict prefix_name;
    
    %%
    %secondary_focus_subject
%     subject_dict = unique(project_data.secondary_focus_subject);
%     miss_dict = ~ismissing(array2table(subject_dict));
%     for i = 1:length(miss_dict)
%         if miss_dict(i) == 1
%             prefix_name = keep_caps(subject_dict(i));
%             prefix_name = strcat('second_sub_', prefix_name);
% 
%             eval(['project_data.',prefix_name,' = (project_data.secondary_focus_subject == subject_dict(i));']);
%             feature_name = [feature_name, {prefix_name}];
%         end
%     end
%     project_data.secondary_focus_subject = [];
%     clear subject_dict miss_dict prefix_name;
    
    %%
    %second focus area
%     subject_dict = unique(project_data.secondary_focus_area);
%     miss_dict = ~ismissing(array2table(subject_dict));
%     for i = 1:length(miss_dict)
%         if miss_dict(i) == 1
%             prefix_name = keep_caps(subject_dict(i));
%             prefix_name = strcat('second_area_', prefix_name);
% 
%             eval(['project_data.',prefix_name,' = (project_data.secondary_focus_area == subject_dict(i));']);
%             feature_name = [feature_name, {prefix_name}];
%         end
%     end
%     project_data.secondary_focus_area = [];
%     clear subject_dict miss_dict prefix_name;
   
    %%
    %resouce type
    subject_dict = unique(project_data.resource_type);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('res_type_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.resource_type == subject_dict(i));']);
            feature_name = [feature_name, {prefix_name}];
        end
    end
    project_data.resource_type = [];
    clear subject_dict miss_dict prefix_name;
    
    %%
    %poverty_level to continous level
%     poverty = zeros(height(project_data), 1);
%     poverty(project_data.poverty_level == categorical(cellstr('highest poverty'))) = 1;
%     poverty(project_data.poverty_level == categorical(cellstr('high poverty'))) = 0.75;
%     poverty(project_data.poverty_level == categorical(cellstr('moderate poverty'))) = 0.5;
%     poverty(project_data.poverty_level == categorical(cellstr('low poverty'))) = 0.25;
%     project_data.num_poverty = poverty;
%     clear poverty;
%     feature_name = [feature_name, {'num_poverty'}];
 

    subject_dict = unique(project_data.poverty_level);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('poverty_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.poverty_level == subject_dict(i));']);
            feature_name = [feature_name, {prefix_name}];
        end
    end
   project_data.poverty_level = [];
   clear subject_dict miss_dict prefix_name;
    
    %%
    %grade level
    subject_dict = unique(project_data.grade_level);
    miss_dict = ~ismissing(array2table(subject_dict));
    for i = 1:length(miss_dict)
        if miss_dict(i) == 1
            prefix_name = keep_caps(subject_dict(i));
            prefix_name = strcat('grade_level_', prefix_name);

            eval(['project_data.',prefix_name,' = (project_data.grade_level == subject_dict(i));']);
            feature_name = [feature_name, {prefix_name}];
        end
    end
%     grade = zeros(height(project_data), 1);
%     grade(project_data.grade_level == categorical(cellstr('Grades PreK-2'))) = 1;
%     grade(project_data.grade_level == categorical(cellstr('Grades 9-12'))) = 0.75;
%     grade(project_data.grade_level == categorical(cellstr('Grades 6-8'))) = 0.5;
%     grade(project_data.grade_level == categorical(cellstr('Grades 3-5'))) = 0.25;
%     project_data.grade = grade;
%     clear grade;
%     feature_name = [feature_name, {'grade'}];
    project_data.grade_level = [];
    clear subject_dict miss_dict prefix_name;
    
    %%
    %fulfillment_labor_materials
    project_data.fulfillment_labor_materials(ismissing(array2table(project_data.fulfillment_labor_materials))) = 0;
    feature_name = [feature_name, {'fulfillment_labor_materials'}];
    
    %%
    %double_matlab
    project_data.is_double_match = (project_data.eligible_double_your_impact_match == 't');
    project_data.not_double_match = (project_data.eligible_double_your_impact_match == 'f');
    feature_name = [feature_name, {'is_double_match'}];
    feature_name = [feature_name, {'not_double_match'}];
    project_data.eligible_double_your_impact_match = [];
    
    %%
    %eligible_almost_home_match
    project_data.is_home_match = (project_data.eligible_almost_home_match == 't');
    project_data.not_home_match = (project_data.eligible_almost_home_match == 'f');
    feature_name = [feature_name, {'is_home_match'}];
    feature_name = [feature_name, {'not_home_match'}];
    project_data.eligible_almost_home_match = [];
    
end