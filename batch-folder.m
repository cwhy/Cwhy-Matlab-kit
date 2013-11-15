% For Graph Theory Parameters extraction for DTI Matrix
close all
clear all
clc
addpath('./lib/');

datafiles = dir(fullfile('..', 'data', 'original', '*.mat'));
datasets = cell(1,length(datafiles));
dataset_names = cell(1,length(datafiles));

for i = 1:length(datafiles)
    dataset_names{i} = datafiles(i).name;
    datasets{i} = load(['../data/original/',datafiles(i).name]);
end
%:length(datasets)
for i = 1:length(datasets)
    datafile_name = cell2mat(dataset_names(i));
    dataset_name = datafile_name(1:end-4);
    dataset = cell2mat(struct2cell(datasets{i}));
    [res,~,Sub] = size(dataset);
    strengths = zeros(res,Sub);
    
    h = waitbar(0,['Start analysis of ',dataset_name,' ...']);
    
    for sub = 1:Sub
        waitbar(sub/Sub,h);
        sub_data = dataset(:,:,sub);
        sub_data(sub_data<3) = 0;
        strengths(:,sub) = sum(sub_data);
    end
    
    csvwrite(['./results/csv/strength_',dataset_name,'.csv'],strengths);
    close(h);
end
