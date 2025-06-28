function [vIdx,iCount1]=Func_ExInrelation1(Surface,vX1,vY1,vZ1,vFace1,num)
%�����߻�����
numvertices = size(Surface.faces, 1);
% figure;
% hold on;
% S=Surface; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'k', 'FaceAlpha', 0.5, 'FaceColor', 'b');
numFaces1 = size(vFace1, 1);
iCount1=0;
% ��������
cross_prod = @(a,b) [... 
  a(:,2).*b(:,3) - a(:,3).*b(:,2), ...
  a(:,3).*b(:,1) - a(:,1).*b(:,3), ...
  a(:,1).*b(:,2) - a(:,2).*b(:,1)];
dot_prod = @(a,b) a(:,1).*b(:,1) + a(:,2).*b(:,2) + a(:,3).*b(:,3);
% normalize = @(V) bsxfun(@rdivide, V, sqrt(sum(V.^2, 2)));

% ����ÿ�������ε���������
V1 = Surface.vertices(Surface.faces(:, 1), :);
V2 = Surface.vertices(Surface.faces(:, 2), :);
V3 = Surface.vertices(Surface.faces(:, 3), :);

% �������߳���
a = vecnorm(V2 - V3, 2, 2); % ��BC
b = vecnorm(V3 - V1, 2, 2); % ��CA
c = vecnorm(V1 - V2, 2, 2); % ��AB

% �����������꣨Ix, Iy, Iz��
Ix = (a .* V1(:,1) + b .* V2(:,1) + c .* V3(:,1)) ./ (a + b + c);
Iy = (a .* V1(:,2) + b .* V2(:,2) + c .* V3(:,2)) ./ (a + b + c);
Iz = (a .* V1(:,3) + b .* V2(:,3) + c .* V3(:,3)) ./ (a + b + c);
vNear = zeros(numvertices, 1);

V1 = [vX1(vFace1(:,1)),vY1(vFace1(:,1)),vZ1(vFace1(:,1))];
V2 = [vX1(vFace1(:,2)),vY1(vFace1(:,2)),vZ1(vFace1(:,2))];
V3 = [vX1(vFace1(:,3)),vY1(vFace1(:,3)),vZ1(vFace1(:,3))];
normal = cross_prod(V2-V1,V3-V1); % array size nFace1 x 3
normal(:,4) = 0-dot_prod(normal,V1);
for i = 1:size(normal, 1)
    if normal(i, 3) < 0  % ��� nz Ϊ��
        normal(i, :) = -normal(i, :);  % ��ת����������
    end
end
nx = normal(:,1);
ny = normal(:,2);
nz = normal(:,3);
% clear normal;
% N1 = normalize(N1);
% d1 = 0-dot_prod(N1,V1);   
% �ҵ��ڶ������Ӹ�������Ƭ���������X/Y/Z���꣬�ټ���������Ƭƽ�淽�̵õ������ĸ������ľ���
% ���߷�������Ϊ (0, 0, 1)��������Z��
vx = 0; vy = 0; vz = 1;
    
for i=1:numvertices
    iCount=0;
%      figure;
%         hold on;
%         plot3( Ix(i),  Iy(i),  Iz(i), 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'r');  % 'o'��ʾ�����״��'r'��ʾ��ɫ
%         grid on;  % ��������
%         xlabel('X');
%         ylabel('Y');
%         zlabel('Z');
    for j = 1 : numFaces1
        dX1 = Ix(i)  - vX1(vFace1(j, 1));
        dY1 = Iy(i)  - vY1(vFace1(j, 1));
        dX2 = vX1(vFace1(j, 2)) - vX1(vFace1(j, 1));
        dY2 = vY1(vFace1(j, 2)) - vY1(vFace1(j, 1));
        dX3 = vX1(vFace1(j, 3)) - vX1(vFace1(j, 1));
        dY3 = vY1(vFace1(j, 3)) - vY1(vFace1(j, 1));       
        dU = (dX1 * dY3 - dX3 * dY1) / (dX2 * dY3 - dX3 * dY2);
        dV = (dX1 * dY2 - dX2 * dY1) / (dX3 * dY2 - dX2 * dY3);
%         dZ = vZ1(vFace1(j, 1)) + vZ1(vFace1(j, 2)) + vZ1(vFace1(j, 3));
        if(dU > 0 && dV > 0 && dU + dV < 1 )  %ĳ���ڵڶ������Ƶ�ĳ������Ƭ�ڣ�����Ӧ��ֻ���ҵ���ײ���Ǹ�����Ϊ�˼�����������ҵ����懡�� (vX(i) < dXMax && vX(i) > dXMin) && 
            
%              patch([vX1(vFace1(j, 1)),vX1(vFace1(j, 2)),vX1(vFace1(j, 3))],[vY1(vFace1(j, 1)),vY1(vFace1(j, 2)),vY1(vFace1(j, 3))], [vZ1(vFace1(j, 1)),vZ1(vFace1(j, 2)),vZ1(vFace1(j, 3))], 'g');  
%              denominator = nx(j) * vx + ny(j) * vy + nz(j) * vz; 
%              t = ((nx(j) * (vX1(vFace1(j, 1)) - Ix(i))) + (ny(j) * (vY1(vFace1(j, 1)) - Iy(i))) + (nz(j) * (vZ1(vFace1(j, 1)) - Iz(i)))) / denominator;
%              if t >= 0
%                 iCount=iCount+1;
%              end
             if(Ix(i) * normal(j, 1) + Iy(i) * normal(j, 2) + Iz(i) * normal(j, 3) +normal(j, 4) > 0)
                iCount=iCount+1;
            end
        end
    end  
%       hold off;
    if mod(iCount, 2) == 1
            vNear(i) = 1;  % �����ڲ�
    end
end

% �ҵ����������ĵ�����
vIdx = find(vNear>0);
% figure;
% hold on;
% % plot3(Ix(vIdx),Iy(vIdx),Iz(vIdx),'o', 'MarkerSize',3, 'MarkerFaceColor', 'k');
% plot3(Ix(vIdx),Iy(vIdx),Iz(vIdx),'o', 'MarkerSize',3, 'MarkerFaceColor', [0.2196, 0.3490, 0.5373],'MarkerEdgeColor',[0.2196, 0.3490, 0.5373]);
% % plot3(Ix(vIdx),Iy(vIdx),Iz(vIdx),'o', 'MarkerSize',3, 'MarkerFaceColor', [0.8235,0.1255,0.1529],'MarkerEdgeColor', [0.8235,0.1255,0.1529]);
% hold off;
% axis off;
% axis equal;
% set(gcf, 'Color', 'white');
% axis image;
iCount1=sum(vIdx < num);
end