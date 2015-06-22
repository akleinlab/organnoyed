addpath('../bfmatlab/')
fname = '/Users/allon/Desktop/Zeiss LSM880 organoid trials/organoid uncleared smaller.czi';
%fname = '/Users/allon/Desktop/Nikon A1R (Point Scanner) Confocal Trial images/z_001.nd2';
V = bfOpen3DVolume(fname);

%%
v = double(V{1}{1});

%%
for k=1:2:size(v,3)
    im = v(:,:,k);
    im = (im-min(im(:)))/(max(im(:))-min(im(:))); % Normalize image
    im0 = v(:,:,k+1);
    im0 = (im0-min(im0(:)))/(max(im0(:))-min(im0(:))); % Normalize image
    im = im + im0;
    im = (im-min(im(:)))/(max(im(:))-min(im(:))); % Normalize image
    
    %im1 = imdilate(im,strel('disk',5));
    im1 = im>0.7*multithresh(im); % Threshold image
    im2 = imdilate(im1,strel('disk',2)); % Dilate pixels
    im3 = bwareaopen(im2,200); % Remove small objects
    im3 = imfill(im3,'holes');
    im4 = imopen(imclose(im3,strel('disk',10)),strel('disk',10,0)); %
    im5 = edge(im4); %
    vout(:,:,ceil(k/2))=im5;
%     figure, imshow(im,[]), title('im0')
%     figure, imshow(im1,[]), title('im1')
%     figure, imshow(im2,[]), title('im2')
%     figure, imshow(im3,[]), title('im3')
%     figure, imshow(im4,[]), title('im4')
    figure, imshow(imoverlay(im,im5,[],[],[1 1 0])); title('im5')
end

%%
