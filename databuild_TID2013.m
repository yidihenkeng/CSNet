close all;
clear;
%[a]=textread('D:\likaiwen\network_TID2013\tid2013\mos_std.txt','%7s');
%std = [];
%for i = 1:3000
   % s = a{i};
    %s = str2num(s)*10;
    %std = [std s];
%end

%读取数据库的数据
A=load('D:\likaiwen\network_TID2013\mos.mat'); 
mos=A.mos;%每幅图的DMOS
B=load('D:\likaiwen\network_TID2013\std.mat'); 
std=B.std;%每幅图的DMOS
name=load('D:\likaiwen\network_TID2013\name.mat');
name=name.image_name;%所有图像的名字
ref = [];
num = 0;
count = 0;
%a=randperm(25,5)
for i = 1:25
    for j = 1:24
        if (i>=2&&i<=6) ||(i>=8&&i<=9) || (i>=11&&i<=15)|| (i>=17&&i<=18)|| (i>=20&&i<=25)     %train
        %if i==4||i==10||i==14||i==16||i==23     %test
            for k = 1:5
                count = count+1;
                ref= [ref count];
            end
        else
            count=count+5;
        end
    end
    %end
end
for allnumber = 1:2400
    i = ref(allnumber);
    st1 = name{i};
    str1=['D:\likaiwen\network_TID2013\tid2013\distorted_images\' num2str(st1)];
    img1 = imread(str1);
    %img1 = rgb2gray(img1);
    num = num+1;
    %imwrite(img1,strcat('D:\likaiwen\network_TID2013\network3_4_13\ref3_img_test\',int2str(num),'_',num2str(mos(i)),'.bmp'));
    imwrite(img1,strcat('D:\likaiwen\network_TID2013\network3_4_8\ref3_img_train\',int2str(num),'_',num2str(mos(i)),'_',num2str(std(i)),'.bmp'));
end
                        