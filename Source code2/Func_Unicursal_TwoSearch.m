function [mLineSub_cell,LineFlag,vRectangle,iCountContour] = Func_Unicursal_TwoSearch(vXTemp, vYTemp, dSlice)
%     figure;
%     hold on;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%点的使用情况
    
    mLine = zeros(iLen, 2);%轮廓线
    iCount = 0;
    iCountContour = 0;
    vContourPoint=[];
    vColor = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'w'];
    dR = 5 * dSlice;  
    LeftisOver=false;
    while(iCount < iLen)
      
        iCountContour = iCountContour + 1;
        iLeft = 1;
        %% 找到最左侧点作为起点
        for i = 1 : iLen
            if(vUsed(iLeft) == 1)%如果初始点已经用过
                iLeft = iLeft + 1;
                continue;
            end
            if vUsed(i) == 1  % 如果当前点已经用过，跳过
                continue;
            end
            if vXTemp(i) < vXTemp(iLeft) || (vXTemp(i) == vXTemp(iLeft) && vYTemp(i) < vYTemp(iLeft))
                iLeft = i;  % 更新起始点
            end
        end
        iCount = iCount + 1;%轮廓线的序数.第几条边
        
        [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR);
        if(iCountUnUsed==0)
            iCountContour = iCountContour - 1;
            continue;
        end
        mLine(iCount, 1) = iLeft;
        vUsed(iLeft) = 1;
%         if(iCountUnUsed<2)
%             continue;
%         end
         [~, iMin] = min(vDisUU);  % 获取最小距离的索引
         iMin = iMin(1);  % 如果有多个最小值，只取第一个
             
         iRight = vIdxUU(iMin);
         vIdxUU(iMin)=[];
         vDisUU(iMin)=[];
         iCountUnUsed= iCountUnUsed-1;
         mLine(iCount, 2) = iRight;    
         
%          line([vXTemp(iLeft), vXTemp(iRight)],[vYTemp(iLeft), vYTemp(iRight)], 'Color', vColor(iCountContour), 'linewidth', 2);
%          plot([vXTemp(iLeft), vXTemp(iRight)],[vYTemp(iLeft), vYTemp(iRight)],'ko');
         
         vUsed(iRight) = 1;
         iCount = iCount + 1;
         [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iRight, dR);
    %% 一次轮廓搜索 ,以Left为起点搜索
%          if iCountUnUsed
            % 如果有未连接的点，进行连接
        while(iCountUnUsed > 0)
            [~, iMin] = min(vDisUU);  % 获取最小距离的索引
            iMin = iMin(1);  % 如果有多个最小值，只取第一个
            iTemp = vIdxUU(iMin);
            iTemp_Dis = (vXTemp(iTemp) - vXTemp(iLeft))^2 + (vYTemp(iTemp) - vYTemp(iLeft))^2;
            vUsed(iTemp) = 1;
%             if(iTemp==122)
%                 a=1;
%             end
%             plot(vXTemp(iTemp),vYTemp(iTemp),'ko');
            % 连接点并更新轮廓线
            if(iTemp_Dis < vDisUU(iMin))   
                mLine(iCount, 1) = iTemp; 
                mLine(iCount, 2) = iLeft;
%                 line([vXTemp(iLeft), vXTemp(iTemp)], [vYTemp(iLeft), vYTemp(iTemp)], 'Color', vColor(iCountContour), 'linewidth', 2);
            
                iLeft = iTemp;
                  
            else
                mLine(iCount, 1) = iRight; 
                mLine(iCount, 2) = iTemp;

%                 line([vXTemp(iTemp), vXTemp(iRight)], [vYTemp(iTemp), vYTemp(iRight)], 'Color', vColor(iCountContour), 'linewidth', 2);
                iRight = iTemp;  
            end
            iCount = iCount + 1;
            % 重新计算未连接的点
            [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iRight, dR);
            if iCountUnUsed==0
                LeftisOver=true;
                % 搜右边点还有没有
            end
        end
        if LeftisOver
            [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR);
             while(iCountUnUsed > 0)
                [~, iMin] = min(vDisUU);  % 获取最小距离的索引
                iMin = iMin(1);  % 如果有多个最小值，只取第一个
                iTemp = vIdxUU(iMin);
                
                vUsed(iTemp) = 1;

                % 连接点并更新轮廓线         
                mLine(iCount, 1) = iLeft; 
                mLine(iCount, 2) = iTemp;

%                 line([vXTemp(iTemp), vXTemp(iLeft)], [vYTemp(iTemp), vYTemp(iLeft)], 'Color', vColor(iCountContour), 'linewidth', 2);
                iLeft = iTemp;    
               
                iCount = iCount + 1;
                % 重新计算未连接的点
                [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR);

            end
        end
        if isempty(vContourPoint)
            vContourPoint = [vContourPoint; iCount];  % 直接添加
        else
            num_Point = iCount - sum(vContourPoint);
            vContourPoint = [vContourPoint; num_Point];
        end
