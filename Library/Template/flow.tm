function [dq,ds,l]=FUNCNAME_(flow,t,q,p,u,s,l)
    [TF,Vel,Cor,Jac,TransDis,MM,GFI,GFF,GFU,JacU,JacCons,CorCons,GFCons]=SYSTEM_(t,q,p,u,s);
    
    MM=sum(MM,3);
    GFI=sum(GFI,2);
    GFF=sum(GFF,2);
    GFU=sum(GFU,2);

    ConsContent=0;

%SWITCHCASE_
    
    l=l*0;
    GF=GFI+GFF+GFU;
    if(ConsContent(1)~=0)
        partialJacCons=JacCons(ConsContent,:);
        partialCorCons=CorCons(ConsContent,1);
        partialGFCons=GFCons(ConsContent,1);
    
        l(ConsContent)=-(partialJacCons*(MM\partialJacCons.'))\(partialJacCons*(MM\GF)+partialCorCons);
        GFL=JacCons.'*l;
        GFC=-partialJacCons.'*partialGFCons;
        GF=GF+GFL+GFC;
    end
    
    dq=[q(end/2+1:end);MM\GF];
    ds=NHSIGNAL_(t,q,p,u,s);
    