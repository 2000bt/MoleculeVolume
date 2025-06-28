%�˴��洢���̴���
% �������ε��ĸ���������

% % ����һ���������
% len=length(mLine);
% point_1=[vXTemp(mLine(1,1)),vYTemp(mLine(1,1))];
% point_2=[vXTemp(mLine(len,1)),vYTemp(mLine(len,1))];
% 
% % �жϵ��Ƿ��ھ�����
% % inRectangle = inpolygon(point(1), point(2), rect(:, 1), rect(:, 2));
% 
% % if inRectangle
% %     disp('���ھ����ڲ�������ı��Ǿ��εı߽�');
% % else
%     % ����㵽ÿ���ߵľ���
%     distances = zeros(4, 1);
%     for i = 1:4
%         p1 = rect(i, :);
%         p2 = rect(mod(i, 4) + 1, :);
%         distances(i) = point_to_line_distance(point_1, p1, p2);
%     end
%     
%     % �ҵ���С���뼰��Ӧ�ı�
%     [minDistance, minIndex] = min(distances);
%     disp(['�㵽���αߵ���������� ', num2str(minDistance), '������ı��ǵ� ', num2str(minIndex), ' ����']);
%     
%     distances1 = zeros(4, 1);
%     for i = 1:4
%         p1 = rect(i, :);
%         p2 = rect(mod(i, 4) + 1, :);
%         distances1(i) = point_to_line_distance(point_2, p1, p2);
%     end
%     
%     % �ҵ���С���뼰��Ӧ�ı�
%     [minDistance1, minIndex1] = min(distances1);
%     disp(['�㵽���αߵ���������� ', num2str(minDistance1), '������ı��ǵ� ', num2str(minIndex1), ' ����']);
%     
%     [mLine]=Func_rewrite(mLine,minIndex.minIndex1);
% end

function distance = point_to_line_distance(point, p1, p2)
    A = point - p1;
    B = p2 - p1;
    t = dot(A, B) / dot(B, B);
    
    if t <= 0
        distance = norm(point - p1);
    elseif t >= 1
        distance = norm(point - p2);
    else
        projection = p1 + t * B;
        distance = norm(point - projection);
    end
end