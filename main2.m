clear;
clc;
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

for i =1:size(train)
    imgname = sprintf('food-10/images/%s.jpg',train{i});
    Img = imread(imgname);
    if(i==1)
       w=size(Img,2);
       h=size(Img,1);
       Images = zeros(w*h,size(train,1)*3); 
    end
    Images(1:w*h,i) = reshape(Img',w*h,1);
end