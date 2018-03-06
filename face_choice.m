% created and coded by Abhishek Gupta (abhishekgpt10@gmail.com)
imaqreset;
clear all;
close all;
clc;
i=1;
global M;   %input no. of faces
global face_id
times=5;   %no. of pics capture for an individual
N=4;   %default no. of faces
vid = videoinput('winvideo',1,'YUY2_320x240');

while (1==1)
    choice=menu('Face Recognition',...
        'Generate database',...
        'Recognize face from drive',...
        'Recognize face from camera',...
        'Track face from camera',...
        'Track the recognized face from camera',...
        'Exit');
    
    if (choice==1)
        choice1=menu('Face Recognition',...
            'Enter no. of faces',...
            'Exit');
        if (choice1==1)
            M=input('Enter : ');
            preview(vid);
            while(i<((M*times)+1))
                choice2=menu('Face Recognition',...
                    'Capture');
                
                if(choice2==1)
                    g=getsnapshot(vid);
                    
                    %saving rgb image in specified folder
                    rgbImage=ycbcr2rgb(g);
                    str=strcat(int2str(i),'.jpg');
                    fullImageFileName = fullfile('E:\New Folder\',str);
                    imwrite(rgbImage,fullImageFileName);
                    
                    %saving grayscale image in current directory
                    grayImage=rgb2gray(rgbImage);
                    Dir_name=fullfile(pwd,str);
                    imwrite(grayImage,Dir_name);
                    i=(i+1);
                end
            end
            closepreview(vid);
        end
        
        if (choice1==2)
            clear choice1;
        end
        
    end
    
    if(choice==2)
        if(isempty(M)==1)
            default=N*times;
            face_id=recognize_face_drive((default));
        else
            faces=M*times;
            face_id=recognize_face_drive(faces);
        end
    end
    
    if(choice==3)
        if(isempty(M)==1)
            default=N*times;
            face_id=recognize_face_cam(default);
        else
            faces=M*times;
            face_id=recognize_face_cam(faces);
        end
    end
    
    if (choice==4)
        vj_track_face();
    end
     
    if (choice==5)
        vj_faceD_live();
    end
    
    if (choice==6)
        close all;
        return;
    end
end
stop(vid);