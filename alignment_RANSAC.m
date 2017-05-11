function [ ST ] = alignment_RANSAC( x1,x2,y1,y2,img1, ratio)

% settings
minpts = 3; % the smallest number of points required
epsilon = 5; % the threshold used to identify a point that fits well
inlierpts = length(y1)*ratio; % the number of nearby points required
iteration = 1000; % the number of iterations required
ST_best = [];

% iteration
for k=1:iteration
    %random
    numrand = randperm(length(y1), minpts);
    y1_rand = []; y2_rand = []; x1_rand = []; x2_rand = [];
    for i=1:minpts
        y1_rand = [y1_rand ; y1(numrand(i),:)];
        y2_rand = [y2_rand ; y2(numrand(i),:)];
        x1_rand = [x1_rand ; x1(numrand(i),:)];
        x2_rand = [x2_rand ; x2(numrand(i),:)];
    end
    %get matrix
    I2_rand = [x2_rand ones([minpts, 1]) zeros([minpts 1]); y2_rand zeros([minpts 1]) ones([minpts 1])];
    I1_rand = [x1_rand; y1_rand];
    %get one ST
    ST = I2_rand\I1_rand;
    %reduce outlier
    I1_new = [ [x2 ones([length(x2) 1]) zeros([length(x2) 1])]*ST [y2 zeros([length(x2) 1]) ones([length(x2) 1])]*ST ];
    distance = sqrt(sum((I1_new - [x1 y1]).^2,2));
    fitting = distance<=epsilon;
    % if the number of inlier points is enough
    if nnz(fitting)>inlierpts
        bestn = nnz(fitting);
        I2_new = [x2(fitting) ones([length(x2(fitting)) 1]) zeros([length(x2(fitting)) 1]) ; y2(fitting) zeros([length(y2(fitting)) 1]) ones([length(y2(fitting)) 1]) ];
        I1_new = [x1(fitting); y1(fitting)];
        ST = I2_new\I1_new;
        ST_best = ST;
        break;
    end
end


end

