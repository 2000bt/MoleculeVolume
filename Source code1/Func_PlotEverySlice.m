function[vXtemp,vYtemp,vXtemp1,vYtemp1,mLine,mLine1,vContourPoint,vContourPoint1,iCountContour,iCountContour1,totalVolume]= Func_PlotEverySlice(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1)
%matX每一列代表一层点的的横坐标，有多少列就有多少层
% close all
% tic
% for iii=1:6
% FontSize = 30; 
% FontWeight = 'bold';
totalVolume=0;
%估计大概有多少层以及起始以及最终层
% dSlice=step1(1);
dSlice=(step(1)+step1(1))/2;               
% dSlice=(step(1)+step1(1))/3.5;
% dSlice=0.2885;
% dStartZ = vStart1(3)-14;
if vStart(3)>min(min(vZ),min(vZ1))
    dStartZ=min(min(vZ),min(vZ1))-dSlice;
else
    dStartZ=vStart(3);
end
% dStartZ=min(min(vZ),min(vZ1))-2*dSlice;
Max_Z=max(vZ);
Min_Z=min(vZ);
iOffset=round((Min_Z-dStartZ)/dSlice);
Max_Layer=round((Max_Z-dStartZ)/dSlice);
iLayer=Max_Layer-iOffset+1;

Max_Z1=max(vZ1);
Min_Z1=min(vZ1);
iOffset1=round((Min_Z1-dStartZ)/dSlice);
Max_Layer1=round((Max_Z1-dStartZ)/dSlice);
iLayer1=Max_Layer1-iOffset1+1;
%生成三角面片的线矩阵
vFaceline=zeros(iFaceLength*3,2);
vFaceline(1:iFaceLength,1)=vFace(1:iFaceLength,1);
vFaceline(1:iFaceLength,2)=vFace(1:iFaceLength,2);
vFaceline(iFaceLength+1:iFaceLength*2,1)=vFace(1:iFaceLength,2);
vFaceline(iFaceLength+1:iFaceLength*2,2)=vFace(1:iFaceLength,3);
vFaceline(iFaceLength*2+1:iFaceLength*3,1)=vFace(1:iFaceLength,1);
vFaceline(iFaceLength*2+1:iFaceLength*3,2)=vFace(1:iFaceLength,3);
vFaceline=sort(vFaceline,2);
vFaceline=unique(vFaceline,'row','stable');

FacelineLen=length(vFaceline);

%通过三个按分层序号排列的XYZ坐标矩阵
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%预计每层有几个数据
vLayer=zeros(Max_Layer,1);
vLayer1=zeros(Max_Layer1,1);
is_used=false(length(vZ),1);
is_used1=false(length(vZ),1);
for i = 1:FacelineLen
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
%           dX1 = vX(vFaceline(i, 1));
%           dY1 = vY(vFaceline(i, 1));
          dZ1 = vZ(vFaceline(i, 1));
%           dX2 = vX(vFaceline(i, 2));
%           dY2 = vY(vFaceline(i, 2));
          dZ2 = vZ(vFaceline(i, 2));
          a=max(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          b=min(dZ1,dZ2);
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      vLayer(k,1)= vLayer(k,1)+1;
                   elseif((a==c)&&((is_used(aux)==0)))
                      vLayer(k,1)= vLayer(k,1)+1;
                      is_used(aux)=true;
                   else
                       continue;
                   end
              end
                      
          end
end
%%%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer);
matX=zeros(len,Max_Layer);
matY=zeros(len,Max_Layer);
matZ=zeros(len,Max_Layer);

