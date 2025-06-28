function [dS] = Func_TwoDirectionSearch(vXTemp, vYTemp, dSlice)
    dS = 0;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);
    iStart = find(vYTemp == min(vYTemp));
    iStart = iStart(1);
    vUsed(iStart) = 1;
    vIdx = find(0 == vUsed);
    iLenSub = length(vIdx);
    vDis = zeros(iLenSub, 1);
    iFlag = 1;
    for i = 1 : iLenSub
        vDis(i) = (vXTemp(iStart) - vXTemp(vIdx(i)))^2 + (vYTemp(iStart) - vYTemp(vIdx(i)))^2;
    end
    iEnd = vIdx(find(min(vDis) == vDis));
    if(length(iEnd) > 1)
        iEnd = iEnd(1);
    end
    vUsed(iEnd) = 1;
    hold on;
%     scatter(vXTemp(iStart), vYTemp(iStart));
    line([vXTemp(iStart), vXTemp(iEnd)],[vYTemp(iStart), vYTemp(iEnd)], 'Color', 'r','LineWidth', 4);
    iCount = 2;
    while(iCount < iLen)
        vIdx = find(0 == vUsed);
        iLenSub = length(vIdx);
        vDis = zeros(iLenSub, 1);
        if(iFlag == 1)
            for i = 1 : iLenSub
                vDis(i) = (vXTemp(iStart) - vXTemp(vIdx(i)))^2 + (vYTemp(iStart) - vYTemp(vIdx(i)))^2;
            end
        else
            for i = 1 : iLenSub
                vDis(i) = (vXTemp(iEnd) - vXTemp(vIdx(i)))^2 + (vYTemp(iEnd) - vYTemp(vIdx(i)))^2;
            end
        end
        iTemp = vIdx(find(min(vDis) == vDis));
        if(length(iTemp) > 1)
            iTemp = iTemp(1);
        end
        dToStart = (vXTemp(iStart) - vXTemp(iTemp))^2 + (vYTemp(iStart) - vYTemp(iTemp))^2;
        dToEnd = (vXTemp(iEnd) - vXTemp(iTemp))^2 + (vYTemp(iEnd) - vYTemp(iTemp))^2;
        if(dToStart < dToEnd)
            hold on;
            line([vXTemp(iStart), vXTemp(iTemp)],[vYTemp(iStart), vYTemp(iTemp)], 'Color', 'r','LineWidth', 4);
            iStart = iTemp;
            iCount = iCount + 1;
            vUsed(iTemp) = 1;
            iFlag = 1;
        else
            hold on;
            line([vXTemp(iEnd), vXTemp(iTemp)],[vYTemp(iEnd), vYTemp(iTemp)], 'Color', 'r','LineWidth', 4);
            iEnd = iTemp;
            iCount = iCount + 1;
            vUsed(iTemp) = 1;
            iFlag = 0;
        end
    end
    line([vXTemp(iStart), vXTemp(iEnd)],[vYTemp(iStart), vYTemp(iEnd)], 'Color', 'r','LineWidth', 4);
end

