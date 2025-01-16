    function [X,Y,Z,totalVoxels]=Func_ProcessAllBoundaries(Seedcube_num, CubePoints, step_num1, step_num2, step_num3, LUT)
    % 创建一个标记数组，记录每个体元是否已处理
    Processedcube = false(size(CubePoints, 1), 1);%判断插值过的体元
    Traversedcube = false(size(CubePoints, 1), 1);%判断遍历过的体元
    totalVoxels = 0; 
    % 初始化边界体元
    [VoxelofBoundary, X, Y, Z] = Func_SingleCube(Seedcube_num, CubePoints, step_num1, step_num2, step_num3, LUT);
    
    % 反复取出VoxelofBoundary数组的末尾元素  
    while ~isempty(VoxelofBoundary)
        % 取出数组的最后一个体元编号作为新的Seedcube_num 
        Seedcube_num = VoxelofBoundary(end);
        VoxelofBoundary(end) = [];  % 删除末尾元素
        
        % 判断此体元是否已经处理过
        if Processedcube(Seedcube_num)
            continue;  % 如果已处理过，则跳过
        end
        
        % 如果没有处理过，则调用Func_SingleCube函数
        [newVoxelofBoundary, newX, newY, newZ] = Func_SingleCube(Seedcube_num, CubePoints, step_num1, step_num2, step_num3, LUT);
        
        % 将新的边界体元和插值点添加到结果中
        VoxelofBoundary = [VoxelofBoundary, newVoxelofBoundary];
        X = [X, newX];
        Y = [Y, newY];
        Z = [Z, newZ];
        
        % 标记此体元为已处理
        Processedcube(Seedcube_num) = true;
        totalVoxels = totalVoxels + 1;  
    end      
end
