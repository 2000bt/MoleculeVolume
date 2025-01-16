function [dS] = Func_Unicursal_Fina(vXTemp, vYTemp, dSlice,LineFlag,LineFlag1)
    dS = 0;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);
    mLine = zeros(iLen, 2);
    mTwoClose = zeros(iLen, 2);
    iCount = 0;
    iCountContour = 0;
    iCountUnUsed = 0;
    iCountSub = 0;
    vColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
    dR =6 * dSlice;
%     dR = 3* dSlice
    while(iCount < iLen)
        iCountContour = iCountContour + 1;%第几条线
        iStart = 1;
        %% 找到最左侧点作为起点，如果该点被用过则往后
        for i = 1 : iLen
            if(vUsed(iStart) == 1)
                iStart = iStart + 1;
                continue;
            end
            if(1 == vUsed(i))
                continue;
            end
            if(vXTemp(iStart) > vXTemp(i))
                iStart = i;
            end
        end
        iLeft = iStart;
        iCount = iCount + 1;
        mLine(iCount, 1) = iStart;
        vUsed(iStart) = 1;
        %% 记录半径R中点的个数，和未使用点的个数
        for i = 1 : iLen
            if(iStart == i | vXTemp(i) > vXTemp(iStart) + dR | vXTemp(i) < vXTemp - dR | vYTemp(i) > vYTemp(iStart) + dR | vYTemp(i) < vYTemp - dR)
                continue;
            end
            if(0 == vUsed(i))
                iCountUnUsed = iCountUnUsed + 1;
            end
            iCountSub = iCountSub + 1;
        end
        %% 找到距离起点最近的两个点
        vDisUU = zeros(iCountUnUsed, 1);
        vIdxUU = zeros(iCountUnUsed, 1);
        vDis = zeros(iCountSub, 1);
        vIdx = zeros(iCountSub, 1);
        iTemp = 1;
        iTempUU = 1;
        for i = 1 : iLen
            if(iStart == i | vXTemp(i) > vXTemp(iStart) + dR | vXTemp(i) < vXTemp - dR | vYTemp(i) > vYTemp(iStart) + dR | vYTemp(i) < vYTemp - dR)
                continue;
            end
            vDis(iTemp) = (vXTemp(i) - vXTemp(iStart))^2 + (vYTemp(i) - vYTemp(iStart))^2;
            vIdx(iTemp) = i;
            if(0 == vUsed(i))
                vDisUU(iTempUU) = vDis(iTemp);
                vIdxUU(iTempUU) = vIdx(iTemp);
                iTempUU = iTempUU + 1;
            end
            iTemp = iTemp + 1;
        end
        %找最小值？？？
        iMin = 1;
        for i = 1 : iCountSub
            if(vDis(iMin) > vDis(i))
                iMin = i;
            end
        end
        if(length(iMin) > 1)
            iMin = iMin(1);
        end
%         mTwoClose(iStart, 1) = vIdx(iMin);
        
        iTemp = iMin;
        iMin = 1;
        for i = 1 : iCountSub
            if(i == iTemp)
                continue;
            end
            if(vDis(iMin) > vDis(i))
                iMin = i;
            end
        end
%         mTwoClose(iStart, 2) = vIdx(iMin);
        iCountSub = 0;
 %% 一次轮廓搜索       
        while(iCountUnUsed > 0)
            iMin = 1;
            for i = 1 : iCountUnUsed
                if(vDisUU(iMin) > vDisUU(i))
                iMin = i;
                end
            end
            iNext = vIdxUU(iMin);
            mLine(iCount, 2) = iNext;
%             if(iNext ~= mTwoClose(iLeft, 1) & iNext ~= mTwoClose(iLeft, 2))
%                 scatter(vXTemp(iLeft), vYTemp(iLeft),120,'r.');
%             end
            vXTemp(iLeft)
            vXTemp(iNext)
            vYTemp(iLeft)
            vYTemp(iNext)
%             line([vXTemp(iLeft), vXTemp(iNext)],[vYTemp(iLeft), vYTemp(iNext)], 'Color', vColor(iCountContour));
            vUsed(iNext) = 1;
            iCount = iCount + 1;
            iLeft = iNext;
            mLine(iCount, 1) = iLeft;
            %对下一点的周边点进行搜索
            iCountUnUsed = 0;
            for i = 1 : iLen
                if(iLeft == i | vXTemp(i) > vXTemp(iLeft) + dR | vXTemp(i) < vXTemp(iLeft) - dR | vYTemp(i) > vYTemp(iLeft) + dR | vYTemp(i) < vYTemp(iLeft) - dR)
                    continue;
                end
                if(0 == vUsed(i))
                    iCountUnUsed = iCountUnUsed + 1;
                end
                iCountSub = iCountSub + 1;
            end
            
            vDisUU = zeros(iCountUnUsed, 1);
            vIdxUU = zeros(iCountUnUsed, 1);
            vDis = zeros(iCountSub, 1);
            vIdx = zeros(iCountSub, 1);
            iTemp = 1;
            iTempUU = 1;

            for i = 1 : iLen
                if(iLeft == i | vXTemp(i) > vXTemp(iLeft) + dR | vXTemp(i) < vXTemp(iLeft) - dR | vYTemp(i) > vYTemp(iLeft) + dR | vYTemp(i) < vYTemp(iLeft) - dR)
                    continue;
                end
                vDis(iTemp) = (vXTemp(i) - vXTemp(iLeft))^2 + (vYTemp(i) - vYTemp(iLeft))^2;
                vIdx(iTemp) = i;
                if(0 == vUsed(i))
                    vDisUU(iTempUU) = vDis(iTemp);
                    vIdxUU(iTempUU) = vIdx(iTemp);
                    iTempUU = iTempUU + 1;
                end
                iTemp = iTemp + 1;
            end
            
            iMin = 1;
            for i = 1 : iCountSub
                if(vDis(iMin) > vDis(i))
                    iMin = i;
                end
            end
            mTwoClose(iNext, 1) = vIdx(iMin);
            
            iTemp = iMin;
            iMin = 1;
            for i = 1 : iCountSub
                if(i == iTemp)
                    continue;
                end
                if(vDis(iMin) > vDis(i))
                    iMin = i;
                end
            end
            mTwoClose(iNext, 2) = vIdx(iMin);
            iCountSub = 0;          
            
        end
