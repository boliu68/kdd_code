function donordata = Load_Donations(varNamesToImport, path)
%% Import donation data from csv file.
% This script imports donation data into a MATLAB table.  The donations.csv
% file has 3097989 rows of data in it, which takes ~2 mins to import.  The
% names of the variables in donations.csv are given on line 14.  The input 
% "varNamesToImport" is a cell array used to select which of these 
% variables are imported.
fprintf('Reading donations.csv ...\n');

%% Initialize variables for loading
filename = [path, '/donations.csv']; % Give full path to file if it's not on the MATLAB path
fileID = fopen(filename,'r');

varNames = {'donationid','projectid','donor_acctid','donor_city','donor_state','donor_zip','is_teacher_acct','donation_timestamp','donation_to_project','donation_optional_support','donation_total','dollar_amount','donation_included_optional_support','payment_method','payment_included_acct_credit','payment_included_campaign_gift_card','payment_included_web_purchased_gift_card','payment_was_promo_matched','via_giving_page','for_honoree','donation_message'};
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
dataFormat = '%q%q%q%q%q%q%q%q%f%f%f%q%q%q%q%q%q%q%q%q%q';
% Modify format string to only import requested columns
dataFormat = cellstr(reshape(dataFormat,2,[])');
varsNotImported = setxor(allVars,varsToImport);
for i = 1:length(varsNotImported)
    dataFormat{varsNotImported(i)} = ...
        [dataFormat{varsNotImported(i)}(1) '*' dataFormat{varsNotImported(i)}(2)];
end
dataFormat = strjoin(dataFormat','');
endLineFormat = '%[^\n\r]';
formatSpec = [dataFormat endLineFormat];

delimiter = ',';
nlines = 3097990;

% Read data according to format string.
dataArray = textscan(fileID, formatSpec, nlines, ...
    'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false);

% Put data in a table container
donordata = table(dataArray{1:end-1},'VariableNames',varNames(varsToImport));
clearvars('dataArray');

% Save memory: Variables that are categoricals
categoricalVars = [5 7 12:20];
for j = 1:length(categoricalVars)
    ismem = ismember(categoricalVars(j),varsToImport);
    if ismem
        donordata.(varNames{categoricalVars(j)}) = categorical(donordata.(varNames{categoricalVars(j)}));
    end
end

%%
fclose(fileID);