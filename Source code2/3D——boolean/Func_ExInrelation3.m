function [vIdx,iCount2]=Func_ExInrelation2(main_vertices,vX1,vY1,vZ1,vFace1)
numvertices = size(main_vertices, 1);
numFaces1 = size(vFace1, 1);
vNear =false(numvertices, 1);
iCount2 = 0;  % 计数在网格内部的点数
count_intersections = 0;
for i = 1:numvertices
     for j = 1 : numFaces1
        dX1 = main_vertices(i,1) - vX1(vFace1(j, 1));
        dY1 = main_vertices(i,2) - vY1(vFace1(j, 1));
        dX2 = vX1(vFace1(j, 2)) - vX1(vFace1(j, 1));
        dY2 = vY1(vFace1(j, 2)) - vY1(vFace1(j, 1));
        dX3 = vX1(vFace1(j, 3)) - vX1(vFace1(j, 1));
        dY3 = vY1(vFace1(j, 3)) - vY1(vFace1(j, 1));       
        dU = (dX1 * dY3 - dX3 * dY1) / (dX2 * dY3 - dX3 * dY2);
        dV = (dX1 * dY2 - dX2 * dY1) / (dX3 * dY2 - dX2 * dY3);
%         dZ = vZ1(vFace1(j, 1)) + vZ1(vFace1(j, 2)) + vZ1(vFace1(j, 3));
        if(dU > 0 && dV > 0 && dU + dV < 1 )  %某点在第二个点云的某个三角片内，那这应该只能找到碰撞的那个环，为了计算体积不该找点云面嚒？ (vX(i) < dXMax && vX(i) > dXMin) && 
                      
             count_intersections = count_intersections + 1;
   
        end
  end
    if mod(count_intersections, 2) == 1
        vNear(i) = true;  % 点在内部
        iCount2 = iCount2 + 1;  % 计数在内部的点
    else
       vNear(i) = false; % 点在外部
    end
end

    % 返回在网格内部的点的索引
    vIdx = find(vNear == true);  % 返回内部点的索引
end
