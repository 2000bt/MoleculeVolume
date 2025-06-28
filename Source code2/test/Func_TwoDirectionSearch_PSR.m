function [iCorrect, dS] = Func_TwoDirectionSearch_PSR( vXTemp, vYTemp, dSlice )
    iCorrect = 1;
    dS = 0;
    iCount = 0;
    iCountLine = 0;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);
    vDistance = zeros(iLen, 1);
    mLine = zeros(iLen, 2);
    vColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
    %% Y值最小的点作为起始点
    iStart = 1;
    for i = 1 : iLen
        if(vYTemp(iStart) > vYTemp(i))
            iStart = i;
        end
    end
    iCount = iCount + 1;
    vUsed(iStart) = 1;
    
    %% 找到距离iStart最近的点，作为iEnd
    iLenSub = iLen - iCount;
    vIdx = zeros(iLenSub, 1);
    vDis = zeros(iLenSub, 1);
    iTemp = 0;
    for i = 1 : iLen
        if(i == iStart)
            continue;
        end
        iTemp = iTemp + 1;
        vDis(iTemp) = (vXTemp(iStart) - vXTemp(i))^2 + (vYTemp(iStart) - vYTemp(i))^2;
        vIdx(iTemp) = i;
    end
    iEnd = 1;
    for i = 1 : iLenSub
        if(vDis(iEnd) > vDis(i))
            iEnd = i;
        end
    end
    iCountLine = iCountLine + 1;
    vDistance(iCountLine) = sqrt(vDis(iEnd));
    iEnd = vIdx(iEnd);
    iCount = iCount + 1;
    vUsed(iEnd) = 1;
    mLine(iCountLine, 1) = iStart;
    mLine(iCountLine, 2) = iEnd;
    iFlag = 1;
    
    hold on;
%     scatter(vXTemp(iStart), vYTemp(iStart));
%     line([vXTemp(iStart), vXTemp(iEnd)],[vYTemp(iStart), vYTemp(iEnd)], 'Color', 'b');
    %% 遍历剩余所有点
    while(iCount < iLen)
        iLenSub = iLen - iCount;
        vIdx = zeros(iLenSub, 1);
        vDis = zeros(iLenSub, 1);
        iTemp = 0;
        if(1 == iFlag)
            for i = 1 : iLen
                if(1 == vUsed(i))
                    continue;
                end
                iTemp = iTemp + 1;
                vDis(iTemp) = (vXTemp(iStart) - vXTemp(i))^2 + (vYTemp(iStart) - vYTemp(i))^2;
                vIdx(iTemp) = i;
            end       
        else
            for i = 1 : iLen
                if(1 == vUsed(i))
                    continue;
                end
                iTemp = iTemp + 1;
                vDis(iTemp) = (vXTemp(iEnd) - vXTemp(i))^2 + (vYTemp(iEnd) - vYTemp(i))^2;
                vIdx(iTemp) = i;
            end                
        end
        iTemp = 1;
        for i = 1 : iLenSub
            if(vDis(iTemp) > vDis(i))
                iTemp = i;
            end
        end
        iTemp1 = iTemp;
        iTemp = vIdx(iTemp);
        iCount = iCount + 1;
        vUsed(iTemp) = 1;
        dToStart = (vXTemp(iStart) - vXTemp(iTemp))^2 + (vYTemp(iStart) - vYTemp(iTemp))^2;
        dToEnd = (vXTemp(iEnd) - vXTemp(iTemp))^2 + (vYTemp(iEnd) - vYTemp(iTemp))^2;
        if(dToStart < dToEnd)
            hold on;
%             line([vXTemp(iStart), vXTemp(iTemp)],[vYTemp(iStart), vYTemp(iTemp)], 'Color', 'k');
            iCountLine = iCountLine + 1;
            mLine(iCountLine, 1) = iStart;
            mLine(iCountLine, 2) = iTemp;
            vDistance(iCountLine) = sqrt(vDis(iTemp1));
            iStart = iTemp;
            iFlag = 1;
        else
            hold on;
