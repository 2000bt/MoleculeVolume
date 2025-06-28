% 定义点集的数量
totalPoints = 20;  % 总点数
half = floor(totalPoints / 2);  % 左边是稠密的点，右边是稀疏的点

% X 和 Y 坐标，左边稠密，右边稀疏
vXTemp = zeros(totalPoints, 1);  % 初始化 X 坐标
vYTemp = zeros(totalPoints, 1);  % 初始化 Y 坐标

% 左半边生成稠密点
for i = 1:half
    vXTemp(i) = rand() * 5;  % 左半部分的 X 坐标在 [0, 5] 之间，稠密
    vYTemp(i) = rand() * 10;  % 左半部分的 Y 坐标在 [0, 10] 之间，稠密
end

% 右半边生成稀疏点
for i = half+1:totalPoints
    vXTemp(i) = rand() * 5 + 5;  % 右半部分的 X 坐标在 [5, 10] 之间，稀疏
    vYTemp(i) = rand() * 2;  % 右半部分的 Y 坐标在 [0, 2] 之间，稀疏
end

% 可视化点集
figure;
hold on;
plot(vXTemp(1:half), vYTemp(1:half), 'bo');  % 左边的稠密点
plot(vXTemp(half+1:end), vYTemp(half+1:end), 'ro');  % 右边的稀疏点
title('Left Dense Points vs Right Sparse Points');
xlabel('X');
ylabel('Y');
grid on;

figure;
hold on;
plot(vXTemp,vYTemp,'ko');
hold off;
% 设置搜索半径为平均距离的1.5倍
dR = 5 * averageDistance;
%%
% vXTemp(5,:)=[];
% vYTemp(5,:)=[];

[mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_TwoSearch(vXTemp(1:half), vYTemp(1:half), 4/5);