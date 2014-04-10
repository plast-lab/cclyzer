; ModuleID = 'fgrep.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.matcher = type { i8*, void (i8*, i64)*, i64 (i8*, i64, i64*, i8*)* }

@.str = private unnamed_addr constant [6 x i8] c"fgrep\00", align 1
@matchers = constant [2 x %struct.matcher] [%struct.matcher { i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), void (i8*, i64)* @Fcompile, i64 (i8*, i64, i64*, i8*)* @Fexecute }, %struct.matcher zeroinitializer], align 16
@before_options = constant [54 x i8] c"PATTERN is a set of newline-separated fixed strings.\0A\00", align 16
@after_options = constant [61 x i8] c"Invocation as `fgrep' is deprecated; use `grep -F' instead.\0A\00", align 16

declare void @Fcompile(i8*, i64) #0

declare i64 @Fexecute(i8*, i64, i64*, i8*) #0

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!39, !40}
!llvm.ident = !{!41}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !2, metadata !3, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/fgrep.c] [DW_LANG_C99]
!1 = metadata !{metadata !"fgrep.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !31, metadata !35}
!4 = metadata !{i32 786484, i32 0, null, metadata !"matchers", metadata !"matchers", metadata !"", metadata !5, i32 4, metadata !6, i32 0, i32 1, [2 x %struct.matcher]* @matchers, null} ; [ DW_TAG_variable ] [matchers] [line 4] [def]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/fgrep.c]
!6 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 384, i64 64, i32 0, i32 0, metadata !7, metadata !29, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 384, align 64, offset 0] [from ]
!7 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !8} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from matcher]
!8 = metadata !{i32 786451, metadata !9, null, metadata !"matcher", i32 30, i64 192, i64 64, i32 0, i32 0, null, metadata !10, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [matcher] [line 30, size 192, align 64, offset 0] [def] [from ]
!9 = metadata !{metadata !"./grep.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!10 = metadata !{metadata !11, metadata !15, metadata !23}
!11 = metadata !{i32 786445, metadata !9, metadata !8, metadata !"name", i32 32, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_member ] [name] [line 32, size 64, align 64, offset 0] [from ]
!12 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!14 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!15 = metadata !{i32 786445, metadata !9, metadata !8, metadata !"compile", i32 33, i64 64, i64 64, i64 64, i32 0, metadata !16} ; [ DW_TAG_member ] [compile] [line 33, size 64, align 64, offset 64] [from compile_fp_t]
!16 = metadata !{i32 786454, metadata !9, null, metadata !"compile_fp_t", i32 25, i64 0, i64 0, i64 0, i32 0, metadata !17} ; [ DW_TAG_typedef ] [compile_fp_t] [line 25, size 0, align 0, offset 0] [from ]
!17 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !18} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!18 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !19, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!19 = metadata !{null, metadata !12, metadata !20}
!20 = metadata !{i32 786454, metadata !21, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!21 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!22 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!23 = metadata !{i32 786445, metadata !9, metadata !8, metadata !"execute", i32 34, i64 64, i64 64, i64 128, i32 0, metadata !24} ; [ DW_TAG_member ] [execute] [line 34, size 64, align 64, offset 128] [from execute_fp_t]
!24 = metadata !{i32 786454, metadata !9, null, metadata !"execute_fp_t", i32 26, i64 0, i64 0, i64 0, i32 0, metadata !25} ; [ DW_TAG_typedef ] [execute_fp_t] [line 26, size 0, align 0, offset 0] [from ]
!25 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !26} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!26 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !27, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!27 = metadata !{metadata !20, metadata !12, metadata !20, metadata !28, metadata !12}
!28 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !20} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!29 = metadata !{metadata !30}
!30 = metadata !{i32 786465, i64 0, i64 2}        ; [ DW_TAG_subrange_type ] [0, 1]
!31 = metadata !{i32 786484, i32 0, null, metadata !"before_options", metadata !"before_options", metadata !"", metadata !5, i32 9, metadata !32, i32 0, i32 1, [54 x i8]* @before_options, null} ; [ DW_TAG_variable ] [before_options] [line 9] [def]
!32 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 432, i64 8, i32 0, i32 0, metadata !13, metadata !33, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 432, align 8, offset 0] [from ]
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786465, i64 0, i64 54}       ; [ DW_TAG_subrange_type ] [0, 53]
!35 = metadata !{i32 786484, i32 0, null, metadata !"after_options", metadata !"after_options", metadata !"", metadata !5, i32 11, metadata !36, i32 0, i32 1, [61 x i8]* @after_options, null} ; [ DW_TAG_variable ] [after_options] [line 11] [def]
!36 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 488, i64 8, i32 0, i32 0, metadata !13, metadata !37, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 488, align 8, offset 0] [from ]
!37 = metadata !{metadata !38}
!38 = metadata !{i32 786465, i64 0, i64 61}       ; [ DW_TAG_subrange_type ] [0, 60]
!39 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!40 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!41 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
