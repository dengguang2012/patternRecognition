clear;
clc;
 [classes,train,train2Num,ImagesTrain,imagesTest,test2Num] = loadData();

[Vecs,Vals,Psi] = pc_evectors(ImagesTrain,200);%在这个函数中先求Imgs矩阵的协方差矩阵，然后求取该协方差矩阵的特征向量和相应的特征值，将特征值进行从大到小排序，并且相应的特征向量也跟着排序并且进行归一化。返回的Vecs是相应特征向量矩阵，Vals是
 plot(Vals);%展示了特征值
 
%已经解决了 今天的问题是把图片要进行预处理 这个很关键 转为灰度数据 并且将缩小到那个关键的图像位置上面

%将训练集合的数据降维到40
% load('Vecs.mat');
W = Vecs(:,1:10);
ImagesTrain=double(ImagesTrain);

for i=1:size(ImagesTrain,2)
    ImagesTrainXX(:,i)=ImagesTrain(:,i)-Psi;
end
ImagesTrainProjection = ImagesTrainXX'*W;%7293*40



test2NumAccumulate=test2Num;
for i=2:size(test2NumAccumulate)
    test2NumAccumulate(i)=test2NumAccumulate(i)+test2NumAccumulate(i-1);
end
imagesTest=double(imagesTest);
for i=1:size(imagesTest,2)
    imagesTestXX(:,i)=imagesTest(:,i)-Psi;
end
ImagesTestProjection = imagesTestXX'*W;%2400*40
ResultMatrix=zeros(10,10);
for i=1:size(ImagesTestProjection,1)
    if i >= 1 & i<=test2NumAccumulate(1)
        testClass=1;
    elseif i>=test2NumAccumulate(1)+1 & i<=test2NumAccumulate(2)
        testClass=2;
    elseif i>=test2NumAccumulate(2)+1 & i<=test2NumAccumulate(3)
        testClass=3;
    elseif i>=test2NumAccumulate(3)+1 & i<=test2NumAccumulate(4)
        testClass=4;
    elseif i>=test2NumAccumulate(4)+1 & i<=test2NumAccumulate(5)
        testClass=5;
    elseif i>=test2NumAccumulate(5)+1 & i<=test2NumAccumulate(6)
        testClass=6;
    elseif i>=test2NumAccumulate(6)+1 & i<=test2NumAccumulate(7)
        testClass=7;
    elseif i>=test2NumAccumulate(7)+1 & i<=test2NumAccumulate(8)
        testClass=8;
    elseif i>=test2NumAccumulate(8)+1 & i<=test2NumAccumulate(9)
        testClass=9;
    elseif i>=test2NumAccumulate(9)+1 & i<=test2NumAccumulate(10)
        testClass=10;
    
    end
    ImagesTestProjectionIndex = ImagesTestProjection(i,:);
    distanceTestTrain = ImagesTrainProjection;
    for i1=1:size(distanceTestTrain,1)
        distanceTestTrain(i1,:)=distanceTestTrain(i1,:)-ImagesTestProjectionIndex;
    end
    distanceTestTrain=distanceTestTrain.*distanceTestTrain;
    distanceTestTrain=sum(distanceTestTrain,2);
    k=1;
    resultClass = sortresult(distanceTestTrain,train2Num,k);
    ResultMatrix(testClass,resultClass)= ResultMatrix(testClass,resultClass)+1;
end
