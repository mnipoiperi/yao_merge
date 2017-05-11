framename = '..\frame\fly_wen2_align_crop\im';
framename_s = '..\frame\fly_wen2_align_scribble\im';
outname = '..\out\fly_wen2\im';
addpath('..\code\spectralMattingCode');

numFrame = 394;

save_partial_results = 0;
eigs_num=50;
do_grouping = 1;
nclust =10;

zerostr = '0000';
for i=141:numFrame
    img = imread([framename, zerostr(1:4-floor(log10(i))), int2str(i), '.png']);
    img = im2double(img);
    img_s = imread([framename_s, zerostr(1:4-floor(log10(i))), int2str(i), '.png']);
    img_s = im2double(img_s);
    [alpha_comps,alpha] = SpectralMatting(img,img_s, [], eigs_num, nclust,[], save_partial_results);
    
     imwrite(alpha, [outname zerostr(1:4-floor(log10(i))), int2str(i) '.png']);
end
