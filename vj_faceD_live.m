% created and coded by Abhishek Gupta (abhishekgpt10@gmail.com)
function vj_faceD_live(std,mean)
imaqreset;
close all
clc
std_2=0;
mean_2=0;
tlrnce=7;
while (1==1)
    choice=menu('Face Recognition',...
            'Real time recognition',...
            'Track last recognised face',...
            'Exit');
        
        if (choice==1) 
            [std,mean]= recog_trck();
        end
        if(choice==2)
            [std,mean]= recog_lasttrck();
        end
        if(choice==3)
            return
        end
end
%Detect objects using Viola-Jones Algorithm
vid = videoinput('winvideo',1,'YUY2_320x240'); 
set(vid,'ReturnedColorSpace','rgb');
set(vid,'TriggerRepeat',Inf); 
vid.FrameGrabInterval = 1; 
vid.FramesPerTrigger=20;

figure; % Ensure smooth display 
set(gcf,'doublebuffer','on'); 
start(vid);

while(vid.FramesAcquired<=200);


FDetect = vision.CascadeObjectDetector;  %To detect Face
I = getsnapshot(vid);  %Read the input image
BB = step(FDetect,I);  %Returns Bounding Box values based on number of objects
hold on

if(size(BB,1) == 1)
    I2=imcrop(I,BB);
    gray_face=rgb2gray(I2);
    std_2 = std2(gray_face);
    mean_2 = mean2(gray_face);
    %figure(1),imshow(gray_face);
end

figure(2),imshow(I); 
title('Face Recognition');
display(std);
display(mean);
display(std_2);
display(mean_2);
for i = 1:size(BB,1)
    
   if((((std_2<=(std+tlrnce))&&(std_2>=(std-tlrnce))))&&((mean_2<=(mean+tlrnce))&&(mean_2>=(mean-tlrnce))))
       rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','g');
       display('DETECTED');
   else
       rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
       display('NOT DETECTED');
   end
hold off;
flushdata(vid);
end
end
stop(vid);