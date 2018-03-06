% created and coded by Abhishek Gupta (abhishekgpt10@gmail.com)    
function vj_track_face()
    imaqreset;
    close all;
    clc
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
        BB = step(FDetect,I); %Returns Bounding Box values based on number of objects
     
        hold on

        figure(2),imshow(I);
        title('Face Detection');
        for i = 1:size(BB,1)

            rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','y');
            display(BB(1));
            display(BB(2));

            hold off;
            flushdata(vid);
        end
    end
    stop(vid);
    end