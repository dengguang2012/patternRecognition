function [Vectors,Values,Psi] = pc_evectors(A,numvecs)
    if nargin ~=2
        error('usage: pc_evectors(A,numvecs)');
    end
    nexamp = size(A,2);
    fprintf(1,'Computing average vector and vector differences from avg...\n');
    Psi = mean(A')';%计算训练数据的均值  这个对应的是一个列向量 每一维表示了所有训练图片该维像素灰度值的均值
   A=double(A);
    for i=1:nexamp
        A(:,i)=A(:,i)-Psi;%A矩阵的每一列都减去均值的列向量
    end
    fprintf(1,'Calculating L=A''A\n');
       C = A'*A;

    
    fprintf(1,'Calculating eigenvectors of L...\n');
    [Vectors,Values] = eig(C);
    
    fprintf(1,'Sorting evectors/values...\n');
    [Vectors,Values] = sortVV(Vectors,Values);
%     load('sortVV.mat');
    fprintf(1,'Computing eigenvectors of the real covariance matrix..\n');
    A=double(A);
  Vectors = A*Vectors;
   % Get the eigenvalues out of the diagonal matrix and
  % normalize them so the evalues are specifically for cov(A'), not A*A'.

  Values = diag(Values);
  Values = Values / (nexamp-1);

 % Normalize Vectors to unit length, kill vectors corr. to tiny evalues

  num_good = 0;
  for i = 1:nexamp
    Vectors(:,i) = Vectors(:,i)/norm(Vectors(:,i));
    if Values(i) < 0.00001
      % Set the vector to the 0 vector; set the value to 0.
      Values(i) = 0;
      Vectors(:,i) = zeros(size(Vectors,1),1);
    else
      num_good = num_good + 1;
    end;
  end;
  if (numvecs > num_good)
    fprintf(1,'Warning: numvecs is %d; only %d exist.\n',numvecs,num_good);
    numvecs = num_good;
  end;
  Vectors = Vectors(:,1:numvecs);
%     C = A*A';
% 
%     
%     fprintf(1,'Calculating eigenvectors of L...\n');
%     [Vectors,Values] = eig(C);
%     
%     fprintf(1,'Sorting evectors/values...\n');
%     [Vectors,Values] = sortVV(Vectors,Values);
% 
%  Values = diag(Values);
%     nexamp = size(Vectors,2);
%     num_good = 0;
%     for i = 1:nexamp
%         Vectors(:,i) = Vectors(:,i)/norm(Vectors(:,i));
%         if Values(i) < 0.00001
%         % Set the vector to the 0 vector; set the value to 0.
%             Values(i) = 0;
%             Vectors(:,i) = zeros(size(Vectors,1),1);
%         else
%             num_good = num_good + 1;
%         end;
%     end;
%     if (numvecs > num_good)
%         fprintf(1,'Warning: numvecs is %d; only %d exist.\n',numvecs,num_good);
%     numvecs = num_good;
%     end;
%     Vectors = Vectors(:,1:numvecs);
end