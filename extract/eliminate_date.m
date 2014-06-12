function Training_Data = eliminate_date(Training_Data)

    %%
    %is exciting
    training_set = Training_Data.date_posted < datenum('2010-01-01');
    Training_Data.is_exciting(training_set) = categorical(0);
    
    %%
    %fully funded
    %the same before 2010 01 01
    Training_Data.fully_funded(training_set) = categorical(0);
    
    %%
    %at_least_1_teacher_referred_donor
    %do nothing
    
    %%
    %great chat
    %do nothing
    
    %%
    %at_least_1_green_donation
    %eliminate before 2008
    training_set = Training_Data.date_posted < datenum('2008-01-01');
    Training_Data.at_least_1_green_donation(training_set) = categorical(0);
    
    %%
    %three_or_more_non_teacher_referred_donors
    %do nothing
    
    %%
    %one_non_teacher_referred_donor_giving_100_plus
    %do nothing
    
    %%
    %donation_from_thoughtful_donor
    %eliminate before 2006
    training_set = Training_Data.date_posted < datenum('2006-01-01');
    Training_Data.donation_from_thoughtful_donor(training_set) = categorical(0); 
    
    
end