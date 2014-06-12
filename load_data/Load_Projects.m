function projectdata = Load_Projects(varNamesToImport, path)
%% Import project data from csv file.
% This script imports project data into a MATLAB table.  The projects.csv
% file has 664099 rows of data in it, which takes ~30 secs to import.  The
% names of the variables in projects.csv are given on line 14.  The input 
% "varNamesToImport" is a cell array used to select which of these 
% variables are imported.
fprintf('Reading projects.csv ...\n');

%% Initialize variables for loading
filename = [path, '/projects.csv']; % Give full path to file if it's not on the MATLAB path
fileID = fopen(filename,'r');

%%record the feature

%  project_attribute = {'projectid','school_city' ,'school_state' ,...
%     'school_metro' ,'school_district','school_county','school_charter' ,...
%     'school_magnet' ,'school_year_round' ,'school_nlns' ,...
%     'school_kipp' ,'school_charter_ready_promise' ,'teacher_prefix' ,...
%     'teacher_teach_for_america' ,'teacher_ny_teaching_fellow' ,...
%     'primary_focus_subject' ,'primary_focus_area' ,'secondary_focus_subject' ,...
%     'secondary_focus_area' ,'resource_type' ,'poverty_level' ,'grade_level' ,...
%     'fulfillment_labor_materials' ,'total_price_excluding_optional_support' ,...
%     'total_price_including_optional_support' ,'students_reached' ,...
%     'eligible_double_your_impact_match' ,'eligible_almost_home_match' ,'date_posted'};  

varNames = {'projectid','teacher_acctid','schoolid','school_ncesid','school_latitude','school_longitude','school_city','school_state','school_zip','school_metro','school_district','school_county','school_charter','school_magnet','school_year_round','school_nlns','school_kipp','school_charter_ready_promise','teacher_prefix','teacher_teach_for_america','teacher_ny_teaching_fellow','primary_focus_subject','primary_focus_area','secondary_focus_subject','secondary_focus_area','resource_type','poverty_level','grade_level','fulfillment_labor_materials','total_price_excluding_optional_support','total_price_including_optional_support','students_reached','eligible_double_your_impact_match','eligible_almost_home_match','date_posted'};
allVars = 1:length(varNames);
varsToImport = [];
for i = 1:length(varNamesToImport)
    idx = find(strcmp(varNamesToImport{i}, varNames));
    if isempty(idx)
        error('variable %s is not in this dataset',varNamesToImport{i});
    end
    varsToImport = [varsToImport idx];
end

%% Load the data
dataFormat = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q';
% Modify format string to only import requested columns
dataFormat = cellstr(reshape(dataFormat,2,[])');
varsNotImported = setxor(allVars,varsToImport);
for i = 1:length(varsNotImported)
    dataFormat{varsNotImported(i)} = ...
        [dataFormat{varsNotImported(i)}(1) '*' dataFormat{varsNotImported(i)}(2)];
end
formatSpec = strjoin(dataFormat','');

delimiter = ',';
nlines = 664099;

dataArray = textscan(fileID, formatSpec, nlines, ...
    'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false,...
    'TreatAsEmpty',{'""'});

% Put data in a table container
projectdata = table(dataArray{1:end},'VariableNames',varNames(varsToImport));
clearvars('dataArray');

% Convert dates to datenums
if ismember('date_posted',varNamesToImport)
    projectdata.date_posted = datenum(projectdata.date_posted,'yyyy-mm-dd');
end

% Save memory - categorical variables
categoricalVars = [2:20 27 28];%[8:10 13:28 33 34];
ordinalVars = [21 22];%[27 28];
for j = 1:length(categoricalVars)
    ismem = ismember(categoricalVars(j),varsToImport);
    if ismem
        if ismember(j,ordinalVars)
            projectdata.(varNames{categoricalVars(j)}) = ...
                categorical(projectdata.(varNames{categoricalVars(j)}),...
                'Ordinal',true);
        else
            projectdata.(varNames{categoricalVars(j)}) = ...
                categorical(projectdata.(varNames{categoricalVars(j)}));
        end
    end
end

%%
fclose(fileID);