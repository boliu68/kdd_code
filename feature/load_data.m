function [project_data, outcome_data, essay_data, donation_data] = load_data(path, project_attribute, essay_attribute,...
        outcome_attribute, donation_attribute)

    %%
    %Put the function of load different data into one file.
    %Author: BO Liu
    %EMail: bliuab@ust.hk
    %Use the code shared on Kaggle forum

    %%
%     donation_attribute = {'donationid','projectid' ,'donor_acctid' ,'donor_city',...
%     'donor_state' ,'donor_zip' ,'is_teacher_acct', 'donation_timestamp' ,...
%     'donation_to_project','donation_optional_support' ,'donation_total' ,...
%     'dollar_amount' ,'donation_included_optional_support' ,'payment_method' ,...
%     'payment_included_acct_credit' ,'payment_included_campaign_gift_card' ,...
%     'payment_included_web_purchased_gift_card' ,'payment_was_promo_matched' ,...
%     'via_giving_page' ,'for_honoree' ,'donation_message' };
%     %
%     essay_attribute = {'projectid','teacher_acctid','title','short_description',...
%     'need_statement','essay'};
%     %
%     outcome_attribute = {'projectid','is_exciting' ,'at_least_1_teacher_referred_donor',...
%     'fully_funded' ,'at_least_1_green_donation' ,'great_chat' ,...
%     'three_or_more_non_teacher_referred_donors' ,'one_non_teacher_referred_donor_giving_100_plus' ,...
%     'donation_from_thoughtful_donor' ,'great_messages_proportion' ,'teacher_referred_count' ,'non_teacher_referred_count' }; 
%     %
%     project_attribute = {'projectid','teacher_acctid' ,'schoolid' ,'school_ncesid' ,...
%     'school_latitude' ,'school_longitude' ,'school_city' ,'school_state' ,...
%     'school_zip' ,'school_metro' ,'school_district' ,'school_county' ,...
%     'school_charter' ,'school_magnet' ,'school_year_round' ,'school_nlns' ,...
%     'school_kipp' ,'school_charter_ready_promise' ,'teacher_prefix' ,...
%     'teacher_teach_for_america' ,'teacher_ny_teaching_fellow' ,...
%     'primary_focus_subject' ,'primary_focus_area' ,'secondary_focus_subject' ,...
%     'secondary_focus_area' ,'resource_type' ,'poverty_level' ,'grade_level' ,...
%     'fulfillment_labor_materials' ,'total_price_excluding_optional_support' ,...
%     'total_price_including_optional_support' ,'students_reached' ,...
%     'eligible_double_your_impact_match' ,'eligible_almost_home_match' ,'date_posted' };  
%     %
%     %preprocessing
    project_data = Load_Projects(project_attribute, path);
    essay_data = Load_Essays(essay_attribute, path);
    outcome_data = Load_Outcomes(outcome_attribute, path);
    donation_data = [];%Load_Donations(donation_attribute, path);
    
    %sort the tables
    project_data = sortrows(project_data, 'projectid');
    essay_data = sortrows(essay_data, 'projectid');
    outcome_data = sortrows(outcome_data, 'projectid');
    %donation_data = sortrows(donation_data, 'projectid');

end