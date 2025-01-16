function [X,Y,Z,face]=Func_Interpolation(VoxelofBoundary2,count2,CubePoints, step_num1, step_num2, step_num3, LUT)
lengthXYZ=0;%记录三角形边的数量
a=step_num1*step_num2*step_num3;
Cub_num=step_num2*step_num3;

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
                Y(countXYZ) = (CubePoints(num_0,2) + CubePoints(num_1,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_1,:), 2 );
                Z(countXYZ) = CubePoints(num_0,3) ;
            case 11
                X(countXYZ) = (CubePoints(num_3,1) + CubePoints(num_7,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_7,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_3,2);
                Z(countXYZ) = CubePoints(num_3,3);
            case 1
                X(countXYZ) = CubePoints(num_1,1) ;
                Y(countXYZ) = CubePoints(num_1,2) ;
                Z(countXYZ) = (CubePoints(num_1,3) + CubePoints(num_2,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_2,:), 3 );
            case 2
                X(countXYZ) = CubePoints(num_2,1) ;
                Y(countXYZ) = (CubePoints(num_2,2) + CubePoints(num_3,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_3,:), 2 );
                Z(countXYZ) = CubePoints(num_2,3) ;
            case 3
                X(countXYZ) = CubePoints(num_3,1) ;
                Y(countXYZ) = CubePoints(num_3,2) ;
                Z(countXYZ) = (CubePoints(num_3,3) + CubePoints(num_0,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_3,:), CubePoints(num_0,:), 3 );
            case 4
                X(countXYZ) = CubePoints(num_4,1) ;
                Y(countXYZ) = (CubePoints(num_4,2) + CubePoints(num_5,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_4,:), CubePoints(num_5,:), 2 );
                Z(countXYZ) = CubePoints(num_4,3) ;
            case 5
                X(countXYZ) = CubePoints(num_5,1) ;
                Y(countXYZ) = CubePoints(num_5,2) ;
                Z(countXYZ) = (CubePoints(num_5,3) + CubePoints(num_6,3))/2;
                %Z(iCloudCount) = Func_get_coor( CubePoints(num_5,:), CubePoints(num_6,:), 3 );
            case 6
                X(countXYZ) = CubePoints(num_6,1) ;
                Y(countXYZ) = (CubePoints(num_6,2) + CubePoints(num_7,2))/2;
                %Y(iCloudCount) = Func_get_coor( CubePoints(num_6,:), CubePoints(num_7,:), 2 );
                Z(countXYZ) = CubePoints(num_6,3) ;
            case 7
                X(countXYZ) = CubePoints(num_7,1) ;
                Y(countXYZ) = CubePoints(num_7,2) ;
                Z(countXYZ) = (CubePoints(num_7,3) + CubePoints(num_4,3))/2;
                %Z(iCloudCount) =  Func_get_coor( CubePoints(num_7,:), CubePoints(num_4,:), 3 );
            case 8
                X(countXYZ) = (CubePoints(num_0,1) + CubePoints(num_4,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_0,:), CubePoints(num_4,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_0,2);
                Z(countXYZ) = CubePoints(num_0,3);
            case 9
                X(countXYZ) = (CubePoints(num_1,1) + CubePoints(num_5,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_1,:), CubePoints(num_5,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_1,2);
                Z(countXYZ) = CubePoints(num_1,3);
            case 10
                X(countXYZ) = (CubePoints(num_2,1) + CubePoints(num_6,1))/2 ;
                %X(iCloudCount) = Func_get_coor( CubePoints(num_2,:), CubePoints(num_6,:), 1 ) ;
                Y(countXYZ) = CubePoints(num_2,2);
                Z(countXYZ) = CubePoints(num_2,3);
       end 
       
       if(0 == mod(m, 3))
        counface = countface + 1;
        face(counface, 1) = countXYZ - 2;
        face(counface, 2) = countXYZ - 1;
        face(counface, 3) = countXYZ;
       end
   end
end  
