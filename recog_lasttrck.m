function [std_f,mean_f] = recog_lasttrck()
close all;
clc;
n=5;
global face_id
global std
global mean
std=0;mean=0;
i=face_id;
FDetect = vision.CascadeObjectDetector;
j=(i*n);
k=(j-n);
while(j>k)
    str=strcat(int2str(j),'.jpg');
    fullImageFileName = fullfile('E:\New Folder\',str);
    I=imread(fullImageFileName);
    BB = step(FDetect,I);                
    I2=imcrop(I,BB);
    
    grayImage=rgb2gray(I2);
    str2=strcat(int2str(j),'f.jpg');
    Dir_name=fullfile(pwd,str2);
    imwrite(grayImage,Dir_name);
    std = (std+std2(grayImage));
    mean =(mean+mean2(grayImage));
    j=(j-1);
end
 std_f=(std/n)
 mean_f=(mean/n)
end