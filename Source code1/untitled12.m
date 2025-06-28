numRows = 500000; % 总行数
numFirstRows = 100000; % 前两万行

% 创建一个全零数组
A = zeros(numRows, 1);

% 将前两万行设置为1
A(1:numFirstRows) = 1;
tic;
B=find(A~=0);
time1=toc;

fprintf('代码段1执行时间: %f 秒\n', time1);