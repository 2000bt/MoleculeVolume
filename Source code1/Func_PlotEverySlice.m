function[vXtemp,vYtemp,vXtemp1,vYtemp1,mLine,mLine1,vContourPoint,vContourPoint1,iCountContour,iCountContour1,totalVolume]= Func_PlotEverySlice(vX, vY, vZ, iFaceLength, vFace,step,vStart,vX1, vY1, vZ1, iFaceLength1, vFace1,step1)
%matXÿһ�д���һ���ĵĺ����꣬�ж����о��ж��ٲ�
% close all
% tic
% for iii=1:6
% FontSize = 30; 
% FontWeight = 'bold';
totalVolume=0;
%���ƴ���ж��ٲ��Լ���ʼ�Լ����ղ�
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
%����������Ƭ���߾���
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

%ͨ���������ֲ�������е�XYZ�������
%cellArray=cell(10000,Max_Layer);
% cellArray={};

%Ԥ��ÿ���м�������
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
          
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
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
%%%ͬ���ж����Ĳ㣬Ȼ��ͬ�����㽻�����ݣ�����ھ�����
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
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
          
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
          
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
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
%ͬ���ж����Ĳ㣬Ȼ��ͬ�����㽻�����ݣ�����ھ�����
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
          %�жϸ���������߶�������һ��,ͬʱ������������һ������
          
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

