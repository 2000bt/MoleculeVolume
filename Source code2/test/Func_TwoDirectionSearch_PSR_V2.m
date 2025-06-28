function [dOutlier, dLstd] = Func_TwoDirectionSearch_PSR_V2( vXTemp, vYTemp, dSlice )
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

end