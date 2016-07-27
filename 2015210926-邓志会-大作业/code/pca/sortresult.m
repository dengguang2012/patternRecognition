function [result]=sortresult(distanceTestTrain,train2Num,k)%distanceTestTrain 7900*1 train2Num 10 * 1
    serialNum = 1:size(distanceTestTrain);
    train2NumAccumulate=train2Num;
    for i=2:size(train2NumAccumulate)
        train2NumAccumulate(i)=train2NumAccumulate(i)+train2NumAccumulate(i-1);
    end
    for i=1:size(distanceTestTrain,1)
        temp=distanceTestTrain(i,1);
        tempIndex=i;
        for j=i+1:size(distanceTestTrain,1)
            if distanceTestTrain(j,1)<temp
                temp = distanceTestTrain(j,1);
                tempIndex=j;
            end
        end
        if tempIndex ~= i
            temp2=distanceTestTrain(tempIndex);
            distanceTestTrain(tempIndex)=distanceTestTrain(i);
            distanceTestTrain(i) = temp2;
            
            temp2 = serialNum(tempIndex);
            serialNum(tempIndex)=serialNum(i);
            serialNum(i)=temp2;
        end
    end
    resultNum = zeros(size(train2Num),1);
    for i=1:k
        if serialNum(i) >= 1 & serialNum(i) <= train2NumAccumulate(1)
            resultNum(1)=resultNum(1)+1;
        elseif serialNum(i) >= train2NumAccumulate(1)+1 & serialNum(i) <= train2NumAccumulate(2)
             resultNum(2)=resultNum(2)+1;
        elseif serialNum(i) >= train2NumAccumulate(2)+1 & serialNum(i) <= train2NumAccumulate(3)
             resultNum(3)=resultNum(3)+1;
        elseif serialNum(i) >= train2NumAccumulate(3)+1 & serialNum(i) <= train2NumAccumulate(4)
             resultNum(4)=resultNum(4)+1;        
        elseif serialNum(i) >= train2NumAccumulate(4)+1 & serialNum(i) <= train2NumAccumulate(5)
             resultNum(5)=resultNum(5)+1;        
        elseif serialNum(i) >= train2NumAccumulate(5)+1 & serialNum(i) <= train2NumAccumulate(6)
             resultNum(6)=resultNum(6)+1;        
        elseif serialNum(i) >= train2NumAccumulate(6)+1 & serialNum(i) <= train2NumAccumulate(7)
             resultNum(7)=resultNum(7)+1;        
        elseif serialNum(i) >= train2NumAccumulate(7)+1 & serialNum(i) <= train2NumAccumulate(8)
             resultNum(8)=resultNum(8)+1;        
        elseif serialNum(i) >= train2NumAccumulate(8)+1 & serialNum(i) <= train2NumAccumulate(9)
             resultNum(9)=resultNum(9)+1;        
        elseif serialNum(i) >= train2NumAccumulate(9)+1 & serialNum(i) <= train2NumAccumulate(10)
             resultNum(10)=resultNum(10)+1;        
        end
    end
    maxNum=1;
    for i=1:size(resultNum)
        if resultNum(i)  > resultNum(maxNum)
            maxNum=i;
        end
    end

    result=maxNum;
end