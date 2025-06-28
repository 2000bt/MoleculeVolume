function [vIdx,iCount1]=Func_ExInrelation2(main_vertices,vX1,vY1,vZ1,vFace1)
numvertices = size(main_vertices, 1);
numFaces1 = size(vFace1, 1);
vNear = zeros(numvertices, 1);
iCount1 =0;
cross_prod = @(a,b) [... 
  a(:,2).*b(:,3) - a(:,3).*b(:,2), ...
  a(:,3).*b(:,1) - a(:,1).*b(:,3), ...
  a(:,1).*b(:,2) - a(:,2).*b(:,1)];
% dot_prod = @(a,b) a(:,1).*b(:,1) + a(:,2).*b(:,2) + a(:,3).*b(:,3);
% normalize = @(V) bsxfun(@rdivide, V, sqrt(sum(V.^2, 2)));
V1 = [vX1(vFace1(:,1)),vY1(vFace1(:,1)),vZ1(vFace1(:,1))];
V2 = [vX1(vFace1(:,2)),vY1(vFace1(:,2)),vZ1(vFace1(:,2))];
V3 = [vX1(vFace1(:,3)),vY1(vFace1(:,3)),vZ1(vFace1(:,3))];
normal = cross_prod(V2-V1,V3-V1); % array size nFace1 x 3
for i = 1:size(normal, 1)
    if normal(i, 3) < 0  % ��� nz Ϊ��
        normal(i, :) = -normal(i, :);  % ��ת����������
    end
end
nx = normal(:,1);
ny = normal(:,2);
nz = normal(:,3);
clear normal;
% N1 = normalize(N1);
% d1 = 0-dot_prod(N1,V1);   
%�ҵ��ڶ������Ӹ�������Ƭ���������X/Y/Z���꣬�ټ���������Ƭƽ�淽�̵õ������ĸ������ľ���
% ���߷�������Ϊ (0, 0, 1)��������Z��
vx = 0; vy = 0; vz = 1;
    
    
for i = 1 : numvertices
    iCount=0;
%     if(i==183)
%         a=1;
%          figure;
%         hold on;
%         plot3(main_vertices(i,1), main_vertices(i,2), main_vertices(i,3), 'o', 'MarkerSize', 1, 'MarkerFaceColor', 'r');  % 'o'��ʾ�����״��'r'��ʾ��ɫ
%         grid on;  % ��������
%         xlabel('X');
%         ylabel('Y');
%         zlabel('Z');
%     end
       
%     end
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
        if(dU >0 && dV > 0 && dU + dV < 1 )  %ĳ���ڵڶ������Ƶ�ĳ������Ƭ�ڣ�����Ӧ��ֻ���ҵ���ײ���Ǹ�����Ϊ�˼�����������ҵ����懡�� (vX(i) < dXMax && vX(i) > dXMin) && 
%              if(i==183)
%             patch([vX1(vFace1(j, 1)),vX1(vFace1(j, 2)),vX1(vFace1(j, 3))],[vY1(vFace1(j, 1)),vY1(vFace1(j, 2)),vY1(vFace1(j, 3))], [vZ1(vFace1(j, 1)),vZ1(vFace1(j, 2)),vZ1(vFace1(j, 3))], 'b');  
%              end
%             if(vNear(i) == 0)
%                 vNear(i) = -1;
%             end
            denominator = nx(j) * vx + ny(j) * vy + nz(j) * vz; % ������ƽ��ķ�����
%             if denominator == 0
%                 % ��� denominator == 0��˵��������ƽ��ƽ�У������ཻ
%                 isIntersecting = false;
%                 return;
%             end
    
            % ��� t (����Ĳ���)
            t = ((nx(j) * (vX1(vFace1(j, 1)) - main_vertices(i,1))) + (ny(j) * (vY1(vFace1(j, 1)) - main_vertices(i,2))) + (nz(j) * (vZ1(vFace1(j, 1)) - main_vertices(i,3)))) / denominator;

            % ��� t >= 0����ʾ���߷������н���
            if t >= 0
                iCount=iCount+1;
%                 isIntersecting = true;
%             else
%                 isIntersecting = false;
            end
%             if(main_vertices(i,1) * N1(j, 1) + main_vertices(2,1) * N1(j, 2) + main_vertices(i,3) * N1(j, 3) + d1(j) > 0)
%                 vNear(i) = -1 * vNear(i);
% %             else
% %                 vNear(i) = -1 * vNear(i);
%             end
%             if(main_vertices(i,3) > vZ1(vFace1(j, 3)))
%                 iCount2 = iCount2 + 1; 
%                 vNear(i) = -1 * vNear(i);
%             end
        end
    end 
%     hold off;
    if mod(iCount, 2) == 1
            vNear(i) = 1;  % �����ڲ�
       % iCount2 = iCount2 + 1;  % �������ڲ��ĵ�

    end
%     vNear(i)
end
vIdx = find(vNear > 0);
figure;
hold on;
plot3(main_vertices(vIdx,1),main_vertices(vIdx,2),main_vertices(vIdx,3),'o', 'MarkerSize',3, 'MarkerFaceColor', 'k');
hold off;
iCount1=numvertices-length(vIdx);
end