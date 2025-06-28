function [vIdx,iCount2]=Func_ExInrelation(Surface,Surface1)
numFaces = size(Surface.faces, 1);
numFaces1 = size(Surface1.faces, 1);
cross_prod = @(a,b) [...
  a(:,2).*b(:,3)-a(:,3).*b(:,2), ...
  a(:,3).*b(:,1)-a(:,1).*b(:,3), ...
  a(:,1).*b(:,2)-a(:,2).*b(:,1)];
dot_prod = @(a,b) a(:,1).*b(:,1)+a(:,2).*b(:,2)+a(:,3).*b(:,3);
normalize = @(V) bsxfun(@rdivide,V, sqrt(sum(V.^2,2)));

%计算分子2面法向量
% 
% V1 = Surface1.vertices(Surface1.faces (:,1),:);
% V2 = Surface1.vertices(Surface1.faces (:,2),:);
% V3 = Surface1.vertices(Surface1.faces (:,3),:);
% N_face1 = cross_prod(V2-V1,V3-V1); % array size nFace1 x 3
% N_face1 = normalize(N_face1);
% d_face1 = 0-dot_prod(N_face1,V1); 
vNear = zeros(numFaces, 1);
iCount2=0;
for i=1:numFaces
    
    dA = Surface.vertices(Surface.faces (i,1),:);
    dB = Surface.vertices(Surface.faces (i,2),:);
    dC = Surface.vertices(Surface.faces (i,3),:);
    a = norm(dB - dC);  % 边BC
    b = norm(dC - dA);  % 边CA
    c = norm(dA - dB);  % 边AB

% 计算内心坐标
    Ix = (a * dA(1,1) + b * dB(1,1) + c * dC(1,1)) / (a + b + c);
    Iy = (a * dA(1,2) + b * dB(1,2) + c * dC(1,3)) / (a + b + c);
    Iz = (a * dA(1,3) + b * dB(1,3) + c * dC(1,3)) / (a + b + c);
    for j = 1 : numFaces1
        dX1 = Ix - Surface1.vertices(Surface1.faces(j, 1),1);
        dY1 = Iy - Surface1.vertices(Surface1.faces(j, 1),2);
        dX2 = Surface1.vertices(Surface1.faces(j, 2),1) - Surface1.vertices(Surface1.faces(j, 1),1);
        dY2 = Surface1.vertices(Surface1.faces(j, 2),2) - Surface1.vertices(Surface1.faces(j, 1),2);
        dX3 = Surface1.vertices(Surface1.faces(j, 3),1) - Surface1.vertices(Surface1.faces(j, 1),1);
        dY3 = Surface1.vertices(Surface1.faces(j, 3),2) - Surface1.vertices(Surface1.faces(j, 1),2);       
        dU = (dX1 * dY3 - dX3 * dY1) / (dX2 * dY3 - dX3 * dY2);
        dV = (dX1 * dY2 - dX2 * dY1) / (dX3 * dY2 - dX2 * dY3);
    %         dZ = vZ1(vFace1(j, 1)) + vZ1(vFace1(j, 2)) + vZ1(vFace1(j, 3));
        if(dU > 0 && dV > 0 && dU + dV <= 1 )  %某点在第二个点云的某个三角片内，那这应该只能找到碰撞的那个环，为了计算体积不该找点云面嚒？ (vX(i) < dXMax && vX(i) > dXMin) && 
            iCount2 = iCount2 + 1;            
            if(vNear(i) == 0)
                vNear(i) = -1;
            end
    %             if(vX(i) * mNormal(j, 1) + vY(i) * mNormal(j, 2) + vZ(i) * mNormal(j, 3) + mNormal(j, 4) > 0)
    %                 vNear(i) = 1 * vNear(i);
    %             else
    %                 vNear(i) = -1 * vNear(i);
    %             end
            if(Iz > Surface1.vertices(Surface1.faces(j, 3),3))
                vNear(i) = -1 * vNear(i);
            end
        end
    end  
end
vIdx = find(vNear > 0);
end