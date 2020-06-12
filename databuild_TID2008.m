close all;
clear;
%[a]=textread('D:\likaiwen\network_TID2008\tid2008\mos_std.txt','%7s');
%std = [];
%for i = 1:1700
   % s = a{i};
    %s = str2num(s)*10;
    %std = [std s];
%end

%读取数据库的数据
A=load('D:\likaiwen\network_TID2008\mos.mat'); 
mos=A.mos;%每幅图的DMOS
B=load('D:\likaiwen\network_TID2008\std.mat'); 
std=B.std;%每幅图的DMOS
name=load('D:\likaiwen\network_TID2008\name.mat');
name=name.image_name;%所有图像的名字
ref = [];
num = 0;
count = 0;
for i = 1:25
    for j = 1:17
        %if i==1||i==3||(i>=5&&i<=9) ||(i>=11&&i<=15) ||(i>=17&&i<=22)||(i>=24&&i<=25)  %train
        if i==2 || i==4 ||i==10||i==16||i==23   %test
            if j<=13
                for k = 1:4
                    count = count+1;
                    ref= [ref count];
                end
            else 
                count = count+4;
            end
        else
            count=count+4;
            %break;
        end
    end
end
for allnumber = 1:1040
    i = ref(allnumber);
    st1 = name{i};
    str1=['D:\likaiwen\network_TID2008\tid2008\distorted_images\' num2str(st1)];
    img1 = imread(str1);
    %img1 = rgb2gray(img1);
    %[hei,wid] = size(img1);
    %img0 = zeros(hei,wid,3);
    %img0(:,:,1) = img1;
    %img0 = img1;
    %img0 = uint8(img0);
    num = num+1;
    imwrite(img1,strcat('D:\likaiwen\network_TID2008\network3_4_13\ref3_img_test\',int2str(num),'_',num2str(mos(i)),'.bmp'));
    %imwrite(img1,strcat('D:\likaiwen\network_TID2008\network3_4_12\ref3_img_train\',int2str(num),'_',num2str(mos(i)),'_',num2str(std(i)),'.bmp'));
end
                        