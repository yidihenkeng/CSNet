close all;
clear;
%%%%%%%%%%%%%%%%%%%%
%B= load('D:\likaiwen\network_LIVEMD\MDID2013\dis_img.mat');
%A= load('D:\likaiwen\network_LIVEMD\MDID2013\dmos.mat');
%name = B.dis_img;
%dmos = A.MDID_dmos;
B = load('D:\likaiwen\network_LIVEMD\LIVEmultidistortiondatabase\To_Release\Part 2\Imagelists.mat');
A = load('D:\likaiwen\network_LIVEMD\LIVEmultidistortiondatabase\To_Release\Part 2\Scores.mat');
name = B.distimgs; 
dmos = A.DMOSscores;
std_data = A.dist_diffscores;
std_score = std(std_data,0);
num=450;
for i = 1:225
    %str1=['D:\likaiwen\network_LIVEMD\MDID2013\dst_img\' 'img' int2str(i) '.png'];
    n = name{i};
    str1=['D:\likaiwen\network_LIVEMD\LIVEmultidistortiondatabase\To_Release\Part 2\blurnoise\', n];
    img1 = imread(str1);
    %img1 = rgb2gray(img1);
    %[hei,wid] = size(img1);
    %img0 = zeros(hei,wid,3);
    %img0(:,:,1) = img1;
    %img0 = uint8(img0);
    num = num+1;
    %imwrite(img1,strcat('D:\likaiwen\network_LIVEMD\network3_4_1\ref3_img_test\',num2str(num),'_',num2str(dmos(i)),'.bmp'));
    imwrite(img1,strcat('D:\likaiwen\network_LIVEMD\network3_4_1\ref3_img_train\',num2str(num),'_',num2str(dmos(i)),'_',num2str(std_score(i)),'.bmp'));
end
                        