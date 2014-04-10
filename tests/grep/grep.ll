; ModuleID = 'grep.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.matcher = type { i8*, void (i8*, i64)*, i64 (i8*, i64, i64*, i8*)* }

@.str = private unnamed_addr constant [5 x i8] c"grep\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"egrep\00", align 1
@.str2 = private unnamed_addr constant [4 x i8] c"awk\00", align 1
@.str3 = private unnamed_addr constant [6 x i8] c"fgrep\00", align 1
@.str4 = private unnamed_addr constant [5 x i8] c"perl\00", align 1
@matchers = constant [6 x %struct.matcher] [%struct.matcher { i8* getelementptr inbounds ([5 x i8]* @.str, i32 0, i32 0), void (i8*, i64)* @Gcompile, i64 (i8*, i64, i64*, i8*)* @EGexecute }, %struct.matcher { i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0), void (i8*, i64)* @Ecompile, i64 (i8*, i64, i64*, i8*)* @EGexecute }, %struct.matcher { i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), void (i8*, i64)* @Acompile, i64 (i8*, i64, i64*, i8*)* @EGexecute }, %struct.matcher { i8* getelementptr inbounds ([6 x i8]* @.str3, i32 0, i32 0), void (i8*, i64)* @Fcompile, i64 (i8*, i64, i64*, i8*)* @Fexecute }, %struct.matcher { i8* getelementptr inbounds ([5 x i8]* @.str4, i32 0, i32 0), void (i8*, i64)* @Pcompile, i64 (i8*, i64, i64*, i8*)* @Pexecute }, %struct.matcher zeroinitializer], align 16
@before_options = constant [59 x i8] c"PATTERN is, by default, a basic regular expression (BRE).\0A\00", align 16
@after_options = constant [114 x i8] c"`egrep' means `grep -E'.  `fgrep' means `grep -F'.\0ADirect invocation as either `egrep' or `fgrep' is deprecated.\0A\00", align 16

; Function Attrs: nounwind uwtable
define internal void @Gcompile(i8* %pattern, i64 %size) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !23), !dbg !55
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !24), !dbg !55
  tail call void @GEAcompile(i8* %pattern, i64 %size, i64 68358) #3, !dbg !56
  ret void, !dbg !57
}

declare i64 @EGexecute(i8*, i64, i64*, i8*) #1

; Function Attrs: nounwind uwtable
define internal void @Ecompile(i8* %pattern, i64 %size) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !19), !dbg !58
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !20), !dbg !58
  tail call void @GEAcompile(i8* %pattern, i64 %size, i64 2210588) #3, !dbg !59
  ret void, !dbg !60
}

; Function Attrs: nounwind uwtable
define internal void @Acompile(i8* %pattern, i64 %size) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !15), !dbg !61
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !16), !dbg !61
  tail call void @GEAcompile(i8* %pattern, i64 %size, i64 778441) #3, !dbg !62
  ret void, !dbg !63
}

declare void @Fcompile(i8*, i64) #1

declare i64 @Fexecute(i8*, i64, i64*, i8*) #1

declare void @Pcompile(i8*, i64) #1

declare i64 @Pexecute(i8*, i64, i64*, i8*) #1

