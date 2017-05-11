framename = '..\frame\fly_wen2_align';

numFrame = 302;
minx = 120;
maxx = 435;
miny = 82;
maxy = 947;
th = 100;
green = zeros(1,1,3); green(1,1,1) = 0; green(1,1,2) = 131; green(1,1,3) = 88;
back2 = zeros(1,1,3); back2(1,1,1) = 87; back2(1,1,2) = 105; back2(1,1,3) = 84;

zerostr = '0000';
for i=1:numFrame
    img = imread([framename '\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']);
    img = img(minx:maxx, miny:maxy,:);
    [h,w,~] = size(img);
    
    diff = double(img) - repmat(green, [h,w,1]);
    img_s = uint8(sum(abs(diff),3)>th)*255;
    
    diff = double(img) - repmat(back2, [h,w,1]);
    img_s( (sum(abs(diff),3)<60)==1 ) = 0;
    
    img_s = repmat(img_s, [1,1,3]);
    
    
    imwrite(img, [framename '_crop\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']);
    imwrite(img_s, [framename '_scribble\im' zerostr(1:4-floor(log10(i))), int2str(i) '.png']);
end
