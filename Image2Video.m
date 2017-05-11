framename = '..\out\sky_fly_wen2\im';
videoname = '..\out\sky_fly_wen2';

numFrame = 316;

vidObj = VideoWriter(videoname);
open(vidObj);
zerostr = '0000';
for i=1:numFrame
    img = imread([framename, zerostr(1:4-floor(log10(i))), int2str(i), '.png']);
    writeVideo(vidObj, img);
end

close(vidObj);

