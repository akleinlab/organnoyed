function segmentImg
% N. Tallapragada and A.M. Klein -- June 2015
% Code to segment 5D organoid images into foreground and background
% This thresholding is necessary to reconstruct 
% the organoid surface from the image

%% Load headers
addpath('bfmatlab')
addpath('imoverlay')

%% Load image
image_5d = loadImg;

numSlices = size(image_5d,3);
numChan = size(image_5d,4);
image_5d_norm = mat2gray(image_5d(:,:,1:numSlices,1:numChan,1));
image_comp = sum(image_5d_norm,4);

%% Auto-threshold each stack


% image_comp = imdilate(image_comp,strel('disk',5));
% for slice = 1:numSlices
%     image_thresh(:,:,slice) = image_comp(:,:,slice) > 0.7*multithresh(image_comp(:,:,slice));
% end
% im2 = imdilate(image_thresh,strel('disk',2));
% im3 = imfill(bwareaopen(im2,200),'holes');
% im4 = imopen(imclose(im3,strel('disk',10)),strel('disk',10,0));
% for slice = 1:numSlices
%     im5(:,:,slice) = edge(im4(:,:,slice));
% end
% imshow(imoverlay(image_5d(:,:,5,1,1),im5(:,:,5),[],[],[1 1 0]));

%     
%     %im1 = imdilate(im,strel('disk',5));
%     im1 = im>0.7*multithresh(im); % Threshold image
%     im2 = imdilate(im1,strel('disk',2)); % Dilate pixels
%     im3 = bwareaopen(im2,200); % Remove small objects
%     im3 = imfill(im3,'holes');
%     im4 = imopen(imclose(im3,strel('disk',10)),strel('disk',10,0)); %
%     im5 = edge(im4); %
%     vout(:,:,ceil(k/2))=im5;
% %     figure, imshow(im,[]), title('im0')
% %     figure, imshow(im1,[]), title('im1')
% %     figure, imshow(im2,[]), title('im2')
% %     figure, imshow(im3,[]), title('im3')
% %     figure, imshow(im4,[]), title('im4')
%     figure, imshow(imoverlay(im,im5,[],[],[1 1 0])); title('im5')
% end

%%
