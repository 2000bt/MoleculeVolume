function [mLine,iCountContour,vContourPoint] = Func_Unicursal_3(vXTemp, vYTemp, dSlice)
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%���ʹ�����
    mLine = zeros(iLen, 2);%������
    iCount = 0;
    iCountContour = 0;
    iCountUnUsed = 0;
    iCountSub = 0;
    vColor = [ 'm', 'y', 'k', 'w','r', 'g', 'b', 'c'];
    dR = 6 * dSlice;
    while(iCount < iLen)
        iCountContour = iCountContour + 1;
        iStart = 1;
        %% �ҵ���������Ϊ���
        for i = 1 : iLen
            if(vUsed(iStart) == 1)%�����ʼ���Ѿ��ù�
                iStart = iStart + 1;
                continue;
            end
            if(1 == vUsed(i))
                continue;
            end
            if(vXTemp(iStart) < vXTemp(i))
                iStart = i;
            end
        end
        iLeft = iStart;
        iCount = iCount + 1;%�����ߵ�����
        mLine(iCount, 1) = iStart;
        vUsed(iStart) = 1;
        %% ��¼�뾶R�е�ĸ�������δʹ�õ�ĸ���
        for i = 1 : iLen
            if(iStart == i | vXTemp(i) > vXTemp(iStart) + dR | vXTemp(i) < vXTemp - dR | vYTemp(i) > vYTemp(iStart) + dR | vYTemp(i) < vYTemp - dR)
                continue;
            end
            if(0 == vUsed(i))
                iCountUnUsed = iCountUnUsed + 1;
            end
            iCountSub = iCountSub + 1;
        end
        %% �ҵ�������������������
        vDisUU = zeros(iCountUnUsed, 1);%
        vIdxUU = zeros(iCountUnUsed, 1);
        vDis = zeros(iCountSub, 1);
        vIdx = zeros(iCountSub, 1);
        iTemp = 1;
        iTempUU = 1;
        %������r��Χ�ھ�������λ��
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
        
        iMin = 1;
        for i = 1 : iCountSub
            if(vDis(iMin) > vDis(i))
                iMin = i;
            end
        end
        if(length(iMin) > 1)
            iMin = iMin(1);
        end
        %Ϊʲô����iMin
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
 %% һ����������       
        while(iCountUnUsed > 0)
            iMin = 1;
            for i = 1 : iCountUnUsed
                if(vDisUU(iMin) > vDisUU(i))
                iMin = i;
                end
            end
            iNext = vIdxUU(iMin);
            mLine(iCount, 2) = iNext;    
            line([vXTemp(iLeft), vXTemp(iNext)],[vYTemp(iLeft), vYTemp(iNext)], 'Color', vColor(iCountContour), 'linewidth', 2);
            vUsed(iNext) = 1;
            iCount = iCount + 1;
            iLeft = iNext;
            mLine(iCount, 1) = iLeft;
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
        end
        line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', vColor(iCountContour),'linewidth', 2);
    end
    %%  ����������
    vContourPoint = zeros(iCountContour, 1);
    iCount = 0;
    iCountContour = 0;
    for i = 1 : iLen
        if(mLine(i, 2) ~= 0 )
            iCount = iCount + 1;
        else
            iCount = iCount + 1;
            iCountContour = iCountContour + 1;
            vContourPoint(iCountContour, 1) = iCount;
            iCount = 0;
        end
    end
end