function L=skin4(t) 
rgbImage=imread(t); 
cform = makecform('srgb2lab');
lab_Image = applycform(im2double(rgbImage),cform);
	
% Extract out the color bands from the original image
% into 3 separate 2D arrays, one for each color component.
LChannel = lab_Image(:, :, 1); 
aChannel = lab_Image(:, :, 2); 
bChannel = lab_Image(:, :, 3); 
% Get the average lab color value.
[LMean, aMean, bMean] = GetMeanLABValues(LChannel, aChannel, bChannel, mask);
lRef = LMean(indexOfReferenceImage);
aRef = aMean(indexOfReferenceImage);
bRef = bMean(indexOfReferenceImage);
% Then compute deltas of all images to that
deltaLs = LMean = lRef; % Is an array if LMean is an array.
deltaas = aMean = aRef; % Is an array if aMean is an array.
deltabs = bMean = bRef; % Is an array if bMean is an array.
% Now compute all delta Es
deltaEs = sqrt(deltaLs.^2 + deltaas.^2 + deltabs.^2);
% Find ones with large color differences
badImages = find(deltaEs > 5); % Images greater than 5 delta E from the ref.