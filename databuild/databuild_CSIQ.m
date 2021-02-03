close all;
clear;

%¶ÁÈ¡Êý¾Ý¿âµÄÊý¾Ý
%A=xlsread('D:\123\network\CSIQ_database\csiq.beta.xls');
[num,txt,raw]=xlsread('D:\123\network\CSIQ_database\csiq.beta.xlsx','all_by_image');
[num1,txt1,raw1]=xlsread('D:\123\network\CSIQ_database\csiq.beta.xlsx','all_by_distortion');
dmos =num1(:,9);
std = num1(:,8);
refname_number = [];
num=0;
dirsl=load('D:\123\network\name.mat');
dirsl=dirsl.dirsl;
number = 0;
ref = [];
for refnum = 1:30
    j = refnum
    %if (j>=1&&j<=6)     %test
    %if (j>=1&&j<=2)||(j>=6&&j<=25)||(j>=29&&j<=30)    %train
    if j==3||j==4||j==5||j==26||j==27||j==28
        for i = 2:867
            %if (i>=2&&i<=451)||(i>=602&&i<=751)
            a = raw1{i,3};
            b = dirsl{refnum};
            if strcmp(num2str(a),num2str(b))
                number=number+1;
                ref(number) = i;
            end
            %end
        end
    end
end

for allnumber = 1:number
    i = ref(allnumber);
    a=i-1;
    if i>=2&&i<=151
        st=raw1{i,3};
        if rem((i-1),5)==0
            i=5;
        else
            i=rem(i-1,5);
        end
        str1=['D:\123\network\CSIQ_database\distorted\awgn\' num2str(st) '.AWGN.' int2str(i)  '.png'];
    elseif i>=152&&i<=301
        st=raw1{i,3};
        if rem((i-1),5)==0
            i=5;
        else
            i=rem(i-1,5);
        end
        str1=['D:\123\network\CSIQ_database\distorted\jpeg\' num2str(st) '.JPEG.' int2str(i)  '.png'];
    elseif i>=302&&i<=451
        st=raw1{i,3};
        if rem((i-1),5)==0
            i=5;
        else
            i=rem(i-1,5);
        end
        str1=['D:\123\network\CSIQ_database\distorted\jpeg2000\' num2str(st) '.jpeg2000.' int2str(i)  '.png'];
    elseif i>=452&&i<=601
        st=raw1{i,3};
        if rem((i-1),5)==0
            i=5;
        else
            i=rem(i-1,5);
        end
        str1=['D:\123\network\CSIQ_database\distorted\fnoise\' num2str(st) '.fnoise.' int2str(i)  '.png'];
    elseif i>=602&&i<=751
        st=raw1{i,3};
        if rem((i-1),5)==0
            i=5;
        else
            i=rem(i-1,5);
        end
        str1=['D:\123\network\CSIQ_database\distorted\blur\' num2str(st) '.BLUR.' int2str(i)  '.png'];
    else
        st=raw1{i,3};
        s1 = dirsl{9};
        s2 = dirsl{13};
        s3 = dirsl{14};
        s4 = dirsl{26};
        if strcmp(num2str(st),num2str(s1))||strcmp(num2str(st),num2str(s2))||strcmp(num2str(st),num2str(s3))||strcmp(num2str(st),num2str(s4))
            if rem((i-1),3)==0
                i=3;
            else
                i=rem(i-1,3);
            end
        else
            if rem((i-1),4)==0
                i=4;
            else
                i=rem(i-1,4);
            end
        end  
        %%%%%
        str1=['D:\123\network\CSIQ_database\distorted\contrast\' num2str(st) '.contrast.' int2str(i)  '.png'];
    end
    img1 = imread(str1);
    %img1 = rgb2gray(img1);
    %[hei,wid] = size(img1);
    %img0 = zeros(hei,wid,3);
    %img0(:,:,1) = img1;
    %img0 = uint8(img0);
    num=num+1;
    imwrite(img1,strcat('D:\123\network_CSIQ\network3_4_12\ref3_img_test\',int2str(num),'_',num2str(dmos(a)),'.bmp'));
    %imwrite(img1,strcat('D:\123\network_CSIQ\network3_4_12\ref3_img_train\',int2str(num),'_',num2str(dmos(a)),'_',num2str(std(a)),'.bmp'));
end
                        
