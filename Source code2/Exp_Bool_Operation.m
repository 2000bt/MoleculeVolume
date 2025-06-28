function [dVol,num_delete,num_int]= Exp_Bool_Operation(vX, vY, vZ,  vFace,AtomNum,Atom_info,vX1, vY1, vZ1, vFace1,AtomNum1,Atom_info1)
%% ��Χ��ɸ��һ����
dVol=0;
tic
num_delete=zeros(1,12);
num_int=zeros(1,2);
num_delete(1,1)=size(vFace,1);
num_delete(1,2)=size(vFace1,1);
% [vIdx,vIdx1]=Func_AABB_Sphere(vX, vY, vZ, iFaceLength, vFace,vX1, vY1, vZ1,iFaceLength1, vFace1);
% toc
% figure;
% hold on;
[vIdx,vIdx1,num]=Func_BoundingBox(vX, vY, vZ,  vFace,AtomNum,Atom_info,vX1, vY1, vZ1, vFace1,AtomNum1,Atom_info1);
% [vIdx1,iCount1]=Func_BoundingBox(vX1, vY1, vZ1, iFaceLength1, vFace1,vX, vY, vZ);
num_delete(1,3:10)=num(1,1:8);
toc

% ����Surface3��Surface4
Surface3 = createSurface(vX, vY, vZ, vFace, vIdx);
Surface4 = createSurface(vX1, vY1, vZ1, vFace1, vIdx1);

% ȥ�ض���
[~, ia, ic] = unique(Surface3.vertices, 'rows');
Surface3.vertices = Surface3.vertices(ia, :);
Surface3.faces = ic(Surface3.faces);

[~, ia, ic] = unique(Surface4.vertices, 'rows');
Surface4.vertices = Surface4.vertices(ia, :);
Surface4.faces = ic(Surface4.faces);

