close all;
clear all;
clc;
RGB = imread('\\samba1\vvaradha\dcengr\Desktop\sunset-690333__340.jpg');
       I  = rgb2gray(RGB); % convert to intensity
        H = fspecial('gaussian',9,2);
        blurredImage=imfilter(I,H);
        edgeFilter=[1 2 1;0 0 0;-1 -2 -1];
        edgeImg=imfilter(I,edgeFilter);
      % BW = edge(edgeImg,'sobel'); % extract edges
       [H,T,R] = hough(edgeImg,'Theta',-90:30:89);
  
       figure;
       subplot(2,1,1);
       imshow(edgeImg);
       title('gantrycrane.png');
  
       subplot(2,1,2); 
       imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
              'InitialMagnification','fit');
       title('Limited theta range Hough transform of gantrycrane.png');
       xlabel('\theta'), ylabel('\rho');
       axis on, axis normal;
       colormap(gca,hot);
       
         P  = houghpeaks(H,2);
    lines = houghlines(edgeImg,T,R,P,'FillGap',20,'MinLength',3);
     pcolor(T,R,H);
    shading flat;
    title('Hough Transform');
    xlabel('Theta (radians)');
    ylabel('Rho (pixels)');
    colormap('gray');
    hold on
plot(T(P(:,2)),R(P(:,1)),'s','color','blue');
hold off
figure, imshow(RGB), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end