function [classes,train,train2Num,ImagesTrain,imagesTest,test2Num] = loadData()

    fid=fopen('food-10/meta/classes.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1} = tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    classes = tlines;
    
    fid=fopen('food-10/meta/train.txt');
    tline = fgetl(fid);
    tlines = cell(0,1);
    while ischar(tline)
        tlines{end+1,1} = tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    train=tlines;
    train2Num=zeros(size(classes),1);

    iTrainNo=1;
    
    for i =1:size(train)
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
             end

             if w>=400
                 w1=100;
                 w2=399;
             elseif w>300 & w<400
                 w1=1;
                 w2=300;
             else
                continue;
             end
             J=J(h1:h2,w1:w2);
             JTemp=J(1:3:300,1:3:300);
%              JTemp2=zeros(30,30);
%              for j1=1:30
%                  for j2=1:30
%                      sumValue=double(0);
%                      count=0;
%                      for j3=-1:1
%                          for j4=-1:1
%                              if (j1+j3)>=1 & (j1+j3)<=30 & (j2+j4)>=1 & (j2+j4)<=30
%                                  sumValue=double (JTemp(j1+j3,j2+j4))+sumValue;
%                                  count=count+1;
%                              end
% 
%                          end
%                      end
%                      sumValue=sumValue/count;
%                      JTemp2(j1,j2)=uint8 (sumValue);
%                  end
%              end
%              JTemp2=uint8(JTemp2);
             ImagesTemp = reshape(JTemp,100*100,1);
             ImagesTrain(:,iTrainNo)=ImagesTemp;

             for j5=1:size(classes)
                 if size(strfind(imgname,classes{j5})) ~= 0
                     train2Num(j5)= train2Num(j5) + 1;
                 end
             end
             iTrainNo=iTrainNo+1;
    end
    
    test2Num=zeros(size(classes),1);%test文件中 每一类的个数
    
    fid = fopen('food-10/meta/test.txt');
    tline = fgetl(fid);
    tlines =  cell(0,1);
    while ischar(tline)
        tlines{end+1,1} = tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    test = tlines;
    iTestNo = 1;
    for i = 1:size(test)
        imgnameTest = sprintf('food-10/images/%s.jpg',test{i});
        ImgTest = imread(imgnameTest);
        JTest = rgb2gray(ImgTest);
        h=size(JTest,1);
        w=size(JTest,2);
        if h>=400
            h1=100;
            h2=399;
        elseif h>300 & h<400
            h1=1;
            h2=300;
        else
            continue;
        end

        if w>=400
            w1=100;
            w2=399;
        elseif w>300 & w<400
            w1=1;
            w2=300;
        else
            continue;
        end
        JTest = JTest(h1:h2,w1:w2);
        JTestTemp = JTest(1:3:300,1:3:300);
%         JTestTemp2=zeros(30,30);
%         for j1=1:30
%             for j2=1:30
%                  sumValue=double(0);
%                  count=0;
%                  for j3=-1:1
%                      for j4=-1:1
%                          if (j1+j3)>=1 & (j1+j3)<=30 & (j2+j4)>=1 & (j2+j4)<=30
%                              sumValue=double (JTestTemp(j1+j3,j2+j4))+sumValue;
%                              count=count+1;
%                          end
% 
%                      end
%                  end
%                  sumValue=sumValue/count;
%                  JTestTemp2(j1,j2)=uint8 (sumValue);
%              end
%          end
%         JTestTemp2=uint8(JTestTemp2);
         ImagesTemp = reshape(JTestTemp,100*100,1);
         imagesTest(:,iTestNo)=ImagesTemp;%imagesTest存储 test中 的 所有 图像数组

         for j5=1:size(classes)
             if size(strfind(imgnameTest,classes{j5})) ~= 0
                 test2Num(j5)= test2Num(j5) + 1;
             end
         end
         iTestNo=iTestNo+1;


    end
end