%%����sphereɸ����
figure;
hold on;
S=Surface3; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.8235,0.1255,0.1529], 'FaceAlpha', 0.5, 'FaceColor',  [0.99216,0.96078,0.90196]);
S=Surface4; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 0.5, 'FaceColor',  [0.99216,0.96078,0.90196]);
% hold off;
axis equal;
set(gcf, 'Color', 'white');
axis off;
axis image;
% view(3);
%%
% figure;
% hold on;
[inter_face,Surf] = SurfaceIntersection(Surface3,Surface4);
% S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'g','LineWidth', 2,  'FaceColor', 'r');
% hold off;
toc
% intersect_matrix=full(inter_face);
% [idxx,idxy]=find(intersect_matrix);
% num_idxx=length(idxx);
%%
% figure;
% hold on;
% S=Surface3; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'r','LineWidth', 2,  'FaceColor', 'r');
% faces = [
%     1 2 3;   % ��һ�������Σ���Ӧ vertices �ĵ�1-3�У�
% ];
% colors = [
%     0 1 0;   % ��ɫ����һ�������Σ�
% ];
% for pp=1:num_idxx
%     tri_faces = [
%     Surface3.faces(idxx(pp), :);   % �� Surface ��ȡ��һ�������ε���Ƭ����
%     
% ];
% vertices = [
%     Surface3.vertices(tri_faces(1, :), :);  % ��ȡ Surface ��Ӧ�����εĶ���
%   
% ];
%      patch('Faces', faces, 'Vertices', vertices, ...
%       'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%       'EdgeColor', 'k', 'LineWidth', 1);
% end
% hold off;
% figure;
% hold on;
% S=Surface4; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor',[0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'r','LineWidth', 2,  'FaceColor', 'r');
% faces = [
%     1 2 3;   % ��һ�������Σ���Ӧ vertices �ĵ�1-3�У�
% ];
colors = [
    [0.149, 0.596, 0.313];   % ��ɫ����һ�������Σ�
];
% for pp=1:num_idxx
%     tri_faces = [
%     Surface4.faces(idxy(pp), :);   % �� Surface ��ȡ��һ�������ε���Ƭ����
%     
% ];
% vertices = [
%     Surface4.vertices(tri_faces(1, :), :);  % ��ȡ Surface ��Ӧ�����εĶ���
%   
% ];
%      patch('Faces', faces, 'Vertices', vertices, ...
%       'FaceVertexCData', colors, 'FaceColor', 'flat', ...
%       'EdgeColor', 'k', 'LineWidth', 1);
% end
% hold off;
%%
intersect_matrix=full(inter_face);
[idxx,idxy]=find(intersect_matrix);
num_idxx=length(idxx);

% figure;
% hold on;
% faces = [
%     1 2 3;   % ��һ�������Σ���Ӧ vertices �ĵ�1-3�У�
%     4 5 6;   % �ڶ��������Σ���Ӧ vertices �ĵ�4-6�У�
% ];
% colors1= [
% % [0.8235,0.1255,0.1529];   % ��ɫ����һ�������Σ�
% % [0.2196,0.3490,0.5373];   % ��ɫ���ڶ��������Σ�
% % [0.149, 0.596, 0.313];
% % [0.149, 0.596, 0.313];
% [0, 1, 0];
% [0, 1, 0];
% ];
% for pp=1:num_idxx
%     tri_faces = [
%     Surface3.faces(idxx(pp), :);   % �� Surface ��ȡ��һ�������ε���Ƭ����
%     Surface4.faces(idxy(pp), :)   % �� Surface1 ��ȡ��һ�������ε���Ƭ����
% ];
% vertices = [
%     Surface3.vertices(tri_faces(1, :), :);  % ��ȡ Surface ��Ӧ�����εĶ���
%     Surface4.vertices(tri_faces(2, :), :)  % ��ȡ Surface1 ��Ӧ�����εĶ���
% ];
%      patch('Faces', faces, 'Vertices', vertices, ...
%       'FaceVertexCData', colors1, 'FaceColor', 'flat', ...
%       'EdgeColor', 'k', 'LineWidth', 1);
% end
% hold off;
% set(gcf, 'Color', 'white');
% axis equal;
% axis off;
% axis image;

%%
%�������ǻ�
pair_tri=Surf.triangles;
len_tri=length(pair_tri);
used_tri_face1=false(len_tri,1);
used_tri_face2=false(len_tri,1);
N_change={};
for pp=1:len_tri
% for pp=8:8
    if(used_tri_face1(pp))
        continue;
    end
    temp_tri = pair_tri(pp, 1);
    
    % ֱ�ӻ�ȡ�����ε����ж���
    tri_idx = Surface3.faces(temp_tri, :);  % ��ȡ�����εĶ�������
    %ȥ��ԭ������Ƭ
  %  Surface.faces(temp_tri,:)=[];
    Points_tri = Surface3.vertices(tri_idx, :);      % ��ȡ��Ӧ�Ķ�������
%     figure;
%     hold on;
  %�������㷽��
    [N_temp,~]=Func_PlotNorvec(Points_tri,0,false);
%     hold off;
    %
    idx_tri=find(pair_tri(:,1)==temp_tri);
    used_tri_face1(idx_tri)=true;
    %len_temp=length(idx_tri);
    temp_mat = unique(reshape(Surf.edges(idx_tri, :), [], 1));
    temp_cor=Surf.vertices(temp_mat,:);
   
    Points_tri=[Points_tri;temp_cor];
    
    original_vertex_count=size(Surface3.vertices,1);
    Surface3.vertices=[Surface3.vertices;temp_cor];
%     figure;
%     hold on;
    %ͶӰ
    tri=Func_Desect_triangle(Points_tri);
    for ppp=1:size(tri,1)
        [NN,flags]=Func_PlotNorvec([Points_tri(tri(ppp,1),:);Points_tri(tri(ppp,2),:);Points_tri(tri(ppp,3),:)],N_temp(1,3),true);
        N_temp=[N_temp;NN];
        if(flags)
            %��������˳��
            [tri(ppp,2), tri(ppp,3)] = deal(tri(ppp,3), tri(ppp,2));
        end
    end
    N_change{end+1,1} = N_temp;

    %������������Ƭ
    tri(tri == 1) = tri_idx(1);  % ������ A �е� 1 �滻Ϊ tri(1)
    tri(tri == 2) = tri_idx(2);  % ������ A �е� 2 �滻Ϊ tri(2)
    tri(tri == 3) = tri_idx(3);  % ������ A �е� 3 �滻Ϊ tri(3)
  
% ������Ԫ�ؼ���ԭ��������
    tri(~ismember(tri, tri_idx)) = tri(~ismember(tri, tri_idx)) + original_vertex_count-3;
    Surface3.faces=[Surface3.faces;tri];
    
end
%ȥ��
idxx_unique = unique(idxx);
length_idxx_un=length(idxx_unique);
Surface3.faces(idxx_unique,:)=[];
[~,ia,ic] = unique(Surface3.vertices,'rows'); % V = P(ia,:) and P = V(ic,:)
Surface3.vertices = Surface3.vertices(ia,:);
Surface3.faces = ic(Surface3.faces);
inside1=size(vIdx,1)-length_idxx_un;
%%
N_change1={};
for qq=1:len_tri
    if(used_tri_face2(qq))
        continue;
    end
    temp_tri = pair_tri(qq, 2);
    % ֱ�ӻ�ȡ�����ε����ж���
    tri_idx = Surface4.faces(temp_tri, :);  % ��ȡ�����εĶ�������
  
    Points_tri = Surface4.vertices(tri_idx, :);      % ��ȡ��Ӧ�Ķ�������
    [N_temp,~]=Func_PlotNorvec(Points_tri,0,false);
    
    idx_tri=find(pair_tri(:,2)==temp_tri);
    used_tri_face2(idx_tri)=true;
    %len_temp=length(idx_tri);
    temp_mat = unique(reshape(Surf.edges(idx_tri, :), [], 1));
    temp_cor=Surf.vertices(temp_mat,:);
   %����ȥ�غϲ�
    Points_tri=[Points_tri;temp_cor];
     
    original_vertex_count=size(Surface4.vertices,1);
    Surface4.vertices=[Surface4.vertices;temp_cor];
    %ͶӰ
    tri=Func_Desect_triangle(Points_tri);
    for ppp=1:size(tri,1)
        [NN,flags]=Func_PlotNorvec([Points_tri(tri(ppp,1),:);Points_tri(tri(ppp,2),:);Points_tri(tri(ppp,3),:)],N_temp(1,3),true);
        N_temp=[N_temp;NN];
        if(flags)
            %��������˳��
            [tri(ppp,2), tri(ppp,3)] = deal(tri(ppp,3), tri(ppp,2));
        end
    end
    N_change1{end+1,1} = N_temp;
    %������������Ƭ
    tri(tri == 1) = tri_idx(1);  % ������ A �е� 1 �滻Ϊ tri(1)
    tri(tri == 2) = tri_idx(2);  % ������ A �е� 2 �滻Ϊ tri(2)
    tri(tri == 3) = tri_idx(3);  % ������ A �е� 3 �滻Ϊ tri(3)
  
% ������Ԫ�ؼ���ԭ��������
    tri(~ismember(tri, tri_idx)) = tri(~ismember(tri, tri_idx)) + original_vertex_count-3;
    Surface4.faces=[Surface4.faces;tri];
    
end
idxy_unique = unique(idxy);
%Surface2=Surface;
length_idxy_un=length(idxy_unique);
Surface4.faces(idxy_unique,:)=[];
[~,ia,ic] = unique(Surface4.vertices,'rows'); % V = P(ia,:) and P = V(ic,:).
Surface4.vertices = Surface4.vertices(ia,:);
Surface4.faces = ic(Surface4.faces);
inside2=size(vIdx1,1)-length_idxy_un;
%%
%ȥ���˻�
Surface3=Func_ExcluDegrada(Surface3);
Surface4=Func_ExcluDegrada(Surface4);
%%
% figure;
% hold on;
% % S=Surface3; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% % 
% % patch('Faces', Surface3.faces(length(vIdx)-length_idxx_un:end, :), 'Vertices', Surface3.vertices, ...
% %     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
% %     'EdgeColor', 'k', 'LineWidth', 1);
% % S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'r','LineWidth', 2,  'FaceColor', 'r');
% % hold off;
% % figure;
% % hold on;
% 
% %����Surface3�����桢�ཻ��
% S=Surface3; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.8235,0.1255,0.1529], 'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]); 
% patch('Faces', Surface3.faces(length(vIdx)-length_idxx_un:end, :), 'Vertices', Surface3.vertices, ...
%     'FaceVertexCData', [0.5, 0, 0.5], 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% 
% % hold off;
% % 
% % 
% % % figure;
% % % hold on;
% 
% %����Surface4�����桢�ཻ��
% S=Surface4; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor',[0.2196,0.3490,0.5373], 'FaceAlpha', 0.5, 'FaceColor',  [0.99216,0.96078,0.90196]);
% patch('Faces', Surface4.faces(length(vIdx1)-length_idxy_un:end, :), 'Vertices', Surface4.vertices, ...
%     'FaceVertexCData', [0.5, 0, 0.5], 'FaceColor', 'flat', ...
%     'EdgeColor', 'k', 'LineWidth', 1);
% % S=Surf; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', 'r','LineWidth', 2,  'FaceColor', 'r');
% % hold off;
% % 
% % figure;
% % hold on;
% % S=Surface4; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
% % patch('Faces', Surface4.faces(length(vIdx1)-length_idxy_un:end, :), 'Vertices', Surface4.vertices, ...
% %     'FaceVertexCData', colors, 'FaceColor', 'flat', ...
% %     'EdgeColor', 'k', 'LineWidth', 1);
% % hold off;
% axis off;
% axis equal;
% set(gcf, 'Color', 'white');
% axis image;
%%
%�����ϵ�ж�

[vIdx_interface2,iCount4]=Func_ExInrelation1(Surface3,vX1,vY1,vZ1,vFace1,inside1);
[vIdx_interface1,iCount3]=Func_ExInrelation1(Surface4,vX,vY,vZ,vFace,inside2);
num_delete(1,11)=iCount4+length_idxx_un;%length_idxx_un:�ཻ��Ƭ���� iCount4:
num_delete(1,12)=iCount3+length_idxy_un;

%% 
figure;
hold on;
patch('Faces', Surface4.faces(vIdx_interface1,:), 'Vertices', Surface4.vertices, ...
    'FaceVertexCData',  [0.99216,0.96078,0.90196], 'FaceColor', 'flat', ...
    'EdgeColor',[0.2196,0.3490,0.5373], 'LineWidth', 1);
% figure;
patch('Faces', Surface3.faces(vIdx_interface2,:), 'Vertices', Surface3.vertices, ...
    'FaceVertexCData',  [0.99216,0.96078,0.90196], 'FaceColor', 'flat', ...
    'EdgeColor', [0.8235,0.1255,0.1529], 'LineWidth', 1);
hold off;
axis equal;
set(gcf, 'Color', 'white');
axis image;
axis off;
view(3);
%%���Ʒ�����
% Surface1 = createSurface(vX, vY, vZ, vFace, vIdx);
% Surface1 = createSurface(vX1, vY1, vZ1, vFace1, vIdx1);
% 
% vFace=Surface1.faces;
% vX=Surface1.vertices(:,1);
% vY=Surface1.vertices(:,2);
% vZ=Surface1.vertices(:,3);
% mNormal = zeros(length(vFace), 4);
% for i = 1 : length(vFace)
%    dX1 = vX(vFace(i, 1));
%    dX2 = vX(vFace(i, 2));
%    dX3 = vX(vFace(i, 3));
%    
%    dY1 = vY(vFace(i, 1));
%    dY2 = vY(vFace(i, 2));
%    dY3 = vY(vFace(i, 3));
%    
%    dZ1 = vZ(vFace(i, 1));
%    dZ2 = vZ(vFace(i, 2));
%    dZ3 = vZ(vFace(i, 3));
%    
%    mNormal(i, 1) = (dY2 - dY1) * (dZ3 - dZ1) - (dZ2 - dZ1) * (dY3 - dY1);
%    mNormal(i, 2) = (dZ2 - dZ1) * (dX3 - dX1) - (dX2 - dX1) * (dZ3 - dZ1);
%    mNormal(i, 3) = (dX2 - dX1) * (dY3 - dY1) - (dY2 - dY1) * (dX3 - dX1);
%    mNormal(i, 4) = 0 - (mNormal(i, 1) * dX1 + mNormal(i, 2) * dY1 + mNormal(i, 3) * dZ1);
% end
% for i =1 : 120
%     dX1 = vX(vFace(i, 1));
%     dX2 = vX(vFace(i, 2));
%     dX3 = vX(vFace(i, 3));
%     dY1 = vY(vFace(i, 1));
%     dY2 = vY(vFace(i, 2));
%     dY3 = vY(vFace(i, 3));
%     dZ1 = vZ(vFace(i, 1));
%     dZ2 = vZ(vFace(i, 2));
%     dZ3 = vZ(vFace(i, 3));
%     dX4 = (dX1 + dX2 + dX3) / 3;
%     dY4 = (dY1 + dY2 + dY3) / 3;
%     dZ4 = (dZ1 + dZ2 + dZ3) / 3;
%     line( [ dX1; dX2 ], [ dY1; dY2 ], [ dZ1; dZ2 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
%     line( [ dX2; dX3 ], [ dY2; dY3 ], [ dZ2; dZ3 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
%     line( [ dX3; dX1 ], [ dY3; dY1 ], [ dZ3; dZ1 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
% %     h = quiver3(dX4, dY4, dZ4, mNormal(i, 1), mNormal(i, 2), mNormal(i, 3), 3);
% %     set(h,'maxheadsize',10);
% %     set(h,'LineWidth',3);
%     h = quiver3(dX4, dY4, dZ4, mNormal(i, 1), mNormal(i, 2), mNormal(i, 3),3, 'LineWidth', 2);
%     set(h,'maxheadsize',2);
%     hold on
% end
% axis image;
% axis off;
% for i = 121 : 260
%     dX1 = vX(vFace(i, 1));
%     dX2 = vX(vFace(i, 2));
%     dX3 = vX(vFace(i, 3));
%     dY1 = vY(vFace(i, 1));
%     dY2 = vY(vFace(i, 2));
%     dY3 = vY(vFace(i, 3));
%     dZ1 = vZ(vFace(i, 1));
%     dZ2 = vZ(vFace(i, 2));
%     dZ3 = vZ(vFace(i, 3));
%     dX4 = (dX1 + dX2 + dX3) / 3;
%     dY4 = (dY1 + dY2 + dY3) / 3;
%     dZ4 = (dZ1 + dZ2 + dZ3) / 3;
%     line( [ dX1; dX2 ], [ dY1; dY2 ], [ dZ1; dZ2 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
%     line( [ dX2; dX3 ], [ dY2; dY3 ], [ dZ2; dZ3 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
%     line( [ dX3; dX1 ], [ dY3; dY1 ], [ dZ3; dZ1 ], 'LineWidth', 2, 'Color', [0.375, 0.375, 0.375] );
%     h = quiver3(dX4, dY4, dZ4, mNormal(i, 1), mNormal(i, 2), mNormal(i, 3),3, 'LineWidth', 2);
%     set(h,'maxheadsize',2);
%     hold on
% end

%%
%�������
intSurface.vertices = [];
intSurface.faces    = [];
np = size(Surface4.vertices,1);
intSurface.vertices = [Surface4.vertices; Surface3.vertices];
intSurface.faces    = [Surface4.faces(vIdx_interface1,:);    Surface3.faces(vIdx_interface2,:)+np];
dVol=Func_ComputeVolume(intSurface);
num_int(1,1)=size(Surface3.faces, 1);
num_int(1,2)=size(Surface4.faces, 1);

% 
% Surface4.faces=Surface4.faces(vIdx_interface1,:);
% Surface3.faces=Surface3.faces(vIdx_interface2,:);
% total_volume = 
% total_volume1= Func_ComputeVolume(Surface4);
% total_volume+total_volume1;
% ����������
function surface = createSurface(vX, vY, vZ, vFace, vIdx)
    len = length(vIdx);
    surface = struct('vertices', [], 'faces', []);
    
    for k = 0:len-1
        a = vIdx(k + 1);
        % ��ȡ��Ƭ��������������
        X1 = vX(vFace(a, 1)); Y1 = vY(vFace(a, 1)); Z1 = vZ(vFace(a, 1));
        X2 = vX(vFace(a, 2)); Y2 = vY(vFace(a, 2)); Z2 = vZ(vFace(a, 2));
        X3 = vX(vFace(a, 3)); Y3 = vY(vFace(a, 3)); Z3 = vZ(vFace(a, 3));
        
        % ���¶������Ƭ����
        surface.vertices(3*k + (1:3), :) = [X1 Y1 Z1; X2 Y2 Z2; X3 Y3 Z3];
        surface.faces(k + 1, :) = 3*k + (1:3);
    end
end
end