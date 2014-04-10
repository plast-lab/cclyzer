; ModuleID = 'pcresearch.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str1 = private unnamed_addr constant [81 x i8] c"support for the -P option is not compiled into this --disable-perl-regexp binary\00", align 1

; Function Attrs: nounwind uwtable
define void @Pcompile(i8* nocapture readnone %pattern, i64 %size) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !36), !dbg !50
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !37), !dbg !50
  %1 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([81 x i8]* @.str1, i64 0, i64 0), i32 5) #6, !dbg !51
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %1) #6, !dbg !52
  ret void, !dbg !53
}

declare void @error(i32, i32, i8*, ...) #1

; Function Attrs: nounwind
declare i8* @dcgettext(i8*, i8*, i32) #2

; Function Attrs: noreturn nounwind uwtable
define i64 @Pexecute(i8* nocapture readnone %buf, i64 %size, i64* nocapture readnone %match_size, i8* nocapture readnone %start_ptr) #3 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !43), !dbg !54
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !44), !dbg !54
  tail call void @llvm.dbg.value(metadata !{i64* %match_size}, i64 0, metadata !45), !dbg !54
  tail call void @llvm.dbg.value(metadata !{i8* %start_ptr}, i64 0, metadata !46), !dbg !55
  tail call void @abort() #7, !dbg !56
  unreachable, !dbg !56
}

; Function Attrs: noreturn nounwind
declare void @abort() #4

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #5

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!47, !48}
!llvm.ident = !{!49}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !23, metadata !24, metadata !23, metadata !23, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/pcresearch.c] [DW_LANG_C99]
!1 = metadata !{metadata !"pcresearch.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3, metadata !7}
!3 = metadata !{i32 786436, metadata !4, null, metadata !"", i32 44, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 44, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"./system.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!5 = metadata !{metadata !6}
!6 = metadata !{i32 786472, metadata !"EXIT_TROUBLE", i64 2} ; [ DW_TAG_enumerator ] [EXIT_TROUBLE :: 2]
!7 = metadata !{i32 786436, metadata !8, null, metadata !"", i32 27, i64 32, i64 32, i32 0, i32 0, null, metadata !9, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 27, size 32, align 32, offset 0] [def] [from ]
!8 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/locale.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!9 = metadata !{metadata !10, metadata !11, metadata !12, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17, metadata !18, metadata !19, metadata !20, metadata !21, metadata !22}
!10 = metadata !{i32 786472, metadata !"__LC_CTYPE", i64 0} ; [ DW_TAG_enumerator ] [__LC_CTYPE :: 0]
!11 = metadata !{i32 786472, metadata !"__LC_NUMERIC", i64 1} ; [ DW_TAG_enumerator ] [__LC_NUMERIC :: 1]
!12 = metadata !{i32 786472, metadata !"__LC_TIME", i64 2} ; [ DW_TAG_enumerator ] [__LC_TIME :: 2]
!13 = metadata !{i32 786472, metadata !"__LC_COLLATE", i64 3} ; [ DW_TAG_enumerator ] [__LC_COLLATE :: 3]
!14 = metadata !{i32 786472, metadata !"__LC_MONETARY", i64 4} ; [ DW_TAG_enumerator ] [__LC_MONETARY :: 4]
!15 = metadata !{i32 786472, metadata !"__LC_MESSAGES", i64 5} ; [ DW_TAG_enumerator ] [__LC_MESSAGES :: 5]
!16 = metadata !{i32 786472, metadata !"__LC_ALL", i64 6} ; [ DW_TAG_enumerator ] [__LC_ALL :: 6]
!17 = metadata !{i32 786472, metadata !"__LC_PAPER", i64 7} ; [ DW_TAG_enumerator ] [__LC_PAPER :: 7]
!18 = metadata !{i32 786472, metadata !"__LC_NAME", i64 8} ; [ DW_TAG_enumerator ] [__LC_NAME :: 8]
!19 = metadata !{i32 786472, metadata !"__LC_ADDRESS", i64 9} ; [ DW_TAG_enumerator ] [__LC_ADDRESS :: 9]
!20 = metadata !{i32 786472, metadata !"__LC_TELEPHONE", i64 10} ; [ DW_TAG_enumerator ] [__LC_TELEPHONE :: 10]
!21 = metadata !{i32 786472, metadata !"__LC_MEASUREMENT", i64 11} ; [ DW_TAG_enumerator ] [__LC_MEASUREMENT :: 11]
!22 = metadata !{i32 786472, metadata !"__LC_IDENTIFICATION", i64 12} ; [ DW_TAG_enumerator ] [__LC_IDENTIFICATION :: 12]
!23 = metadata !{i32 0}
!24 = metadata !{metadata !25, metadata !38}
!25 = metadata !{i32 786478, metadata !1, metadata !26, metadata !"Pcompile", metadata !"Pcompile", metadata !"", i32 38, metadata !27, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64)* @Pcompile, null, null, metadata !35, i32 39} ; [ DW_TAG_subprogram ] [line 38] [def] [scope 39] [Pcompile]
!26 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/pcresearch.c]
!27 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !28, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!28 = metadata !{null, metadata !29, metadata !32}
!29 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !30} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!30 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !31} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!31 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!32 = metadata !{i32 786454, metadata !33, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !34} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!33 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!34 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!35 = metadata !{metadata !36, metadata !37}
!36 = metadata !{i32 786689, metadata !25, metadata !"pattern", metadata !26, i32 16777254, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 38]
!37 = metadata !{i32 786689, metadata !25, metadata !"size", metadata !26, i32 33554470, metadata !32, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 38]
!38 = metadata !{i32 786478, metadata !1, metadata !26, metadata !"Pexecute", metadata !"Pexecute", metadata !"", i32 105, metadata !39, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i8*, i64, i64*, i8*)* @Pexecute, null, null, metadata !42, i32 107} ; [ DW_TAG_subprogram ] [line 105] [def] [scope 107] [Pexecute]
!39 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !40, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!40 = metadata !{metadata !32, metadata !29, metadata !32, metadata !41, metadata !29}
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !32} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!42 = metadata !{metadata !43, metadata !44, metadata !45, metadata !46}
!43 = metadata !{i32 786689, metadata !38, metadata !"buf", metadata !26, i32 16777321, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 105]
!44 = metadata !{i32 786689, metadata !38, metadata !"size", metadata !26, i32 33554537, metadata !32, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 105]
!45 = metadata !{i32 786689, metadata !38, metadata !"match_size", metadata !26, i32 50331753, metadata !41, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_size] [line 105]
!46 = metadata !{i32 786689, metadata !38, metadata !"start_ptr", metadata !26, i32 67108970, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start_ptr] [line 106]
!47 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!48 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!49 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!50 = metadata !{i32 38, i32 0, metadata !25, null}
!51 = metadata !{i32 42, i32 0, metadata !25, null}
!52 = metadata !{i32 41, i32 0, metadata !25, null}
!53 = metadata !{i32 102, i32 0, metadata !25, null}
!54 = metadata !{i32 105, i32 0, metadata !38, null}
!55 = metadata !{i32 106, i32 0, metadata !38, null}
!56 = metadata !{i32 109, i32 0, metadata !38, null}
