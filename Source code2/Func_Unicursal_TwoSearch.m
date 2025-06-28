function [mLineSub_cell,LineFlag,vRectangle,iCountContour] = Func_Unicursal_TwoSearch(vXTemp, vYTemp, dSlice)
%     figure;
%     hold on;
    iLen = length(vXTemp);
    vUsed = zeros(iLen, 1);%���ʹ�����
    
    mLine = zeros(iLen, 2);%������
    iCount = 0;
    iCountContour = 0;
    vContourPoint=[];
    vColor = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'w'];
    dR = 5 * dSlice;  
    LeftisOver=false;
    while(iCount < iLen)
      
        iCountContour = iCountContour + 1;
        iLeft = 1;
        %% �ҵ���������Ϊ���
        for i = 1 : iLen
            if(vUsed(iLeft) == 1)%�����ʼ���Ѿ��ù�
                iLeft = iLeft + 1;
                continue;
            end
            if vUsed(i) == 1  % �����ǰ���Ѿ��ù�������
                continue;
            end
            if vXTemp(i) < vXTemp(iLeft) || (vXTemp(i) == vXTemp(iLeft) && vYTemp(i) < vYTemp(iLeft))
                iLeft = i;  % ������ʼ��
            end
        end
        iCount = iCount + 1;%�����ߵ�����.�ڼ�����
        
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
         [~, iMin] = min(vDisUU);  % ��ȡ��С���������
         iMin = iMin(1);  % ����ж����Сֵ��ֻȡ��һ��
             
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
    %% һ���������� ,��LeftΪ�������
%          if iCountUnUsed
            % �����δ���ӵĵ㣬��������
        while(iCountUnUsed > 0)
            [~, iMin] = min(vDisUU);  % ��ȡ��С���������
            iMin = iMin(1);  % ����ж����Сֵ��ֻȡ��һ��
            iTemp = vIdxUU(iMin);
            iTemp_Dis = (vXTemp(iTemp) - vXTemp(iLeft))^2 + (vYTemp(iTemp) - vYTemp(iLeft))^2;
            vUsed(iTemp) = 1;
%             if(iTemp==122)
%                 a=1;
%             end
%             plot(vXTemp(iTemp),vYTemp(iTemp),'ko');
            % ���ӵ㲢����������
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
            % ���¼���δ���ӵĵ�
            [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iRight, dR);
            if iCountUnUsed==0
                LeftisOver=true;
                % ���ұߵ㻹��û��
            end
        end
        if LeftisOver
            [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR);
             while(iCountUnUsed > 0)
                [~, iMin] = min(vDisUU);  % ��ȡ��С���������
                iMin = iMin(1);  % ����ж����Сֵ��ֻȡ��һ��
                iTemp = vIdxUU(iMin);
                
                vUsed(iTemp) = 1;

                % ���ӵ㲢����������         
                mLine(iCount, 1) = iLeft; 
                mLine(iCount, 2) = iTemp;

%                 line([vXTemp(iTemp), vXTemp(iLeft)], [vYTemp(iTemp), vYTemp(iLeft)], 'Color', vColor(iCountContour), 'linewidth', 2);
                iLeft = iTemp;    
               
                iCount = iCount + 1;
                % ���¼���δ���ӵĵ�
                [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR);

            end
        end
        if isempty(vContourPoint)
            vContourPoint = [vContourPoint; iCount];  % ֱ�����
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
  
        %% �������������İ�Χ��
    mLineSub_cell=cell(iCountContour);
    vRectangle = zeros(iCountContour, 4);%��Χ��
    vTest = zeros(iCountContour, 1);%���λ�ã����ڲ��Ƿ�����ĵ�
    for i=1:iCountContour
        if(i==1)
            mLineSub=mLine(1:vContourPoint(1),:);
            vTest(i) = 1;
        else
            iFrom = 1 + sum(vContourPoint(1 : i - 1));%�Ҹ����������
            iTo = sum(vContourPoint(1 : i));
            vTest(i) = iFrom;
            mLineSub=mLine(iFrom:iTo,:);
        end
        % ��ȡ mLineSub ������ X �� Y ����
        mLineSub_cell{i}=mLineSub;
        xCoords = vXTemp(mLineSub(1:end));  % ��ȡ mLineSub �����е�� X ����
        yCoords = vYTemp(mLineSub(1:end));  % ��ȡ mLineSub �����е�� Y ����

        % ������Сֵ�����ֵ
        dMinX = min(xCoords);  % ��С X ֵ
        dMaxX = max(xCoords);  % ��� X ֵ
        dMinY = min(yCoords);  % ��С Y ֵ
        dMaxY = max(yCoords);  % ��� Y ֵ

        % ����Χ�е�����洢�� vRectangle ��
        vRectangle(i, :) = [dMinX, dMaxX, dMinY, dMaxY];
    end
       %% �ж������ϵ
    LineFlag=false(iCountContour,1);
  
    for i = 1 : iCountContour
%         mLineSub = mLine(vFrom2To(i, 1) : vFrom2To(i, 2), :);
%         mLineSub(vContourPoint(i), 2) = mLine(vFrom2To(i, 1), 1);
        mLineSub=mLineSub_cell{i};
        for j = 1 : iCountContour%�����������İ�����
            if(j == i)
                continue;
            end
            iTemp = mLine(vTest(j), 1);
            dTestX = vXTemp(iTemp);
            dTestY = vYTemp(iTemp);
            %%%����
            if(dTestX < vRectangle(i, 1) | dTestX > vRectangle(i, 2) | dTestY < vRectangle(i, 3) | dTestY > vRectangle(i, 4))
                    continue;
            else
                for k = 1 : vContourPoint(i)
                    %�߶η���yֵ��С����
                    dTempMinY = min(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                    dTempMaxY = max(vYTemp(mLineSub(k, 1)), vYTemp(mLineSub(k, 2)));
                    % ������Ե��yֵ�ڵ�ǰ�߶ε�yֵ��Χ�ڣ������ཻ�ж�
                    if dTempMinY < dTestY && dTempMaxY >= dTestY
                        % ������˳��ʹ�ýϸߵĵ�Ϊ��һ��
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
   
% �ֲ�����������δʹ�õĵ������ľ��벢ɸѡ���������ĵ�
    function [vDisUU, vIdxUU, iCountUnUsed] = findUnusedPoints(vXTemp, vYTemp, vUsed, iLeft, dR)
        % ɸѡδʹ�õĵ�
        unusedIdx = find(~vUsed);  % �ҳ�����δʹ�õĵ������

        % ��ȡδʹ�õ�� X �� Y ����
        unusedX = vXTemp(unusedIdx);
        unusedY = vYTemp(unusedIdx);

        % ����δʹ�õ������֮��ľ����ƽ��
        deltaX = unusedX - vXTemp(iLeft);  % δʹ�õ�� X �����
        deltaY = unusedY - vYTemp(iLeft);  % δʹ�õ�� Y �����
        vDis = deltaX.^2 + deltaY.^2;  % ŷ�Ͼ����ƽ��

        % ɸѡ�����ڰ뾶��Χ�ڵĵ�
        vDisUU = vDis(vDis <= dR^2);  % �ҵ����������ĵ�ľ���
        vIdxUU = unusedIdx(vDis <= dR^2);  % �ҵ����������ĵ������

        % ��¼���������ĵ�
        iCountUnUsed = numel(vIdxUU);  % ����δ���ӵ���Ŀ
    end

end