% ResultMatrix=zeros(10,10);
% for i=1:size(testLabels,1)
%     
%     ResultMatrix(testLabels(i,1),pred(1,i))= ResultMatrix(testLabels(i,1),pred(1,i))+1;
% end

rrr2=sum(ResultMatrix,2);
for i=1:10
	ResultMatrix2(:,i)=ResultMatrix(:,i)./rrr2;
end
xx4=diag(ResultMatrix2);%这个向量记录了每一类的召回率
test2Num(1,1)=242;
test2Num(2,1)=247;
test2Num(3,1)=241;
test2Num(4,1)=234;
test2Num(5,1)=239;
test2Num(6,1)=240;
test2Num(7,1)=237;
test2Num(8,1)=237;
test2Num(9,1)=239;
test2Num(10,1)=229;
 sum1=sum(ResultMatrix);
 sum1=sum(sum1);
for i=1:size(test2Num)
    noisum(i,1)=sum1-test2Num(i,1);
end

xx5=sum(ResultMatrix)';
xx6=diag(ResultMatrix);
norecognisedAsI=xx5-xx6;

xx7=norecognisedAsI./noisum;