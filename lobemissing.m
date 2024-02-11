%Calcul du diagramme de directivité de la voie broadside d'une antenne
%synthétique.
D=0.5; %distance interping
Lr=1; %Longueur antenne Rx
lambda=5e-3;
N= 41; %nbre de pings
n=(0:N-1);
pu=10000;
u=linspace(-2,2,pu); % u=sin(theta) in units of lambda/L

weights=ones(N,1);%weights(20)=0;
Phi=exp(j*4*pi*D/Lr*u'*n);
DirAF=Phi*weights;
DirAP=sinc(u);
DirSA=DirAF.*DirAP';
maxDirAF=max(abs(DirAF));
figure(2)
plot(u',abs(DirAF)/maxDirAF,"r",u',abs(DirSA)/maxDirAF,"b",u',abs(DirAP),"g")


