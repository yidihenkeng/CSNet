close all;
clear;

%读取数据库的数据
%A=load('D:\likaiwen\network\network3\LIVE\dmos.mat'); 
%dmos=A.dmos;%每幅图的DMOS
%B=load('D:\likaiwen\network_LIVE\std_csiq.mat'); 
%std=B.std;%每幅图的DMOS
%%%%%%%%%%%%%%%%%%%%
B=load('D:\likaiwen\network\network3\LIVE\dmos_realigned.mat'); 
dmos = B.dmos_new;
std = B.dmos_std;
%%%%%%%%%%%%%%%%%%%%
name=load('D:\likaiwen\network\network3\LIVE\refnames_all.mat');
refname=name.refnames_all;%所有图像的名字
dirs1=dir('D:\likaiwen\network\network3\LIVE\refimgs\*.bmp');%读取参考图的信息

num = 0;
refname_number = [];
number = 0;
ref = [];
%a=randperm(29,23); 
%a=[1 2 3 4 5 7 10 11 12 13 14 15 16 17 18 20 21 22 23 25 26 27 28];   %train
b=[3 8 10 13 18 20];        %test
for refnum = 1:6
    %f = a(refnum);
    f = b(refnum);
    %f = refnum;
    for i = 1:982
        if strcmp(refname{i},dirs1(f).name)
            number=number+1;
            ref(number) = i;
        end
    end
end
for allnumber = 1:number
    i = ref(allnumber);
    if i>=1&&i<=227
        str1=['D:\likaiwen\network\network3\LIVE\jp2k\' 'img' int2str(i)  '.bmp'];
    elseif i>=228&&i<=460
        str1=['D:\likaiwen\network\network3\LIVE\jpeg\' 'img' int2str(i-227)  '.bmp'];
    elseif i>=461&&i<=634
        str1=['D:\likaiwen\network\network3\LIVE\wn\' 'img' int2str(i-460)  '.bmp'];
    elseif i>=635&&i<=808
        str1=['D:\likaiwen\network\network3\LIVE\gblur\' 'img' int2str(i-634)  '.bmp'];
    else
        str1= ['D:\likaiwen\network\network3\LIVE\fastfading\' 'img' int2str(i-808)  '.bmp'];
    end
    img1 = imread(str1);
    %img1 = rgb2gray(img1);
    %[hei,wid] = size(img1(:,:,1));
    %img0 = zeros(hei,wid,3);
    %img0(:,:,1) = img1(:,:,1);
    %img0(:,:,2) = img1(:,:,2);
    %img0(:,:,3) = img1(:,:,3);
    %img0 = uint8(img0);
    num = num+1;
    imwrite(img1,strcat('D:\likaiwen\network_LIVE\network3_4_10\ref3_img_test\',num2str(num),'_',num2str(dmos(i)),'.bmp')); 
    %imwrite(img1,strcat('D:\likaiwen\network_LIVE\network3_4_11\ref3_img_train\',num2str(num),'_',num2str(dmos(i)),'_',num2str(std(i)),'.bmp'));
end
                        