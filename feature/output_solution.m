function output_solution(projectid, pred)
    %%
    %output the predicted probability with respect to projectid
    outData = [projectid num2cell(pred)]';
    
    formatSpec = '%s,%f\n';
    time_record = clock;
    fileID = fopen(['my_submission_',num2str(time_record(1)),'_',num2str(time_record(2)),'_',...
        num2str(time_record(3)),'_',num2str(time_record(4)),'_',num2str(time_record(5)),'.txt'],'w');
    fprintf(fileID,'projectid,is_exciting\n'); % Header line
    fprintf(fileID,formatSpec,outData{:,:}); % Data
    fclose(fileID);
    
end