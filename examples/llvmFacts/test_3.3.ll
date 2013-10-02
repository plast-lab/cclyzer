; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"ert\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@main.buf = private unnamed_addr constant [3 x i32] [i32 1, i32 2, i32 3], align 4
@main.s = private unnamed_addr constant [2 x [2 x [3 x i8]]] [[2 x [3 x i8]] [[3 x i8] c"ab\00", [3 x i8] c"cd\00"], [2 x [3 x i8]] [[3 x i8] c"ef\00", [3 x i8] c"gh\00"]], align 1

; Function Attrs: nounwind
define i32 @foo(i32* %arg, i32 %p, i8* %str) #0 {
entry:
  %arg.addr = alloca i32*, align 4
  %p.addr = alloca i32, align 4
  %str.addr = alloca i8*, align 4
  store i32* %arg, i32** %arg.addr, align 4
  store i32 %p, i32* %p.addr, align 4
  store i8* %str, i8** %str.addr, align 4
  %0 = load i32* %p.addr, align 4
  %1 = load i32** %arg.addr, align 4
  %2 = load i32* %1, align 4
  %add = add nsw i32 %2, %0
  store i32 %add, i32* %1, align 4
  %3 = load i32* %p.addr, align 4
  %sub = sub nsw i32 0, %3
  ret i32 %sub
}

; Function Attrs: nounwind
define i32 @func(i32 %x, i32 %y, i32 %z) #0 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %z.addr = alloca i32, align 4
  %w = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 %y, i32* %y.addr, align 4
  store i32 %z, i32* %z.addr, align 4
  %0 = load i32* %x.addr, align 4
  %1 = load i32* %y.addr, align 4
  %mul = mul nsw i32 %0, %1
  %2 = load i32* %z.addr, align 4
  %add = add nsw i32 %mul, %2
  %sub = sub nsw i32 %add, 4
  store i32 %sub, i32* %w, align 4
  %3 = load i32* %w, align 4
  ret i32 %3
}

; Function Attrs: nounwind
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca double, align 8
  %ptr = alloca i32*, align 4
  %x = alloca i32, align 4
  %buf = alloca [3 x i32], align 4
  %s = alloca [2 x [2 x [3 x i8]]], align 1
  store i32 0, i32* %retval
  store i32 10, i32* %i, align 4
  %0 = load i32* %i, align 4
  %add = add nsw i32 %0, 6
  store i32 %add, i32* %c, align 4
  %1 = load i32* %c, align 4
  %mul = mul nsw i32 %1, 2
  store i32 %mul, i32* %c, align 4
  store double 3.434500e-03, double* %d, align 8
  store i32* %c, i32** %ptr, align 4
  %2 = load i32* %i, align 4
  %call = call i32 @foo(i32* %c, i32 %2, i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  store i32 %call, i32* %x, align 4
  %3 = load i32* %x, align 4
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %3)
  %4 = bitcast [3 x i32]* %buf to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %4, i8* bitcast ([3 x i32]* @main.buf to i8*), i32 12, i32 4, i1 false)
  %arrayidx = getelementptr inbounds [3 x i32]* %buf, i32 0, i32 0
  %5 = load i32* %arrayidx, align 4
  %cmp = icmp slt i32 %5, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %arrayidx2 = getelementptr inbounds [3 x i32]* %buf, i32 0, i32 0
  store i32 0, i32* %arrayidx2, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %6 = bitcast [2 x [2 x [3 x i8]]]* %s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %6, i8* getelementptr inbounds ([2 x [2 x [3 x i8]]]* @main.s, i32 0, i32 0, i32 0, i32 0), i32 12, i32 1, i1 false)
  %arrayidx3 = getelementptr inbounds [2 x [2 x [3 x i8]]]* %s, i32 0, i32 1
  %arrayidx4 = getelementptr inbounds [2 x [3 x i8]]* %arrayidx3, i32 0, i32 1
  %arrayidx5 = getelementptr inbounds [3 x i8]* %arrayidx4, i32 0, i32 0
  store i8 114, i8* %arrayidx5, align 1
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i32, i1) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
