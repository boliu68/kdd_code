import os
import csv

def analysis_file(path):

    ##Author: Bo Liu
    ##raw data path

    donation_path = os.path.join(path, 'donations.csv')
    essays_path = os.path.join(path, 'essays.csv')
    outcome_path = os.path.join(path, 'outcomes.csv')
    projects_path = os.path.join(path, 'projects.csv')
    res_path = os.path.join(path, 'resources.csv')

    ##read the files

    donation_name, donation_data = read_file(donation_path)
    essays_name, essays_data = read_file(essays_path)
    outcome_name, outcome_data = read_file(outcome_path)
    projects_name, projects_data = read_file(projects_path)
    res_name, res_data = read_file(res_path)

    #print name
    # print 'Donatin:', donation_name
    # print 'Essays:', essays_name
    # print 'outcome:', outcome_name
    # print 'project:', projects_name
    # print 'Res:', res_name

    print 'Length of projects and outcome:', len(projects_data), len(outcome_data)


def extract_feature(donation_name, donation_data, essays_name, essays_data, outcome_name,
                    outcome_data, projets_name, projects_data, res_name, res_data):

    feature_name = ['project_id']

    #Extract unique project id
    project_id = []
    for feature in projects_data:
        project_id.append(feature[0])

    #Construct the groundtruth


def read_file(path):

    #read the file and return the feature dictionary
    #and the raw data
    csv_file = open(path, 'r')
    csv_reader = csv.reader(csv_file)

    line_id = 0
    data = []

    for row in csv_reader:
        if line_id == 0:
            feature_name = row
            #return feature_name

        else:
            feature = {}
            for feature_id in range(len(feature_name)):
                feature[feature_name[feature_id]] = row[feature_id]
            data.append(feature)

        line_id += 1

    return [feature_name, data]