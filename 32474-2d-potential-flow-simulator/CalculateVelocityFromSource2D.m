function [u,v,un,vn]=CalculateVelocityFromSource2D(s,xc,yc,x,y)

%--------------------------------------------------------------------------
%CalculateVelocityFromSource2D
%Version 1.00
%Created by Stepen
%Created 8 January 2011
%--------------------------------------------------------------------------
%CalculateVelocityFromSource2D calculates the flow velocity influenced by
%several given source flow at several given locations in 2D domain.
%CalculateVelocityFromSource2D assumes that the sources that influence the
%flow are point sources.
%--------------------------------------------------------------------------
%Syntax:
%[u,v,un,vn]=CalculateVelocityFromSource2D(s,xc,yc,x,y)
%Input argument:
%- s (m x 1 num) specifies the strength of all point sources.
%- xc (m x 1 num) specifies the x axis location of all point sources.
%- yc (m x 1 num) specifies the y axis location of all point sources.
%- x (p x q num) specifies the x axis location of the corresponding
%  velocity vector.
%- y (p x q num) specifies the y axis location of the corresponding
%  velocity vector.
%Output argument:
%- u (m x n) specifies the horizontal velocity component at the
%  corresponding location.
%- u (m x n) specifies the vertical velocity component at the corresponding
%  location.
%- un (m x n num) specifies the normalized horizontal velocity component of
%  the corresponding location. un output was generated for plotting
%  purpose. Use this output instead of u for velocity quiver plotting.
%- vn (m x n num) specifies the normalized vertical velocity component of
%  the corresponding location. vn output was generated for plotting
%  purpose. Use this output instead of v for velocity quiver plotting.
%--------------------------------------------------------------------------

%CodeStart-----------------------------------------------------------------
%Checking input point sources
    s_size=size(s);
    xc_size=size(xc);
    yc_size=size(yc);
    if (s_size(2)~=1)||(xc_size(2)~=1)||(yc_size(2)~=1)
        error('Input point sources must be a i x 1 array!')
    end
    if (numel(s)~=numel(xc))||(numel(s)~=numel(yc))
        error('Input s, xc, and yc do not have the same size!')
    end
    sourcecount=numel(s);
%Checking input location
    x_size=size(x);
    y_size=size(y);
    if (x_size(1)~=y_size(1))||(x_size(2)~=y_size(2))
        error('Input x and y do not have the same size!')
    end
    rowcount=x_size(1);
    colcount=x_size(2);
%Preallocating array for speed
    u=zeros(rowcount,colcount);
    v=zeros(rowcount,colcount);
    un=zeros(rowcount,colcount);
    vn=zeros(rowcount,colcount);
%Calculating influenced velocity
    for i=1:1:rowcount
        for j=1:1:colcount
            for k=1:1:sourcecount
                if (x(i,j)==xc(k))&&(y(i,j)==yc(k))
                    u(i,j)=u(i,j);
                    v(i,j)=v(i,j);
                else
                    r=norm([(x(i,j)-xc(k)),(y(i,j)-yc(k))]);
                    vr=s(k)/(2*pi()*r);
                    u(i,j)=u(i,j)+(vr*((x(i,j)-xc(k))/r));
                    v(i,j)=v(i,j)+(vr*((y(i,j)-yc(k))/r));
                end
            end
        end
    end
%Calculating normalized vector
    for i=1:1:rowcount
        for j=1:1:colcount
            V=norm([u(i,j),v(i,j)]);
            un(i,j)=u(i,j)/V;
            vn(i,j)=v(i,j)/V;
        end
    end
%CodeEnd-------------------------------------------------------------------

end