% % ����һ���µ�ͼ�δ���
% figure;
% 
% % ����ƽ��
% planeVertices = [0, 0, 0; 22, 0, 0;  22, 20, 0; 0, 20, 0];
% planeFaces = [1, 2, 3, 4];
% patch('Vertices', planeVertices, 'Faces', planeFaces, 'FaceColor', 'none', 'FaceAlpha', 0.5);
% 
% hold on;
% 
% % ���������ε��������㣬ʹ��С��ƽ��
% triangleVertices = [2.5, 0.5, -2.5; 1, 4, -1; 4, 2, -1.5];
% triangleVertices1 = [5.25, 0.5, -1.5; 3.75, 4, 0; 6.75, 2, -0.5];
% triangleVertices2 =  [8, 0.5, -1.1; 6.5, 4, 0.4; 9.5, 2, -0.1];
% triangleVertices3 = [10.75, 0.5, -1; 9.25, 4, 0.5; 12.25, 2, 0];
% % triangleVertices4 = [13.5, 0.5, -0.5; 12, 4, 1; 15, 2, 0.5];
% % triangleVertices5 = [16.25, 0.5, 0; 14.75, 4, 1.5; 17.75, 2, 1];
% triangleVertices6 = [13.5, 0.5, 1; 12, 4, 2.5; 15, 2, 2];
% triangleVertices7 = [16.25, 0.5, 0; 16.25, 0.5, 4; 17.75, 0.5, 0];
% % triangleVertices8 = [24.5, 0.5, 0; 23, 0.5, -2; 26, 0.5, 0];
% triangleVertices9 = [19, 0.5, 0; 19, 8, 0; 20.5, 2, 0];
% % ��ƽ���·�����С�����Σ���ɫΪ����ɫ
% patch('Vertices', triangleVertices, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices1, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices2, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices3, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices4, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices5, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices6, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices7, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% % patch('Vertices', triangleVertices8, 'Faces', [1, 2, 3], 'FaceColor', [1, 1, 0], 'FaceAlpha', 1);
% patch('Vertices', triangleVertices9, 'Faces', [1, 2, 3], 'FaceColor', [0.2196,0.3490,0.5373], 'FaceAlpha', 1);
% 
% % ����ͼ������
% % axis equal;
% axis image;
% ������ά�߶ε������յ�
startPoint = [0, 0, 0];
endPoint = [4, 4, 4];

% ����ƽ����z�����ƽ���λ��
zPositions = [1, 2, 3];

% ������ά�߶�
figure;
plot3([startPoint(1), endPoint(1)], [startPoint(2), endPoint(2)], [startPoint(3), endPoint(3)], 'r-', 'LineWidth', 4);
hold on;
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Line Segment and Intersecting Planes');

% ���㲢�����߶�����ƽ��Ľ���
for i = 1:length(zPositions)
    z = zPositions(i);
    
    % ���㽻��
    t = (z - startPoint(3)) / (endPoint(3) - startPoint(3));
    intersectPoint = startPoint + t * (endPoint - startPoint);
    
    % ���ƽ���
    plot3(intersectPoint(1), intersectPoint(2), z, 'r.', 'MarkerSize', 8, 'LineWidth', 2);
    
    % ������ƽ��
    [X, Y] = meshgrid(linspace(startPoint(1), endPoint(1), 10), linspace(startPoint(2), endPoint(2), 10));
    Z = z * ones(size(X));
    surf(X, Y, Z, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none');
end

legend('Line Segment', 'Intersect Points', 'Intersecting Planes', 'Location', 'best');
hold off;

axis off;
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('3D Plane and Small Triangle Below');

% ��ʾͼ��
% legend('Plane', 'Triangle');

% �ر�ͼ�λ���
% hold off;
%%
% ��������ֱ�ߵ�����
x1 = [0, 2];
y1 = [1.5, 3.5];

x2 = [1, 3];
y2 = [6, 2];

% ����һ���µ�ͼ�δ���
figure;

% ���Ƶ�һ��ֱ��
plot(x1, y1, 'k', 'LineWidth', 2);
hold on;  % ����ͼ�Σ��Ա���Ӹ����ͼ��Ԫ��

% ���Ƶڶ���ֱ��
plot(x2, y2, 'k', 'LineWidth', 2);
scatter(x1(1),y1(1),35,'k','filled');
scatter(x1(2),y1(2),35,'k','filled');
scatter(x2(1),y2(1),35,'k','filled');
scatter(x2(2),y2(2),35,'k','filled');
% ��������ֱ�ߵİ�Χ��
% min_x = min([x1, x2]);
% max_x = max([x1, x2]);
% min_y = min([y1, y2]);
% max_y = max([y1, y2]);
% 
width = x1(2) - x1(1);
height = y1(2) - y1(1);
width1 = x2(2) - x2(1);
height1 = y2(1) - y2(2);
% ���ư�Χ��
rectangle('Position', [x1(1), y1(1), width, height], 'EdgeColor', [0.8235,0.1255,0.1529], 'LineWidth', 3,'LineStyle', '--');
rectangle('Position', [x2(1), y2(2), width1, height1], 'EdgeColor', [0.2196,0.3490,0.5373], 'LineWidth', 3,'LineStyle', '--');
% ������ķ�Χ
axis image;
axis off;
% axis equal;
% axis([0, 10, 0, 10]);

% % ��ӱ���ͱ�ǩ
% title('Lines and their bounding box');
% xlabel('X-axis');
% ylabel('Y-axis');
% 
% % ��ʾͼ��
% legend('Line 1', 'Line 2', 'Bounding Box');

