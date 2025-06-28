function [vSort] = Func_Unicursal(vXTemp, vYTemp, dSlice)
%     dS = 0;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%�Ƿ�ʹ�ù�
    vSort = zeros(iLen, 1);%���кõģ��������⣬ÿ������û�ֿ�
    iCount = 0;%���кõ��±�
    iCountContour = 0;
    vColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
    while(iCount < iLen)
        %��û�ù���x����С��
        vIdx = find(0 == vUsed);
        iCountContour = iCountContour + 1;%�ڼ��������õڼ�����ɫ
        iTemp = find(min(vXTemp(vIdx)));
        iStart = vIdx(iTemp);
        %�����x����ͬ�ģ�ȡ��һ��
        if(length(iStart) > 1)
            iStart = iStart(1);
            iCount = iCount + 1;
            vSort(iCount) = iStart;
        end
        iCount = iCount + 1;
        vSort(iCount) = iStart;
        iLeft = iStart;
        vUsed(iLeft) = 1;%ʹ�������1
        %%%�˴��ǽ��������Σ�����Բ�Σ�����
        vIdxSub = find(vXTemp < vXTemp(iLeft) + 3.3 * dSlice);
        vIdxSub = vIdxSub(find(vYTemp(vIdxSub) < vYTemp(iLeft) + 3.3 * dSlice));
        vIdxSub = vIdxSub(find(vXTemp(vIdxSub) > vXTemp(iLeft) - 3.3 * dSlice));
        vIdxSub = vIdxSub(find(vYTemp(vIdxSub) > vYTemp(iLeft) - 3.4 * dSlice));
        iLenSub = length(vIdxSub);
        iFlag = sum(vUsed(vIdxSub));
        %������û���ù��ĵ�
        while(iFlag < iLenSub)
            %�ȽϾ���
            vDis = zeros(iLenSub, 1);
            for k = 1 : iLenSub
                if(1 == vUsed(vIdxSub(k)))
                    vDis(k) = 200;
                    continue;
                end
                vDis(k) = (vXTemp(vIdxSub(k)) - vXTemp(iLeft))^2 + (vYTemp(vIdxSub(k)) - vYTemp(iLeft))^2;
            end
            %��һ��������С�����
            iNext = vIdxSub(find(min(vDis) == vDis));
            %����о�����ͬ��ֻ���ӵ�һ�������������Ϊ����
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
            %���½��벽��2
            vIdxSub = find(vXTemp < vXTemp(iLeft) + 3.4 * dSlice);
            vIdxSub = vIdxSub(find(vYTemp(vIdxSub) < vYTemp(iLeft) + 3.4 * dSlice));
            vIdxSub = vIdxSub(find(vXTemp(vIdxSub) > vXTemp(iLeft) - 3.4 * dSlice));
            vIdxSub = vIdxSub(find(vYTemp(vIdxSub) > vYTemp(iLeft) - 3.4 * dSlice));
            iLenSub = length(vIdxSub);
            iFlag = sum(vUsed(vIdxSub));
        end
        %���������յ�
        line([vXTemp(iLeft), vXTemp(iStart)],[vYTemp(iLeft), vYTemp(iStart)], 'Color', vColor(iCountContour));
    end
%     iCountContour
end

