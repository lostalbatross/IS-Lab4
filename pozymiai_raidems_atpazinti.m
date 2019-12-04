function pozymiai = pozymiai_raidems_atpazinti(pavadinimas, pvz_eiluciu_sk)
%pozymiai = pozymiai_raidems_atpazinti(pavadinimas, pvz_eiluciu_sk)
%taikymo pavyzdys:
pozymiai = pozymiai_raidems_atpazinti('test_data.png', 9) 

% Scanning a sample image
V = imread(pavadinimas);
figure(12), imshow(V)
% Cut and paste letters into the cells of the variable 'objects'
V_pustonis = rgb2gray(V);
% threshold conversion value search for image conversion
slenkstis = graythresh(V_pustonis);
% converting halftone image to binary
V_dvejetainis = im2bw(V_pustonis,slenkstis);
% rendering the result
figure(1), imshow(V_dvejetainis)
% image is the object contrast search
V_konturais = edge(uint8(V_dvejetainis));
% rendering the result
figure(2),imshow(V_konturais)
% object control 
se = strel('square',7); % structural element for filling
V_uzpildyti = imdilate(V_konturais, se); 
% rendering the result
figure(3),imshow(V_uzpildyti)
% tutum objeсt inside filling
V_vientisi= imfill(V_uzpildyti,'holes');
% rendering the result
figure(4),imshow(V_vientisi)
% integer object binary image numbering
[O_suzymeti, Skaicius] = bwlabel(V_vientisi);
% calculating objects features in the binary image
O_pozymiai = regionprops(O_suzymeti);
% readable for poymi - object rib coordinate purposes
O_ribos = [O_pozymiai.BoundingBox];
% since the bound is defined by 4 coordinates, we regroup the values
O_ribos = reshape(O_ribos,[4 Skaicius]); % Number is the number of objects
% readable poymi - object mass center coordinates
O_centras = [O_pozymiai.Centroid];
% since the center defines 2 coordinates, we regroup the needs
O_centras = reshape(O_centras,[2 Skaicius]);
O_centras = O_centras';
% each object in the image is added to the image (third column, aliases)
O_centras(:,3) = 1:Skaicius;
% sorted objects by x coordinate - column
O_centras = sortrows(O_centras,2);
% sorted by string and alphanumeric examples
raidziu_sk = Skaicius/pvz_eiluciu_sk;
for k = 1:pvz_eiluciu_sk
    O_centras((k-1)*raidziu_sk+1:k*raidziu_sk,:) = ...
        sortrows(O_centras((k-1)*raidziu_sk+1:k*raidziu_sk,:),3);
end
% snippets of image that are binned within the boundaries of the object
for k = 1:Skaicius
    objektai{k} = imcrop(V_dvejetainis,O_ribos(:,O_centras(k,3)));
end
% rendering one fragment of an image
figure(5),
for k = 1:Skaicius
   subplot(pvz_eiluciu_sk,raidziu_sk,k), imshow(objektai{k})
end
% snippets of the image are cropped, eliminating background shake (by rectangle)

for k = 1:Skaicius % Number = 108 for 108 letters
    V_fragmentas = objektai{k};
    % the size of each image fragment is determined
    [aukstis, plotis] = size(V_fragmentas);
    
    % 1. Deletion of Balt columns
    % let's calculate the sum of each column
    stulpeliu_sumos = sum(V_fragmentas,1);
    % we delete those columns where the sum equals the height
    V_fragmentas(:,stulpeliu_sumos == aukstis) = [];
    % recalculating the size of the object
    [aukstis, plotis] = size(V_fragmentas);
    % 2. Deleting Balt Rows
    % let's calculate the sum of each salivary
    eiluciu_sumos = sum(V_fragmentas,2);
    % we delete the rows where the sum equals the width
    V_fragmentas(eiluciu_sumos == plotis,:) = [];
    objektai{k}=V_fragmentas;% we put it in place of the uncut
end
% rendering one fragment of an image
figure(6),
for k = 1:Skaicius
   subplot(pvz_eiluciu_sk,raidziu_sk,k), imshow(objektai{k})
end

% We unify image size up to 70x50
for k=1:Skaicius
    V_fragmentas=objektai{k};
    V_fragmentas_7050=imresize(V_fragmentas,[70,50]);
    % let's divide the image fragment into 10x10 size
    for m=1:7
        for n=1:5
            % let's calculate the average guest for each part 
            Vid_sviesumas_eilutese=sum(V_fragmentas_7050((m*10-9:m*10),(n*10-9:n*10)));
            Vid_sviesumas((m-1)*5+n)=sum(Vid_sviesumas_eilutese);
        end
    end
    % In the 10x10 size section, the maximum visibility can be used for is 100
    % normalize the brightness value in the range [0, 1]
    Vid_sviesumas = ((100-Vid_sviesumas)/100);
    % it is more convenient for the neural network to display the result (pomius) in a column
    Vid_sviesumas = Vid_sviesumas(:);
    % we save the calculated attributes in common variable j
    pozymiai{k} = Vid_sviesumas;
end