declare void @GEAcompile(i8*, i64, i64) #1

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!52, !53}
!llvm.ident = !{!54}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !25, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/grep.c] [DW_LANG_C99]
!1 = metadata !{metadata !"grep.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !17, metadata !21}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Acompile", metadata !"Acompile", metadata !"", i32 17, metadata !6, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64)* @Acompile, null, null, metadata !14, i32 18} ; [ DW_TAG_subprogram ] [line 17] [local] [def] [scope 18] [Acompile]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/grep.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !11}
!8 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!9 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!10 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!11 = metadata !{i32 786454, metadata !12, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!12 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!13 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!14 = metadata !{metadata !15, metadata !16}
!15 = metadata !{i32 786689, metadata !4, metadata !"pattern", metadata !5, i32 16777233, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 17]
!16 = metadata !{i32 786689, metadata !4, metadata !"size", metadata !5, i32 33554449, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 17]
!17 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Ecompile", metadata !"Ecompile", metadata !"", i32 11, metadata !6, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64)* @Ecompile, null, null, metadata !18, i32 12} ; [ DW_TAG_subprogram ] [line 11] [local] [def] [scope 12] [Ecompile]
!18 = metadata !{metadata !19, metadata !20}
!19 = metadata !{i32 786689, metadata !17, metadata !"pattern", metadata !5, i32 16777227, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 11]
!20 = metadata !{i32 786689, metadata !17, metadata !"size", metadata !5, i32 33554443, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 11]
!21 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"Gcompile", metadata !"Gcompile", metadata !"", i32 5, metadata !6, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64)* @Gcompile, null, null, metadata !22, i32 6} ; [ DW_TAG_subprogram ] [line 5] [local] [def] [scope 6] [Gcompile]
!22 = metadata !{metadata !23, metadata !24}
!23 = metadata !{i32 786689, metadata !21, metadata !"pattern", metadata !5, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 5]
!24 = metadata !{i32 786689, metadata !21, metadata !"size", metadata !5, i32 33554437, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 5]
!25 = metadata !{metadata !26, metadata !44, metadata !48}
!26 = metadata !{i32 786484, i32 0, null, metadata !"matchers", metadata !"matchers", metadata !"", metadata !5, i32 22, metadata !27, i32 0, i32 1, [6 x %struct.matcher]* @matchers, null} ; [ DW_TAG_variable ] [matchers] [line 22] [def]
!27 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 1152, i64 64, i32 0, i32 0, metadata !28, metadata !42, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 1152, align 64, offset 0] [from ]
!28 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !29} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from matcher]
!29 = metadata !{i32 786451, metadata !30, null, metadata !"matcher", i32 30, i64 192, i64 64, i32 0, i32 0, null, metadata !31, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [matcher] [line 30, size 192, align 64, offset 0] [def] [from ]
!30 = metadata !{metadata !"./grep.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!31 = metadata !{metadata !32, metadata !33, metadata !36}
!32 = metadata !{i32 786445, metadata !30, metadata !29, metadata !"name", i32 32, i64 64, i64 64, i64 0, i32 0, metadata !8} ; [ DW_TAG_member ] [name] [line 32, size 64, align 64, offset 0] [from ]
!33 = metadata !{i32 786445, metadata !30, metadata !29, metadata !"compile", i32 33, i64 64, i64 64, i64 64, i32 0, metadata !34} ; [ DW_TAG_member ] [compile] [line 33, size 64, align 64, offset 64] [from compile_fp_t]
!34 = metadata !{i32 786454, metadata !30, null, metadata !"compile_fp_t", i32 25, i64 0, i64 0, i64 0, i32 0, metadata !35} ; [ DW_TAG_typedef ] [compile_fp_t] [line 25, size 0, align 0, offset 0] [from ]
!35 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !6} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!36 = metadata !{i32 786445, metadata !30, metadata !29, metadata !"execute", i32 34, i64 64, i64 64, i64 128, i32 0, metadata !37} ; [ DW_TAG_member ] [execute] [line 34, size 64, align 64, offset 128] [from execute_fp_t]
!37 = metadata !{i32 786454, metadata !30, null, metadata !"execute_fp_t", i32 26, i64 0, i64 0, i64 0, i32 0, metadata !38} ; [ DW_TAG_typedef ] [execute_fp_t] [line 26, size 0, align 0, offset 0] [from ]
!38 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !39} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!39 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !40, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!40 = metadata !{metadata !11, metadata !8, metadata !11, metadata !41, metadata !8}
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!42 = metadata !{metadata !43}
!43 = metadata !{i32 786465, i64 0, i64 6}        ; [ DW_TAG_subrange_type ] [0, 5]
!44 = metadata !{i32 786484, i32 0, null, metadata !"before_options", metadata !"before_options", metadata !"", metadata !5, i32 31, metadata !45, i32 0, i32 1, [59 x i8]* @before_options, null} ; [ DW_TAG_variable ] [before_options] [line 31] [def]
!45 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 472, i64 8, i32 0, i32 0, metadata !9, metadata !46, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 472, align 8, offset 0] [from ]
!46 = metadata !{metadata !47}
!47 = metadata !{i32 786465, i64 0, i64 59}       ; [ DW_TAG_subrange_type ] [0, 58]
!48 = metadata !{i32 786484, i32 0, null, metadata !"after_options", metadata !"after_options", metadata !"", metadata !5, i32 33, metadata !49, i32 0, i32 1, [114 x i8]* @after_options, null} ; [ DW_TAG_variable ] [after_options] [line 33] [def]
!49 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 912, i64 8, i32 0, i32 0, metadata !9, metadata !50, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 912, align 8, offset 0] [from ]
!50 = metadata !{metadata !51}
!51 = metadata !{i32 786465, i64 0, i64 114}      ; [ DW_TAG_subrange_type ] [0, 113]
!52 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!53 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!54 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!55 = metadata !{i32 5, i32 0, metadata !21, null}
!56 = metadata !{i32 7, i32 0, metadata !21, null}
!57 = metadata !{i32 8, i32 0, metadata !21, null} ; [ DW_TAG_imported_declaration ]
!58 = metadata !{i32 11, i32 0, metadata !17, null}
!59 = metadata !{i32 13, i32 0, metadata !17, null}
!60 = metadata !{i32 14, i32 0, metadata !17, null}
!61 = metadata !{i32 17, i32 0, metadata !4, null}
!62 = metadata !{i32 19, i32 0, metadata !4, null}
!63 = metadata !{i32 20, i32 0, metadata !4, null}
