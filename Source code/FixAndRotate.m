%%
%把分子数据读出来
clear;clc;close all
strFile1 = 'H:\matlab2019a\bin\molecule_data\空间电子效应\宁利超1\A\density1.cub';
strFile = 'H:\matlab2019a\bin\molecule_data\空间电子效应\宁利超1\B\density1.cub';
[ Atom_info, AtomNum, ~, CubePoints, step_num, step, vStart ] = Func_GetCubePoints( strFile );
[ Atom_info1, AtomNum1, ~, CubePoints1, step_num1, step1, vStart1 ] = Func_GetCubePoints( strFile1 );
load LUT;
cAtomRadius = Func_LoadAtomRadius( 'Acce3.txt' );

[ vX, vY, vZ, iCloudLength, iFaceLength, vFace ] = Func_ContourV2( CubePoints, step_num( 1 ), step_num( 2 ), step_num( 3 ), LUT  );
[ vX1, vY1, vZ1, iCloudLength1, iFaceLength1, vFace1 ] = Func_ContourV2( CubePoints1, step_num1( 1 ), step_num1( 2 ), step_num1( 3 ), LUT  );

dStartX = vStart(1);
dStartY = vStart(2);
dStartZ = vStart(3);
for i = 1 : AtomNum
    iLenTemp = size(cAtomRadius);%这个意思是在所有原子找
    for j = 1 : iLenTemp
        if(Atom_info(i, 1) == cAtomRadius{ j, 3 })
            Atom_info(i, 5) = cAtomRadius{ j, 2 };
            break
        end
    end
end

for i = 1 : AtomNum1
    iLenTemp = size(cAtomRadius);
    for j = 1 : iLenTemp
        if(Atom_info1(i, 1) == cAtomRadius{ j, 3 })
            Atom_info1(i, 5) = cAtomRadius{ j, 2 };
            break
        end
    end
end
%%
%固定键长85O和Mg12,O86和Mg12
bond_lengthO1=2.11383/0.52917720859;
bond_lengthO2=2.11343/0.52917720859;
%新坐标
new_B = Func_Adjust_Coordinates(Atom_info, Atom_info1, 5, 6, 5, bond_lengthO1, bond_lengthO2);
% dss=distance3D(Atom_info(1,2:4),new_B);
% dss1=distance3D(Atom_info(2,2:4),new_B);
deta_x=new_B(1)-Atom_info1(1,2);
deta_y=new_B(2)-Atom_info1(1,3);
deta_z=new_B(3)-Atom_info1(1,4);
vX1=vX1+deta_x;
vY1=vY1+deta_y;
vZ1=vZ1+deta_z;
%开始旋转
result=cell(21,1);
a=1;
for b = 1:3
    for c = 0 : 60 : 360
