% image to binary
% 05 agustos 2023 s18:58, goruntu isminden boyut okuma eklendi
% 29 temmuz 2023 s 13:25
%  gray-level image görüntüsü oluşturuldu
%  hex txt dosyasından rgb görüntü oluşturuldu
%
% sürüm : v0.01

dir='/home/ws_xilinx/imge/';
path='';

% list all txt files in 'dir' directory
txpaths= glob(strcat(dir, '*_-_.txt'));
% disp(txpaths)

% TODO: make it DRY (Do not Repeatd yourself!)

% TODO make it iterative for all images in the directory
for i=1:length(txpaths);
  % get the text files full path
  path = cell2mat(txpaths(i));
  tmp= strsplit(path,'/');
  filename=cell2mat(tmp(end));
  fprintf('Processing..\t%s\n', filename);

  % get image size from filename
  tmp = strsplit(filename,'_-_');
  h = str2num(cell2mat(tmp(2)));
  w = str2num(cell2mat(tmp(3)));
  c = str2num(cell2mat(tmp(4)));

  % TODO how to check number of column in the entire file?
  % open the text file
  fid=fopen(path,'r');
  if c == 3; % FIX : unknown #of columns
    c_im = textscan(fid,'%s%s%s\n', 'delimiter', ' ');
  else;
    c_im = textscan(fid,'%s\n', 'delimiter', ' ');
  endif
  fclose(fid);
  vh3_im = cell2mat(c_im);

  % convert hex to decimal
  v3_im = uint8(hex2dec(vh3_im));

  % reshape to original image
  im = reshape(v3_im,h,w,c); % FIX : unknown size of images

  % show images
  figure;
  image(im);


%  % get the image full path
%  path = cell2mat(txpaths(2));
%  % open the text file
%  fid=fopen(path,'r');
%  c_im = textscan(fid,'%s\n');
%  fclose(fid);
%  vh_gr = cell2mat(c_im);
%
%  % convert hex to decimal
%  v_gr = uint8(hex2dec(vh_gr));
%
%  % reshape to original image
%  im = reshape(v_gr,418,640);
%  % I = mat2gray(im,[0 255]);
%  % show images
%  figure
%  imshow(im);

end