for i = 1:FacelineLen
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
          dX1 = vX(vFaceline(i, 1));
          dY1 = vY(vFaceline(i, 1));
          dZ1 = vZ(vFaceline(i, 1));
          dX2 = vX(vFaceline(i, 2));
          dY2 = vY(vFaceline(i, 2));
          dZ2 = vZ(vFaceline(i, 2));
          a=max(dZ1,dZ2);
          b=min(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline(i, 1);
          else
              aux=vFaceline(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                   elseif((a==c)&&((is_used1(aux)==0)))
                      matX(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY(vLayer(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ(vLayer(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer(k,1)= vLayer(k,1)-1;
                      is_used1(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end


vFaceline1=zeros(iFaceLength1*3,2);
vFaceline1(1:iFaceLength1,1)=vFace1(1:iFaceLength1,1);
vFaceline1(1:iFaceLength1,2)=vFace1(1:iFaceLength1,2);
vFaceline1(iFaceLength1+1:iFaceLength1*2,1)=vFace1(1:iFaceLength1,2);
vFaceline1(iFaceLength1+1:iFaceLength1*2,2)=vFace1(1:iFaceLength1,3);
vFaceline1(iFaceLength1*2+1:iFaceLength1*3,1)=vFace1(1:iFaceLength1,1);
vFaceline1(iFaceLength1*2+1:iFaceLength1*3,2)=vFace1(1:iFaceLength1,3);
vFaceline1=sort(vFaceline1,2);
vFaceline1=unique(vFaceline1,'row','stable');

FacelineLen1=length(vFaceline1);

is_used2=false(length(vZ1),1);
is_used3=false(length(vZ1),1);
for i = 1:FacelineLen1
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
%           dX1 = vX(vFaceline1(i, 1));
%           dY1 = vY(vFaceline1(i, 1));
          dZ1 = vZ1(vFaceline1(i, 1));
%           dX2 = vX(vFaceline1(i, 2));
%           dY2 = vY(vFaceline1(i, 2));
          dZ2 = vZ1(vFaceline1(i, 2));
          a=max(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline1(i, 1);
          else
              aux=vFaceline1(i, 2);
          end
          b=min(dZ1,dZ2);
          
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
%           index=round((a-dStartZ)/dSlice);
%           index1=round((b-dStartZ)/dSlice);
%           c=index*dSlice+dStartZ;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      vLayer1(k,1)= vLayer1(k,1)+1;
                   elseif((a==c)&&((is_used2(aux)==0)))
                      vLayer1(k,1)= vLayer1(k,1)+1;
                      is_used2(aux)=true;
                   else
                       continue;
                   end
              end
                      
          end
end
%同步判断在哪层，然后同步计算交点数据，存放在矩阵里
% vLayer1(:,1)=vLayer(:,1);
len=max(vLayer1);
matX1=zeros(len,Max_Layer1);
matY1=zeros(len,Max_Layer1);
matZ1=zeros(len,Max_Layer1);

for i = 1:FacelineLen1
%     if(1 == vUsed(vFace(i, 1))&&1 == vUsed(vFace(i, 2))&& 1 == vUsed(vFace(i, 3)))
          %hold on;
          dX1 = vX1(vFaceline1(i, 1));
          dY1 = vY1(vFaceline1(i, 1));
          dZ1 = vZ1(vFaceline1(i, 1));
          dX2 = vX1(vFaceline1(i, 2));
          dY2 = vY1(vFaceline1(i, 2));
          dZ2 = vZ1(vFaceline1(i, 2));
          a=max(dZ1,dZ2);
          b=min(dZ1,dZ2);
          if(a==dZ1)
              aux=vFaceline1(i, 1);
          else
              aux=vFaceline1(i, 2);
          end
          %判断该三角面的线段属于哪一层,同时计算出交点放在一个矩阵
          
%           if(a==b||((a-c)*(b-c)>0))
%               continue;
          if(a==b)
             continue;
          else
              index=round((a-dStartZ)/dSlice);
              index1=round((b-dStartZ)/dSlice);
              for k = index1:index
                   c=k*dSlice+dStartZ;
                   if((a-c)*(b-c)<0)
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ1(vLayer1(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer1(k,1)= vLayer1(k,1)-1;
                   elseif((a==c)&&((is_used3(aux)==0)))
                      matX1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dX1,dX2,dZ1,dZ2);
                      matY1(vLayer1(k,1),k)=Func_ComputeOrg(k,dStartZ,dSlice,dY1,dY2,dZ1,dZ2);
                      matZ1(vLayer1(k,1),k)=c;
                      %cellArray{vLayer(index,1),index}=temp_mat;
                      vLayer1(k,1)= vLayer1(k,1)-1;
                      is_used3(aux)=true;
                   else
                       continue;
                   end
                   
%                    if((a-c)*(b-c)<=0)
                   
              end
                      
          end
end

%公共层点集
iOffset11=max(iOffset,iOffset1);
iLayer11=min(Max_Layer,Max_Layer1)-iOffset11+1;
lengthStart=0;
lengthEnd=0;
for j = 1:iLayer11
    iTemp = iOffset11 + j - 1;
    vXtemp=matX(:,iTemp);
    vXtemp=vXtemp(vXtemp~=0);
    
    vYtemp=matY(:,iTemp);
    vYtemp=vYtemp(vYtemp~=0);

    vXtemp1=matX1(:,iTemp);
    vXtemp1=vXtemp1(vXtemp1~=0);

    vYtemp1=matY1(:,iTemp);
    vYtemp1=vYtemp1(vYtemp1~=0);

    if(length(vXtemp)<=2)
        continue;
    end

    vZtemp=matZ(:,iTemp);
    vZtemp=vZtemp(vZtemp~=0);

    if(length(vXtemp1)<=2)
        continue;
    end

    vXY=[vXtemp,vYtemp];
    vXY1=[vXtemp1,vYtemp1];
    vXY=unique(vXY,'row','stable');
    vXY1=unique(vXY1,'row','stable');
    lengthStart1=length(vXY)+length(vXY1);
    lengthStart=lengthStart+lengthStart1;
    fprintf('包围盒过滤前%d层点的数量为%d\n', j, lengthStart1);
    fprintf('包围盒过滤前总的点的数量为%d\n',  lengthStart);

    vZtemp1=matZ1(:,iTemp);
    vZtemp1=vZtemp1(vZtemp1~=0);

    d=iTemp*dSlice+dStartZ;
    vZ=d * ones(length(vXY), 1);
    vZ1=d * ones(length(vXY1), 1);

     % 动态计算当前层的坐标范围
    x_min = min([vXY(:, 1); vXY1(:, 1)]);
    x_max = max([vXY(:, 1); vXY1(:, 1)]);
    y_min = min([vXY(:, 2); vXY1(:, 2)]);
    y_max = max([vXY(:, 2); vXY1(:, 2)]);

    % 设置适当的边界间隔（可调节）
    margin = 0.1; % 增加10%的间距
    x_range = x_max - x_min;
    y_range = y_max - y_min;
    x_min = x_min - margin * x_range;
    x_max = x_max + margin * x_range;
    y_min = y_min - margin * y_range;
    y_max = y_max + margin * y_range;

   
    % 初始化图形
    figure;

    % 绘制当前点集
    %hold on;  % 保持当前图像
    plot(vXY(:, 1), vXY(:, 2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); % 使用蓝色点绘制
    hold on;
    plot(vXY1(:, 1), vXY1(:, 2),'.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % 使用红色点绘制
    %set(gca,'LooseInset',get(gca,'TightInset'))
    hold off;
%     view(3)
    axis equal;
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    axis([x_min, x_max, y_min, y_max]); % 动态调整坐标范围
    set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    %%多轮廓分割
    % 初始化最小和最大值
    xMin = inf; 
    xMax = -inf; 
    yMin = inf; 
    yMax = -inf;

    [mLine,iCountContour,vContourPoint,~] = Func_Unicursal_4(vXtemp, vYtemp, dSlice,[0.8235,0.1255,0.1529]);
    [mLine1,iCountContour1,vContourPoint1,~] = Func_Unicursal_4(vXtemp1, vYtemp1, step1(1),[0.2196,0.3490,0.5373]);
    figure;
    hold on; % 保持绘图，叠加多条轮廓
    axis equal; % 确保比例尺一致

      % 绘制第一个轮廓
    numContours = length(vContourPoint);
    for i = 1:numContours
        if i == 1
            startIdx = 1;
        else
            startIdx = sum(vContourPoint(1:i-1)) + 1;
        end
        endIdx = sum(vContourPoint(1:i));
    
        % 提取当前轮廓点索引
        currentContour = mLine(startIdx:endIdx, 1); % 当前轮廓的点索引
        currentX = vXtemp(currentContour);
        currentY = vYtemp(currentContour);
    
        % 闭合轮廓
        currentX = [currentX; currentX(1)];
        currentY = [currentY; currentY(1)];
    
        % 绘制轮廓
        plot(currentX, currentY,'Color', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);
    
        % 更新最小最大值
        xMin = min(xMin, min(currentX));
        xMax = max(xMax, max(currentX));
        yMin = min(yMin, min(currentY));
        yMax = max(yMax, max(currentY));
    end
    
    % 绘制第二个轮廓
    numContours1 = length(vContourPoint1);
    for i = 1:numContours1
        if i == 1
            startIdx1 = 1;
        else
            startIdx1 = sum(vContourPoint1(1:i-1)) + 1;
        end
        endIdx1 = sum(vContourPoint1(1:i));
    
        % 提取当前轮廓点索引
        currentContour1 = mLine1(startIdx1:endIdx1, 1); % 当前轮廓的点索引
        currentX1 = vXtemp1(currentContour1);
        currentY1 = vYtemp1(currentContour1);
    
        % 闭合轮廓
        currentX1 = [currentX1; currentX1(1)];
        currentY1 = [currentY1; currentY1(1)];
    
        % 绘制轮廓
        plot(currentX1, currentY1,'Color', [0.74,0.12,0.12], 'LineWidth', 2);
    
        % 更新最小最大值
        xMin = min(xMin, min(currentX1));
        xMax = max(xMax, max(currentX1));
        yMin = min(yMin, min(currentY1));
        yMax = max(yMax, max(currentY1));
    end
    
    % 计算最终的坐标轴范围并加上空隙
    margin = 0.1;
    xRange = xMax - xMin;
    yRange = yMax - yMin;
    
    xMin2 = xMin - margin * xRange; 
    xMax2 = xMax + margin * xRange;
    yMin2 = yMin - margin * yRange;
    yMax2 = yMax + margin * yRange;
    
    % 设置坐标轴范围
    axis([xMin2, xMax2, yMin2, yMax2]);
    
    % 设置标签
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;  % 结束绘图

     % 绘制多轮廓点集
    
   
    [contourCoords, totalContours, pointsPerContour] = Func_extractContourCoords(mLine, vContourPoint, vXtemp, vYtemp, iCountContour);
    [contourCoords1, totalContours1, pointsPerContour1] = Func_extractContourCoords(mLine1, vContourPoint1, vXtemp1, vYtemp1, iCountContour1);
    
    % 创建新的图形窗口
    figure;
    
    % 绘制第一组轮廓（蓝色点集，红色包围盒）
    for i = 1:totalContours
        % 获取当前轮廓的坐标
        contour = contourCoords(sum(pointsPerContour(1:i-1)) + 1 : sum(pointsPerContour(1:i)), :);
        
        % 绘制轮廓点集（蓝色点）
        plot(contour(:,1), contour(:,2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8);
        hold on;
        
        % 计算当前轮廓的包围盒
        minX = min(contour(:,1));
        maxX = max(contour(:,1));
        minY = min(contour(:,2));
        maxY = max(contour(:,2));
        
        % 绘制包围盒（红色）
        rectangle('Position', [minX, minY, maxX - minX, maxY - minY], 'EdgeColor', [0.74,0.12,0.12], 'LineWidth', 2);
    end
    
    % 绘制第二组轮廓（红色点集，蓝色包围盒）
    for i = 1:totalContours1
        % 获取当前轮廓的坐标
        contour1 = contourCoords1(sum(pointsPerContour1(1:i-1)) + 1 : sum(pointsPerContour1(1:i)), :);
        
        % 绘制轮廓点集（红色点）
        plot(contour1(:,1), contour1(:,2),'.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8);
        hold on;
        
        % 计算当前轮廓的包围盒
        minX1 = min(contour1(:,1));
        maxX1 = max(contour1(:,1));
        minY1 = min(contour1(:,2));
        maxY1 = max(contour1(:,2));
        
        % 绘制包围盒（蓝色）
        rectangle('Position', [minX1, minY1, maxX1 - minX1, maxY1 - minY1], 'EdgeColor', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);
    end
    
    % 计算所有轮廓的最小值和最大值
    minX = min([contourCoords(:,1); contourCoords1(:,1)]);
    maxX = max([contourCoords(:,1); contourCoords1(:,1)]);
    minY = min([contourCoords(:,2); contourCoords1(:,2)]);
    maxY = max([contourCoords(:,2); contourCoords1(:,2)]);
    
    % 为坐标轴添加边距
    margin = 0.1;  % 边距比例，0.1表示10%的空间
    xLimits = [minX - (maxX - minX) * margin, maxX + (maxX - minX) * margin];
    yLimits = [minY - (maxY - minY) * margin, maxY + (maxY - minY) * margin];
    
    % 设置坐标轴范围并显示
    axis([xLimits, yLimits]);  % 应用新的坐标范围
    axis equal;
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    % title('轮廓及其包围盒');
    % legend({'第一组轮廓', '第一组包围盒', '第二组轮廓', '第二组包围盒'});
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;

    
    %%绘制包围盒过滤后的点集

    % 假设你已经提取到 validContourCoords 和 validContourCoords1
   % 假设你已经提取到 validContourCoords 和 validContourCoords1
[validContourCoords, validContourCoords1] = Func_AABB_EverySlice(contourCoords, totalContours, pointsPerContour, contourCoords1, totalContours1, pointsPerContour1);
lengthEnd1=length(validContourCoords)+length(validContourCoords1);
lengthEnd=lengthEnd+lengthEnd1;
fprintf('包围盒过滤后第%d层点的数量为%d\n', j, lengthEnd1);
fprintf('包围盒过滤后总的点的数量为%d\n', j, lengthEnd);

% 创建新的图形窗口
figure;
hold on;

% 绘制第一组有效点（蓝色）
if ~isempty(validContourCoords)&&~isempty(validContourCoords1)
    plot(validContourCoords(:,1), validContourCoords(:,2),  '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); 
% end
% 
% 绘制第二组有效点（红色）
% if ~isempty(validContourCoords1)
    plot(validContourCoords1(:,1), validContourCoords1(:,2), '.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % 使用红色点绘制

% end

% 设置图形的显示属性
    axis equal;
    
    % 为了给图形四周留出空白空间，可以通过手动设置 xlim 和 ylim 来实现
    margin = 0.1;  % 设置空白空间比例
    
    % 获取当前图形的 x 和 y 范围
    xRange = [min([validContourCoords(:,1); validContourCoords1(:,1)]), max([validContourCoords(:,1); validContourCoords1(:,1)])];
    yRange = [min([validContourCoords(:,2); validContourCoords1(:,2)]), max([validContourCoords(:,2); validContourCoords1(:,2)])];
    
    % 计算留空的范围
    xMargin = (xRange(2) - xRange(1)) * margin;
    yMargin = (yRange(2) - yRange(1)) * margin;
    
    % 更新 xlim 和 ylim
    xlim([xRange(1) - xMargin, xRange(2) + xMargin]);
    ylim([yRange(1) - yMargin, yRange(2) + yMargin]);
    
    % 添加标签和标题
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    % title('有效点集');
    % legend({'第一组有效点', '第二组有效点'});
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;
end




    %%绘制射线法筛除后的点集
  % 假设你已经提取到 RvalidContourCoords 和 RvalidContourCoords1
[RvalidContourCoords, RvalidContourCoords1] = Func_RayCasting_Intersect(contourCoords, totalContours, pointsPerContour, contourCoords1, totalContours1, pointsPerContour1);

% 创建新的图形窗口
figure;
hold on;

% 绘制第一组有效点（蓝色）
if ~isempty(RvalidContourCoords)
    plot(RvalidContourCoords(:,1), RvalidContourCoords(:,2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); % 使用蓝色点绘制

end

% 绘制第二组有效点（红色）
if ~isempty(RvalidContourCoords1)
    plot(RvalidContourCoords1(:,1), RvalidContourCoords1(:,2), '.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % 使用红色点绘制

end

% 设置图形的显示属性
axis equal;

% 确保在计算 xRange 和 yRange 前，RvalidContourCoords 和 RvalidContourCoords1 都不为空
if ~isempty(RvalidContourCoords) && ~isempty(RvalidContourCoords1)
    % 获取当前图形的 x 和 y 范围
    xRange = [min([RvalidContourCoords(:,1); RvalidContourCoords1(:,1)]), max([RvalidContourCoords(:,1); RvalidContourCoords1(:,1)])];
    yRange = [min([RvalidContourCoords(:,2); RvalidContourCoords1(:,2)]), max([RvalidContourCoords(:,2); RvalidContourCoords1(:,2)])];

    % 计算留空的范围
    margin = 0.1;  % 设置空白空间比例
    xMargin = (xRange(2) - xRange(1)) * margin;
    yMargin = (yRange(2) - yRange(1)) * margin;

    % 更新 xlim 和 ylim
    xlim([xRange(1) - xMargin, xRange(2) + xMargin]);
    ylim([yRange(1) - yMargin, yRange(2) + yMargin]);
else
    disp('有效点集为空，无法计算范围');
end

% 添加标签和标题
xlabel('X/Bohr','FontSize', 14);
ylabel('Y/Bohr','FontSize', 14);
% title('有效点集');
% legend({'第一组有效点', '第二组有效点'});
box on;
 set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

hold off;



%最终多轮廓分割
   % 最终多轮廓分割
xMin = inf; 
xMax = -inf; 
yMin = inf; 
yMax = -inf;

% 检查 RvalidContourCoords 和 RvalidContourCoords1 是否为空
if isempty(RvalidContourCoords) || isempty(RvalidContourCoords1)
    disp('RvalidContourCoords 或 RvalidContourCoords1 数组为空，跳过当前迭代');
    continue; % 跳过当前迭代
end    

% 合并两个有效的轮廓点集
vXtempL = [RvalidContourCoords(:,1); RvalidContourCoords1(:,1)];
vYtempL = [RvalidContourCoords(:,2); RvalidContourCoords1(:,2)];

% 调用 Func_Unicursal_4 进行轮廓连接
[mLine, iCountContour, vContourPoint,~] = Func_Unicursal_4(vXtempL, vYtempL, dSlice, [0.8235, 0.1255, 0.1529]);

% 绘图
figure;
hold on; % 保持绘图，叠加多条轮廓
axis equal; % 确保比例尺一致

% 绘制每个轮廓
numContours = length(vContourPoint);
for i = 1:numContours
    % 计算当前轮廓的起始和结束索引
    if i == 1
        startIdx = 1;
    else
        startIdx = sum(vContourPoint(1:i-1)) + 1;
    end
    endIdx = sum(vContourPoint(1:i));
   
    % 提取当前轮廓点索引
    currentContour = mLine(startIdx:endIdx, 1); % 当前轮廓的点索引
    currentX = vXtempL(currentContour);
    currentY = vYtempL(currentContour);

    % 高斯面积公式计算轮廓面积
    x_shifted = [currentX(2:end); currentX(1)]; % x_{i+1}
    y_shifted = [currentY(2:end); currentY(1)]; % y_{i+1}
    
    area = 0.5 * abs(sum(currentX .* y_shifted - x_shifted .* currentY)); 
    disp(size(currentX));  % 应该是 (N,1) 或 (1,N)
    disp(size(currentY));  % 应该是 (N,1) 或 (1,N)
    disp(size(area));      % 应该是 (1,1)

    % 累计体积
    totalVolume = totalVolume + area * dSlice;
    disp(totalVolume)

    % 闭合轮廓，连接起始点
    currentX = [currentX; currentX(1)];
    currentY = [currentY; currentY(1)];

    % 绘制轮廓
    plot(currentX, currentY, 'Color', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);

    % 更新最小最大值
    xMin = min(xMin, min(currentX));
    xMax = max(xMax, max(currentX));
    yMin = min(yMin, min(currentY));
    yMax = max(yMax, max(currentY));
end

% 计算最终的坐标轴范围并加上空隙
margin = 0.1;
xRange = xMax - xMin;
yRange = yMax - yMin;

xMin2 = xMin - margin * xRange; 
xMax2 = xMax + margin * xRange;
yMin2 = yMin - margin * yRange;
yMax2 = yMax + margin * yRange;

% 设置坐标轴范围
axis([xMin2, xMax2, yMin2, yMax2]);

% 设置标签
xlabel('X/Bohr','FontSize', 14);
ylabel('Y/Bohr','FontSize', 14);
box on;
set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

hold off;  % 结束绘图


end


hold off;  % 关闭保持