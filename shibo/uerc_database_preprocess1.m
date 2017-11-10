function [db, annotations] = uerc_database_preprocess(db, annotations)
	% preprocess applies preprocessing to 
	% each image in db for each db
	% 
	% Input:
	%    I              = ear image
	%    I_annotations  = annotation data for the image
	% 
	% Output:
	%    I              = modified ear image
	%    I_annotations  = modified annotation data

	% TODO calc average
    
    if (exist('single_scale_retinex','file'))
        uerccore_log('INFace is installed.\n', 2);
    else
        uerccore_log('INFace NOT installed. Attempting install ...\n', 2);
        
        addpath(genpath('libraries/INface_tool'));
        
        uerccore_log('INFace installed.\n', 2);
    end
    
    RES_factor = 100;
    
    strs = zeros(size(db, 1), 3*RES_factor*RES_factor);
    
    for i = 1:size(db, 1)
		I = db(i, :).image{1};
		if (size(annotations) > 0)
			annotations_row = annotations(i, :);
		else
			annotations_row = [];
		end
		%{
		if (size(I, 3) == 3)
				I = rgb2gray(I);
		end
        %}
        
		I = imresize(I, [RES_factor RES_factor]);
        %I = histeq(I);
        %I =rgb2gray(I);
		I = double(I);
       
        
        if size(I,3)==1
            I=histeq(I);
           I=cat(3, I, I, I); 
           
        end
		
        %}
        %I = single_scale_retinex(I);
        
        strs(i, :) = I(:);
        db(i, :).image{1} = I;
    end
    
    [~, ns] = unique(strs, 'rows');
    
    to_del = setdiff(1:size(strs, 1), ns);
    db(to_del, :) = [];
    uerccore_log(['Number of duplicates in DB ignored: ', num2str(length(to_del))], 1);
     %disp 'ENTER *************** 2222222222 ***************************************'
end