%         line([vXTemp(iLeft), vXTemp(iRight)], [vYTemp(iLeft), vYTemp(iRight)], 'Color', vColor(iCountContour), 'linewidth', 2);
        mLine(iCount, 1) = iRight; 
        mLine(iCount, 2) = iLeft;
    end  
    hold off;
    axis image;
  
        %% 计算各个子区域的包围盒
    mLineSub_cell=cell(iCountContour);
    vRectangle = zeros(iCountContour, 4);%包围盒
    vTest = zeros(iCountContour, 1);%起点位置，用于测是否包含的点
    for i=1:iCountContour
        if(i==1)
            mLineSub=mLine(1:vContourPoint(1),:);
            vTest(i) = 1;
        else
            iFrom = 1 + sum(vContourPoint(1 : i - 1));%找该轮廓的起点
            iTo = sum(vContourPoint(1 : i));
            vTest(i) = iFrom;
            mLineSub=mLine(iFrom:iTo,:);
        end
        % 获取 mLineSub 的所有 X 和 Y 坐标
        mLineSub_cell{i}=mLineSub;
        xCoords = vXTemp(mLineSub(1:end));  % 获取 mLineSub 中所有点的 X 坐标
        yCoords = vYTemp(mLineSub(1:end));  % 获取 mLineSub 中所有点的 Y 坐标

        % 计算最小值和最大值
        dMinX = min(xCoords);  % 最小 X 值
        dMaxX = max(xCoords);  % 最大 X 值
        dMinY = min(yCoords);  % 最小 Y 值
        dMaxY = max(yCoords);  % 最大 Y 值

        % 将包围盒的坐标存储到 vRectangle 中
        vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];
    end
       %% 判断内外关系
    LineFlag=false(iCountContour,1);
  
    for i = 1 : iCountContour
%         mLineSub = mLine(vFrom2To(i, 1) : vFrom2To(i, 2), :);
%         mLineSub(vContourPoint(i), 2) = mLine(vFrom2To(i, 1), 1);
        mLineSub=mLineSub_cell{i};
        for j = 1 : iCountContour%被其他轮廓的包含数
            if(j == i)
                continue;
            end
            iTemp = mLine(vTest(j), 1);
            dTestX = vXTemp(iTemp);
            dTestY = vYTemp(iTemp);
            %%%相离
            if(dTestX < vRectangle(i, 1) | dTestX > vRectangle(i, 2) | dTestY < vRectangle(i, 3) | dTestY > vRectangle(i, 4))
                    continue;
            else
                for k = 1 : vContourPoint(i)
                    %线段方向y值从小到大
                    dTempMinY = min(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                    dTempMaxY = max(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                    % 如果测试点的y值在当前线段的y值范围内，进行相交判断
                    if dTempMinY < dTestY && dTempMaxY >= dTestY
                        % 交换点顺序，使得较高的点为第一点
                        if vYTemp(mLineSub(k, 1)) > vYTemp(mLineSub(k, 2))
                            mCors = [vXTemp(mLineSub(k, 2)), vYTemp(mLineSub(k, 2));
                                     vXTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 1))];
                        else
                            mCors = [vXTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 1));
                                     vXTemp(mLineSub(k, 2)), vYTemp(mLineSub(k, 2))];
                        end
                        dTemp1 = (mCors(2, 1) - mCors(1, 1)) * (dTestY - mCors(1, 2));
                        dTemp2 = (dTestX - mCors(1, 1)) * (mCors(2, 2) - mCors(1, 2));
                        if(dTemp1 < dTemp2)
                            LineFlag(j,1)=~LineFlag(j,1);
                        end
                    else
                        continue;
                    end
                end
%                     vS(j) = (-1)^iFlag * vS(j); 
            end
        end
    end
   
% 局部函数：计算未使用的点与起点的距离并筛选符合条件的点
    function [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR)
        % 筛选未使用的点
        unusedIdx = find(~vUsed);  % 找出所有未使用的点的索引

        % 提取未使用点的 X 和 Y 坐标
        unusedX = vXTemp(unusedIdx);
        unusedY = vYTemp(unusedIdx);

        % 计算未使用点与起点之间的距离的平方
        deltaX = unusedX - vXTemp(iLeft);  % 未使用点的 X 坐标差
        deltaY = unusedY - vYTemp(iLeft);  % 未使用点的 Y 坐标差
        vDis = deltaX.^2 + deltaY.^2;  % 欧氏距离的平方

        % 筛选距离在半径范围内的点
        vDisUU = vDis(vDis <= dR^2);  % 找到符合条件的点的距离
        vIdxUU = unusedIdx(vDis <= dR^2);  % 找到符合条件的点的索引

        % 记录符合条件的点
        iCountUnUsed = numel(vIdxUU);  % 更新未连接点数目
    end

end