%             line([vXTemp(iEnd), vXTemp(iTemp)],[vYTemp(iEnd), vYTemp(iTemp)], 'Color', 'r');
            iCountLine = iCountLine + 1;
            mLine(iCountLine, 1) = iEnd;
            mLine(iCountLine, 2) = iTemp;
            iEnd = iTemp;     
            vDistance(iCountLine) = sqrt(vDis(iTemp1));
            iFlag = 0;
        end
    end
    iCountLine = iCountLine + 1;
    mLine(iCountLine, 1) = iStart;
    mLine(iCountLine, 2) = iEnd;
    vDistance(iCountLine) = sqrt((vXTemp(iStart) - vXTemp(iEnd))^2 + (vYTemp(iStart) - vYTemp(iEnd))^2);
%     line([vXTemp(iStart), vXTemp(iEnd)],[vYTemp(iStart), vYTemp(iEnd)], 'Color', 'y');
    %% 整理边的顺序
    if(mLine(1, 2) ~= mLine(2, 1))
        iTemp = mLine(1, 1);
        mLine(1, 1) = mLine(1, 2);
        mLine(1, 2) = iTemp;
    end
    if(mLine(iLen - 1, 2) ~= mLine(iLen, 1))
        iTemp = mLine(iLen, 1);
        mLine(iLen, 1) = mLine(iLen, 2);
        mLine(iLen, 2) = iTemp;
    end
    iSeg = 0;
    for i = 1 : iLen - 1
        if(mLine(i, 2) ~= mLine(i + 1, 1))
            iSeg = iSeg + 1;
        end
    end
    iSeg = iSeg + 1;
    vSeg = zeros(iSeg, 2);
    iSeg = 0;
    for i = 1 : iLen - 1
        if(mLine(i, 2) ~= mLine(i + 1, 1))
            iSeg = iSeg + 1;
            if(1 == iSeg)
                vSeg(iSeg, 1) = 1;
                vSeg(iSeg, 2) = i;
            else
            vSeg(iSeg, 1) = vSeg(iSeg - 1, 2) + 1;
            vSeg(iSeg, 2) = i;
            end
        end
    end
    iSeg = iSeg + 1;
    if(iSeg > 1)
        vSeg(iSeg, 1) = vSeg(iSeg - 1, 2) + 1;
        vSeg(iSeg, 2) = iLen;
        vUsedSeg = zeros(iSeg, 1);
        mLineRe = zeros(iLen, 2);
        vDisRe = zeros(iLen, 1);
        mLineRe(1 : vSeg(1, 2), :) = mLine(1 : vSeg(1, 2), :);
        vDisRe(1 : vSeg(1, 2)) = vDistance(1 : vSeg(1, 2));
        vUsedSeg(1) = 1;
        iTemp = vSeg(1, 2);
        iTemp1 = iTemp;
        for k = 1 : iSeg - 1
            for i = 1 : iSeg
                if(1 == vUsedSeg(i))
                    continue;
                end
                if(mLine(iTemp, 2) == mLine(vSeg(i, 1), 1) | mLine(iTemp, 2) == mLine(vSeg(i, 2), 2))
                    vUsedSeg(i) = 1;
                    iLenSub = vSeg(i, 2) - vSeg(i, 1) + 1;
                    mLineSub = zeros(iLenSub, 2);
                    vDisSub = zeros(iLenSub, 1);
                    if(mLine(iTemp, 2) == mLine(vSeg(i, 1), 1))
                        mLineRe(iTemp1 + 1 : iTemp1 + iLenSub, :) = mLine(vSeg(i, 1) : vSeg(i, 2), :);
                        vDisRe(iTemp1 + 1 : iTemp1 + iLenSub) = vDistance(vSeg(i, 1) : vSeg(i, 2));
                    else
                        iCount = 0;
                        for j = vSeg(i, 2) : -1 : vSeg(i, 1)
                            iCount = iCount + 1;
                            mLineSub(iCount, 1) = mLine(j, 2);
                            mLineSub(iCount, 2) = mLine(j, 1);
                            vDisSub(iCount) = vDistance(j);
                        end
                        mLineRe(iTemp1 + 1 : iTemp1 + iLenSub, :) = mLineSub;
                        vDisRe(iTemp1 + 1 : iTemp1 + iLenSub) = vDisSub;
                    end
                    iTemp = vSeg(i, 2);
                    iTemp1 = iTemp1 + iLenSub;
                end
            end
        end
        mLine = mLineRe;
        vDistance = vDisRe;
    end
    %% 开始准备拆分异常边
    iSeg = 0;
    dTemp = 0;
    dLmean = sum(vDistance) / iLen;
    for i = 1 : iLen
        dTemp = dTemp + (vDistance(i) - dLmean)^2;
    end
    dLstd = sqrt(dTemp / (iLen - 1)); 
    dOutlier = dLmean + 2.5 * dLstd;
    for i = 1 : iLen
        if(vDistance(i) > dOutlier);
