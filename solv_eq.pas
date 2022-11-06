UNIT solv_eq;

INTERFACE

USES SYSUTILS, Ucomplex, math;

TYPE 	TCoef = double;
		TRoot = complex;
		TMasCoef = array of TCoef;
		TMasRoot = array of TRoot;

	TLinEq = Object

	public
		constructor initEq(degreePoly:byte);
		procedure setCoef(a1, a0 : TCoef);
		procedure getCoef(var Mas: TMasCoef);
		procedure getRoot(var NRoot: integer; var MRoot: TMasRoot); virtual;
		function RootToStr(len, dec: byte): string;

	private
		a : TMasCoef;
		NumRoot : integer;
		MasRoot : TMasRoot;
		degree: byte;
		procedure solveEq; virtual;
end;

	TSqrEq = object(TLinEq)

	public
		procedure setCoef(a2, a1, a0: TCoef);
	private
		procedure solveEq; virtual;
end;

	TCubeEq = object(TSqrEq);

	public
		procedure setCoef(a3, a2, a1, a0: TCoef);
	private
		procedure solveEq; virtual;
end;

IMPLEMENTATION

constructor TLinEq.initEq(degreePoly : byte);
begin
	SetLength(a, degreePoly);
	degree := degreePoly;
end;

procedure TLinEq.setCoef(a1, a0 : TCoef);
begin
	a[0] := a0;
	a[1] := a1;
end;

procedure TLinEq.getCoef(var Mas:TMasCoef);
begin
	Mas := a;
end;

procedure TLinEq.solveEq;
begin
	if a[1]<>0 then begin
		SetLength(MasRoot, 1);
		MasRoot[0] := -a[0]/a[1];
		NumRoot := 1;
	end
	else
	if a[0] = 0 then NumRoot:=-1
	else NumRoot:=0;
end;

procedure TLinEq.getRoot(var NRoot: integer; var MRoot: TMasRoot);
begin
	solveEq;
	NRoot := NumRoot;
	MRoot := MasRoot;
end;

function TLinEq.RootToStr(len, dec: byte): string;
var st: string;
i: integer;
begin
	st := '';
	if NumRoot > 0 then
	for i := Low(MasRoot) to High(MasRoot) do
		st := st + CStr(MasRoot[i], len, dec) + ' '
	else if NumRoot = 0 then st:='no roots'
	else st := 'all reals';
	RootToStr := st
end;

procedure TSqrEq.setCoef(a2, a1, a0 : TCoef);
begin
	TLinEq.setCoef(a1, a0);
	a[2]:=a2;
end;

procedure TSqrEq.solveEq;
var D : double;
	begin
		if a[2] <> 0 then begin
			D := sqr(a[1])-4*a[2]*a[0];
			SetLength(MasRoot,2);
			MasRoot[0]:=(-a[1]+Csqrt(D))/(2*a[2]);
			MasRoot[1]:=(-a[1]-Csqrt(D))/(2*a[2]);
			NumRoot:=2;
		end
	else TLinEq.solveEq;
	end;

procedure TCubeEq.setCoef(a3,a2,a1, a0 : TCoef);
begin
	TSqrEq.setCoef(a2, a1, a0);
	a[3] := a3;
end;

procedure TCubeEq.solveEq;
var aa, bb, cc, Q, R, S: TCoef;
	fi, x1: double;
begin
	if a[3] <> 0 then begin
		aa := a[2]/a[3];
		bb := a[1]/a[3];
		cc := a[0]/a[3];
		Q := (aa*aa - 3*bb) /9;
		R := (2*aa*aa*aa - 9*aa*bb + 27*cc)/54;
		S := Q*Q*Q - R*R;
		if S > 0 then begin
			fi := arccos(R/sqrt(Q*Q*Q))/3;
			MasRoot[0] := -2*sqrt(Q)*cos(fi) - aa/3;
			MasRoot[1] := -2*sqrt(Q)*cos(fi + 2*pi/3) - aa/3;
			MasRoot[1] := -2*sqrt(Q)*cos(fi - 2*pi/3) - aa/3;
		end;
		if S < 0 then begin
			if Q > 0 then begin
				fi := arcosh((abs(R)/sqrt(Q*Q*Q))/3;
				MasRoot[0] := -2*sgn(R)*sqrt(Q)*cosH(fi) - aa/3;
				MasRoot[1] := sgn(R)*sqrt(Q)*cosH(fi) - aa/3 + i*sqrt(3)*sqrt(Q)*sinh(fi);
				MasRoot[2] := sgn(R)*sqrt(Q)*cosH(fi) - aa/3 - i*sqrt(3)*sqrt(Q)*sinh(fi);
			end;
			if Q < 0 then begin
	     		fi := arsinh(abs(R)/sqrt(abs(Q*Q*Q)))/3;
         		MasRoot[0] := -2*sgn(R)*sqrt(abs(Q))*sinh(fi) - aa/3;
	     		MasRoot[1] := sgn(R)*sqrt(abs(Q))*sinh(fi) - aa/3 + i*sqrt(abs(3*Q_)*cosh(fi);
				MasRoot[2] := sgn(R)*sqrt(abs(Q))*sinh(fi) - aa/3 - i*sqrt(abs(3*Q))*cosh(fi);
	     	end;
	   		if Q = 0 then begin
		 		x1 := power(cc - aa*aa*aa/27, 1./3) - aa/3;
		 		MasRoot[0] := x1;
		 		MasRoot[1] := -(aa + x1)/2 + i/2*sqrt(abs((aa - 3*x1)*(aa + x1) - 4*bb));
		 		MasRoot[2] := -(aa + x1)/2 - i/2*sqrt(abs((aa - 3*x1)*(aa + x1) - 4*bb));
		 	end;
		end;
		if S = 0 then begin
			MasRoot[0] := -2*sgn(R)*sqrt(Q) - aa/3;
			MasRoot[1] := sgn(R)*sqrt(Q) - a/3;
			MasRoot[2] := MasRoot[1];
		end;
	end;
end;

END.