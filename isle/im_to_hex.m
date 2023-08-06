% image to binary
%
% 05 agustos 2023 s 17:54, dizindeki tum imgeleri isleyen for dongusu eklendi.
% 29 temmuz 2023 s 12:47,  rgb görüntü RR_GG_BB formata çevrilerek kaydedildi.
%
% sürüm : v0.01

dir='/home/ws_xilinx/imge/';
% TODO: set output file save directory
out_path='/home/ws_xilinx/imge/'
% TODO: image file formats and selection, (now just jpg is considered)
% .jpg, .jpeg, .png, ...

% list all jpg files in 'dir' directory
impaths= glob(strcat(dir, '*.jpg'));
% disp(impaths)

% TODO: make it DRY (Do not Repeatd yourself!)

% iterative for all images in the directory
for i=1:length(impaths);
  % get the image full path
  path = cell2mat(impaths(i));
  tmp= strsplit(path,'/');
  filename=cell2mat(tmp(end));
  fprintf('Processing..\t%s\n', filename);

  % read image
  im=imread(path);

  % check number of channel and take actions
  sz = size(im);

  if length(sz) == 2;
    h = sz(1);
    w = sz(2);
    c = 1;
    d = '_-_'; % delimiter patern
    o_path = strcat(strrep(path,'.jpg',''), d,num2str(h),d,num2str(w),d,num2str(c),d);

    % vectorize the monochromatic image
    v_mn=im(:);
    % convert decimal to hexadecimal (base conversion; 10 -->> 16)
    vh_mn = dec2hex(v_mn);
    % output path for gray-level binary
    o_path_mn=strcat(o_path,'.txt');
    % open a new file to write
    file=fopen(o_path_mn,'w');
    % iterate over all pixels
    for px = 1:length(vh_mn)
      % write to file line by line
      fprintf(file, '%s\n', vh_mn(px));
    end
    fclose(file);

  elseif length(sz) == 3;
    h = sz(1);
    w = sz(2);
    c = sz(3);
    d = '_-_'; % delimiter patern
    o_path = strcat(strrep(path,'.jpg',''), d,num2str(h),d,num2str(w),d,num2str(c),d);

    % get gray-level image
    gr=rgb2gray(im);
    % vectorize the images
    % tst(:,:,1) = [1 2 3 4; 5 6 7 8];
    % tst(:,:,2) = [-10 -20 -30 -40; -50 -60 -70 -80];
    % tst(:,:,3) = [91 92 93 94; 95 96 97 98];
    % v_tst=tst(:)
    % a = reshape(tst, [], 3)

    % v_im=im(:);
    v3_im = reshape(im,[],3);
    v_gr=gr(:);

    % make the vectors HEX
    vh_imr = dec2hex(v3_im(:,1));
    vh_img = dec2hex(v3_im(:,2));
    vh_imb = dec2hex(v3_im(:,3));
    vh_gr = dec2hex(v_gr);

    % output path for gray-level binary
    o_path_gri=strcat(o_path,'gr_-_.txt');
    % output path for rgb binary
    o_path_rgb=strcat(o_path,'.txt');

    % TODO: make write to file as function
    % open a new file to write
    file=fopen(o_path_gri,'w');
    % iterate over all pixels
    for px = 1:length(vh_gr)
      % write to file line by line
      fprintf(file, '%s\n', vh_gr(px,:));
    end
    fclose(file);

    % open a new file to write
    file=fopen(o_path_rgb,'w');
    % iterate over all pixels
    for px = 1:length(v3_im)
      % write to file line by line
      fprintf(file, '%s %s %s\n', vh_imr(px,:), vh_img(px,:), vh_imb(px,:));
    end
    fclose(file);
  else
    fprintf("[INFO]\tSadece 1 veya 3 kanalli goruntuler desteklenmektedir.\n")
    continue
  endif
end

