% ����㼯������
totalPoints = 20;  % �ܵ���
half = floor(totalPoints / 2);  % ����ǳ��ܵĵ㣬�ұ���ϡ��ĵ�

% X �� Y ���꣬��߳��ܣ��ұ�ϡ��
vXTemp = zeros(totalPoints, 1);  % ��ʼ�� X ����
vYTemp = zeros(totalPoints, 1);  % ��ʼ�� Y ����

% �������ɳ��ܵ�
for i = 1:half
    vXTemp(i) = rand() * 5;  % ��벿�ֵ� X ������ [0, 5] ֮�䣬����
    vYTemp(i) = rand() * 10;  % ��벿�ֵ� Y ������ [0, 10] ֮�䣬����
end

% �Ұ������ϡ���
for i = half+1:totalPoints
    vXTemp(i) = rand() * 5 + 5;  % �Ұ벿�ֵ� X ������ [5, 10] ֮�䣬ϡ��
    vYTemp(i) = rand() * 2;  % �Ұ벿�ֵ� Y ������ [0, 2] ֮�䣬ϡ��
end

% ���ӻ��㼯
figure;
hold on;
plot(vXTemp(1:half), vYTemp(1:half), 'bo');  % ��ߵĳ��ܵ�
plot(vXTemp(half+1:end), vYTemp(half+1:end), 'ro');  % �ұߵ�ϡ���
title('Left Dense Points vs Right Sparse Points');
xlabel('X');
ylabel('Y');
grid on;

figure;
hold on;
plot(vXTemp,vYTemp,'ko');
hold off;
% ���������뾶Ϊƽ�������1.5��
dR = 5 * averageDistance;
%%
% vXTemp(5,:)=[];
% vYTemp(5,:)=[];

[mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_TwoSearch(vXTemp(1:half), vYTemp(1:half), 4/5);