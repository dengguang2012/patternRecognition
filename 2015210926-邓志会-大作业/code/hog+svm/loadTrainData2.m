function [hog_train_label,hog_train_data]=loadTrainData2()
    hog_train_label=[];
    hog_train_data=[];
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
    
%     hog_train_data=zeros(7000,44764);
% hog_train_label=zeros(7000,1);
    train2Num=zeros(size(classes),1);
    
    iTrainNo=1;
    cellSize=8;
    for i=1:size(train)
        imgname = sprintf('food-10/images/%s.jpg',train{i});
        Img = imread(imgname);
        J=rgb2gray(Img);
        w=size(J,2);
        h=size(J,1);
        if h>=400
            h1=100;
            h2=399;
        elseif h>300 & h<400
            h1=1;
            h2=300;
        else
            continue;
        end;
        if w>=400
            w1=100;
            w2=399;
        elseif w>300 & w<400
            w1=1;
            w2=300;
        else
            continue;
        end;
        J=J(h1:h2,w1:w2);
        JTemp = J(1:2:300,1:2:300);
        J=single(JTemp);
        hog=vl_hog(J,cellSize,'verbose');
        ImagesTemp = reshape(hog,size(hog,1)*size(hog,2)*size(hog,3),1);
        %hog_train_data(iTrainNo,:) =
%         if size(ImagesTemp)<=44764
%             hog_train_data(iTrainNo,1:size(ImagesTemp)) = ImagesTemp;
%         else
%              hog_train_data(iTrainNo,1:44764) = ImagesTemp(1:44764);
%         end;
        hog_train_data(iTrainNo,:) = ImagesTemp';
        for j=1:size(classes)
            if size(findstr(train{i},classes{j}))~=0
                hog_train_label(iTrainNo,1)=j;
                break;
            end
        end
%         if iTrainNo >= 7000
%             break;
    
        iTrainNo=iTrainNo+1;
    end
%     hog_train_data=hog_train_data(1:iTrainNo-1,:);
%      hog_train_label=hog_train_label(1:iTrainNo-1);
end