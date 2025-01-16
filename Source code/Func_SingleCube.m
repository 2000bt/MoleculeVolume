%%判定单个体元周围的六个体元是否是边界体元,是则入栈，不是则跳过；并将当前体元插值
function [VoxelofBoundary,X,Y,Z]=Func_SingleCube(Seedcube_num,CubePoints, step_num1, step_num2, step_num3, LUT)
   %找出代表这六个体元的点，顺序为左、右、前、后、上、下
   a=step_num1*step_num2*step_num3;
   Cub_num=step_num2*step_num3;
   
   leftcube_num=Seedcube_num-Cub_num;
   rightcube_num=Seedcube_num+Cub_num;
   frontcube_num=Seedcube_num+step_num3;
   backcube_num=Seedcube_num-step_num3;
   upcube_num=Seedcube_num+1;
   downcube_num=Seedcube_num-1;
   VoxelofBoundary=[leftcube_num,rightcube_num,frontcube_num,backcube_num,upcube_num,downcube_num];
   for i = length(VoxelofBoundary):-1:1
       num_3 = VoxelofBoundary(i);
       num_2 = num_3 + step_num3;
       num_7 = num_3 + Cub_num;  
       num_6 = num_3 + Cub_num + step_num3;
       num_0 = num_3 + 1;
       num_1 = num_3 + step_num3 + 1;
       num_4 = num_3 + Cub_num + 1;
       num_5 = num_3 + Cub_num + step_num3 + 1;
       count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
       if (count == 8 || count == 0)
          VoxelofBoundary(i) = []; % 删除八个顶点全在等值面内或全在外的情况
       end
   end

   %当前体元插值
   num_3 = Seedcube_num;
   num_2 = num_3 + step_num3;
   num_7 = num_3 + Cub_num;
   num_6 = num_3 + Cub_num + step_num3;
   num_0 = num_3 + 1;
   num_1 = num_3 + step_num3 + 1;
   num_4 = num_3 + Cub_num + 1;
   num_5 = num_3 + Cub_num + step_num3 + 1;
   index = CubePoints(num_0,5) * 2^0 + CubePoints(num_1,5) * 2^1 + CubePoints(num_2,5) * 2^2 + CubePoints(num_3,5) * 2^3 + CubePoints(num_4,5) * 2^4 + CubePoints(num_5,5) * 2^5 + CubePoints(num_6,5) * 2^6 + CubePoints(num_7,5) * 2^7;
   ePoints = LUT(index + 1, :);
   count1 = 1;
   while(ePoints(1, count1) ~= -1)
         count1 = count1 + 1;
   end
   
   iCloudCount=0;
   for m = 1 : count1 - 1
       iCloudCount = iCloudCount + 1;
       switch ePoints(1, m)
            case 0
                X(iCloudCount) = CubePoints(num_0,1) ;
                Y(iCloudCount) = (CubePoints(num_0,2) + CubePoints(num_1,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_1,:), 2 );
                Z(iCloudCount) = CubePoints(num_0,3) ;
            case 11
                X(iCloudCount) = (CubePoints(num_3,1) + CubePoints(num_7,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_7,:), 1 ) ;
                Y(iCloudCount) = CubePoints(num_3,2);
                Z(iCloudCount) = CubePoints(num_3,3);
            case 1
                X(iCloudCount) = CubePoints(num_1,1) ;
                Y(iCloudCount) = CubePoints(num_1,2) ;
                Z(iCloudCount) = (CubePoints(num_1,3) + CubePoints(num_2,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_2,:), 3 );
            case 2
                X(iCloudCount) = CubePoints(num_2,1) ;
                Y(iCloudCount) = (CubePoints(num_2,2) + CubePoints(num_3,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_3,:), 2 );
                Z(iCloudCount) = CubePoints(num_2,3) ;
            case 3
                X(iCloudCount) = CubePoints(num_3,1) ;
                Y(iCloudCount) = CubePoints(num_3,2) ;
                Z(iCloudCount) = (CubePoints(num_3,3) + CubePoints(num_0,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_0,:), 3 );
            case 4
                X(iCloudCount) = CubePoints(num_4,1) ;
                Y(iCloudCount) = (CubePoints(num_4,2) + CubePoints(num_5,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_4,:), CubePoints(num_5,:), 2 );
                Z(iCloudCount) = CubePoints(num_4,3) ;
            case 5
                X(iCloudCount) = CubePoints(num_5,1) ;
                Y(iCloudCount) = CubePoints(num_5,2) ;
                Z(iCloudCount) = (CubePoints(num_5,3) + CubePoints(num_6,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_5,:), CubePoints(num_6,:), 3 );
            case 6
                X(iCloudCount) = CubePoints(num_6,1) ;
                Y(iCloudCount) = (CubePoints(num_6,2) + CubePoints(num_7,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_6,:), CubePoints(num_7,:), 2 );
                Z(iCloudCount) = CubePoints(num_6,3) ;
            case 7
                X(iCloudCount) = CubePoints(num_7,1) ;
                Y(iCloudCount) = CubePoints(num_7,2) ;
                Z(iCloudCount) = (CubePoints(num_7,3) + CubePoints(num_4,3))/2;
                %Z(iCloudCount) =  Func_get_coor( CubePoints(num_7,:), CubePoints(num_4,:), 3 );
            case 8
                X(iCloudCount) = (CubePoints(num_0,1) + CubePoints(num_4,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_4,:), 1 ) ;
                Y(iCloudCount) = CubePoints(num_0,2);
                Z(iCloudCount) = CubePoints(num_0,3);
            case 9
                X(iCloudCount) = (CubePoints(num_1,1) + CubePoints(num_5,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_5,:), 1 ) ;
                Y(iCloudCount) = CubePoints(num_1,2);
                Z(iCloudCount) = CubePoints(num_1,3);
            case 10
                X(iCloudCount) = (CubePoints(num_2,1) + CubePoints(num_6,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_6,:), 1 ) ;
                Y(iCloudCount) = CubePoints(num_2,2);
                Z(iCloudCount) = CubePoints(num_2,3);
       end        
   end

    
