function image_5d = loadImg
% N. Tallapragada -- June 2015
% Code to convert a stack of confocal images of an organoid into a 5D array
% Cheese is so chunky

%% Load data and function arguments
data = bfopen;
imgData = data{1,1};

%% Calculate number of slices in stack from number of images and number of channels
numImgs = length(imgData);
% Number of channels is the last character in the string imgData{1,2} (if 2-digit, it's everything after the /)
numChan = str2num(imgData{1,2}(end));
numSlices = numImgs/numChan;

for chanNum = 1:numChan
    %% Build 5D array
    z_slice = 1;
    for img = chanNum:numChan:numImgs
        image_5d(:,:,z_slice,chanNum,1) = double(imgData{img,1});
        z_slice = z_slice + 1;
    end
end

end