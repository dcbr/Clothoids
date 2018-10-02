%=========================================================================%
%                                                                         %
%  Autors: Enrico Bertolazzi                                              %
%          Department of Industrial Engineering                           %
%          University of Trento                                           %
%          enrico.bertolazzi@unitn.it                                     %
%          m.fregox@gmail.com                                             %
%                                                                         %
%=========================================================================%
% Driver test program to check Clothoids lib                              %
%=========================================================================%

addpath('../matlab');
addpath('/Users/enrico/Ricerca/develop/myGitProjetcs/QIBSH/lib_matlab');

clear all ;
close all ;

x0     = 0 ;
y0     = 0 ;
theta0 = pi+pi/4 ;
kappa0 = -0.00013852;
kappa1 = -0.00111413;
L0     = 268.41596493;

S = ClothoidList() ;

addseg = @(l,c0,c1) S.push_back(c0,(c1-c0)/l,l) ;

S.push_back( x0, y0, theta0, kappa0, (kappa1-kappa0)/L0, L0 ) ;
%addseg( 268.41596493,  -0.00013852,   -0.00111413 ); 

addseg(  31.16644924,  -0.14835903,   -0.00905621 ); 
addseg( 354.65575897,   0.00083487,   -0.00313990 ); 
addseg( 207.95039965,   0.00044729,   -0.00004305 ); 
addseg(  83.11870679,  -0.00499887,    0.01208489 ); 
addseg(  95.55365343,   0.00134067,   -0.01052564 ); 
addseg( 116.78112466,  -0.00962787,    0.00411102 ); 
addseg( 100.90536102,   0.01105484,   -0.00565341 ); 
addseg( 244.17564307,   0.00150893,   -0.00253593 ); 
addseg(  88.89102995,  -0.00485968,    0.00254170 ); 
addseg( 680.11925941,  -0.00006341,    0.00002659 ); 
addseg(  78.57394239,  -0.01649083,   -0.02122158 ); 
addseg(  79.07273174,   0.02522984,    0.01144217 ); 
addseg(  95.92187019,   0.00851979,   -0.01744093 ); 
addseg( 188.04481029,  -0.01269045,    0.00424639 ); 
addseg( 167.95026167,   0.00168104,   -0.00379117 ); 
addseg(  93.13450504,  -0.02225371,   -0.01948272 ); 
addseg(  62.91880703,  -0.02403964,   -0.01088918 ); 
addseg( 130.10616794,  -0.00006949,    0.00346007 ); 
addseg(  52.06009800,   0.02621089,    0.01920416 ); 
addseg( 220.74231575,  -0.00010272,   -0.00144167 ); 
addseg( 235.19138393,  -0.00026125,    0.00070307 ); 
addseg( 136.14786035,   0.01475287,    0.00385269 ); 
addseg( 191.52279546,   0.00310431,    0.00902704 ); 
addseg( 272.17221893,   0.00146630,   -0.00088744 ); 
addseg( 126.16789847,   0.00334631,   -0.01677585 ); 
addseg(  80.83492003,  -0.01457234,   -0.00889941 ); 
addseg( 103.44483379,   0.01084106,    0.01592214 ); 
addseg( 207.70524107,   0.00494010,   -0.00350124 ); 
addseg(  84.38887630,  -0.01196972,   -0.02586791 ); 
addseg( 148.20073114,   0.00555922,   -0.01020357 ); 
addseg(  85.12269980,  -0.00816289,   -0.01218014 ); 
addseg( 118.11789492,   0.00080205,   -0.00442719 ); 
addseg( 184.93552473,  -0.00260881,   -0.00038858 ); 
addseg( 267.23389782,  -0.00338904,    0.00178021 ); 
addseg( 214.66190111,   0.00241122,    0.00411986 ); 
addseg( 180.50060988,  -0.00421951,    0.00774823 ); 
addseg(  73.10986179,   0.01129778,   -0.00106990 ); 
addseg( 184.20716325,   0.00053508,   -0.00069143 ); 
addseg( 144.45884371,  -0.00353334,   -0.00007505 ); 
addseg( 136.23643684,  -0.00067520,    0.00097963 ); 
addseg(  28.80513435,  -0.08890172,   -0.05712332 ); 
addseg(  45.61022550,   0.00885904,    0.06595860 ); 
addseg(  44.86161912,   0.05021172,   -0.01200622 ); 
%addseg( 257.77168829,  -0.00088992,    0.00086831 );
S.push_back_G1( x0, y0, theta0) ; % close curve
%%


%DX = X(2:end)-X(1:end-1);
%DY = Y(2:end)-Y(1:end-1);
%T  = [0,cumsum(hypot(DX,DY))];
[ T, ~, ~ ] = S.getSTK();
[X,Y] = S.getXY();

SG2 = ClothoidSplineG2() ;
SL = SG2.buildP2( X, Y ) ;
[ T, ~, ~ ] = SL.getSTK();

subplot(2,1,1);

[dx,dy] = SL.eval_D(0);

%pp = pchip( T, [X;Y] );
pp = spline( T, [ dx, X, dx ; dy, Y, dy ] );
TT = T(1):(T(end)-T(1))/10000:T(end);
%XY = interp1( T, [X;Y].', TT, 'pchip' );


XY = ppval(pp,TT);
D  = ppval(fnder(pp,1),TT).';
DD = ppval(fnder(pp,2),TT).';
%plot(XY(:,1),XY(:,2),'Linewidth',5);
plot(XY(1,:),XY(2,:),'Linewidth',5);
hold on
%SL.plot() ;

Q = QIBSH1D('Q') ;
Q.setup(5,T,true);
Q.build_spline( [X;Y], 3 ) ;
%Q.build_spline( [X,Y].', [dX,dY].' ) ;
%Q.qpoly

RES = Q.eval( TT, 2 ) ;

PS  = RES(:,:,1);
D1  = RES(:,:,2).';
DD1 = RES(:,:,3).'; 

plot( PS(1,:), PS(2,:), '-k', 'LineWidth', 5 ) ;

axis equal

subplot(2,1,2);
%
%SL.plotCurvature(1000);
hold on
% 
KUR = (D(:,1).*DD(:,2)-D(:,2).*DD(:,1))./hypot(D(:,1),D(:,2));
plot( TT, KUR, 'Linewidth', 2 );
hold on

KUR1 = (D1(:,1).*DD1(:,2)-D1(:,2).*DD1(:,1))./hypot(D1(:,1),D1(:,2));
plot( TT, KUR1, 'Linewidth', 2 );
hold on