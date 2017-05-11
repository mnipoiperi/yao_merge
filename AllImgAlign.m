clc, clear;
% setting
inputfilename = '..\frame\fly_wen2';
numFrames = 302;
zerostr = '0000';
% reference
i = randi(numFrames)
imgref = im2double(imread([inputfilename '\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']));
% all
for i=1:numFrames
    img2 = im2double(imread([inputfilename '\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']));
    result = alignment(imgref, img2);

    imwrite(result, [inputfilename '_align\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']);
end