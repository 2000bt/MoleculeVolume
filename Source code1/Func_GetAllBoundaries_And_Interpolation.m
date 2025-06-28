function [X,Y,Z,face,CountTraversed,CountBoundary]=Func_GetAllBoundaries_And_Interpolation(CubePoints, step_num1, step_num2, step_num3, LUT)
Cub_num = step_num2 * step_num3;
a = step_num1 * step_num2 * step_num3;
%%取种子体元     
Seedcube_num = 0;
found=false;
CountTraversed=0;
for i = 1 :5: step_num1
    if (i == step_num1)%边界位置不取，已经没有Cube
        continue;
    end
    for j = 1 :5:step_num2
        if(j == step_num2) 
            continue;
        end
        for k = 1 :5: step_num3
            if( k == step_num3)
                continue;
            end
            num_3 = k + step_num3 * (j - 1) + step_num2 * step_num3* (i -1);
            num_2 = num_3 + step_num3;
            num_7 = num_3 + Cub_num;
            num_6 = num_3 + Cub_num + step_num3; 
            num_0 = num_3 + 1;
            num_1 = num_3 + step_num3 + 1;
            num_4 = num_3 + Cub_num + 1;
            num_5 = num_3 + Cub_num + step_num3 + 1;
            count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
            if (count ~= 8 && count ~= 0)
                Seedcube_num = num_3;
                found = true; % 设置标志变量
                break; % 退出内层循环
            end
        end

        if found
            break; % 退出中间层循环
        end
    end
    if found
        break; % 退出中间层循环
    end
end


%%取边界体元及数量
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

     CountTraversed=CountTraversed+6;%计数遍历体元的个数
     
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

 %%取插值坐标和三角形
 lengthXYZ=0;%记录三角形边的数量
 for i=1:count2
   num_3 = VoxelofBoundary2(i);
   num_2 = num_3 + step_num3;
   num_7 = num_3 + Cub_num;  
   num_6 = num_3 + Cub_num + step_num3;
   num_0 = num_3 + 1;
   num_1 = num_3 + step_num3 + 1;
   num_4 = num_3 + Cub_num + 1;
   num_5 = num_3 + Cub_num + step_num3 + 1;
   %count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
   %当前体元插值
   index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
   ePoints = LUT(index + 1, :);
   count1 = 1;
   while(ePoints(1, count1) ~= -1)
         count1 = count1 + 1;
         lengthXYZ = lengthXYZ + 1;
   end
end 

%插值
lengthface=lengthXYZ/3;
face=zeros(lengthface,3);
X=zeros(lengthXYZ,1);
Y=zeros(lengthXYZ,1);
Z=zeros(lengthXYZ,1);
countXYZ=0;
countface=0;

for i=1:count2
   num_3 = VoxelofBoundary2(i);
   num_2 = num_3 + step_num3;
   num_7 = num_3 + Cub_num;  
   num_6 = num_3 + Cub_num + step_num3;
   num_0 = num_3 + 1;
   num_1 = num_3 + step_num3 + 1;
   num_4 = num_3 + Cub_num + 1;
   num_5 = num_3 + Cub_num + step_num3 + 1;
   %count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
   %当前体元插值
   index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
   ePoints = LUT(index + 1, :);
   count1 = 1;
   while(ePoints(1, count1) ~= -1)
         count1 = count1 + 1;
   end
 
   for m = 1 : count1 - 1
       countXYZ = countXYZ + 1;
       switch ePoints(1, m)
            case 0
                X(countXYZ) = CubePoints(num_0,1) ;
%                 Y(countXYZ) = (CubePoints(num_0,2) + CubePoints(num_1,2))/2;
                Y(countXYZ) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_1,:), 2 );
                Z(countXYZ) = CubePoints(num_0,3) ;
            case 11
%                 X(countXYZ) = (CubePoints(num_3,1) + CubePoints(num_7,1))/2 ;
                X(countXYZ) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_7,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_3,2);
                Z(countXYZ) = CubePoints(num_3,3);
            case 1
                X(countXYZ) = CubePoints(num_1,1) ;
                Y(countXYZ) = CubePoints(num_1,2) ;
%                 Z(countXYZ) = (CubePoints(num_1,3) + CubePoints(num_2,3))/2;
                Z(countXYZ) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_2,:), 3 );
            case 2
                X(countXYZ) = CubePoints(num_2,1) ;
%                 Y(countXYZ) = (CubePoints(num_2,2) + CubePoints(num_3,2))/2;
                Y(countXYZ) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_3,:), 2 );
                Z(countXYZ) = CubePoints(num_2,3) ;
            case 3
                X(countXYZ) = CubePoints(num_3,1) ;
                Y(countXYZ) = CubePoints(num_3,2) ;
%                 Z(countXYZ) = (CubePoints(num_3,3) + CubePoints(num_0,3))/2;
                Z(countXYZ) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_0,:), 3 );
            case 4
                X(countXYZ) = CubePoints(num_4,1) ;
%                 Y(countXYZ) = (CubePoints(num_4,2) + CubePoints(num_5,2))/2;
                Y(countXYZ) = Func_get_coor( CubePoints(num_4,:), CubePoints(num_5,:), 2 );
                Z(countXYZ) = CubePoints(num_4,3) ;
            case 5
                X(countXYZ) = CubePoints(num_5,1) ;
                Y(countXYZ) = CubePoints(num_5,2) ;
%                 Z(countXYZ) = (CubePoints(num_5,3) + CubePoints(num_6,3))/2;
                Z(countXYZ) = Func_get_coor( CubePoints(num_5,:), CubePoints(num_6,:), 3 );
            case 6
                X(countXYZ) = CubePoints(num_6,1) ;
%                 Y(countXYZ) = (CubePoints(num_6,2) + CubePoints(num_7,2))/2;
                Y(countXYZ) = Func_get_coor( CubePoints(num_6,:), CubePoints(num_7,:), 2 );
                Z(countXYZ) = CubePoints(num_6,3) ;
            case 7
                X(countXYZ) = CubePoints(num_7,1) ;
                Y(countXYZ) = CubePoints(num_7,2) ;
%                 Z(countXYZ) = (CubePoints(num_7,3) + CubePoints(num_4,3))/2;
                Z(countXYZ) =  Func_get_coor( CubePoints(num_7,:), CubePoints(num_4,:), 3 );
            case 8
%                 X(countXYZ) = (CubePoints(num_0,1) + CubePoints(num_4,1))/2 ;
                X(countXYZ) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_4,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_0,2);
                Z(countXYZ) = CubePoints(num_0,3);
            case 9
%                 X(countXYZ) = (CubePoints(num_1,1) + CubePoints(num_5,1))/2 ;
                X(countXYZ) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_5,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_1,2);
                Z(countXYZ) = CubePoints(num_1,3);
            case 10
%                 X(countXYZ) = (CubePoints(num_2,1) + CubePoints(num_6,1))/2 ;
                X(countXYZ) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_6,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_2,2);
                Z(countXYZ) = CubePoints(num_2,3);
       end 
       
       if(0 == mod(m, 3))
        countface = countface + 1;
        face(countface, 1) = countXYZ - 2;
        face(countface, 2) = countXYZ - 1;
        face(countface, 3) = countXYZ;
       end
   end
end  