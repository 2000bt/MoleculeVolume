function [Surface1]=Func_ExcluDegrada(Surface)
% �����ݲ�ֵ
    epsilon = 1e-6;

    % ��ȡ���������εĶ�������
    V1 = Surface.vertices(Surface.faces(:, 1), :);  % ���� 1
    V2 = Surface.vertices(Surface.faces(:, 2), :);  % ���� 2
    V3 = Surface.vertices(Surface.faces(:, 3), :);  % ���� 3

    % ����ÿ�������εı����� V1V2 �� V1V3
    V1V2 = V2 - V1;  % �� V1 �� V2 ������
    V1V3 = V3 - V1;  % �� V1 �� V3 ������

    % ��������ÿ������
    cross_x = V1V2(:, 2).*V1V3(:, 3) - V1V2(:, 3).*V1V3(:, 2);  % X ����
    cross_y = V1V2(:, 3).*V1V3(:, 1) - V1V2(:, 1).*V1V3(:, 3);  % Y ����
    cross_z = V1V2(:, 1).*V1V3(:, 2) - V1V2(:, 2).*V1V3(:, 1);  % Z ����

    % ��������ģ��
    cross_norm = sqrt(cross_x.^2 + cross_y.^2 + cross_z.^2);

    % �ж���Щ���������˻��� (ģ��С�� epsilon)
    valid_faces = cross_norm >= epsilon;
%     num=size(Surface.faces,1)-size(valid_faces,1);
    % ɾ���˻���������
    Surface.faces = Surface.faces(valid_faces, :);
    Surface1=Surface;
end