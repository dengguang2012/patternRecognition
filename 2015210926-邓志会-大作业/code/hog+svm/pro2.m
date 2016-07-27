clear;
clc;
[hog_train_label,hog_train_data]=loadTrainData2();
[hog_test_label,hog_test_data]=loadTestData2();
% load('loadpro2.mat');

[Vecs,Vals,Psi] = pc_evectors(hog_train_data',200);%在这个函数中先求Imgs矩阵的协方差矩阵，然后求取该协方差矩阵的特征向量和相应的特征值，将特征值进行从大到小排序，并且相应的特征向量也跟着排序并且进行归一化。返回的Vecs是相应特征向量矩阵，Vals是
 plot(Vals);%展示了特征值
 
%已经解决了 今天的问题是把图片要进行预处理 这个很关键 转为灰度数据 并且将缩小到那个关键的图像位置上面

%将训练集合的数据降维到20
W = Vecs(:,1:20);
hog_train_data=double(hog_train_data)';

for i=1:size(hog_train_data,2)
    ImagesTrainXX(:,i)=hog_train_data(:,i)-Psi(:,1);
end
ImagesTrainProjection = ImagesTrainXX'*W;%7293*40



hog_test_data=double(hog_test_data)';
for i=1:size(hog_test_data,2)
    imagesTestXX(:,i)=hog_test_data(:,i)-Psi;
end
ImagesTestProjection = imagesTestXX'*W;%2400*40

%# train one-against-all models
model = cell(10,1);
for k=1:10
    model{k} = svmtrain(double(hog_train_label==k), ImagesTrainProjection, '-c 1 -g 0.2 -b 1');
end
%# get probability estimates of test instances using each model
prob = zeros(size(hog_test_label),10);
for k=1:10
    [~,~,p] = svmpredict(double(hog_test_label==k), ImagesTestProjection, model{k}, '-b 1');
    prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end

%# predict the class with the highest probability
[~,pred] = max(prob,[],2);
acc = sum(pred == hog_test_label) ./ numel(hog_test_label)    %# accuracy
C = confusionmat(hog_test_label, pred)                   %# confusion matrix