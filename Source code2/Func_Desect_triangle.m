function[tri]=Func_Desect_triangle(Points_tri)
    v1 = Points_tri(2,:) -  Points_tri(1,:) ;
    v2 = Points_tri(3,:)  - Points_tri(1,:) ;

    normal=cross(v1,v2);  % ������ = v1 �� v2

    % ��׼��������
    normal = normal / norm(normal);

    % ������ת����ʹ��ƽ�淨������z��ƽ��
    % ����Ҫ����������z�����
    z_axis = [0, 0, 1];  % Ŀ���ǽ����������뵽z��
    axis_of_rotation = cross(normal, z_axis);  % ��ת���Ƿ�������z��Ĳ��
    angle_of_rotation = acos(dot(normal, z_axis));  % ��ת�Ƕ��Ƿ�������z��ļн�

    % ʹ�� Rodrigues' ��ת��ʽ��������ת����
    K = [0, -axis_of_rotation(3), axis_of_rotation(2);
         axis_of_rotation(3), 0, -axis_of_rotation(1);
         -axis_of_rotation(2), axis_of_rotation(1), 0];
    R = eye(3) + sin(angle_of_rotation) * K + (1 - cos(angle_of_rotation)) * (K * K);

    % ��ת�����εĶ���
%     p1_rot = (R * p1')';
%     p2_rot = (R * p2')';
%     p3_rot = (R * p3')';
%     p4_rot=(R * p4')';
%     p5_rot=(R * p5')';
    Points_tri_rot=(R*Points_tri')';
    % ����ת���������ͶӰ��xyƽ�棨������z���꣩
%     p1_proj = p1_rot(1:2);
%     p2_proj = p2_rot(1:2);
%     p3_proj = p3_rot(1:2);
%     p4_proj = p4_rot(1:2);
%     p5_proj = p5_rot(1:2);
    Points_tri_proj=Points_tri_rot(:,1:2);
    % ���ӻ�����������ά�ռ��ͶӰ��xyƽ������
%     figure;
%     hold on;
% 
%     % ------------- 3D ������ ----------------
%     subplot(1, 2, 1);
%     hold on;
%     % ���������� (�߽���ɫ���ڲ���ɫ)
%     fill3(Points_tri(1:3,1), Points_tri(1:3,2), Points_tri(1:3,3),  [0.2196,0.3490,0.5373], 'EdgeColor','k' );
%     % ���ƺ�ɫʵ�ĵ�
%     plot3(Points_tri(4:end, 1), Points_tri(4:end, 2), Points_tri(4:end, 3), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 10);
%     xlabel('X'); ylabel('Y'); zlabel('Z');
%     title('3D Triangle');
% %     axis equal;
% axis off;
%     axis image;
%     grid on;

    % ------------- 2D ͶӰ (XY ƽ��) ----------------
%     subplot(1, 2, 2);
% figure;
% FontSize = 30;
% FontWeight = 'bold';
%    
%     dXStart = 4.5;
%     dXEnd = 5.2;
%     
%     dYStart = 6.6;
%     
%     dYEnd = 7.3;
% %     figure(i)
%     axes2 = axes('Parent', figure(1), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
% 
% %     hold on;
%     % ʹ�� fill ��ͶӰ
%     fill(Points_tri_proj(1:3,1), Points_tri_proj(1:3,2), [102/255, 190/255, 190/255], 'EdgeColor', 'k','linewidth',3);
% %     % ���ƺ�ɫʵ�ĵ�
%     plot(Points_tri_proj(:,1), Points_tri_proj(:,2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 25);
% %     xlabel('X'); ylabel('Y');
% %     title('2D Projection of the Triangle (XY Plane)');
% %     axis equal;
% %     grid on;
% axis image;
%     hold off;
    %���� Delaunay �����ʷ�
    tri = delaunay(Points_tri_proj(:,1), Points_tri_proj(:,2));
% 
% % %     ����������
%     figure;
%     triplot(tri, Points_tri_proj(:,1), Points_tri_proj(:,2), 'k'); % ����������
%     hold on;
%     plot(Points_tri_proj(:,1), Points_tri_proj(:,2), 'ro', 'MarkerFaceColor', 'r'); % ���Ƶ�
% % %     title('2D Delaunay Triangulation');
%     axis equal;
% % %     grid on;
%     hold off;
end