 function TrainingRecg()
 I = ['a.bmp','d.bmp','f.bmp','h.bmp','k.bmp','m.bmp','n.bmp','o.bmp','p.bmp','q.bmp','r.bmp','s.bmp','u.bmp','w.bmp','x.bmp','z.bmp'];
 II = ['a','d','f','h','k','m','n','o','p','q','r','s','u','w','x','z'];
 [NormFeaMatAll,LableNorFeaMatAll,AvgMean,AvgStan] = OCR_Extract_Features();   
 p = 1;
 th = 210;
 for i = 1:5:(length(I)-4)
     im = imread(I(i:i+4)); 
     %im = im2double(imread(I(i:i+4)));
     im2 = uint8(im < th);
     x = bwlabel(im2);
     Nc=max(max(x));
     figure;
     imagesc(x);
     hold on;
     Features = [];
     locations = [];
     for j=1:Nc; 
         [r,c]=find(x==j);
         maxr=max(r);
         minr=min(r);
         maxc=max(c);
         minc=min(c);
         a = maxr - minr;
         b = maxc - minc;
         if (a*b > 100 && a >10 && b >10 && a < 150 && b < 150)
             rectangle('Position',[minc,minr,maxc-minc+1,maxr-minr+1], 'EdgeColor','w');
             text(maxc-2,minr,II(1,p),'color', 'yellow');
             locations = [locations;maxc,maxr];
             cim = im2(minr:maxr,minc:maxc);
             [centroid, theta, roundness, inmo] = moments(cim, 1);
             Features=[Features; theta, roundness, inmo];
         end
     end
        %Normalization
        NormFeatures = [];
        [m,n] = size(Features);
        for j=1:m;
            for k=1:n;
                NormFeatures(j,k) = (Features(j,k) - AvgMean(1,k)) / AvgStan(1,k);
            end
        end
      FeatureMatrix = [];
      FeatureMatrix = NormFeatures;%FeatureMatrix is the normalized matrix
      D = dist2(FeatureMatrix, NormFeaMatAll);   
      [D_distance, D_index] = sort(D, 2);
      NeigIndex = D_index(:,2);
      count = 0;
      for o = 1:size(NeigIndex,1);
          Num = LableNorFeaMatAll(NeigIndex(o,1),7);
          text(locations(o,1),locations(o,2),II(1,Num),'color','yellow');
          if Num == p
              count = count + 1;
          end
      end
      ratings = count / size(NeigIndex,1)
      p = p + 1;
      hold off;
  end 
 
