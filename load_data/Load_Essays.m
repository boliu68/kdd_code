function essaydata = Load_Essays(varNamesToImport, path)
%% Import essay data from csv file.
% This script imports essay data into a MATLAB table.  The essays.csv
% file has 664099 rows of data in it, which takes ~75 secs to import.  The
% names of the variables in essays.csv are given on line 14.  The input 
% "varNamesToImport" is a cell array used to select which of these 
% variables are imported.
fprintf('Reading essays.csv ...\n');

%% Initialize variables for loading
filename = [path, '/essays.csv']; % Give full path to file if it's not on the MATLAB path
fileID = fopen(filename,'r');

varNames = {'projectid','teacher_acctid','title','short_description','need_statement','essay'};
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
dataFormat = '%q%q%q%q%q%q';
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

% Read data according to format string.
dataArray = textscan(fileID, formatSpec, nlines, ...
    'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false,...
    'TreatAsEmpty',{'""'});

% Put data in a table container
essaydata = table(dataArray{1:end},'VariableNames',varNames(varsToImport));
clearvars('dataArray');

%%
fclose(fileID);