%         line([vXTemp(mLine(i, 1)), vXTemp(mLine(i, 2))],[vYTemp(mLine(i, 1)), vYTemp(mLine(i, 2))], 'Color', 'w');
        iSeg = iSeg + 1;
        end
    end
    
    if(iSeg > 1)
        vNode = zeros(2 * iSeg, 2);
        vUsedSeg = zeros(2 * iSeg, 1);
        iSeg = 0;
        for i = 1 : iLen
            if(vDistance(i) > dOutlier)
                if(i == iLen)
                    iSeg = iSeg + 1;
                    vNode(2 * iSeg - 1, 1) = mLine(i, 1);
                    vNode(2 * iSeg, 1) = mLine(i, 2);
                    vNode(2 * iSeg - 1, 2) = i - 1;
                    vNode(2 * iSeg, 2) = 1;
                else
                    iSeg = iSeg + 1;
                    vNode(2 * iSeg - 1, 1) = mLine(i, 1);
                    vNode(2 * iSeg, 1) = mLine(i, 2);
                    vNode(2 * iSeg - 1, 2) = i - 1;
                    vNode(2 * iSeg, 2) = i + 1;
                end
            end
        end
        vTemp = zeros(1, 2);
        vTemp = vNode(2 * iSeg, :);
        vNode(2 : 2 * iSeg, :) = vNode(1 : 2 * iSeg - 1, :);
        vNode(1, :) = vTemp(:);
    end
    %% 拆分后重组
    if(iSeg > 1)
        vUsedSeg = zeros(2 * iSeg, 1);
        mLineRe = zeros(iLen, 2);
        iCountLine = 0;
        iTemp = 0;
        iTemp1 = 0;
        for i = 1 : iSeg
            if(1 == i)
                if(1 == vNode(2 * i - 1, 2))
                    iLenSub = vNode(2 * i, 2) - vNode(2 * i - 1, 2) + 1;
                    iCountLine = iLenSub;
                    mLineSub = zeros(iLenSub, 2);
                    mLineSub(1 : vNode(2 * i, 2), :) = mLine(1 : vNode(2 * i, 2), :);
                    mLineRe(1 : iLenSub, :) = mLineSub;
                else
                    iLenSub = vNode(2 * i, 2) - vNode(2 * i - 1, 2) + 1 + iLen;
                    iCountLine = iLenSub;
                    mLineSub = zeros(iLenSub, 2);
                    mLineSub(1 : iLen - vNode(2 * i- 1, 2) + 1, :) = mLine(vNode(2 * i - 1, 2) : iLen, :);
                    mLineSub(iLen - vNode(2 * i - 1, 2) + 2 : iLenSub, :) = mLine(1 : vNode(2 * i, 2), :);
                    mLineRe(1 : iLenSub, :) = mLineSub;
                end
                iTemp = vNode(2 * i, 1);
                iTemp1 = 2;
                vUsedSeg(iTemp1) = 1;
                continue;
            end
            iCount = 2 * iSeg - sum(vUsedSeg);
            iCount1 = 0;
            vDisSeg = zeros(iCount, 1);
            vIdxSeg = zeros(iCount, 1);
            for j = 1 : 2 * iSeg
                if(1 == vUsedSeg(j))
                    continue
                end
                iCount1 = iCount1 + 1;
                vDisSeg(iCount1) = (vXTemp(iTemp) - vXTemp(vNode(j, 1)))^2 + (vYTemp(iTemp) - vYTemp(vNode(j, 1)))^2;
                vIdxSeg(iCount1) = j;
            end
            iNext = vIdxSeg(find(vDisSeg == min(vDisSeg)))
            iNext = iNext(1);
            if(iTemp1 - iNext == 1)
                vUsedSeg(iNext) = 1;
                iCountLine = iCountLine + 1;
                mLineRe(iCountLine, 1) = vNode(iTemp1, 1);
                mLineRe(iCountLine, 2) = vNode(iNext, 1);
                iLineSub = vNode(2 * i, 2) - vNode(2 * i - 1, 2) + 1;
                mLineRe(iCountLine + 1 : iCountLine + iLineSub, :) = mLine(vNode(2 * i - 1, 2) : vNode(2 * i, 2), :);
                iCountLine = iCountLine + iLineSub;
                iTemp = vNode(2 * i, 1);
                iTemp1 = 2 * i;
                vUsedSeg(iTemp1) = 1;
            elseif(1 == mod(iTemp1 + iNext, 2))
                vUsedSeg(iNext) = 1;
                iCountLine = iCountLine + 1;
                mLineRe(iCountLine, 1) = vNode(iTemp1, 1);
                mLineRe(iCountLine, 2) = vNode(iNext, 1);
                iLineSub = vNode(2 * i, 2) - vNode(2 * i - 1, 2) + 1;
                mLineRe(iCountLine + 1 : iCountLine + iLineSub, :) = mLine(vNode(2 * i - 1, 2) : vNode(2 * i, 2), :);
                iCountLine = iCountLine + iLineSub;
                iTemp1 = iNext + 1;
                iTemp = vNode(iNext + 1, 1);
                vUsedSeg(iNext + 1) = 1;
            else
                iCountLine = iCountLine + 1;
                mLineRe(iCountLine, 1) = vNode(iTemp1, 1);
                mLineRe(iCountLine, 2) = vNode(iNext, 1);
                iLienSub = vNode(iNext, 2) - vNode(iNext - 1, 2) + 1;
                iTemp2 = 0
                for k = vNode(iNext, 2) : -1 : vNode(iNext - 1, 2)
                    iTemp2 = iTemp2 + 1;
                    mLineRe(iCountLine + iTemp2, 1) = mLine(k, 2);
                    mLineRe(iCountLine + iTemp2, 2) = mLine(k, 1);
                end
                iCountLine = iCountLine + iLenSub;
                vTemp = vNode(iNext, :)
                vNode(iNext, :) = vNode(iNext - 1, :);
                vNode(iNext - 1, :) = vTemp(:);
                vUsedSeg(iNext -1) = 1;
            end
        end
        
        vDisSeg = zeros(2 * iSeg - 1, 1);
        vIdxSeg = zeros(2 * iSeg - 1, 1);
        iCount1 = 0;
        for i = 1 : 2 * iSeg
            if(1 == vUsedSeg(i))
                continue
            end
            iLast = vNode(i, 1);
            for j = 1 : 2 * iSeg
                if(j == i)
                    continue;
                end
                iCount1 = iCount1 + 1;
                vDisSeg(iCount1) = (vXTemp(vNode(j, 1)) - vXTemp(iLast))^2 + (vYTemp(vNode(j, 1)) - vYTemp(iLast))^2;
                if(0 == vDisSeg(iCount1))
                    vDisSeg(iCount1) = 99;
                end
                vIdxSeg(iCount1) = j;
            end
        end
        iCountLine = iCountLine + 1;
        mLineRe(iCountLine, 1) = iLast;
        iNext = vNode(vIdxSeg(find(vDisSeg == min(vDisSeg))), 1);
        iNext = iNext(1);
        mLineRe(iCountLine, 2) = iNext;
        if(mLineRe(iLen - 1, 2) ~= mLineRe(iLen, 1))
            iTemp = mLineRe(iCountLine, 1);
            mLineRe(iCountLine, 1) = mLineRe(iCountLine, 2);
            mLineRe(iCountLine, 2) = iTemp;
        end
        mLine = mLineRe;
