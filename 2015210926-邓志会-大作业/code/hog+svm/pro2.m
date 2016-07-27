clear;
clc;
[hog_train_label,hog_train_data]=loadTrainData2();
[hog_test_label,hog_test_data]=loadTestData2();
% load('loadpro2.mat');

[Vecs,Vals,Psi] = pc_evectors(hog_train_data',200);%���������������Imgs�����Э�������Ȼ����ȡ��Э��������������������Ӧ������ֵ��������ֵ���дӴ�С���򣬲�����Ӧ����������Ҳ���������ҽ��й�һ�������ص�Vecs����Ӧ������������Vals��
 plot(Vals);%չʾ������ֵ
 
%�Ѿ������ ����������ǰ�ͼƬҪ����Ԥ���� ����ܹؼ� תΪ�Ҷ����� ���ҽ���С���Ǹ��ؼ���ͼ��λ������

%��ѵ�����ϵ����ݽ�ά��20
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