%         line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', vColor(iCountContour));
    end
    %%  多轮廓分区
    vS = zeros(iCountContour, 1);
    vContourPoint = zeros(iCountContour, 1);
    iCount = 0;
    vRectangle = zeros(iCountContour, 4);%包围盒
    vTest = zeros(iCountContour, 1);%起点位置，用于测是否包含的点
    vFrom2To = zeros(iCountContour, 2);%存储各轮廓起点和终点在mline中的坐标
    iCountContour = 0;%几个轮廓
    for i = 1 : iLen
        %线段矩阵如果第二列为0则代表为轮廓的最后一个点
        if(mLine(i, 2) ~= 0 )
            iCount = iCount + 1;
        else
            iCount = iCount + 1;
            iCountContour = iCountContour + 1;
            vContourPoint(iCountContour, 1) = iCount;%每个轮廓有多少点
            iCount = 0;
        end
    end
    %% 计算各个其区域面积
    for i = 1 : iCountContour
        dS = 0;
        mLineSub = zeros(vContourPoint(i), 2);%每个轮廓
        if(i == 1)
            iFrom = 1;
            iTo = vContourPoint(1);
            vTest(i) = 1;
            vFrom2To(i, 1) = 1;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(1, 1));
            dMaxX = vXTemp(mLine(1, 1));
            dMinY = vYTemp(mLine(1, 1));
            dMaxY = vYTemp(mLine(1, 1));
        else
            iFrom = 1 + sum(vContourPoint(1 : i - 1));%找该轮廓的起点
            iTo = sum(vContourPoint(1 : i));
            vTest(i) = iFrom;
            vFrom2To(i, 1) = iFrom;
            vFrom2To(i, 2) = iTo;
            dMinX = vXTemp(mLine(iFrom, 1));
            dMaxX = vXTemp(mLine(iFrom, 1));
            dMinY = vYTemp(mLine(iFrom, 1));
            dMaxY = vYTemp(mLine(iFrom, 1));
        end
        mLineSub = mLine(iFrom : iTo, :);
        mLineSub(vContourPoint(i), 2) = mLineSub(1, 1);%连接起点，补全
        for j = 1 : vContourPoint(i)
            if(vXTemp(mLineSub(j + 1)) < dMinX)
                dMinX = vXTemp(mLineSub(j + 1));
            end
            if(vXTemp(mLineSub(j + 1)) > dMaxX)
                dMaxX = vXTemp(mLineSub(j + 1));
            end
            if(vYTemp(mLineSub(j + 1)) < dMinY)
                dMinY = vYTemp(mLineSub(j + 1));
            end
            if(vYTemp(mLineSub(j + 1)) > dMaxY)
                dMaxY = vYTemp(mLineSub(j + 1));
            end
            vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];%相当于包围盒检测是否相交
            dS = dS + 0.5 * (vXTemp(mLineSub(j)) * vYTemp(mLineSub(j, 2)) - vXTemp(mLineSub(j, 2)) * vYTemp(mLineSub(j)));
        end
        vS(i) = abs(dS);
    end
    %% 判断轮廓间包含关系
    if(1 == iCountContour)
        mFlag=xor(LineFlag,LineFlag1);
        vS =(-1)^mFlag * vS;
        dS = sum(vS);
    else
        for i = 1 : iCountContour
            mLineSub = mLine(vFrom2To(i, 1) : vFrom2To(i, 2), :);
            mLineSub(vContourPoint(i), 2) = mLine(vFrom2To(i, 1), 1);
            for j = 1 : iCountContour%被其他轮廓的包含数
                if(j == i)
                    continue;
                end
                iTemp = mLine(vTest(j), 1);
                iFlag = 0;
                mFlag=xor(LineFlag,LineFlag1);
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
                        mCors = zeros(2, 2);
                        mCors(1, :) = [vXTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 1))];
                        mCors(2, :) = [vXTemp(mLineSub(k, 2)), vYTemp(mLineSub(k, 2))];
                        %if条件保证相交
                        if(dTempMinY < dTestY && dTempMaxY >= dTestY)
                            
                            if(vYTemp(mLineSub(k, 1)) > vYTemp(mLineSub(k, 2)))
                                vTemp = zeros(1, 2);
                                vTemp(1, :) = mCors(1, :);
                                mCors(1, :) = mCors(2, :);
                                mCors(2, :) = vTemp(1, :);
                            end
                            dTemp1 = (mCors(2, 1) - mCors(1, 1)) * (dTestY - mCors(1, 2));
                            dTemp2 = (dTestX - mCors(1, 1)) * (mCors(2, 2) - mCors(1, 2));
                            if(dTemp1 < dTemp2)
                                iFlag = ~iFlag;
                            end
                        else
                            continue;
                        end
                    end
                    vS(j) = (-1)^(iFlag+mFlag) * vS(j); 
                end
            end
        end
    end
    dS = sum(vS);
%     sLabel = strings(1, 4);
%     for i = 1 : iCountContour
%         str = sprintf('polyline %d', i);
%         sLabel(i) = str;
%     end
%     legend(sLabel, 'Interpreter','latex')
end
