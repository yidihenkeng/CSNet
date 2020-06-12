clc;
clear;
X = 100;
Y = 100;
stride = 50;

Train=[];
Label=[];
num=0;

fileExt = '*.bmp';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    files = dir(fullfile('D:\likaiwen\network_TID2013\network3_4_19\ref3_img_train\8\',fileExt));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_num = length(files);
for i = 1:file_num  
    i
    %读取图像名
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileName = strcat('D:\likaiwen\network_TID2013\network3_4_19\ref3_img_train\8\',files(i,1).name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    S=regexp(fileName,'\\','split');
    s=S(7);
    %分割出图像名中编号和标签
    str1=regexp(s,'_','split');
    img_num=str1{1,1}(1);
    img_num=str2num(img_num{1});
    str2 = str1{1,1}(2);
    str3 = regexp(str2,'_','split');
    label1 = str3{1,1}(1);
    label1 = str2num(label1{1});
    str4 = str1{1,1}(3);
    str5 = regexp(str4,'\.bmp','split');
    label2 = str5{1,1}(1);
    label2 = str2num(label2{1});
	label = [label1]';  %yiyuan
    %label = [label1+3*label2 label1-3*label2]'; %zhixin

        img = imread(fileName);
        [hei,wid] = size(img(:,:,1));
        for x = 1 : stride : hei-X+1
            for y = 1 :stride : wid-Y+1
                img0=zeros(X,Y,3);
                img0(1:X,1:Y,1)=img(x : x+X-1, y : y+Y-1,1);
                img0(1:X,1:Y,2)=img(x : x+X-1, y : y+Y-1,2);
                img0(1:X,1:Y,3)=img(x : x+X-1, y : y+Y-1,3);
                num=num+1;
                Train(:,:,:,num)=img0/255;
                Label=[Label label];
            end
        end 
end


index=randperm(num);
newTrain=zeros(X,Y,3,num);
newLabel=zeros(1,num); %yiyuan
%newLabel=zeros(2,num); %zhixin
for j=1:num
    newTrain(:,:,:,j)=Train(:,:,:,index(j));
    newLabel(:,j)=Label(:,index(j));
end

newLabel=newLabel/90;    %according to the range of the database
chunksz=100;
created_flag = true;
startloc = struct('dat',[1,1,1,1], 'lab', [1,1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file_path = 'D:\likaiwen\network_TID2013\network3_4_19\ref3_img_train\hdf5_100_14\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:num/chunksz
    k
    savepath = [file_path 'train_dmos_',num2str(k),'.h5'];
    batchdata = newTrain(:,:,:,(k-1)*chunksz+1:k*chunksz);
    batchlabel = newLabel(:,(k-1)*chunksz+1:k*chunksz);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabel, created_flag, startloc, chunksz);
end
