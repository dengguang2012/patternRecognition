clear;
clc;
 [classes,train,train2Num,ImagesTrain,imagesTest,test2Num] = loadData();

[Vecs,Vals,Psi] = pc_evectors(ImagesTrain,200);%���������������Imgs�����Э�������Ȼ����ȡ��Э��������������������Ӧ������ֵ��������ֵ���дӴ�С���򣬲�����Ӧ����������Ҳ���������ҽ��й�һ�������ص�Vecs����Ӧ������������Vals��
 plot(Vals);%չʾ������ֵ
 
%�Ѿ������ ����������ǰ�ͼƬҪ����Ԥ���� ����ܹؼ� תΪ�Ҷ����� ���ҽ���С���Ǹ��ؼ���ͼ��λ������

%��ѵ�����ϵ����ݽ�ά��40
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
