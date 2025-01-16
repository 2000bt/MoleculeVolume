%%方法一：连成完整轮廓后，用直线相交算交点
function[dS]= Func_Find_interp1(vXTemp,vYTemp,vXTemp1,vYTemp1,dSlice,step1,vertex,vertex_match)
Flag=1;
mLine=[];
mLine1=[];
% point=[];
dS=0;
dS1=0;
%包围盒求交
Max_X=max(vXTemp);
Max_Y=max(vYTemp);
Max_X1=max(vXTemp1);
Max_Y1=max(vYTemp1);
Min_X=min(vXTemp);
Min_Y=min(vYTemp);
Min_X1=min(vXTemp1);
Min_Y1=min(vYTemp1);
% w=Max_X-Min_X;
% h=Max_Y-Min_Y;
% w1=Max_X1-Min_X1;
% h1=Max_Y1-Min_Y1;
% if(j==43)
%     disp([Max_X,Max_Y,Min_X,Min_Y,;Max_X1,Max_Y1,Min_X1,Min_Y1]);
%      hold on;
%      rectangle('Position',[Min_X Min_Y w h],'edgecolor','g','facecolor','none','linewidth',2) ;
%       rectangle('Position',[Min_X1 Min_Y1 w1 h1],'edgecolor','r','facecolor','none','linewidth',2) 
% end
%二维包围盒
if(((Min_X>Max_X1)||(Min_Y>Max_Y1))||((Max_X<Min_X1)||(Max_Y<Min_Y1)))
%     a=sprintf("第 %d 层不相交",j); 
%     disp(a);
    Flag=0;
    return
end

%连接轮廓
if(Flag==1)
    
%     figure ;
%     hold on;
%     
    
%    scatter(vXTemp,vYTemp,'filled','r');
%    scatter(vXTemp1,vYTemp1,'filled','b');
%先连轮廓，不连接尾部
   

    figure;
    hold on;
    [mLine,iCountContour,vContourPoint] = Func_Unicursal_5(vXTemp, vYTemp, dSlice,'r'); 
    %plot(vertex1(:,1),vertex1(:,2),'k','LineWidth',3);
 
%    hold off;
%    figure;
%    hold on;
   
   [mLine1,iCountContour1,vContourPoint1] = Func_Unicursal_5(vXTemp1, vYTemp1,step1,'b');
%    plot(vertex(:,1),vertex(:,2),'k','LineWidth',10);
   hold off;
  
  
  


%    p=plot([-18,-18],[-15,14],'-k');
%    p.LineWidth=3;
%       hold off;
%       axis image;  
% % 设置X轴标签的字体大小和字体粗细
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight','bold');
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% set(gca, 'FontSize', 22);
%    hold off;
   %%多轮廓的解决办法
   if iCountContour>1&&iCountContour1==1  
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
        [mLine1,vXTemp1,vYTemp1]=Func_rewrite(mLine1,2,vXTemp1,vYTemp1,vertex,vertex_match);
        for num_c=1:iCountContour
                if((vRectangle(num_c,1)>Max_X1)||(vRectangle(num_c,3)>Max_Y1)||(vRectangle(num_c,2)<Min_X1)||(vRectangle(num_c,4)<Min_Y1))
                        continue;
                else
%                    figure;
                  
                   [mLineSub{num_c},vXTemp,vYTemp]=Func_rewrite(mLineSub{num_c},1,vXTemp,vYTemp,vertex,vertex_match);
