function [hog_test_label,hog_test_data]=loadTestData2()
    hog_test_label=[];
    hog_test_data=[];
    fid=fopen('food-10/meta/classes.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1}=tline;
        tline=fgetl(fid);
    end
    fclose(fid);
    classes = tlines;
    
    fid = fopen('food-10/meta/test.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1}=tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    test=tlines;
    
%     hog_test_data=zeros(1500,44764);
%      hog_test_label=zeros(1500,1);
    test2Num=zeros(size(classes),1);
    
    itestNo=1;
    cellSize=8;
    for i=1:size(test)
        imgname = sprintf('food-10/images/%s.jpg',test{i});
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
        hog_test_data(itestNo,:) = ImagesTemp';
        for j=1:size(classes)
            if size(findstr(test{i},classes{j}))~=0
                hog_test_label(itestNo,1)=j;
                break;
            end
        end
%         if(itestNo>=1500)
%             break;
%         end;
        itestNo=itestNo+1;
    end
%     hog_test_data=hog_test_data(1:itestNo-1,:);
%      hog_test_label=hog_test_label(1:itestNo-1);
end