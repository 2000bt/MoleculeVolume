%%
% in=full(inter_face);
% % spy(intersection);
% %%�ع��߽磬����ȷ���費��Ҫ
% [idxy,idxx]=find(in.');
% %%
% % ��ȡ���������ε���Ƭ����
% figure;
% hold on;
% len_idx=length(idxx);
% faces = [
%     1 2 3;   % ��һ�������Σ���Ӧ vertices �ĵ�1-3�У�
%     4 5 6;   % �ڶ��������Σ���Ӧ vertices �ĵ�4-6�У�
% ];
% colors = [
%     0 0 1;   % ��ɫ����һ�������Σ�
%     0 0 1;   % ��ɫ���ڶ��������Σ�
% ];
% for pp=1:1
%     tri_faces = [
%     Surface.faces(idxx(pp), :);   % �� Surface ��ȡ��һ�������ε���Ƭ����
%     Surface1.faces(idxy(pp), :)   % �� Surface1 ��ȡ��һ�������ε���Ƭ����
% ];
% vertices = [
%     Surface.vertices(tri_faces(1, :), :);  % ��ȡ Surface ��Ӧ�����εĶ���
%     Surface1.vertices(tri_faces(2, :), :)  % ��ȡ Surface1 ��Ӧ�����εĶ���
% ];
%      patch('Faces', faces, 'Vertices', vertices, ...
%       'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%       'EdgeColor', 'r', 'LineWidth', 1);
% end
% 

% ����ͼ����ʾ
% [~,Surf] = SurfaceIntersection(Surface,Surface1);
% S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'k','LineWidth', 2,  'FaceColor', 'r');
% axis equal;
% view(3);
% xlabel('X'); ylabel('Y'); zlabel('Z');
% title('�����ռ�������Ƭ');
% grid on;

%%�ռ������ο����ཻ�㷨����
% vFacetemp=vFace(vIdx,:);
% vFacetemp1=vFace(vIdx1,:);
% load tetmesh;
% TR = triangulation(tet,X);
% [Surface4.faces, Surface4.vertices] = freeBoundary(TR);
% 
% TR=triangulation(vFace,vX,vY,vZ);
% [Surface2.faces, Surface2.vertices] = freeBoundary(TR);
% 
% TR1=triangulation(vFace1,vX1,vY1,vZ1);
% [Surface3.faces, Surface3.vertices] = freeBoundary(TR1);

% Surface.vertices = [vX(:), vY(:), vZ(:)];  % �� vX, vY, vZ ��ϳ�һ�����󣬴洢Ϊ Surface.vertices
% Surface.faces = vFace;  
% Surface1.vertices = [vX1(:), vY1(:), vZ1(:)];  % �� vX, vY, vZ ��ϳ�һ�����󣬴洢Ϊ Surface.vertices
% Surface1.faces = vFace1;  

% %%�ж�����λ�ù�ϵ-----------�ǽ��߻�
% faces_front = Surface3.faces(1:len-length_idxx_un, :);  % ǰn����
faces_front1 = Surface4.faces(1:len1-length_idxy_un, :);  % ǰn����
% % չ��faces_front����ȡΨһ�Ķ�������
% vertices_front_indices = unique(faces_front(:));  
vertices_front_indices1 = unique(faces_front1(:));  
% Surface_front.vertices = Surface3.vertices(vertices_front_indices, :);  % ��ԭvertices��ȡǰn����Ķ���
Surface_front1.vertices = Surface4.vertices(vertices_front_indices1, :); 
% % ����ǰn�����faces������ʹ��ָ��ǰn������
% [~, new_face_idx] = ismember(faces_front, vertices_front_indices);  % ��ȡfaces�е�ÿ�������������
[~, new_face_idx1] = ismember(faces_front1, vertices_front_indices1);
% Surface_front.faces = new_face_idx;
Surface_front1.faces = new_face_idx1;
% %     Surface_front.vertices=Surface_front.vertices(2407,:);
% [vIdx_face,iCount]=Func_ExInrelation2(Surface_front.vertices,vX1,vY1,vZ1,vFace1);
[vIdx_face1,iCount1]=Func_ExInrelation2(Surface_front1.vertices,vX,vY,vZ,vFace);

% Step 2: ��ȡ���߻�
faces_remaining1 = Surface4.faces(len1-length_idxy_un+1:end, :);  % ʣ�����
vertices_remaining1 = unique(faces_remaining1(:)); 
Surface_remaining.vertices = Surface4.vertices(vertices_remaining1 , :);  % ��ԭvertices��ȡǰn����Ķ���

%
[~, new_face_idx1] = ismember(faces_remaining1, vertices_remaining1);
Surface_remaining.faces = new_face_idx1;
%���߻�����
% [vIdx_face,iCount]=Func_ExInrelation2(Surface3,vX1,vY1,vZ1,vFace1);

%���߻�
% [vIdx_interface,iCount2]=Func_ExInrelation1(Surface3,vX1,vY1,vZ1,vFace1);
%  Surface_remaining.faces=Surface_remaining.faces(456,:);
%  Surface_remaining.vertices=Surface_remaining.vertices(

% figure;
% hold on;
% patch('Faces', Surface_remaining.faces, 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;


% [vIdx_interface2,iCount4]=Func_ExInrelation2(Surface4.vertices,vX,vY,vZ,vFace);
%%���ཻ�����и������
% %%
% % �ǽ��߻�ʶ�����ڲ���������
% matching_rows = false(size(Surface_front.faces, 1), 1);
% % ���� faces ��ÿһ�У�����Ƿ���� vdx �е�����һ������
% for i = 1:size(Surface_front.faces, 1)
%     % �����е�����Ԫ���Ƿ������ vdx �е�����һ��Ԫ��
%     if all(ismember(Surface_front.faces(i,:), vIdx_face) ) % ��� faces(i,:) ��ÿ��Ԫ���Ƿ��� vdx ��
%         matching_rows(i) = true;
%     end
% end
% % �õ� faces ��ƥ����е�����
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_front.faces(matching_indices,:), 'Vertices', Surface_front.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% 
% matching_rows = false(size(Surface_front1.faces, 1), 1);
% % ���� faces ��ÿһ�У�����Ƿ���� vdx �е�����һ������
% for i = 1:size(Surface_front1.faces, 1)
%     % �����е�����Ԫ���Ƿ������ vdx �е�����һ��Ԫ��
%     if all(ismember(Surface_front1.faces(i,:), vIdx_face1) ) % ��� faces(i,:) ��ÿ��Ԫ���Ƿ��� vdx ��
%         matching_rows(i) = true;
%     end
% end
% % �õ� faces ��ƥ����е�����
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_front1.faces(matching_indices,:), 'Vertices', Surface_front1.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% %���ǽ��߻�����ʶ�������������
% figure;
% hold on;
% patch('Faces', Surface_front.faces, 'Vertices', Surface_front.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% figure;
% hold on;
% patch('Faces', Surface_front1.faces, 'Vertices', Surface_front1.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;

%%
% �����߻�
% for i = 1:size(Surface_remaining.faces, 1)
%     % �����е�����Ԫ���Ƿ������ vdx �е�����һ��Ԫ��
%     if all(ismember(Surface_remaining.faces(i,:), vIdx_interface2) ) % ��� faces(i,:) ��ÿ��Ԫ���Ƿ��� vdx ��
%         matching_rows(i) = true;
%     end
% end
% % �õ� faces ��ƥ����е�����
% matching_indices = find(matching_rows);
% figure;
% hold on;
% patch('Faces', Surface_remaining.faces(matching_indices,:), 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
% figure;
% hold on;
% patch('Faces', Surface_remaining.faces(vIdx_interface1,:), 'Vertices', Surface_remaining.vertices, ...
%     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% hold off;
%%
clc; clear; close all;

% ϸ�����ε��ĸ�������
x = [0, 4, 2, 2];  
y = [1, 1, 3, -1];

figure;
subplot(1,2,1);
hold on; axis equal;
title('��������������ʷ�');
tri1 = [1 3 2; 1 4 3]; % ѡ����ȷ�ĶԽ���
triplot(tri1, x, y, 'b', 'LineWidth', 1.5);
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
draw_circumcircles(tri1, x, y, 'b'); % �������Բ

subplot(1,2,2);
hold on; axis equal;
title('����������������ʷ�');
tri2 = [1 2 4; 2 3 4]; % ����һ���Խ��ߣ�ʹ���Բ������
triplot(tri2, x, y, 'r', 'LineWidth', 1.5);
plot(x, y, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
draw_circumcircles(tri2, x, y, 'r'); % �������Բ



function draw_circumcircles(tri, x, y, color)
    for k = 1:size(tri,1)
        % ��ȡ������������������
        A = [x(tri(k,1)), y(tri(k,1))];
        B = [x(tri(k,2)), y(tri(k,2))];
        C = [x(tri(k,3)), y(tri(k,3))];

        % �������ԲԲ�ĺͰ뾶
        [xc, yc, R] = circumcircle(A, B, C);

        % �����Բ
        theta = linspace(0, 2*pi, 100);
        plot(xc + R*cos(theta), yc + R*sin(theta), color, 'LineWidth', 1);
    end
end

function [xc, yc, R] = circumcircle(A, B, C)
    % �������������Բ��Բ�ĺͰ뾶
    D = 2 * (A(1) * (B(2) - C(2)) + B(1) * (C(2) - A(2)) + C(1) * (A(2) - B(2)));

    % ���ԲԲ��
    xc = ((A(1)^2 + A(2)^2) * (B(2) - C(2)) + ...
          (B(1)^2 + B(2)^2) * (C(2) - A(2)) + ...
          (C(1)^2 + C(2)^2) * (A(2) - B(2))) / D;
    yc = ((A(1)^2 + A(2)^2) * (C(1) - B(1)) + ...
          (B(1)^2 + B(2)^2) * (A(1) - C(1)) + ...
          (C(1)^2 + C(2)^2) * (B(1) - A(1))) / D;

    % �������Բ�뾶
    R = sqrt((A(1) - xc)^2 + (A(2) - yc)^2);
end
