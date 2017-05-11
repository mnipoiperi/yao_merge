videoname = '..\video\sky.mp4';
framename = '..\frame\sky\im';

vidObj = VideoReader(videoname);
numFrames = 0;
zerostr = '0000';
while hasFrame(vidObj)
    img = readFrame(vidObj);
    numFrames = numFrames+1;
    
    img = imresize(img, 0.5);
    %img = img(100:484, 140:930,:);%down_wen1
    %img = img(159:958, 472:1917,:); %down_wen2
    imwrite(img, [framename, zerostr(1:4-floor(log10(numFrames))), int2str(numFrames), '.png']);
end

