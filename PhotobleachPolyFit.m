function  [newgreen,newred,gTrace,rTrace] = PhotobleachPolyFit(green_tiff,red_tiff,go1,ro1)
% [f1 fftdata1]=fftshow(ro1,10000);
% y = detrendnonlin(ro1,2);

for ch=1:2% number of channels
    if ch==1
        Data=green_tiff;
    else
        Data=red_tiff;
    end
    
    NewData=Data;
    for i=1:size(Data,1)
        for j=1:size(Data,2)
            x=double(squeeze(Data(i,j,:)));
            order=2;
            p = polyfit((1:numel(x))', x(:), order);%new 
            y = double(x(:)) - polyval(p, (1:numel(x))');
%             figure; plot(x);hold on;
%             plot(y);

            NewData(i,j,:)=y;
        end
    end
    size(NewData)
    
    
    if ch==1
        newgreen=double(NewData);
    else
        newred=double(NewData);
    end
end

h=figure; set(h,'position',[138 522 1460 276])
go=squeeze(mean(mean(newgreen(:,:,:))));gTrace=go-mean(go);
subplot(221);plot(gTrace);axis([-inf inf -inf inf]); title('green');
ro=squeeze(mean(mean(newred(:,:,:))));rTrace=ro-mean(ro);
subplot(223); plot(rTrace);axis([-inf inf -inf inf]); title('red')
subplot(222);imagesc(mean(double(newgreen),3));title('green');colorbar
subplot(224);imagesc(mean(double(newred),3));title('red');colormap(jet);colorbar
% tightfig

subplot(221);hold on ;plot(go1);legend('corrected','raw');
subplot(223);hold on; plot(ro1);legend('corrected','raw');


end