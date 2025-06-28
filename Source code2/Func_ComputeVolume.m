function total_volume=Func_ComputeVolume(Surface)
% ��ʼ�����
total_volume = 0;

% ��ȡÿ�������εĶ�������
for i = 1:size(Surface.faces, 1)
    % ��ȡ��ǰ�����ε���������
    V1 = Surface.vertices(Surface.faces(i, 1), :);
    V2 = Surface.vertices(Surface.faces(i, 2), :);
    V3 = Surface.vertices(Surface.faces(i, 3), :);
    
    % �������� V1V2 �� V1V3
    V1V2 = V2 - V1;
    V1V3 = V3 - V1;
    
    % ������
    cross_product = cross(V1V2, V1V3);
    
    % �����������
    volume_contribution = dot(V1, cross_product) / 6;
    
    % �ۼ����
    total_volume = total_volume + volume_contribution;
end

% ��ʾ�ܵ����
disp(['��������Ϊ: ', num2str(total_volume)]);

end
