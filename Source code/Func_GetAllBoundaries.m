 function [VoxelofBoundary2,count2]=Func_GetAllBoundaries(Seedcube_num,CubePoints, step_num1, step_num2, step_num3)
 a=step_num1*step_num2*step_num3;
 Cub_num=step_num2*step_num3;
 Traversedcube = false(size(CubePoints, 1), 1);%判断遍历过的体元
 VoxelofBoundary1=zeros(size(CubePoints, 1), 1);%遍历应处理的体元
 %VoxelofBoundary1=[];%遍历应处理的体元
 VoxelofBoundary2=zeros(size(CubePoints, 1), 1);%存储应处理的体元
 count1=1;%计数当前VoxelofBoundary1中存储了多少个体元
 count2=1;%计数当前VoxelofBoundary2中存储了多少个体元
 VoxelofBoundary1(1)=Seedcube_num;%种子体元入栈1
 count1=count1+1;   
 %VoxelofBoundary2(count2)=Seedcube_num;%种子体元入栈2      
 %count2=count2+1;
 Traversedcube(Seedcube_num)=true;%将种子体元标记为已经遍历
 Boolean=true;%循环是否继续的标记

 while Boolean
 %判断周围体元是否需要入栈1
     Seedcube_num=VoxelofBoundary1(count1-1);%取栈顶体元作为种子体元
     %VoxelofBoundary1(count1-1)=[];
     count1=count1-1;
     VoxelofBoundary2(count2)=Seedcube_num;
     count2=count2+1;
     
     leftcube_num=Seedcube_num-Cub_num;
     [count]=Func_GetCountofCubepoints(leftcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(leftcube_num)==false)
         VoxelofBoundary1(count1)=leftcube_num; 
         count1=count1+1;
%          VoxelofBoundary2(count2)=leftcube_num;
%          count2=count2+1;
         Traversedcube(leftcube_num)=true;
     end    
    
     
     rightcube_num=Seedcube_num+Cub_num;
     [count]=Func_GetCountofCubepoints(rightcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(rightcube_num)==false)
         VoxelofBoundary1(count1)=rightcube_num;
         count1=count1+1;
%          VoxelofBoundary2(count2)=rightcube_num;
%          count2=count2+1;
         Traversedcube(rightcube_num)=true;
     end
    
     frontcube_num=Seedcube_num+step_num3;
     [count]=Func_GetCountofCubepoints(frontcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(frontcube_num)==false)
         VoxelofBoundary1(count1)=frontcube_num;
         count1=count1+1;
%          VoxelofBoundary2(count2)=frontcube_num;
%          count2=count2+1;
         Traversedcube(frontcube_num)=true;
     end    
    
     backcube_num=Seedcube_num-step_num3;
     [count]=Func_GetCountofCubepoints(backcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(backcube_num)==false)
         VoxelofBoundary1(count1)=backcube_num;
         count1=count1+1;
%          VoxelofBoundary2(count2)=backcube_num;
%          count2=count2+1;
         Traversedcube(backcube_num)=true;
     end    
    
     upcube_num=Seedcube_num+1;
     [count]=Func_GetCountofCubepoints(upcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(upcube_num)==false)
         VoxelofBoundary1(count1)=upcube_num;
         count1=count1+1;
%          VoxelofBoundary2(count2)=upcube_num;
%          count2=count2+1;
         Traversedcube(upcube_num)=true;
     end    
    
     downcube_num=Seedcube_num-1;
     [count]=Func_GetCountofCubepoints(downcube_num,Cub_num,step_num3,CubePoints);
     if(count~=0&&count~=8&&Traversedcube(downcube_num)==false)
         VoxelofBoundary1(count1)=downcube_num;
         count1=count1+1;
%          VoxelofBoundary2(count2)=downcube_num;
%          count2=count2+1;
         Traversedcube(downcube_num)=true;
     end
     if count1==1
         Boolean=false;
     end    
 end
 count2=count2-1;

