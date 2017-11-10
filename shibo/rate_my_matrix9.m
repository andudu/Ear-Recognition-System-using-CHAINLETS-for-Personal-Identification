%% Rate my matrix
% This file produces results based on the input similarity matrix that
% contains values delimited by spaces
%
% simply set myMatrix location to the MY_MATRIX_LOCATION
global uerc;
uerc.VERSION = '1.0';
uerc.databases_path = 'databases/';
uerc.preprocessor_path = 'preprocessors/';
uerc.extractors_path = 'extractors/';
uerc.models_path = 'models/';
uerc.file_endings = {'png', 'jpg', 'bmp'};
uerc.annotations_file_name = 'annotations.json';
uerc.temp_path = '_output/temp/';
uerc.results_path = '_output/results/';
uerc.calculated_features_path = '_output/calculated_features/';
uerc.run_id = datestr(now,'yyyymmdd-HHMM-SSFFF');
uerc.results_header_set = 0;
uerc.norm_features = 1;
uerc.plots = struct();
uerc.log_level = 2;
uerc.current_parameter_set = [];
uerc.parameter_path = '';

% Automatically different colors
addpath(genpath('libraries/colors'));
uerc.plot_colors = distinguishable_colors(20);

DATASET_LOCATION = 'databases/uerc-test/';

%MY_MATRIX_LOCATION = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-CHAINLETS00 Baseline-.txt';

MY_MATRIX_LOCATION1 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-LBP Baseline-.txt';

MY_MATRIX_LOCATION2 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-POEM Baseline-.txt';
%{
MY_MATRIX_LOCATION3 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-bsif Baseline-.txt';
MY_MATRIX_LOCATION4 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-Gabor Baseline-.txt';
MY_MATRIX_LOCATION5 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-lpq Baseline-.txt';
MY_MATRIX_LOCATION6 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-rilpq Baseline-.txt';
MY_MATRIX_LOCATION7 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distanceA2A-UERC-HOG Baseline-.txt';
%MY_MATRIX_LOCATION2 = '/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/_output/results/chainlets/distancesA2A_chainlets2_result.txt';

%}
%}
% The formatted names, that are used in the results section
DATASET_NAME = 'UERC'; % no dashes or slashes
%METHOD_NAME={'CHAINLETS','LBP','POEM','bsif','Gabor','lpq','rilpq','HOG'};
%METHOD_NAME = 'VGG-16 Baseline';
%mtrx={MY_MATRIX_LOCATION,MY_MATRIX_LOCATION1,MY_MATRIX_LOCATION2,MY_MATRIX_LOCATION3,MY_MATRIX_LOCATION4,MY_MATRIX_LOCATION5,MY_MATRIX_LOCATION6,MY_MATRIX_LOCATION7};
%mtrx={MY_MATRIX_LOCATION,MY_MATRIX_LOCATION1,MY_MATRIX_LOCATION2,MY_MATRIX_LOCATION3,MY_MATRIX_LOCATION4,MY_MATRIX_LOCATION5,MY_MATRIX_LOCATION6,MY_MATRIX_LOCATION7};
%mx1='/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/dst5.txt';
mx2='/Users/adil/Documents/MATLAB/UERC 2017 Toolkit/dst6.txt';
METHOD_NAME={'LBP', 'POEM', 'CHAINLETS'};
mtrx={MY_MATRIX_LOCATION1,MY_MATRIX_LOCATION2,mx2};
addpath('core');
for i=1:3
distanceA2A = dlmread(mtrx{i});


if (exist([DATASET_LOCATION, 'files.txt'], 'file') == 2)
    dataGroups = dlmread([DATASET_LOCATION, 'groups.txt']);
    
    fileId = fopen([DATASET_LOCATION, 'files.txt']);
    filenames = textscan(fileId, '%s');
    filenames = filenames{1};
    fclose(fileId);

    r = cellfun(@(s) strsplit(s, '/'), filenames, 'UniformOutput', false);
    rClasses = cellfun(@(c) c(1), r);
    classesTmp = str2double(rClasses);
else
    disp('ERROR reading db info');
    return
end
         
classes = uint32(classesTmp);

cGy = classes(dataGroups==1, :);
cIy = classes(dataGroups==0, :);
classes = [cGy; cIy];

[output2D, target2D, classes_x, classes_y] = uerccore_distances_to_one_class(distanceA2A, classes);
classes_y = classes_y(1:size(output2D, 1), :); 

distances = struct();
distances.distanceA2A = distanceA2A;
distances.output2D = output2D;
distances.target2D = target2D;
distances.classes_x = classes_x;
distances.classes_y = classes_y;
distances.classes = classes;
distances.output = output2D(:);
distances.target = target2D(:);
distances.features_len = 2;



uerc.current_database = struct();
uerc.current_database.name = DATASET_NAME;
uerc.current_extractor = struct();
uerc.current_extractor.name = METHOD_NAME{i};
% uerc.current_extractor = struct();
% extractorNameArr = strsplit(MY_MATRIX_LOCATION, '/');
% extractorName = strrep(extractorNameArr(end), 'distanceA2A-', '');
% extractorName = strrep(extractorName, '.txt', '');
% uerc.current_extractor.name = extractorName{1};
% 
% uerc.current_database = struct();
% dbNameArr = strsplit(DATASET_LOCATION, '/');
% dbNameTmp = dbNameArr(end);
% if (isempty(dbNameTmp{1}))
%     dbName = dbNameArr(end-1);
% else
%     dbName = dbNameArr(end);
% end
% uerc.current_database.name = dbName{1};

uerccore_vizualize_roc_cmc(distances);

disp(['Results are stored in: ', uerc.results_path, uerc.run_id]);
end