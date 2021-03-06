function [act,flow,count,q,p,s]=Jump_6_1_PassiveWalker(act,flow,count,t,q,p,u,s,l)
    if(act)%If jump occured in previous jump function, return.
        return;
    end
    
    if((flow==6)&&CONDITION_(act,flow,count,t,q,p,u,s,l))%Condition to determine jump occurence.
        act=1;%Flag of jumpping
        flow=1;%The flow after jumping
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
        q(2)=YReal(act,flow,count,t,q,p,u,s,l);
        p(1)=FPos(act,flow,count,t,q,p,u,s,l);
    end
%  
%     function output=CONDITION_(act,flow,count,t,q,p,u,s,l)
%           %Write Your Jumping Condition Map Here!
%     end

	function realExpr = CONDITION_(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%CONDITION_
	%    REALEXPR = CONDITION_(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:30
	qi1__dt_0 = in5(3,:);
	qi2__dt_0 = in5(4,:);
	qy__dt_0 = in5(2,:);
	realExpr = (qy__dt_0.*2.0 <= cos(qi1__dt_0)+cos(qi2__dt_0));
	end

	function realExpr = FPos(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%FPOS
	%    REALEXPR = FPOS(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:30
	qi1__dt_0 = in5(3,:);
	qi2__dt_0 = in5(4,:);
	qx__dt_0 = in5(1,:);
	realExpr = qx__dt_0+sin(qi1__dt_0).*(1.0./2.0)+sin(qi2__dt_0).*(1.0./2.0);
	end

	function realExpr = YReal(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%YREAL
	%    REALEXPR = YREAL(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:30
	qi1__dt_0 = in5(3,:);
	qi2__dt_0 = in5(4,:);
	realExpr = cos(qi1__dt_0).*(1.0./2.0)+cos(qi2__dt_0).*(1.0./2.0);
	end

	function realExpr = JCons(ACT,FLOW,COUNT,t,in5,in6,in7,NHSIGNAL,in9)
	%JCONS
	%    REALEXPR = JCONS(ACT,FLOW,COUNT,T,IN5,IN6,IN7,NHSIGNAL,IN9)
	%    This function was generated by the Symbolic Math Toolbox version 8.0.
	%    31-Mar-2018 04:48:30
	qi1__dt_0 = in5(3,:);
	qi2__dt_0 = in5(4,:);
	realExpr = reshape([0.0,1.0,0.0,0.0,0.0,1.0,1.0,cos(qi1__dt_0).*(1.0./2.0),sin(qi1__dt_0).*(1.0./2.0),-1.0,cos(qi2__dt_0).*(1.0./2.0),sin(qi2__dt_0).*(1.0./2.0),0.0,0.0,0.0,0.0,0.0,0.0],[3,6]);
	end

end

