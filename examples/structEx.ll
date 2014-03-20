; ModuleID = 'structEx.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST = type { i32, double, %struct.RT }
%struct.RT = type { i8, [10 x [20 x i32]], i8 }

; Function Attrs: nounwind uwtable
define signext i8 @foo(%struct.ST* %s) #0 {
  %1 = alloca %struct.ST*, align 8
  %i = alloca i32, align 4
  store %struct.ST* %s, %struct.ST** %1, align 8
  store i32 1, i32* %i, align 4
  %2 = load i32* %i, align 4
  %3 = add nsw i32 %2, 2
  store i32 %3, i32* %i, align 4
  %4 = load %struct.ST** %1, align 8
  %5 = getelementptr inbounds %struct.ST* %4, i64 1
  %6 = getelementptr inbounds %struct.ST* %5, i32 0, i32 2
  %7 = getelementptr inbounds %struct.RT* %6, i32 0, i32 2
  %8 = load i8* %7, align 1
  ret i8 %8
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
