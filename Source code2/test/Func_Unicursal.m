function [vSort] = Func_Unicursal(vXTemp, vYTemp, dSlice)
%     dS = 0;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%是否使用过
    vSort = zeros(iLen, 1);%排列好的，存在问题，每个轮廓没分开
    iCount = 0;%排列好的下标
    iCountContour = 0;
    vColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
    while(iCount < iLen)
        %找没用过中x轴最小的
        vIdx = find(0 == vUsed);
        iCountContour = iCountContour + 1;%第几条轮廓用第几个颜色
        iTemp = find(min(vXTemp(vIdx)));
        iStart = vIdx(iTemp);
        %如果有x轴相同的，取第一个
        if(length(iStart) > 1)
            iStart = iStart(1);
            iCount = iCount + 1;
            vSort(iCount) = iStart;
        end
        iCount = iCount + 1;
        vSort(iCount) = iStart;
        iLeft = iStart;
        vUsed(iLeft) = 1;%使用情况置1
        %%%此处是建立长方形，不是圆形？？？
        vIdxSub = find(vXTemp < vXTemp(iLeft) + 3.3 * dSlice);
        vIdxSub = vIdxSub(find(vYTemp(vIdxSub) < vYTemp(iLeft) + 3.3 * dSlice));
        vIdxSub = vIdxSub(find(vXTemp(vIdxSub) > vXTemp(iLeft) - 3.3 * dSlice));
        vIdxSub = vIdxSub(find(vYTemp(vIdxSub) > vYTemp(iLeft) - 3.4 * dSlice));
        iLenSub = length(vIdxSub);
        iFlag = sum(vUsed(vIdxSub));
        %其中有没有用过的点
        while(iFlag < iLenSub)
            %比较距离
            vDis = zeros(iLenSub, 1);
            for k = 1 : iLenSub
                if(1 == vUsed(vIdxSub(k)))
                    vDis(k) = 200;
                    continue;
                end
                vDis(k) = (vXTemp(vIdxSub(k)) - vXTemp(iLeft))^2 + (vYTemp(vIdxSub(k)) - vYTemp(iLeft))^2;
            end
            %下一个点是最小距离的
            iNext = vIdxSub(find(min(vDis) == vDis));
            %如果有距离相同的只连接第一个，将其余的设为已用
            if(length(iNext) > 1)
                for j = 1 : length(iNext)
                    vUsed(iNext(j)) = 1;
                    iCount = iCount + 1;
                    vSort(iCount) =  iNext(j);
                end
                hold on
                line([vXTemp(iLeft), vXTemp(iNext(1))],[vYTemp(iLeft), vYTemp(iNext(1))], 'Color', vColor(iCountContour));
                iLeft = iNext(1);
            else
                vUsed(iNext) = 1;
                iCount = iCount + 1;
                vSort(iCount) =  iNext;
                hold on
                line([vXTemp(iLeft), vXTemp(iNext(1))],[vYTemp(iLeft), vYTemp(iNext(1))], 'Color', vColor(iCountContour));
                iLeft = iNext(1);
            end
            %重新进入步骤2
            vIdxSub = find(vXTemp < vXTemp(iLeft) + 3.4 * dSlice);
            vIdxSub = vIdxSub(find(vYTemp(vIdxSub) < vYTemp(iLeft) + 3.4 * dSlice));
            vIdxSub = vIdxSub(find(vXTemp(vIdxSub) > vXTemp(iLeft) - 3.4 * dSlice));
            vIdxSub = vIdxSub(find(vYTemp(vIdxSub) > vYTemp(iLeft) - 3.4 * dSlice));
            iLenSub = length(vIdxSub);
            iFlag = sum(vUsed(vIdxSub));
        end
        %连接起点和终点
        line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', vColor(iCountContour));
    end
%     iCountContour
end

