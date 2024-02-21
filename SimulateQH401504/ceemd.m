% Y: Inputted data;
% Nstd: ratio of the standard deviation of the added noise and that of Y(附加噪声的标准偏差与Y的标准偏差之比);
% NE: Ensemble member being used
% TNM: total number of modes (not including the trend)
%
function allmode=ceemd(Y,Nstd,NE,TNM)
% find data length
xsize=length(Y);
dd=1:1:xsize;
% Nornaliz data
Ystd=std(Y);
Y=Y/Ystd;
% Initialize saved data
TNM2=TNM+2;
for kk=1:1:TNM2
    for ii=1:1:xsize
        allmode(ii,kk)=0.0;
    end
end

for iii=1:1:NE
% adding noise
    for i=1:xsize
        temp=randn(1,1)*Nstd;
        X1(i)=Y(i)+temp;
        X2(i)=Y(i)-temp;
    end

    % sifting X1
    xorigin = X1;
    xend = xorigin;
% save the initial data into the first column
    for jj=1:1:xsize
        mode(jj,1) = xorigin(jj);
    end
    nmode = 1;
    while nmode <= TNM
         xstart = xend;
        iter = 1;
        while iter<=5
             [spmax, spmin, flag]=extrema(xstart);
             upper= spline(spmax(:,1),spmax(:,2),dd);
             lower= spline(spmin(:,1),spmin(:,2),dd);
             mean_ul = (upper + lower)/2;
             xstart = xstart - mean_ul;
             iter = iter +1;
        end
        xend = xend - xstart;
        nmode=nmode+1;
        % save a mode
        for jj=1:1:xsize
            mode(jj,nmode) = xstart(jj);
        end
    end
    % save the trend
    for jj=1:1:xsize
        mode(jj,nmode+1)=xend(jj);
    end
    % add mode to the sum of modes from earlier ensemble members
    allmode=allmode+mode;

   %%%=============================================================
   % sifting X2
   xorigin = X2;
   xend = xorigin;
   % save the initial data into the first column
   for jj=1:1:xsize,
        mode(jj,1) = xorigin(jj);
   end
   nmode = 1;
   while nmode <= TNM,
       xstart = xend;
       iter = 1;
       while iter<=5,
           [spmax, spmin, flag]=extrema(xstart);
           upper= spline(spmax(:,1),spmax(:,2),dd);
           lower= spline(spmin(:,1),spmin(:,2),dd);
           mean_ul = (upper + lower)/2;
           xstart = xstart - mean_ul;
           iter = iter +1;
       end
       xend = xend - xstart;
       nmode=nmode+1;
       % save a mode
       for jj=1:1:xsize,
           mode(jj,nmode) = xstart(jj);
       end
   end
    % save the trend
    for jj=1:1:xsize,
        mode(jj,nmode+1)=xend(jj);
    end
    % add mode to the sum of modes from earlier ensemble members
    allmode=allmode+mode;
    %fprintf('-');
end
% ensemble average
allmode=allmode/NE/2;
% Rescale mode to origional unit.
allmode=allmode*Ystd;