%                    mLine1(vContourPoint1,2)=mLine1(1,1);
                   [point]=Func_FindOverlap_1(mLineSub{num_c},mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1);
                   if ~isempty(point)
                        figure;
                        point=unique(point,'row','stable'); 
                        scatter(point(:,1),point(:,2),30,'filled','k');
                        figure;
                        dS1=Func_Unicursal_R(point(:,1),point(:,2),dSlice); 
                   end
                end
                dS=dS+abs(dS1);
        end

    elseif iCountContour1>1&&iCountContour==1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       [mLine,vXTemp,vYTemp]=Func_rewrite(mLine,1,vXTemp,vYTemp,vertex,vertex_match);
       for num_c=1:iCountContour1
               if((vRectangle(num_c,1)>Max_X)||(vRectangle(num_c,3)>Max_Y)||(vRectangle(num_c,2)<Min_X)||(vRectangle(num_c,4)<Min_Y))
                        continue;
               else
%                    figure;
                   
                   [mLineSub{num_c},vXTemp1,vYTemp1]=Func_rewrite(mLineSub{num_c},2,vXTemp1,vYTemp1,vertex,vertex_match);
%                    mLine(vContourPoint,2)=mLine(1,1);
                   [point]=Func_FindOverlap_1(mLine,mLineSub{num_c},vXTemp,vYTemp,vXTemp1,vYTemp1);
                   if ~isempty(point)
                        figure;
                        point=unique(point,'row','stable'); 
                         scatter(point(:,1),point(:,2),30,'filled','k');
                         figure;
                        dS1=Func_Unicursal_R(point(:,1),point(:,2),dSlice); 
                   end
               end
               dS=dS+abs(dS1);
        end
   elseif iCountContour1>1&&iCountContour>1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
       [mLineSub1,vRectangle1]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       for num_c=1:iCountContour
           for num_c1=1:iCountContour1
               if((vRectangle(num_c,1)>vRectangle1(num_c1,2))||(vRectangle(num_c,3)>vRectangle1(num_c1,4))||(vRectangle(num_c,2)<vRectangle1(num_c1,1))||(vRectangle(num_c,4)<vRectangle1(num_c1,3)))
                        continue;
               else
%                    figure;
                   [mLineSub{num_c},vXTemp,vYTemp]=Func_rewrite(mLineSub{num_c},1,vXTemp,vYTemp,vertex,vertex_match);
                   [mLineSub1{num_c},vXTemp1,vYTemp1]=Func_rewrite(mLineSub1{num_c},2,vXTemp1,vYTemp1,vertex,vertex_match);
                   [point]=Func_FindOverlap_1(mLineSub{num_c},mLineSub1{num_c1},vXTemp,vYTemp,vXTemp1,vYTemp1);
                   if ~isempty(point)
                        figure;
                        point=unique(point,'row','stable'); 
                        scatter(point(:,1),point(:,2),30,'filled','k');
                        figure;
                        dS1=Func_Unicursal_R(point(:,1),point(:,2),dSlice); 
                   end
                   
               end
               dS=dS+abs(dS1);
           end
       end
       
   else
%        mLine(vContourPoint,2)=mLine(1,1);
%        mLine1(vContourPoint1,2)=mLine1(1,1);
        [mLine,vXTemp,vYTemp]=Func_rewrite(mLine,1,vXTemp,vYTemp,vertex,vertex_match); 
        [mLine1,vXTemp1,vYTemp1]=Func_rewrite(mLine1,2,vXTemp1,vYTemp1,vertex,vertex_match);  
%        figure;
       [point]=Func_FindOverlap_1(mLine,mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1);
       if ~isempty(point)
            figure;
            point=unique(point,'row','stable'); 
            scatter(point(:,1),point(:,2),30,'filled','k');
% %             axis image;     
% % 设置X轴标签的字体大小和字体粗细
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% set(gca, 'FontSize', 22);
figure;
% hold on;
            dS=Func_Unicursal_R(point(:,1),point(:,2),dSlice); 
%             % 设置X轴标签的字体大小和字体粗细
%             hold off;
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% set(gca, 'FontSize', 22);
       end
   end
%    figure;
%    hold on;
%    scatter(vXTemp,vYTemp,35,'filled','r');
%    scatter(vXTemp1,vYTemp1,35,'filled','b');
%    hold off;
end% 计算点到线段的距离函数

end

