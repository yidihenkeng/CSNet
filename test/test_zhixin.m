clear;
close all;

caffe.reset_all();
caffe.set_mode_gpu();
caffe.set_device(1);

folder = 'D:\likaiwen\network_LIVE\network3_4_kuaku\';
model = [folder 'sort_net3_score_deploy_5conv_2.prototxt'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
weights = [folder 'sort_net3_5conv_1_old\sort_net_iter_100000.caffemodel'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net = caffe.Net(model,weights,'test');

X = 100;
Y = 100;
stride = 50;
feature = [];
label = [];
patch_num = 0; %图像块个数
image_count = 0;%图像个数


fileExt = '*.bmp';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files = dir(fullfile('D:\likaiwen\network_LIVE\network3_4_kuaku\ref3_img_test_CSIQ\',fileExt));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_num = length(files);

temp = [];   %%%%%%%
Feature = [];
Label = [];
%Label = [4.7 4.3 3.3 2.8 2 4.3 3.3 2.6 1.9 1.4];     %IVC data 
%Label = [Label 4.4 3.3	2.5	1.5	1.1	4.6	3.7	2.3	1.0	1 4.5 3.7 2.4 1.4 1.1 4	3.3	2.4	1.7	1.1];
%Label = [Label 4.1	2.9	2.5	1.3	1	4.6	4.2	3.2	2.3	1.2	4.3	4.1	2.6	1.9	1.2];
%Label = [Label 4.9	4.2	3.7	2.7	1.2	4.5	3.6	2.5	1.8	1.1	4.3	3.7	2.9	1.5	1.4];
%Label = [Label 4	2.2	1.7	1.4	1.2	4.7	4	3.1	1.9	1.2	4.6	4.2	3.3	2.2	1.5	4.3	3.9	3.2	1.7	1.1];
%Label = [Label 4.7	4.3	3.4	2.1	1.2	4.7	4	3.3	1.6	1.2];
%Label = [Label 4.8	4.3	3.2	2.6	1.3	4.6	4.2	3.2	2.2	1.5 4.3	4	2.7	2	1.3];
%Label = [Label 4.5	2.9	1.8	1.7	1.2	4.9	4.2	3.1	2.2	1.3	4.3	3.7	2.3	1.5	1.1];
%Label = [Label 4.3	4.3	3.3	1.8	1.2 4.6	4.5	3.3	2.9	1.6	4.6	3.8	3	2.3	1.5];
%Label = [Label 4.7	4.3	3.3	2.5	1	3.6	3.5	2.8	1.7	1.3];
img_flag1 = [];
for i = 1:file_num
    
    %读取图像名
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileName = strcat('D:\likaiwen\network_LIVE\network3_4_kuaku\ref3_img_test_CSIQ\',files(i,1).name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    S=regexp(fileName,'\\','split');
    s=S(6);
    %分割出图像名中编号和标签
    str1=regexp(s,'_','split');
    img_num=str1{1,1}(1);
    img_num=str2num(img_num{1});
    str2 = str1{1,1}(2);
    str3 = regexp(str2,'.bmp','split');
    label1 = str3{1,1}(1);
    label1 = str2num(label1{1});
    patch_feature = [];
    i
        img = imread(fileName);
        img = rgb2gray(img);
        [hei,wid] = size(img(:,:,1));
        for x = 1 : stride : hei-X+1
            for y = 1 :stride : wid-Y+1
                img0=zeros(X,Y,1);
                img0(1:X,1:Y,1)=img(x : x+X-1, y : y+Y-1,1);
                %img0(1:X,1:Y,2)=img(x : x+X-1, y : y+Y-1,2);
                %img0(1:X,1:Y,3)=img(x : x+X-1, y : y+Y-1,3);
                patch_num=patch_num+1;
                img0 = img0/255;
                patch_score = net.forward({img0});     %从网络中获得图像块的分数
                I1 = patch_score{1,1}(1);
                I2 = patch_score{1,1}(2);
                I = (I1+I2)/2;
                patch_feature = [patch_feature I];
            end
        end
        Maxvalue = mean(patch_feature);
        %Maxvalue = 90 - mean(patch_feature)*90;
        Feature = [Feature Maxvalue];     %拼接矩阵
        Label = [Label label1];
        image_count = image_count+1;
end
Feature = Feature';
Label = Label';
SPROCC=corr(Feature,Label,'type','Spearman')
CC1=corr(Feature,Label,'type','Pearson')

