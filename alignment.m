function [result] = alignment(img1, img2)

%% setting
[h, w, d] = size(img2);

%% find the alignment
% get feature and matching
img1_g = rgb2gray(img1);
img2_g = rgb2gray(img2);
pst1 = detectSURFFeatures(img1_g);
pst2 = detectSURFFeatures(img2_g);
[features1, validPts1] = extractFeatures(img1_g, pst1);
[features2, validPts2] = extractFeatures(img2_g, pst2);
index_pairs = matchFeatures(features1, features2);
matchedPst1 = validPts1(index_pairs(:,1));
matchedPst2 = validPts2(index_pairs(:,2));
y1 = matchedPst1.Location(:,2);
y2 = matchedPst2.Location(:,2);
x1 = matchedPst1.Location(:,1);
x2 = matchedPst2.Location(:,1);

%% RANSAC
[ST] = alignment_RANSAC(x1, x2, y1, y2, img1_g, 0.5);
tform1 = [ST(1) 0 0; 0 ST(1) 0; ST(2) ST(3) 1]; % sacle = 1

%% affine
tform1_aff = affine2d(tform1);
outputView = imref2d(size(img1_g) + [10 0]);
result = imwarp(img2, tform1_aff, 'OutputView', outputView, 'Interp', 'cubic');

%% crop
% WH = tform1' * [1 1 1; w h 1]'; WH((1:2)) = round(WH(1:2)); WH((4:5)) = round(WH(4:5));
% img2_crop = result(1:h, :,:);
% if(WH(2,1)>0)
%     img2_crop(1:WH(2,1),:,:) = img2(h-WH(2,1)+1:h,:,:);
% else
%     img2_crop(h+WH(2,1)+1:h,:,:) = img2(1:-WH(2,1),:,:);
% end

%% output
result = result(1:h, :,:);