%         for i = 1 : iCountLine
%             hold on;
%             line([vXTemp(mLineRe(i, 1)), vXTemp(mLineRe(i, 2))],[vYTemp(mLineRe(i, 1)), vYTemp(mLineRe(i, 2))], 'Color', 'r');
%         end
    else
%         for i = 1 : iLen
%             hold on;
%             line([vXTemp(mLine(i, 1)), vXTemp(mLine(i, 2))],[vYTemp(mLine(i, 1)), vYTemp(mLine(i, 2))], 'Color', 'r');
%         end
    end
    %% 多轮廓分区
    iCountContour = 1;
    for i = 1 : iLen - 1
        if(mLine(i, 2) ~= mLine(i + 1, 1))
            iCountContour = iCountContour + 1;
        end
    end
    vS = zeros(iCountContour, 1);
    vContourPoint = zeros(iCountContour, 1);
    iCount = 1;
    vRectangle = zeros(iCountContour, 4);
    vTest = zeros(iCountContour, 1);
    vFrom2To = zeros(iCountContour, 2);
    iCountContour = 1;
    for i = 1 : iLen - 1
        if(mLine(i, 2) ~= mLine(i + 1, 1))
            vContourPoint(iCountContour, 1) = iCount;
            iCountContour = iCountContour + 1;
            iCount = 1;
        else
            iCount = iCount + 1;
        end
    end
    vContourPoint(iCountContour, 1) = iCount;
    %% 计算各个区域面积
    for i = 1 : iCountContour
        dS = 0;
        mLineSub = zeros(vContourPoint(i), 2);
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
            iFrom = 1 + sum(vContourPoint(1 : i - 1));
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
        mLineSub(vContourPoint(i), 2) = mLineSub(1, 1);
        
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
            vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];
            dS = dS + 0.5 * (vXTemp(mLineSub(j)) * vYTemp(mLineSub(j, 2)) - vXTemp(mLineSub(j, 2)) * vYTemp(mLineSub(j)));
            line([vXTemp(mLineSub(j)), vXTemp(mLineSub(j, 2))],[vYTemp(mLineSub(j)), vYTemp(mLineSub(j, 2))], 'Color', vColor(i));
        end
        vS(i) = abs(dS);
    end
        %% 判断轮廓间包含关系
    if(1 == iCountContour)
        dS = sum(vS);
    else
        for i = 1 : iCountContour
            mLineSub = mLine(vFrom2To(i, 1) : vFrom2To(i, 2), :);
            for j = 1 : iCountContour
                if(j == i)
                    continue;
                end
                iTemp = mLine(vTest(j), 1);
                iFlag = 0;
                dTestX = vXTemp(iTemp);
                dTestY = vYTemp(iTemp);
                if(dTestX < vRectangle(i, 1) | dTestX > vRectangle(i, 2) | dTestY < vRectangle(i, 3) | dTestY > vRectangle(i, 4))
                        continue;
                else
                    for k = 1 : vContourPoint(i)
                        dTempMinY = min(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                        dTempMaxY = max(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                        mCors = zeros(2, 2);
                        mCors(1, :) = [vXTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 1))];
                        mCors(2, :) = [vXTemp(mLineSub(k, 2)), vYTemp(mLineSub(k, 2))];
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
                            continue
                        end
                    end
                    vS(j) = (-1)^iFlag * vS(j); 
                end
            end
        end
    end
   dS = sum(vS);
end 

