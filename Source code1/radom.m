for i =1:length(cross)
cross(i,4)=(cross(i,1)-cross(i,3))/cross(i,3);
cross(i,5)=cross(i,1)-cross(i,3);
end
%%
% result1=result;
save recat6 result1
% min(vZ2)
%%
dir='F:\AAALLL\ply\';
dir1='y';
numFiles=6;
filename=strcat(dir,dir1,num2str(numFiles),'.ply');
%%
for i = 1:21
%     for j =1:3
         result1{i,1}(:,:)=result{i,1}(:,:);
end
% end
%%
sum=0;
dev=zeros(21,1);
for i =1:21
    dev(i)=abs((result1{i,3}-result1{i,1}))/result1{i,3};
    sum=sum+abs((result1{i,3}-result1{i,1}))/result1{i,3};
%     dev=dev+(result1{i,3}-result{i,1})^2;
%     if i ==8 ||i==15
%         continue;
%     end
end
average=abs(sum/21);
for i =1:21
    std_dev=(dev(i)-average)^2;
    if i ==8 ||i==15
        continue;
    end
end
std=sqrt(std_dev/19);
%%
pointyy=point{1,1};
dS=0;
len=length(pointyy);
for i = 1:len-1
    dS=dS+0.5*(pointyy(i,1)*pointyy(i+1,2)-pointyy(i+1,1)*pointyy(i,2));
end
dS=dS+0.5*(pointyy(len,1)*pointyy(1,2)-pointyy(1,1)*pointyy(len,2))
%%
area=result1{1,2};
abs_area=size(area,1);
rela=size(area,1);
for i =1:size(area,1)
    if area(i,3)==0
        continue;
    end
    abs_area(i)=abs(area(i,3)-area(i,1));
    rela(i)=abs(area(i,3)-area(i,1))/area(i,3);
end
    