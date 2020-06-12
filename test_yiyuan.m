clear;
close all;

caffe.reset_all();
caffe.set_mode_gpu();
caffe.set_device(1);

folder = 'D:\likaiwen\network_LIVEMD\network3_4_2\';
%model = [folder 'sort_net3_score_deploy_5conv_1.prototxt'];
model = [folder 'deploy_2.prototxt'];
mos = load('D:\likaiwen\network_LIVE\IVCMOS.mat');
mos = mos.mos;
%%%%%%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
weights = [folder 'sort_net3_5conv_7\sort_net_iter_34000.caffemodel'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net = caffe.Net(model,weights,'test');

X = 224;
Y = 224;
stride = 50;
feature = [];
label = [];
patch_num = 0; %图像块个数
image_count = 0;%图像个数


fileExt = '*.bmp';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files = dir(fullfile('D:\likaiwen\network_LIVEMD\network3_4_1\ref3_img_test\',fileExt));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_num = length(files);

temp = [];   %%%%%%%
Feature = [];
Label = [];
img_flag1 = [];
for i = 1:file_num
    
    %读取图像名
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileName = strcat('D:\likaiwen\network_LIVEMD\network3_4_1\ref3_img_test\',files(i,1).name);
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
        %img = rgb2gray(img);
        [hei,wid] = size(img(:,:,1));
        for x = 1 : stride : hei-X+1
            for y = 1 :stride : wid-Y+1
                img0=zeros(X,Y,3);
                img0(1:X,1:Y,1)=img(x : x+X-1, y : y+Y-1,1);
                img0(1:X,1:Y,2)=img(x : x+X-1, y : y+Y-1,2);
                img0(1:X,1:Y,3)=img(x : x+X-1, y : y+Y-1,3);
                patch_num=patch_num+1;
                img0 = img0/255;
                patch_score = net.forward({img0});     %从网络中获得图像块的分数
                I1 = patch_score{1,1}(1);
                %I2 = patch_score{1,1}(2);
                %I = (I1+I2)/2;
                patch_feature = [patch_feature I1];
            end
        end
        Maxvalue = mean(patch_feature);
        Feature = [Feature Maxvalue];     %拼接矩阵
        Label = [Label label1];
        image_count = image_count+1;
end
Feature = Feature';
Label = Label';
SPROCC=corr(Feature,Label,'type','Spearman')
CC1=corr(Feature,Label,'type','Pearson')

