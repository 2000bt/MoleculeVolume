
save itrz11_70-130.mat result;

%% 绝对误差
result=result1;
Ab_error=zeros(21,1);
for i=1:21
 Ab_error(i,1)=round(result{i,1}-result{i,3},4);
end
%% 相对误差
re_error=zeros(21,1);
for i=1:21
 re_error(i,1)=round((abs(Ab_error(i,1))/result{i,3})*100,4);
end
re_error1=zeros(21,1);
for i=1:21
 re_error1(i,1)=round((Ab_error(i,1)/result{i,3})*100,4);
end
%%
result(:,4) = num2cell(Ab_error(:)); 
result(:,5) = num2cell(re_error(:));
%% 平均相对误差
avg = mean(re_error(:));  
%% 标准偏差
std_all = std(re_error1(:));
%%
result1=result;
% save compare_itrz11.mat result1
%%
data=zeros(7,3);


for i=1:7
% for i=8:14
    a=result{i,2};
    data(i,1)=a(1,1)+a(1,2)-a(1,11)-a(1,12);
    data(i,2)=a(1,3)+a(1,5);
    data(i,3)=a(1,7)+a(1,9);
%     dev(i,1)=
end
% %% 示例数据
% % 示例数据，每组数据包含 4 个数
% data = [
%     100, 80, 120, 90;  
%     110, 90, 130, 95;  
%     120, 100, 140, 110; 
%     80, 70, 100, 85   
% ];

% 颜色配置
colors = [
    [0.3020,0.5216,0.7412];
   
 
    [0.3490,0.6627,0.3529]; 
    [0.9686,0.5647,0.2392];
];

% colors = [
%     0.2196, 0.3490, 0.5373;  % 深蓝（第一列）
%     0.8235, 0.1255, 0.1529;  % 深红
%     0.8706, 0.5608, 0.0196;  % 深橙
% %     0.1804, 0.5451, 0.3412   % 深绿
% ];

% 创建图形
figure;
hold on;

% 设置横坐标位置，每组数据之间留间隔
numGroups = size(data,1);
x = 1.5 * (1:numGroups);  % 每组数据间隔 1.5，而不是 1
xOffset = 0.3;  % 条形的横向偏移量

% 绘制第一列数据
b1 = bar(x - xOffset, data(:,1), 0.4, 'FaceColor', colors(1, :)); 

% 绘制剩余三列数据（堆叠），并调整 x 轴偏移
b2 = bar(x + xOffset, data(:,2:3), 0.4, 'stacked');

% 设置堆叠部分的颜色
for i = 1:2
    b2(i).FaceColor = colors(i+1, :);
end

% 设置坐标轴标签
% title('数据分列柱状图');
ylabel('三角面片数','FontSize', 14);
xlabel('旋转角度(°)','FontSize', 14);
set(gca, 'XTick', x, 'XTickLabel', {'70', '80', '90','100', '110', '120','130'},'FontSize', 14);

% 显示图例
% legend({'应筛除三角面片总数', 'AABB筛除数', 'Sphere筛除数'}, 'Location', 'northwest','FontSize', 13);

% grid on;
% axis image;
hold off;





% 显示图形

% data=data1(:,2)./data1(:,1)*100;
% re=sum(data)/21;
% data=[];
% data(:,1)=data1(:,1)-data1(:,4);%应当筛除
% data(:,2)=data1(:,2);%AABB
% data(:,3)=data1(:,3);%AABB
%%
save Bound_ap.mat data;
% dev=[];
% for i=1:21
%     dev(i,1)=result{i,5};
% %     dev(i,1)=
% end
%%
% for i=1:14
%     result{i,2}=result1{i,2};
% end
% save method2_apy1370-130.mat result