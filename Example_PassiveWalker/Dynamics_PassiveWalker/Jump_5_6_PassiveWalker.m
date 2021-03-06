function [act,flow,count,q,p,s]=Jump_5_6_PassiveWalker(act,flow,count,t,q,p,u,s,l)
    if(act)%If jump occured in previous jump function, return.
        return;
    end
    
    if((flow==5)&&CONDITION_(act,flow,count,t,q,p,u,s,l))%Condition to determine jump occurence.
        act=1;%Flag of jumpping
        flow=6;%The flow after jumping
        count=count+1;%Counter for Jumping occurence at the same moment
    else
        act=0;
        count=0;
        return;
    end
    
    [t,q,p,u,s,l]=RESET_(act,flow,count,t,q,p,u,s,l);
    function [t,q,p,u,s,l]=RESET_(act,flow,count,t,q,p,u,s,l)
        %The Default Impact Mapper, requires Constraint Jacobian <JCons> and Inertia Matrix <MMat>
        qSize=numel(q);
        qdot=q(qSize/2+1:qSize);
        M=MMat(t,q,p,u,s,l);%Note the input of MMat does not include act, flow, and count!
        J=JCons(act,flow,count,t,q,p,u,s,l);
        q(qSize/2+1:qSize)=qdot-(M\(J.'*((J*(M\J.'))\J)))*qdot;
        %Write Your Reset Map Below!
    end
%  
%     function output=CONDITION_(act,flow,count,t,q,p,u,s,l)
%           %Write Your Jumping Condition Map Here!
%     end

	function realExpr = CONDITION_(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%CONDITION_
	%    REALEXPR = CONDITION_(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:14
	ba = in7(4,:);
	la = in6(2,:);
	qo1__dt_0 = in5(5,:);
	realExpr = (qo1__dt_0+ba <= la);
	end

	function realExpr = JCons(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%JCONS
	%    REALEXPR = JCONS(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:14
	qo1__dt_0 = in5(5,:);
	qo2__dt_0 = in5(6,:);
	realExpr = reshape([0.0,1.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,-1.0,0.0,0.0,0.0,cos(qo1__dt_0).*(1.0./2.0),sin(qo1__dt_0).*(1.0./2.0),0.0,cos(qo2__dt_0).*(1.0./2.0),sin(qo2__dt_0).*(1.0./2.0)],[3,6]);
	end

end

