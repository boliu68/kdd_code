function res_data = Load_Resources(varNamesToImport, path)
%% Import project data from csv file.
%Read the resources 
fprintf('Reading resources.csv ...\n');

%% Initialize variables for loading
filename = [path, '/resources.csv'];%Give full path to file if it's not on the MATLAB path
fileID = fopen(filename,'r');

varNames = {'resourceid ','projectid','vendorid','vendor_name',...
    'project_resource_type','item_name','item_number','item_unit_price',...
    'item_quantity'};
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
dataFormat = '%q%q%q%q%q%q%f%f%f';
% Modify format string to only import requested columns
dataFormat = cellstr(reshape(dataFormat,2,[])');
varsNotImported = setxor(allVars,varsToImport);
for i = 1:length(varsNotImported)
    dataFormat{varsNotImported(i)} = ...
        [dataFormat{varsNotImported(i)}(1) '*' dataFormat{varsNotImported(i)}(2)];
end
formatSpec = strjoin(dataFormat','');

delimiter = ',';
nlines = 3667623;

dataArray = textscan(fileID, formatSpec, nlines, ...
    'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false,...
    'TreatAsEmpty',{'""'});

% Put data in a table container
res_data = table(dataArray{1:end},'VariableNames',varNames(varsToImport));
clearvars('dataArray');

% Save memory - categorical variables
categoricalVars = [5];
ordinalVars = [];
for j = 1:length(categoricalVars)
    ismem = ismember(categoricalVars(j),varsToImport);
    if ismem
        if ismember(j,ordinalVars)
            res_data.(varNames{categoricalVars(j)}) = ...
                categorical(res_data.(varNames{categoricalVars(j)}),...
                'Ordinal',true);
        else
            res_data.(varNames{categoricalVars(j)}) = ...
                categorical(res_data.(varNames{categoricalVars(j)}));
        end
    end
end

%%
fclose(fileID);