% for b = 0
%     for c = 0
        if b==1
            [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(new_B(1), new_B(2), new_B(3), vX, vY, vZ,iCloudLength, Atom_info, c,0, 0 );
        elseif b==2
            [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(new_B(1), new_B(2), new_B(3), vX, vY, vZ,iCloudLength, Atom_info, 0,c, 0 );
        else
           [vX2, vY2, vZ2, Atom_info2] = Func_Rotate(new_B(1), new_B(2), new_B(3), vX, vY, vZ,iCloudLength, Atom_info, 0,0, c ); 
        end
%          [dVol,~]= test3(vX2, vY2, vZ2, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1);
% % 
    result{a,1}=dVol;
% %     result{a,2}=cross;
    a=a+1;
%         figure;
%         hold on;
%         % % view(180,0);
%         % % view(3);
%         Surface1.faces = vFace1;
%         Surface1.vertices = [vX1,vY1,vZ1];
%         S=Surface1;
%         hh=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [1,0.98039,0.98039] );
%         set(hh,'EdgeColor',[0.8235,0.1255,0.1529]);
%         
%         Surface2.faces = vFace;
%         Surface2.vertices = [vX2,vY2,vZ2];
%         S=Surface2; h=trisurf(S.faces, S.vertices(:,1),S.vertices(:,2),S.vertices(:,3),'FaceAlpha', 0.5, 'FaceColor', [0.99216,0.96078,0.90196]);
%         set(h,'EdgeColor',[0.2196,0.3490,0.5373])
%         hold off;
    end
end
% dis_MgO1= distance3D(Atom_info1(1,2:4), Atom_info(1,2:4));
% dis_MgO2= distance3D(Atom_info1(1,2:4), Atom_info(2,2:4));

% p22=adjust_distance(Atom_info1(1,2:4),Atom_info(1,2:4),bond_lengthO1);
% 
% dss=distance3D(Atom_info1(1,2:4),p22);
%固定距离键1
% model=[vX,vY,vZ];
% model_new=move_model(Atom_info1(1,2:4),Atom_info(1,2:4),model,bond_lengthO1);
% Atom_info_new=move_model(Atom_info1(1,2:4),Atom_info(1,2:4),Atom_info(1,2:4),bond_lengthO1);
% Atom_info2_new=move_model(Atom_info1(1,2:4),Atom_info(1,2:4),Atom_info(2,2:4),bond_lengthO1);
% dss=distance3D(Atom_info1(1,2:4),Atom_info_new);
% %算出相差多少角度
% theta_goal=Func_ComPuteCos(distance3D(Atom_info1(1,2:4),Atom_info_new),distance3D(Atom_info_new,Atom_info(2,2:4)),bond_lengthO2);
% theta2=Func_ComPuteCos(distance3D(Atom_info1(1,2:4),Atom_info_new),distance3D(Atom_info_new,Atom_info(2,2:4)),distance3D(Atom_info1(1,2:4),Atom_info2_new));
% %旋转？
% % 计算旋转矩阵 (Rodrigues' rotation formula)
% % theta_rotate=theta_goal-theta2;
% theta_rotate=theta2-theta_goal;
% A=Atom_info_new;
% B=Atom_info1(1,2:4);
% C=Atom_info2_new;
% % 计算向量
% v1 = B - A;
% v2 = C - A;
% 
% % 计算法向量
% axis = cross(v1, v2);
% % normal = normal / norm(normal);  % 归一化
% 
% 
%     % 确保轴向量是单位向量
%     axis = axis / norm(axis);
%     
%     % 计算旋转角度的正弦和余弦值
%     cos_angle = cos(theta_rotate);
%     sin_angle = sin(theta_rotate);
%     
%     % 计算旋转矩阵的偏置部分
%     bias = (1 - cos_angle) * axis * axis';
%     
%     % 计算旋转矩阵的交叉部分
%     point=C - A;
%     cross_product = sin_angle * cross(axis, point);
%     
%     % 计算旋转矩阵
%     rotation_matrix = eye(3) + bias + cross_product;
%     
%     % 应用罗德里格斯旋转公式
%     rotated_vector = rotation_matrix * point';
% C_new =rotated_vector'+A;
% K = [0, -normal(3), normal(2);
%      normal(3), 0, -normal(1);
%      -normal(2), normal(1), 0];
% I = eye(3);
% 
% R = I + sin(theta_rotate) * K + (1 - cos(theta_rotate)) * (K * K);

% 将 C 平移到 A 为原点
% C_translated = C - A;
% 
% % 应用旋转矩阵
% C_rotated = (R * C_translated')';
% 
% % 将 C 平移回去
% C_new = C_rotated + A;
% C_new=Func_Rotate(Atom_info_new(1), Atom_info_new(2), Atom_info_new(3), Atom_info2_new(1), Atom_info2_new(2), Atom_info2_new(3),iCloudLength, Atom_info, c,0, 0 );
% distance3D(Atom_info1(1,2:4),C_new)
% distance3D(Atom_info1(1,2:4),C)


%%
% model_new=move_model(Atom_info1(1,2:4),Atom_info(1,2:4),Atom_info(1,2:4),bond_lengthO1);
% model_new1=move_model(Atom_info1(1,2:4),Atom_info(1,2:4),Atom_info(2,2:4),bond_lengthO1);
% model_points = rotate_model_to_distance(Atom_info1(1,2:4),model_new, model_new1, bond_lengthO2);
% dss1=distance3D(Atom_info1(1,2:4),model_points);
% dss=distance3D(model_new,Atom_info1(1,2:4));
function model_points_adjusted = move_model(p1, p2, model_points, target_distance)
    current_distance = norm(p2 - p1);
    distance_diff = target_distance - current_distance;
    direction = (p2 - p1) / norm(p2 - p1);
    translation_vector = direction * distance_diff;
    model_points_adjusted = model_points + translation_vector;
end
% % 调整点的位置，使其达到目标距离
% function new_p2 = adjust_distance(p1, p2, target_distance)
%     direction = (p2 - p1) / norm(p2 - p1);
%     new_p2 = p1 + direction * target_distance;
% end
% % %  [dVol,cross]= test3(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX2, vY2, vZ2, iFaceLength1, vFace1,step1);
function d = distance3D(p1, p2)
    % 计算两个三维点之间的欧几里得距离
    % p1和p2是1x3的向量，表示三维空间中的点
    d = sqrt(sum((p2 - p1).^2));
end
function theta=Func_ComPuteCos(d1,d2,d3)
%     disp([d1,d2,d3]);
    pos=(d1*d1+d2*d2-d3*d3)/(2*d1*d2);
%     disp(pos);
    angle = acos(pos); 
    disp(angle);
%     realangle = angle*180/pi; 
%     theta=realangle;
theta=angle;
%     disp(realangle);
end

function new_B = Func_Adjust_Coordinates(Atom1, Atom2, i, j, k, d1, d2)
% 提取坐标
A1 = Atom1(i-4, 2:4);
A2 = Atom1(j-4, 2:4);
B_initial = Atom2(k-4, 2:4);
% 定义目标函数
objective = @(B) (norm(A1 - B) - d1)^2 + (norm(A2 - B) - d2)^2;
% 设置优化选项
options = optimoptions('fmincon', 'Display', 'off');
% 运行优化
new_B = fmincon(objective, B_initial, [], [], [], [], [], [], [], options);
end
