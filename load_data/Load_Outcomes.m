function outcomedata = Load_Outcomes(varNamesToImport, path)
%% Import outcome data from csv file.
% This script imports outcome data into a MATLAB table.  The outcomes.csv
% file has 619327 rows of data in it, which takes ~10 secs to import.  The
% names of the variables in outcomes.csv are given on line 14.  The input 
% "varNamesToImport" is a cell array used to select which of these 
% variables are imported.
fprintf('Reading outcomes.csv ...\n');

%% Initialize variables for loading
filename = [path, '/outcomes.csv']; % Give full path to file if it's not on the MATLAB path
fileID = fopen(filename,'r');

varNames = {'projectid','is_exciting','at_least_1_teacher_referred_donor','fully_funded','at_least_1_green_donation','great_chat','three_or_more_non_teacher_referred_donors','one_non_teacher_referred_donor_giving_100_plus','donation_from_thoughtful_donor','great_messages_proportion','teacher_referred_count','non_teacher_referred_count'};
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
dataFormat = '%q%q%q%q%q%q%q%q%q%q%q%q';
% Modify format string to only import requested columns
dataFormat = cellstr(reshape(dataFormat,2,[])');
varsNotImported = setxor(allVars,varsToImport);
for i = 1:length(varsNotImported)
    dataFormat{varsNotImported(i)} = ...
        [dataFormat{varsNotImported(i)}(1) '*' dataFormat{varsNotImported(i)}(2)];
end
formatSpec = strjoin(dataFormat','');

delimiter = ',';
nlines = 619327;

% Read data according to format string.
dataArray = textscan(fileID, formatSpec, nlines, ...
    'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false);

% Put data in a table container
outcomedata = table(dataArray{1:end},'VariableNames',varNames(varsToImport));
clearvars('dataArray');

% Save memory: Variables that are categoricals
categoricalVars = 2:9;
for j = 1:length(categoricalVars)
    ismem = ismember(categoricalVars(j),varsToImport);
    if ismem
        outcomedata.(varNames{categoricalVars(j)}) = categorical(outcomedata.(varNames{categoricalVars(j)}));
    end
end

%%
fclose(fileID);