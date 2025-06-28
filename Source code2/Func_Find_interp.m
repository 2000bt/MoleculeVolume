%%方法一：连成完整轮廓后，用直线相交算交点
function[dS]= Func_Find_interp(vXTemp,vYTemp,vXTemp1,vYTemp1,j,dSlice,step1)
Flag=1;
FontSize = 22;
FontWeight = 'bold';
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
w=Max_X-Min_X;
h=Max_Y-Min_Y;
w1=Max_X1-Min_X1;
h1=Max_Y1-Min_Y1;
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
%      a=min(vXTemp);
%     b=min(vXTemp1);
%     dXStart = min(a,b);
%     dXStart = round(dXStart) - 1;
%      a=max(vXTemp);
%     b=max(vXTemp1);
%     dXEnd = max(a,b);
%     dXEnd = round(dXEnd) + 1;
%      a=min(vYTemp);
%     b=min(vYTemp1);
%     dYStart = min(a,b);
%     dYStart = round(dYStart) - 1;
%      a=max(vYTemp);
%     b=max(vYTemp1);
%     dYEnd = max(a,b);
%     dYEnd = round(dYEnd) + 1;
%     figure(j);
% %     hold on;
%     axes2 = axes('Parent', figure(j), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
      figure;
    hold on;
   [mLine,iCountContour,vContourPoint,LineFlag] = Func_Unicursal_4(vXTemp, vYTemp, dSlice,[0.8235,0.1255,0.1529]); 
%    [mLine1,iCountContour1,vContourPoint1,LineFlag1] = Func_Unicursal_TwoSearch(vXTemp, vYTemp, dSlice)
   [mLine1,iCountContour1,vContourPoint1,LineFlag1] = Func_Unicursal_4(vXTemp1, vYTemp1, step1(1),[0.2196,0.3490,0.5373]);  
%     rectangle('Position',[Min_X Min_Y w h],'edgecolor',[0.8235,0.1255,0.1529],'facecolor','none','linewidth', 3,'LineStyle', '--') ;
%     rectangle('Position',[Min_X1 Min_Y1 w1 h1],'edgecolor',[0.2196,0.3490,0.5373],'facecolor','none','LineWidth', 3,'LineStyle', '--') 
%         axis image;
%         axis off;
%     saveFolder = 'F:\AAALLL\figure'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('%s_%d.emf', datestr(now, 'yyyymmdd_HHMMSS'),j); % 按照日期和时间规则命名
% 
% % 使用 saveas 函数保存图形
% % saveas(gcf, fullfile(saveFolder, fileName), 'meta');
% print(fullfile(saveFolder, fileName), '-dmeta', '-r600','-painters');
% % close(gcf);
 hold off;  
% 关闭图形绘制

      
   
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
%     figure(j+50);
%   
%     axes2 = axes('Parent', figure(j+50), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
    if iCountContour>1&&iCountContour1==1  
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
        for num_c=1:iCountContour
                if((vRectangle(num_c,1)>Max_X1)||(vRectangle(num_c,3)>Max_Y1)||(vRectangle(num_c,2)<Min_X1)||(vRectangle(num_c,4)<Min_Y1))
                        continue;
                else
%                    figure(num_c+50);
% %   
%     axes2 = axes('Parent', figure(num_c+50), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
                   mLine1(vContourPoint1,2)=mLine1(1,1);
%                    for kkk=1:length(mLineSub{num_c})
%                          plot([vXTemp(mLineSub{num_c}(kkk,1)),vXTemp(mLineSub{num_c}(kkk,2))],[vYTemp(mLineSub{num_c}(kkk,1)),vYTemp(mLineSub{num_c}(kkk,2))],'color',[0.8235,0.1255,0.1529],'linewidth', 2);
%                    end
%                    for kkk=1:length(mLine1)
%                         plot([vXTemp1(mLine1(kkk,1)),vXTemp1(mLine1(kkk,2))],[vYTemp1(mLine1(kkk,1)),vYTemp1(mLine1(kkk,2))],'color',[0.2196,0.3490,0.5373],'linewidth', 2);
%                    end
%                     Max_X=max(vXTemp(mLineSub{num_c}(:)));
%                     Max_Y=max(vYTemp(mLineSub{num_c}(:)));
%                     Min_X=min(vXTemp(mLineSub{num_c}(:)));
%                     Min_Y=min(vYTemp(mLineSub{num_c}(:)));
%                     w=Max_X-Min_X;
%                     h=Max_Y-Min_Y;
%                     rectangle('Position',[Min_X Min_Y w h],'edgecolor',[0.8235,0.1255,0.1529],'facecolor','none','LineWidth', 3,'LineStyle', '--') ;
%                     rectangle('Position',[Min_X1 Min_Y1 w1 h1],'edgecolor',[0.2196,0.3490,0.5373],'facecolor','none','LineWidth', 3,'LineStyle', '--') 
                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1,num_c);
                   if ~isempty(point)
%                         figure;
%                         point=unique(point,'row','stable'); 
%                         dS1=Func_Unicursal_Fina(point(:,1),point(:,2),dSlice,LineFlag(num_c),LineFlag1); 
                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1);
                   else
                       dS1=0;
                   end
                end
                dS=dS+dS1;
        end

    elseif iCountContour1>1&&iCountContour==1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       for num_c=1:iCountContour1
               if((vRectangle(num_c,1)>Max_X)||(vRectangle(num_c,3)>Max_Y)||(vRectangle(num_c,2)<Min_X)||(vRectangle(num_c,4)<Min_Y))
                        continue;
               else
%                    figure;
                   mLine(vContourPoint,2)=mLine(1,1);
                   [point,num_con]=Func_FindOverlap_1(mLine,mLineSub{num_c},vXTemp,vYTemp,vXTemp1,vYTemp1);
%                    save point point;
                   if ~isempty(point)
%                        dXStart = -5;
%     dXEnd = 4;
%   
%     dYStart = 0;
%    
%     dYEnd = 6;
%                        figure(j+1);
%                     axes2 = axes('Parent', figure(j+1), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%                     box(axes2, 'on');
%                     set(axes2, 'xtick', []);
%                     set(axes2, 'ytick', []);
%                     set(axes2, 'xlim', [-5, 4]);
%                     set(axes2, 'ylim', [0 , 6]);
%                     set(axes2, 'xtick', [-5, (-5 + 4)/ 2, 4]);
%                     set(axes2, 'ytick', [0, (0 + 6)/ 2, 6]);
%                     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%                     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%                     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%                     hold on;
%                     scatter(point{1,1}(:,1), point{1,1}(:,2), 22,[0.8235,0.1255,0.1529],'filled')
% %                     plot(point{1,1}(:,1),point{1,1}(:,2),'color',[0.8235,0.1255,0.1529],'LineWidth',2.5);
% %                     leng=length(point{1,1});
% %                     plot([point{1,1}(leng,1),point{1,1}(1,1)],[point{1,1}(leng,2),point{1,1}(1,2)],'color',[0.8235,0.1255,0.1529],'LineWidth',2.5);
%                     hold off;
                        dS1=Func_ComputeArea(point,num_con,LineFlag,LineFlag1(num_c));
%                         figure;
%                         point=unique(point,'row','stable'); 
%                         dS1=Func_Unicursal_Fina(point(:,1),point(:,2),dSlice,LineFlag,LineFlag1(num_c)); 
                   else
                       dS1=0;
                   end
               end
               dS=dS+dS1;
        end
   elseif iCountContour1>1&&iCountContour>1 
       [mLineSub,vRectangle]=Func_GetSubline(mLine,iCountContour,vContourPoint,vXTemp, vYTemp);
       [mLineSub1,vRectangle1]=Func_GetSubline(mLine1,iCountContour1,vContourPoint1,vXTemp1, vYTemp1);
       for num_c=1:iCountContour
%      dXStart = -3;
%     dXEnd = 6.5;
%   
%     dYStart = -3;
%    
%     dYEnd = 7;
%    
%            figure(num_c*10);
%             axes2 = axes('Parent', figure((num_c*10)), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
%    for kkk=1:length(mLineSub{num_c})
%          plot([vXTemp(mLineSub{num_c}(kkk,1)),vXTemp(mLineSub{num_c}(kkk,2))],[vYTemp(mLineSub{num_c}(kkk,1)),vYTemp(mLineSub{num_c}(kkk,2))],'color',[0.8235,0.1255,0.1529],'linewidth', 2);
%    end
%   hold off;
%   saveFolder = 'F:\AAALLL\figure';
%   fileName = sprintf('%s_%d.eps', datestr(now, 'yyyymmdd_HHMMSS'),num_c*10); 
%   print(gcf, '-depsc', '-painters', '-r600', fullfile(saveFolder, fileName));
           for num_c1=1:iCountContour1
%                 figure((num_c*10+num_c1));
% %   figure(num_c1);
%     axes2 = axes('Parent', figure((num_c*10+num_c1)), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
%    for kkk=1:length(mLineSub{num_c})
%          plot([vXTemp(mLineSub{num_c}(kkk,1)),vXTemp(mLineSub{num_c}(kkk,2))],[vYTemp(mLineSub{num_c}(kkk,1)),vYTemp(mLineSub{num_c}(kkk,2))],'color',[0.8235,0.1255,0.1529],'linewidth', 2);
%    end
% 
%    for kkk=1:length(mLineSub1{num_c1})
%          plot([vXTemp1(mLineSub1{num_c1}(kkk,1)),vXTemp1(mLineSub1{num_c1}(kkk,2))],[vYTemp1(mLineSub1{num_c1}(kkk,1)),vYTemp1(mLineSub1{num_c1}(kkk,2))],'color',[0.2196,0.3490,0.5373],'linewidth', 2);
%    end
%   hold off;
%   saveFolder = 'F:\AAALLL\figure';
%   fileName = sprintf('%s_%d.eps', datestr(now, 'yyyymmdd_HHMMSS'),num_c1); 
%   print(gcf, '-depsc', '-painters', '-r600', fullfile(saveFolder, fileName));
               if((vRectangle(num_c,1)>vRectangle1(num_c1,2))||(vRectangle(num_c,3)>vRectangle1(num_c1,4))||(vRectangle(num_c,2)<vRectangle1(num_c1,1))||(vRectangle(num_c,4)<vRectangle1(num_c1,3)))
                        continue;
               else
%                    figure;
                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLineSub1{num_c1},vXTemp,vYTemp,vXTemp1,vYTemp1);
                    
                   if ~isempty(point)
%                                     figure((num_c*10+num_c1+11));
%                     axes2 = axes('Parent', figure((num_c*10+num_c1+11)), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%                     box(axes2, 'on');
%                     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%                     hold on;
%                     scatter(point{1,1}(:,1), point{1,1}(:,2), 22,[0.8235,0.1255,0.1529],'filled')
% %                     plot(point{1,1}(:,1),point{1,1}(:,2),'color','k','LineWidth',2);
% %                     leng=length(point{1,1});
% %                     plot([point{1,1}(leng,1),point{1,1}(1,1)],[point{1,1}(leng,2),point{1,1}(1,2)],'color','k','LineWidth',2);
%                     hold off;
%                     saveFolder = 'F:\AAALLL\figure';
%                      fileName = sprintf('%s_%d.eps', datestr(now, 'yyyymmdd_HHMMSS'),num_c*10+num_c1+11); 
%                     print(gcf, '-depsc', '-painters', '-r600', fullfile(saveFolder, fileName));
                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1(num_c1));
%                         figure;
%                         point=unique(point,'row','stable'); 
%                         dS1=Func_Unicursal_Fina(point(:,1),point(:,2),dSlice,LineFlag(num_c),LineFlag1(num_c1)); 
                   else
                       dS1=0;
                   end
                   
               end
               dS=dS+dS1;
           end
       end
       
   else
       mLine(vContourPoint,2)=mLine(1,1);
       mLine1(vContourPoint1,2)=mLine1(1,1);
%        figure;
       [point,num_con]=Func_FindOverlap_1(mLine,mLine1,vXTemp,vYTemp,vXTemp1,vYTemp1);
       if ~isempty(point)
            dS=Func_ComputeArea(point,num_con,LineFlag,LineFlag1);
%                  dXStart = -5;
%     dXEnd = 4;
%   
%     dYStart = 0;
%    
%     dYEnd = 6;
%    
%            figure(j*10);
%             axes2 = axes('Parent', figure((j*10)), 'xAxisLocation', 'bottom', 'yAxisLocation', 'left');
%     box(axes2, 'on');
%     set(axes2, 'xtick', []);
%     set(axes2, 'ytick', []);
%     set(axes2, 'xlim', [dXStart, dXEnd]);
%     set(axes2, 'ylim', [dYStart , dYEnd]);
%     set(axes2, 'xtick', [dXStart, (dXStart + dXEnd)/ 2, dXEnd]);
%     set(axes2, 'ytick', [dYStart, (dYStart + dYEnd)/ 2, dYEnd]);
%     xlabel('X/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     ylabel('Y/Bohr','Interpreter', 'latex', 'FontSize', FontSize);
%     set( gca, 'TickLabelInterpreter', 'latex', 'FontSize', FontSize, 'FontWeight', FontWeight );
%     hold on;
%    for kkk=1:length(mLineSub{num_c})
%          plot([vXTemp(mLineSub{num_c}(kkk,1)),vXTemp(mLineSub{num_c}(kkk,2))],[vYTemp(mLineSub{num_c}(kkk,1)),vYTemp(mLineSub{num_c}(kkk,2))],'color',[0.8235,0.1255,0.1529],'linewidth', 2);
%    end
%   hold off;
%             figure;
%             point=unique(point,'row','stable'); 
%             scatter(point(:,1),point(:,2),30,[0.8235,0.1255,0.1529],'filled');
% %             axis image;     
% % 设置X轴标签的字体大小和字体粗细
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% set(gca, 'FontSize', 22);
% figure;
% hold on;
%             dS=Func_Unicursal_Fina(point(:,1),point(:,2),dSlice,LineFlag,LineFlag1); 
%             % 设置X轴标签的字体大小和字体粗细
%             hold off;
% xlabel('X/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% 
% % 设置Y轴标签的字体大小和字体粗细
% ylabel('Y/Bohr', 'Interpreter', 'latex', 'FontSize', 22, 'FontWeight', 'bold');
% set(gca, 'FontSize', 22);
       end
   end
%    saveFolder = 'F:\AAALLL\figure'; % 替换为您想要保存的文件夹路径
%    fileName = sprintf('a%s.emf', datestr(now, 'yyyymmdd_HHMMSS')); % 按照日期和时间规则命名
% % 
% % % 使用 saveas 函数保存图形
% % %    saveas(gcf, fullfile(saveFolder, fileName), 'meta');
%     print(fullfile(saveFolder, fileName), '-dmeta', '-r600','-painters');
% % %    close(gcf);
%    hold off;
end
