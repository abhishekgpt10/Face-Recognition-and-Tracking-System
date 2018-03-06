function [std_f,mean_f] = recog_trck()
imaqreset;

close all;
clc;
i=1;
n=5;
global std
global mean
std=0;mean=0;
vid = videoinput('winvideo',1,'YUY2_320x240');
while (1==1)
    choice=menu('Face Recognition',...
            'Taking photos for recognition',...
            'Exit');
        if (choice==1) 
            FDetect = vision.CascadeObjectDetector;
            preview(vid);
            while(i<(n+1))
                choice2=menu('Face Recognition',...
                    'Capture');
                
                if(choice2==1)
                    g=getsnapshot(vid);
                    
                    %saving rgb image in specified folder
                    rgbImage=ycbcr2rgb(g);
                    str=strcat(int2str(i),'f.jpg');
                    fullImageFileName = fullfile('E:\New Folder\',str);
                    imwrite(rgbImage,fullImageFileName);
                    BB = step(FDetect,rgbImage);
                    I2=imcrop(rgbImage,BB);
                    %saving grayscale image in current directory
                    grayImage=rgb2gray(I2);
                    Dir_name=fullfile(pwd,str);
                    imwrite(grayImage,Dir_name);
                    std = (std+std2(grayImage));
                    mean =(mean+mean2(grayImage));
                    i=(i+1);
                end
                std_f=(std/n)
                mean_f=(mean/n)
            end
         end
            closepreview(vid);
            if (choice==2)
                std_f=(std/5)
                mean_f=(mean/5)
            return;
            end
end
end