%% Run a test on your own - using functionality from the toolkit
%
% This script shows how to generate a compliant similarity matrix for UERC,
% save the similarity matrix into the appropriate folder and then produce
% performance metrics based on the saved data.
% 
% Make sure you CD to the location of this file before you run it.
%
% Author: Vitomir Struc
% Date: 17.02.2017

%% Read the image names
file_names = 'databases/uerc-test/';
fid = fopen([file_names 'files.txt'],'r');
fnames = textscan(fid,'%s');
fnames = fnames{1};
fclose(fid);

% read the group.txt files - files corresponding to 1 are probes, the rest
% are galleries
group_names = 'databases/uerc-test/';
fid = fopen([file_names 'groups.txt'],'r');
gnames = textscan(fid,'%d');
gnames = gnames{1};
fclose(fid);


%% Read the data and extract LBP features
data_path = '../UERC 2017 Dataset/Test Dataset/';
feature_type_path = 'extractors/uerc_lbp/'; % we will use LBP features
addpath(feature_type_path)

% read one image to get data size
tmp = imread([data_path fnames{1}]); %read
tmp = rgb2gray(imresize(tmp,[100,100],'bilinear')); %resize and convert to gray-scale
feat = uerc_features_extract(tmp);
   

%load all images end extract features
featM = zeros(length(fnames),length(feat));
for i=1:length(fnames)
   tmp = imread([data_path fnames{i}]); %read
   [a,b,c] = size(tmp);
   if c==3
        tmp = rgb2gray(imresize(tmp,[100,100],'bilinear')); %resize and convert to gray-scale
   else
        tmp = (imresize(tmp,[100,100],'bilinear')); %resize 
   end
   featM(i,:) = uerc_features_extract(tmp);
end
disp('Finished with the feature extraction.')

%% Produce the similarity score matrix
n_probes = sum(gnames==1);
ind = find(gnames==1);

% we will use the cosine similarity, therefore we normalize the columns
% this is just to safe time
for i=1:length(fnames)
    featM(i,:)=featM(i,:)/sqrt(featM(i,:)*featM(i,:)');
end

% Let's compute the similarity matrix
sim_matrix = zeros(n_probes,length(fnames));
for i=1:n_probes
    sim_matrix(i,:) = 1 - featM(ind(i),:)*featM';
end
disp('Similarity matrix done.')


%% Write the result to a txt file 
% and place it in the "Put Your Similarity Matrix Here" folder. You can
% then run the rate_my_matrix.m on your matrix to get results.

output_folder = '../UERC 2017 Dataset/Put Your Similarity Matrix Here/';
dlmwrite([output_folder 'distancesA2A_lbp_result.txt'],sim_matrix, ' ');













