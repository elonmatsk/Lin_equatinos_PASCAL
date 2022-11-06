program es;
uses equOBJ;
begin
 LinEq.InitEq;
 LinEq.SetCoef(1,1);
 LinEq.GetRoots(MasRoot,NumRoot);
 writeln(LinEq.RootToStr(6,2));

 LinEq.InitEq;
 LinEq.SetCoef(0,1);
 LinEq.GetRoots(MasRoot,NumRoot);
 writeln(LinEq.RootToStr(6,2));

 LinEq.InitEq;
 LinEq.SetCoef(0,0);
 LinEq.GetRoots(MasRoot,NumRoot);
 writeln(LinEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(1,-5,6);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(1,-2,1);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(7,1,1);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(0,1,1);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(0,0,1);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 SqEq.InitEq;
 SqEq.SetCoef(0,0,0);
 SqEq.GetRoots(MasRoot,NumRoot);
 writeln(SqEq.RootToStr(6,2));

 readln
end.
