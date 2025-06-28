function [vdx,vdx1,num]=Func_BoundingBox(vX, vY, vZ, vFace,AtomNum,Atom_info,vX1, vY1, vZ1,vFace1,AtomNum1,Atom_info1)
%     iCount = 0;
%     iCount1 = 0;
    num=zeros(1,8);
%% AABB包围盒先点后面
    Common_s=Func_para(vX,vY,vZ,vX1,vY1,vZ1);
    
    validIndices = find(vX >= Common_s(2) & vX <= Common_s(1) & vY >= Common_s(4) & vY <= Common_s(3) & vZ >= Common_s(6) & vZ <= Common_s(5));
    validIndices1 = find(vX1 >= Common_s(2) & vX1 <= Common_s(1) & vY1 >= Common_s(4) & vY1 <= Common_s(3) & vZ1 >= Common_s(6) & vZ1 <= Common_s(5));

    [~, matching_rows] = ismember(vFace, validIndices);
    matching_rows = any(matching_rows, 2);
    [~, matching_rows1] = ismember(vFace1, validIndices1);
    matching_rows1 = any(matching_rows1, 2);

    vdx_AABB=find(matching_rows>0);

    vdx1_AABB=find(matching_rows1>0);
%     vdx=vdx_AABB;
%     vdx1=vdx1_AABB;
     num(1,1)=length(vFace)-length(vdx_AABB);
     num(1,2)=length(vdx_AABB);
     num(1,3)=length(vFace1)-length(vdx1_AABB);
     num(1,4)=length(vdx1_AABB);
%     iCount=iFaceLength-size(vdx,1);
%     iCount1=iFaceLength1-size(vdx1,1);
%% Sphere包围盒
% [vdx]=Func_Sphere(vX, vY, vZ, vFace,AtomNum,Atom_info,vX1, vY1, vZ1,vFace1,AtomNum1,Atom_info1);
% [vdx1]=Func_Sphere(vX1, vY1, vZ1, vFace1,AtomNum1,Atom_info1,vX, vY, vZ,vFace,AtomNum,Atom_info);
%     [~, matching_rows] = ismember(vFace, vdx);
%     matching_rows = any(matching_rows, 2);
%     [~, matching_rows1] = ismember(vFace1, vdx1);
%     matching_rows1 = any(matching_rows1, 2);
% 
%     vdx=find(matching_rows>0);
%     vdx1=find(matching_rows1>0);
%     
% vdx_filtered_by_sphere = setdiff(vdx_AABB, vdx);
% vdx1_filtered_by_sphere = setdiff(vdx1_AABB, vdx1);
% 
% % 计算 Sphere 额外筛除的数量
% num(1,3) = length(vdx_filtered_by_sphere);
% num(1,4) = length(vdx1_filtered_by_sphere);
    
    len = length(vdx_AABB);
    vFace=vFace(vdx_AABB,:);
    temp = findOverlappingFaces(vX, vY, vZ, vFace, Atom_info1, len);
    vdx=find(temp>0);
   
    len1 = length(vdx1_AABB);
    vFace1=vFace1(vdx1_AABB,:);
    temp= findOverlappingFaces(vX1, vY1, vZ1, vFace1, Atom_info, len1);
    vdx1=find(temp>0);
    
    figure;
    hold on;
    Sur.faces=vFace;
    Sur.vertices=[vX,vY,vZ];

    S=Sur; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.8235,0.1255,0.1529], 'FaceAlpha', 0.5, 'FaceColor',  [0.99216,0.96078,0.90196]);
    
    Sur.faces=vFace1;
    Sur.vertices=[vX1,vY1,vZ1];
    S=Sur; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 0.5, 'FaceColor',  [0.99216,0.96078,0.90196]);
    hold off; 
    axis off;
    axis equal;
    set(gcf, 'Color', 'white');
    axis image;
%     view(3);
%     figure;
%     hold on;
%     Sur.faces=vFace(vdx,:);
%     Sur.vertices=[vX,vY,vZ];
% 
%     S=Sur; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'b');
%     
%     Sur.faces=vFace1(vdx1,:);
%     Sur.vertices=[vX1,vY1,vZ1];
%     S=Sur; trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'EdgeColor', [0.5,0.5,0.5], 'FaceAlpha', 0.5, 'FaceColor', 'g');
%     hold off; 
    
    % 输出原始 vFace 的索引
    vdx = vdx_AABB(vdx);  % 还原原始 vFace 的索引
    num(1,5)=size(vFace,1)-size(vdx,1);
    num(1,6)=size(vdx,1);
    vdx1 = vdx1_AABB(vdx1);  % 还原原始 vFace1 的
    num(1,7)=size(vFace1,1)-size(vdx1,1);
    num(1,8)=size(vdx1,1);
function matching_rows = findOverlappingFaces(vX, vY, vZ, vFace, Atom_info1, len)

    matching_rows = false(len, 1); % 初始化匹配结果

    % 提取 vFace 对应的顶点坐标
    V1 = [vX(vFace(:, 1)), vY(vFace(:, 1)), vZ(vFace(:, 1))];
    V2 = [vX(vFace(:, 2)), vY(vFace(:, 2)), vZ(vFace(:, 2))];
    V3 = [vX(vFace(:, 3)), vY(vFace(:, 3)), vZ(vFace(:, 3))];

    % 计算球心：每个面片三个顶点的坐标的平均值
    center = (V1 + V2 + V3) / 3;

    % 计算球心到每个顶点的距离（欧几里得距离）
    d1 = sqrt(sum((V1 - center).^2, 2)); % 对每一行计算与球心的距离
    d2 = sqrt(sum((V2 - center).^2, 2));
    d3 = sqrt(sum((V3 - center).^2, 2));

    % 计算每个面片的半径：取每个面片到球心的最大距离
    radius = max([d1, d2, d3], [], 2);

    % 对于每个原子，检查是否与任意球形包围盒相交
    for i = 1 : size(Atom_info1, 1) % Atom_info1 的行数是原子数目
        % 提取当前原子的位置和半径
        atom_pos = Atom_info1(i, 2:4); % 原子的 (x, y, z) 坐标
        atom_radius =1.8*2.2110 * Atom_info1(i, 5); % 原子的半径

        % 计算球心到原子之间的距离
        distance = sqrt(sum((center - atom_pos).^2, 2)); % 计算每个球心与原子之间的距离

        % 找到所有满足条件的面片
        matching = distance < (radius + atom_radius); % 检查距离是否小于半径和原子半径之和

        % 更新匹配结果
        matching_rows = matching_rows | matching; % 使用逻辑“或”来更新匹配行
%         matching_rows=find(matching_rows>0);
    end
   
end

   
end