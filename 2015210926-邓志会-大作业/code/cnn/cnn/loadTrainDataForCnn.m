function [numTrainImages,trainLabels,trainImages]=loadTrainDataForCnn()
    trainLabels=[];
    trainImages=[];
    fid=fopen('food-10/meta/classes.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1}=tline;
        tline=fgetl(fid);
    end
    fclose(fid);
    classes = tlines;
    
    fid = fopen('food-10/meta/train.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1}=tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    train=tlines;
    
%     trainImages=zeros(7000,44764);
% trainLabels=zeros(7000,1);
    train2Num=zeros(size(classes),1);
    
    iTrainNo=1;
    cellSize=8;
    for i=1:size(train)
        imgname = sprintf('food-10/images/%s.jpg',train{i});
        Img = imread(imgname);
%         J=rgb2gray(Img);
        J=Img;
        w=size(J,2);
        h=size(J,1);
        if h>=420
            h1=100;
            h2=419;
        elseif h>320 & h<420
            h1=1;
            h2=320;
        else
            continue;
        end;
        if w>=420
            w1=100;
            w2=419;
        elseif w>320 & w<420
            w1=1;
            w2=320;
        else
            continue;
        end;
        J=J(h1:h2,w1:w2,:);
        JTemp = J(1:5:320,1:5:320,:);
        J=im2double(JTemp);
%         hog=vl_hog(J,cellSize,'verbose');
%         ImagesTemp = reshape(hog,size(hog,1)*size(hog,2)*size(hog,3),1);
        %trainImages(iTrainNo,:) =
%         if size(ImagesTemp)<=44764
%             trainImages(iTrainNo,1:size(ImagesTemp)) = ImagesTemp;
%         else
%              trainImages(iTrainNo,1:44764) = ImagesTemp(1:44764);
%         end;
        trainImages(:,:,:,iTrainNo) = J;
        for j=1:size(classes)
            if size(findstr(train{i},classes{j}))~=0
                trainLabels(iTrainNo,1)=j;
                break;
            end
        end
%         if iTrainNo >= 7000
%             break;
    
        iTrainNo=iTrainNo+1;
    end
    numTrainImages = iTrainNo-1;
%     trainImages=trainImages(1:iTrainNo-1,:);
%      trainLabels=trainLabels(1:iTrainNo-1);
end