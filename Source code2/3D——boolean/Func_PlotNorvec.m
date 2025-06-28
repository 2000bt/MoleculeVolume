function [N,flags]=Func_PlotNorvec(Points_tri,N_orgin,if_compara)
    flags=false;
    N=zeros(1,4);
%     patch(Points_tri(:,1),Points_tri(:,2),Points_tri(:,3),'b','EdgeColor', 'k', 'FaceAlpha', 0.5);
%���㷨����������
    V1V2 = Points_tri(2,:) - Points_tri(1,:);  % ��P1P2
    V1V3 =  Points_tri(3,:) -  Points_tri(1,:);  % ��P1P3

    % ���㷨�����������
    N(1,1:3) = cross(V1V2, V1V3);
%     centroid = (Points_tri(1,:)  + Points_tri(2,:)  + Points_tri(3,:) ) / 3;
if(if_compara)
    if(sign(N_orgin) ~= sign(N(1,3)))
        flags=true;
    end
end
 % ����ÿ�������εı����� V1V2 �� V1V3
%     V1V2 = V2 - V1;  % �� V1 �� V2 ������
%     V1V3 = V3 - V1;  % �� V1 �� V3 ������

    % ��������ÿ������
    cross_x = V1V2(:, 2).*V1V3(:, 3) - V1V2(:, 3).*V1V3(:, 2);  % X ����
    cross_y = V1V2(:, 3).*V1V3(:, 1) - V1V2(:, 1).*V1V3(:, 3);  % Y ����
    cross_z = V1V2(:, 1).*V1V3(:, 2) - V1V2(:, 2).*V1V3(:, 1);  % Z ����

    % ��������ģ��
    N(1,4) = sqrt(cross_x.^2 + cross_y.^2 + cross_z.^2);


% ���Ʒ����������������������⣩
% quiver3(centroid(1), centroid(2), centroid(3), N(1), N(2), N(3), 0.5, 'r', 'LineWidth', 2,'MaxHeadSize', 0.5);

end