%������㼯
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
    fprintf('��Χ�й���ǰ%d��������Ϊ%d\n', j, lengthStart1);
    fprintf('��Χ�й���ǰ�ܵĵ������Ϊ%d\n',  lengthStart);

    vZtemp1=matZ1(:,iTemp);
    vZtemp1=vZtemp1(vZtemp1~=0);

    d=iTemp*dSlice+dStartZ;
    vZ=d * ones(length(vXY), 1);
    vZ1=d * ones(length(vXY1), 1);

     % ��̬���㵱ǰ������귶Χ
    x_min = min([vXY(:, 1); vXY1(:, 1)]);
    x_max = max([vXY(:, 1); vXY1(:, 1)]);
    y_min = min([vXY(:, 2); vXY1(:, 2)]);
    y_max = max([vXY(:, 2); vXY1(:, 2)]);

    % �����ʵ��ı߽������ɵ��ڣ�
    margin = 0.1; % ����10%�ļ��
    x_range = x_max - x_min;
    y_range = y_max - y_min;
    x_min = x_min - margin * x_range;
    x_max = x_max + margin * x_range;
    y_min = y_min - margin * y_range;
    y_max = y_max + margin * y_range;

   
    % ��ʼ��ͼ��
    figure;

    % ���Ƶ�ǰ�㼯
    %hold on;  % ���ֵ�ǰͼ��
    plot(vXY(:, 1), vXY(:, 2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); % ʹ����ɫ�����
    hold on;
    plot(vXY1(:, 1), vXY1(:, 2),'.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % ʹ�ú�ɫ�����
    %set(gca,'LooseInset',get(gca,'TightInset'))
    hold off;
%     view(3)
    axis equal;
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    axis([x_min, x_max, y_min, y_max]); % ��̬�������귶Χ
    set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    %%�������ָ�
    % ��ʼ����С�����ֵ
    xMin = inf; 
    xMax = -inf; 
    yMin = inf; 
    yMax = -inf;

    [mLine,iCountContour,vContourPoint,~] = Func_Unicursal_4(vXtemp, vYtemp, dSlice,[0.8235,0.1255,0.1529]);
    [mLine1,iCountContour1,vContourPoint1,~] = Func_Unicursal_4(vXtemp1, vYtemp1, step1(1),[0.2196,0.3490,0.5373]);
    figure;
    hold on; % ���ֻ�ͼ�����Ӷ�������
    axis equal; % ȷ��������һ��

      % ���Ƶ�һ������
    numContours = length(vContourPoint);
    for i = 1:numContours
        if i == 1
            startIdx = 1;
        else
            startIdx = sum(vContourPoint(1:i-1)) + 1;
        end
        endIdx = sum(vContourPoint(1:i));
    
        % ��ȡ��ǰ����������
        currentContour = mLine(startIdx:endIdx, 1); % ��ǰ�����ĵ�����
        currentX = vXtemp(currentContour);
        currentY = vYtemp(currentContour);
    
        % �պ�����
        currentX = [currentX; currentX(1)];
        currentY = [currentY; currentY(1)];
    
        % ��������
        plot(currentX, currentY,'Color', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);
    
        % ������С���ֵ
        xMin = min(xMin, min(currentX));
        xMax = max(xMax, max(currentX));
        yMin = min(yMin, min(currentY));
        yMax = max(yMax, max(currentY));
    end
    
    % ���Ƶڶ�������
    numContours1 = length(vContourPoint1);
    for i = 1:numContours1
        if i == 1
            startIdx1 = 1;
        else
            startIdx1 = sum(vContourPoint1(1:i-1)) + 1;
        end
        endIdx1 = sum(vContourPoint1(1:i));
    
        % ��ȡ��ǰ����������
        currentContour1 = mLine1(startIdx1:endIdx1, 1); % ��ǰ�����ĵ�����
        currentX1 = vXtemp1(currentContour1);
        currentY1 = vYtemp1(currentContour1);
    
        % �պ�����
        currentX1 = [currentX1; currentX1(1)];
        currentY1 = [currentY1; currentY1(1)];
    
        % ��������
        plot(currentX1, currentY1,'Color', [0.74,0.12,0.12], 'LineWidth', 2);
    
        % ������С���ֵ
        xMin = min(xMin, min(currentX1));
        xMax = max(xMax, max(currentX1));
        yMin = min(yMin, min(currentY1));
        yMax = max(yMax, max(currentY1));
    end
    
    % �������յ������᷶Χ�����Ͽ�϶
    margin = 0.1;
    xRange = xMax - xMin;
    yRange = yMax - yMin;
    
    xMin2 = xMin - margin * xRange; 
    xMax2 = xMax + margin * xRange;
    yMin2 = yMin - margin * yRange;
    yMax2 = yMax + margin * yRange;
    
    % ���������᷶Χ
    axis([xMin2, xMax2, yMin2, yMax2]);
    
    % ���ñ�ǩ
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;  % ������ͼ

     % ���ƶ������㼯
    
   
    [contourCoords, totalContours, pointsPerContour] = Func_extractContourCoords(mLine, vContourPoint, vXtemp, vYtemp, iCountContour);
    [contourCoords1, totalContours1, pointsPerContour1] = Func_extractContourCoords(mLine1, vContourPoint1, vXtemp1, vYtemp1, iCountContour1);
    
    % �����µ�ͼ�δ���
    figure;
    
    % ���Ƶ�һ����������ɫ�㼯����ɫ��Χ�У�
    for i = 1:totalContours
        % ��ȡ��ǰ����������
        contour = contourCoords(sum(pointsPerContour(1:i-1)) + 1 : sum(pointsPerContour(1:i)), :);
        
        % ���������㼯����ɫ�㣩
        plot(contour(:,1), contour(:,2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8);
        hold on;
        
        % ���㵱ǰ�����İ�Χ��
        minX = min(contour(:,1));
        maxX = max(contour(:,1));
        minY = min(contour(:,2));
        maxY = max(contour(:,2));
        
        % ���ư�Χ�У���ɫ��
        rectangle('Position', [minX, minY, maxX - minX, maxY - minY], 'EdgeColor', [0.74,0.12,0.12], 'LineWidth', 2);
    end
    
    % ���Ƶڶ�����������ɫ�㼯����ɫ��Χ�У�
    for i = 1:totalContours1
        % ��ȡ��ǰ����������
        contour1 = contourCoords1(sum(pointsPerContour1(1:i-1)) + 1 : sum(pointsPerContour1(1:i)), :);
        
        % ���������㼯����ɫ�㣩
        plot(contour1(:,1), contour1(:,2),'.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8);
        hold on;
        
        % ���㵱ǰ�����İ�Χ��
        minX1 = min(contour1(:,1));
        maxX1 = max(contour1(:,1));
        minY1 = min(contour1(:,2));
        maxY1 = max(contour1(:,2));
        
        % ���ư�Χ�У���ɫ��
        rectangle('Position', [minX1, minY1, maxX1 - minX1, maxY1 - minY1], 'EdgeColor', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);
    end
    
    % ����������������Сֵ�����ֵ
    minX = min([contourCoords(:,1); contourCoords1(:,1)]);
    maxX = max([contourCoords(:,1); contourCoords1(:,1)]);
    minY = min([contourCoords(:,2); contourCoords1(:,2)]);
    maxY = max([contourCoords(:,2); contourCoords1(:,2)]);
    
    % Ϊ��������ӱ߾�
    margin = 0.1;  % �߾������0.1��ʾ10%�Ŀռ�
    xLimits = [minX - (maxX - minX) * margin, maxX + (maxX - minX) * margin];
    yLimits = [minY - (maxY - minY) * margin, maxY + (maxY - minY) * margin];
    
    % ���������᷶Χ����ʾ
    axis([xLimits, yLimits]);  % Ӧ���µ����귶Χ
    axis equal;
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    % title('���������Χ��');
    % legend({'��һ������', '��һ���Χ��', '�ڶ�������', '�ڶ����Χ��'});
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;

    
    %%���ư�Χ�й��˺�ĵ㼯

    % �������Ѿ���ȡ�� validContourCoords �� validContourCoords1
   % �������Ѿ���ȡ�� validContourCoords �� validContourCoords1
[validContourCoords, validContourCoords1] = Func_AABB_EverySlice(contourCoords, totalContours, pointsPerContour, contourCoords1, totalContours1, pointsPerContour1);
lengthEnd1=length(validContourCoords)+length(validContourCoords1);
lengthEnd=lengthEnd+lengthEnd1;
fprintf('��Χ�й��˺��%d��������Ϊ%d\n', j, lengthEnd1);
fprintf('��Χ�й��˺��ܵĵ������Ϊ%d\n', j, lengthEnd);

% �����µ�ͼ�δ���
figure;
hold on;

% ���Ƶ�һ����Ч�㣨��ɫ��
if ~isempty(validContourCoords)&&~isempty(validContourCoords1)
    plot(validContourCoords(:,1), validContourCoords(:,2),  '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); 
% end
% 
% ���Ƶڶ�����Ч�㣨��ɫ��
% if ~isempty(validContourCoords1)
    plot(validContourCoords1(:,1), validContourCoords1(:,2), '.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % ʹ�ú�ɫ�����

% end

% ����ͼ�ε���ʾ����
    axis equal;
    
    % Ϊ�˸�ͼ�����������հ׿ռ䣬����ͨ���ֶ����� xlim �� ylim ��ʵ��
    margin = 0.1;  % ���ÿհ׿ռ����
    
    % ��ȡ��ǰͼ�ε� x �� y ��Χ
    xRange = [min([validContourCoords(:,1); validContourCoords1(:,1)]), max([validContourCoords(:,1); validContourCoords1(:,1)])];
    yRange = [min([validContourCoords(:,2); validContourCoords1(:,2)]), max([validContourCoords(:,2); validContourCoords1(:,2)])];
    
    % �������յķ�Χ
    xMargin = (xRange(2) - xRange(1)) * margin;
    yMargin = (yRange(2) - yRange(1)) * margin;
    
    % ���� xlim �� ylim
    xlim([xRange(1) - xMargin, xRange(2) + xMargin]);
    ylim([yRange(1) - yMargin, yRange(2) + yMargin]);
    
    % ��ӱ�ǩ�ͱ���
    xlabel('X/Bohr','FontSize', 14);
    ylabel('Y/Bohr','FontSize', 14);
    % title('��Ч�㼯');
    % legend({'��һ����Ч��', '�ڶ�����Ч��'});
    box on;
     set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

    hold off;
end




    %%�������߷�ɸ����ĵ㼯
  % �������Ѿ���ȡ�� RvalidContourCoords �� RvalidContourCoords1
[RvalidContourCoords, RvalidContourCoords1] = Func_RayCasting_Intersect(contourCoords, totalContours, pointsPerContour, contourCoords1, totalContours1, pointsPerContour1);

% �����µ�ͼ�δ���
figure;
hold on;

% ���Ƶ�һ����Ч�㣨��ɫ��
if ~isempty(RvalidContourCoords)
    plot(RvalidContourCoords(:,1), RvalidContourCoords(:,2), '.', 'Color', [0.2196, 0.3490, 0.5373],'MarkerSize', 8); % ʹ����ɫ�����

end

% ���Ƶڶ�����Ч�㣨��ɫ��
if ~isempty(RvalidContourCoords1)
    plot(RvalidContourCoords1(:,1), RvalidContourCoords1(:,2), '.', 'Color', [0.74,0.12,0.12],'MarkerSize', 8); % ʹ�ú�ɫ�����

end

% ����ͼ�ε���ʾ����
axis equal;

% ȷ���ڼ��� xRange �� yRange ǰ��RvalidContourCoords �� RvalidContourCoords1 ����Ϊ��
if ~isempty(RvalidContourCoords) && ~isempty(RvalidContourCoords1)
    % ��ȡ��ǰͼ�ε� x �� y ��Χ
    xRange = [min([RvalidContourCoords(:,1); RvalidContourCoords1(:,1)]), max([RvalidContourCoords(:,1); RvalidContourCoords1(:,1)])];
    yRange = [min([RvalidContourCoords(:,2); RvalidContourCoords1(:,2)]), max([RvalidContourCoords(:,2); RvalidContourCoords1(:,2)])];

    % �������յķ�Χ
    margin = 0.1;  % ���ÿհ׿ռ����
    xMargin = (xRange(2) - xRange(1)) * margin;
    yMargin = (yRange(2) - yRange(1)) * margin;

    % ���� xlim �� ylim
    xlim([xRange(1) - xMargin, xRange(2) + xMargin]);
    ylim([yRange(1) - yMargin, yRange(2) + yMargin]);
else
    disp('��Ч�㼯Ϊ�գ��޷����㷶Χ');
end

% ��ӱ�ǩ�ͱ���
xlabel('X/Bohr','FontSize', 14);
ylabel('Y/Bohr','FontSize', 14);
% title('��Ч�㼯');
% legend({'��һ����Ч��', '�ڶ�����Ч��'});
box on;
 set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

hold off;



%���ն������ָ�
   % ���ն������ָ�
xMin = inf; 
xMax = -inf; 
yMin = inf; 
yMax = -inf;

% ��� RvalidContourCoords �� RvalidContourCoords1 �Ƿ�Ϊ��
if isempty(RvalidContourCoords) || isempty(RvalidContourCoords1)
    disp('RvalidContourCoords �� RvalidContourCoords1 ����Ϊ�գ�������ǰ����');
    continue; % ������ǰ����
end    

% �ϲ�������Ч�������㼯
vXtempL = [RvalidContourCoords(:,1); RvalidContourCoords1(:,1)];
vYtempL = [RvalidContourCoords(:,2); RvalidContourCoords1(:,2)];

% ���� Func_Unicursal_4 ������������
[mLine, iCountContour, vContourPoint,~] = Func_Unicursal_4(vXtempL, vYtempL, dSlice, [0.8235, 0.1255, 0.1529]);

% ��ͼ
figure;
hold on; % ���ֻ�ͼ�����Ӷ�������
axis equal; % ȷ��������һ��

% ����ÿ������
numContours = length(vContourPoint);
for i = 1:numContours
    % ���㵱ǰ��������ʼ�ͽ�������
    if i == 1
        startIdx = 1;
    else
        startIdx = sum(vContourPoint(1:i-1)) + 1;
    end
    endIdx = sum(vContourPoint(1:i));
   
    % ��ȡ��ǰ����������
    currentContour = mLine(startIdx:endIdx, 1); % ��ǰ�����ĵ�����
    currentX = vXtempL(currentContour);
    currentY = vYtempL(currentContour);

    % ��˹�����ʽ�����������
    x_shifted = [currentX(2:end); currentX(1)]; % x_{i+1}
    y_shifted = [currentY(2:end); currentY(1)]; % y_{i+1}
    
    area = 0.5 * abs(sum(currentX .* y_shifted - x_shifted .* currentY)); 
    disp(size(currentX));  % Ӧ���� (N,1) �� (1,N)
    disp(size(currentY));  % Ӧ���� (N,1) �� (1,N)
    disp(size(area));      % Ӧ���� (1,1)

    % �ۼ����
    totalVolume = totalVolume + area * dSlice;
    disp(totalVolume)

    % �պ�������������ʼ��
    currentX = [currentX; currentX(1)];
    currentY = [currentY; currentY(1)];

    % ��������
    plot(currentX, currentY, 'Color', [0.2196, 0.3490, 0.5373], 'LineWidth', 2);

    % ������С���ֵ
    xMin = min(xMin, min(currentX));
    xMax = max(xMax, max(currentX));
    yMin = min(yMin, min(currentY));
    yMax = max(yMax, max(currentY));
end

% �������յ������᷶Χ�����Ͽ�϶
margin = 0.1;
xRange = xMax - xMin;
yRange = yMax - yMin;

xMin2 = xMin - margin * xRange; 
xMax2 = xMax + margin * xRange;
yMin2 = yMin - margin * yRange;
yMax2 = yMax + margin * yRange;

% ���������᷶Χ
axis([xMin2, xMax2, yMin2, yMax2]);

% ���ñ�ǩ
xlabel('X/Bohr','FontSize', 14);
ylabel('Y/Bohr','FontSize', 14);
box on;
set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,'filename','-dpdf','-r0')

hold off;  % ������ͼ


end


hold off;  % �رձ���