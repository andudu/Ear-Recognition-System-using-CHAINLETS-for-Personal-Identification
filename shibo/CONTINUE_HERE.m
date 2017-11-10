%% This is the default execution file for the UERC 2017 toolkit, version 1.
% You do not need to change anything in this file. It should run out of the
% box.

clear;clc;

%% __ DATABASES ____________________________________________________________
% path = the path inside 'databases' folder to the database you want to use
% name = the label of the database to be shown in the output        
databases = [
%     struct( 'path', 'demo-check', ...
%             'name', 'Demo')
    struct( 'path', 'uerc-test', ...
            'name', 'UERC')
];

%% __ DB PREPROCESSOR ______________________________________________________
% path = the path inside 'databases' folder to the database you want to use
% name = the label of the database to be shown in the output
%
% if left blank THE DEFAULT VALUE IS
% preprocessor = struct('path', 'uerc_basic', 'name', 'Basic preprocessing');
preprocessor = [];

%% __ EXTRACTORS ___________________________________________________________
% Uncomment other methods if you would like to use another baseline. 

% path = the path inside 'extractors' folder to your .m files or to your
%        features files inside 'databases/[dbname]' folder
% name = the label to be shown in the output
% bulk_postproces[opt] = whether to call postprocess once or always
% distances: chi, euclidean, cosine, cityblock etc.
extractors = [ 
    struct('path', 'uerc_chainlets',         'name', 'CHAINLETS Baseline',      'distance', 'chi','bulk_postprocess', false)
%struct('path', 'features_vgg_fc6', 'name', 'VGG-16 Baseline',   'distance', 'cosine',   'bulk_postprocess', false)
   %struct('path', 'uerc_lbp',         'name', 'LBP Baseline',      'distance', 'cosine',      'bulk_postprocess', false)
     %struct('path', 'uerc_poem',        'name', 'POEM Baseline',     'distance', 'cosine',      'bulk_postprocess', false)
     %struct('path', 'uerc_hog',         'name', 'HOG Baseline',      'distance', 'cosine',      'bulk_postprocess', false)
     %struct('path', 'uerc_rand',        'name', 'Random',            'distance', 'cosine',      'bulk_postprocess', false)
%struct('path', 'SCAFFOLD', 'name', 'SCAFFOLD Baseline',   'distance', 'cosine',   'bulk_postprocess', false)

%struct('path', 'uerc_bsif', 'name', 'uerc_bsif Baseline',   'distance', 'cosine',   'bulk_postprocess', false)     
%struct('path', 'uerc_gabor', 'name', 'uerc_gabor Baseline',   'distance', 'cosine',   'bulk_postprocess', false)
%struct('path', 'uerc_lpq', 'name', 'uerc_lpq Baseline',   'distance', 'cosine',   'bulk_postprocess', false)
%struct('path', 'uerc_rilpq', 'name', 'uerc_rilpq Baseline',   'distance', 'cosine',   'bulk_postprocess', false)

     ];

%% __ LOG LEVEL ____________________________________________________________
% Log level = 0 lowest, 2 the most detailed level of logging
%
% if left blank THE DEFAULT VALUE IS
% log_level = 1;
log_level = [];

%% __ EXECUTE ______________________________________________________________
addpath('core');
uerc_init_and_run(databases, preprocessor, extractors, log_level);