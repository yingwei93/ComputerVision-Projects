function Mns = getxcorr2(M,N)


if ( size(M,3) == size(N,3) )
    Mns = xcorr2(M(:,:,1),N(:,:,1));
    for i = 2 : size(M,3)
        Mns = Mns + xcorr2(M(:,:,i),N(:,:,i));
    end
else
    if( size(N,3) ==1)
        Mns = xcorr2(M(:,:,1),N(:,:));
        for i = 2 : size(M,3)
            Mns = Mns + xcorr2(M(:,:,i),N(:,:));
        end
    else
        if(size(M,3)==1)
            Mns = getxcorr2(N,M);
        else
            Mns = xcorr2(M(:,:,1),N(:,:,1));
        end
    end
end