; ModuleID = 'dfasearch.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.patterns = type { %struct.re_pattern_buffer, %struct.re_registers }
%struct.re_pattern_buffer = type { i8*, i64, i64, i64, i8*, i8*, i64, i8 }
%struct.re_registers = type { i32, i32*, i32* }
%struct.dfa = type opaque
%struct.kwset = type opaque
%struct.dfamust = type { i32, i8*, %struct.dfamust* }
%struct.kwsmatch = type { i32, [1 x i64], [1 x i64] }

@.str = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@dfawarn.mode = internal unnamed_addr global i32 0, align 4
@.str1 = private unnamed_addr constant [16 x i8] c"POSIXLY_CORRECT\00", align 1
@match_icase = external global i32
@eolbyte = external global i8
@patterns = internal unnamed_addr global %struct.patterns* null, align 8
@pcount = internal unnamed_addr global i64 0, align 8
@.str2 = private unnamed_addr constant [17 x i8] c"memory exhausted\00", align 1
@match_words = external global i32
@match_lines = external global i32
@GEAcompile.line_beg_no_bk = internal constant [3 x i8] c"^(\00", align 1
@GEAcompile.line_end_no_bk = internal constant [3 x i8] c")$\00", align 1
@GEAcompile.word_beg_no_bk = internal constant [19 x i8] c"(^|[^[:alnum:]_])(\00", align 16
@GEAcompile.word_end_no_bk = internal constant [19 x i8] c")([^[:alnum:]_]|$)\00", align 16
@GEAcompile.line_beg_bk = internal constant [4 x i8] c"^\5C(\00", align 1
@GEAcompile.line_end_bk = internal constant [4 x i8] c"\5C)$\00", align 1
@GEAcompile.word_beg_bk = internal constant [23 x i8] c"\5C(^\5C|[^[:alnum:]_]\5C)\5C(\00", align 16
@GEAcompile.word_end_bk = internal constant [23 x i8] c"\5C)\5C([^[:alnum:]_]\5C|$\5C)\00", align 16
@dfa = internal unnamed_addr global %struct.dfa* null, align 8
@kwset = internal global %struct.kwset* null, align 8
@kwset_exact_matches = internal unnamed_addr global i32 0, align 4

; Function Attrs: noreturn nounwind uwtable
define void @dfaerror(i8* %mesg) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %mesg}, i64 0, metadata !56), !dbg !219
  tail call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %mesg) #8, !dbg !220
  tail call void @abort() #9, !dbg !221
  unreachable, !dbg !221
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare void @error(i32, i32, i8*, ...) #2

; Function Attrs: noreturn nounwind
declare void @abort() #3

; Function Attrs: nounwind uwtable
define void @dfawarn(i8* %mesg) #4 {
  tail call void @llvm.dbg.value(metadata !{i8* %mesg}, i64 0, metadata !16), !dbg !222
  %1 = load i32* @dfawarn.mode, align 4, !dbg !223, !tbaa !225
  %2 = icmp eq i32 %1, 0, !dbg !223
  br i1 %2, label %3, label %7, !dbg !223

; <label>:3                                       ; preds = %0
  %4 = tail call i8* @getenv(i8* getelementptr inbounds ([16 x i8]* @.str1, i64 0, i64 0)) #8, !dbg !228
  %5 = icmp ne i8* %4, null, !dbg !228
  %6 = select i1 %5, i32 1, i32 2, !dbg !228
  store i32 %6, i32* @dfawarn.mode, align 4, !dbg !228, !tbaa !225
  br label %7, !dbg !228

; <label>:7                                       ; preds = %3, %0
  %8 = phi i32 [ %6, %3 ], [ %1, %0 ], !dbg !229
  %9 = icmp eq i32 %8, 2, !dbg !229
  br i1 %9, label %10, label %11, !dbg !229

; <label>:10                                      ; preds = %7
  tail call void @dfaerror(i8* %mesg) #10, !dbg !231
  unreachable, !dbg !231

; <label>:11                                      ; preds = %7
  ret void, !dbg !232
}

; Function Attrs: nounwind readonly
declare i8* @getenv(i8* nocapture) #5

; Function Attrs: nounwind uwtable
define void @GEAcompile(i8* %pattern, i64 %size, i64 %syntax_bits) #4 {
  %n.i1.i = alloca i64, align 8
  %n.i.i = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !66), !dbg !233
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !67), !dbg !233
  call void @llvm.dbg.value(metadata !{i64 %syntax_bits}, i64 0, metadata !68), !dbg !233
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !72), !dbg !234
  %1 = load i32* @match_icase, align 4, !dbg !235, !tbaa !237
  %2 = icmp eq i32 %1, 0, !dbg !235
  %3 = or i64 %syntax_bits, 4194304, !dbg !239
  call void @llvm.dbg.value(metadata !{i64 %3}, i64 0, metadata !68), !dbg !239
  %syntax_bits. = select i1 %2, i64 %syntax_bits, i64 %3, !dbg !235
  %4 = call i64 @re_set_syntax(i64 %syntax_bits.) #8, !dbg !240
  %5 = load i32* @match_icase, align 4, !dbg !241, !tbaa !237
  %6 = load i8* @eolbyte, align 1, !dbg !241, !tbaa !225
  call void @dfasyntax(i64 %syntax_bits., i32 %5, i8 zeroext %6) #8, !dbg !241
  call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !70), !dbg !242
  br label %7, !dbg !243

; <label>:7                                       ; preds = %38, %0
  %p.0 = phi i8* [ %pattern, %0 ], [ %sep.0, %38 ]
  %total.0 = phi i64 [ %size, %0 ], [ %total.1, %38 ]
  %8 = call i8* @memchr(i8* %p.0, i32 10, i64 %total.0) #11, !dbg !244
  call void @llvm.dbg.value(metadata !{i8* %8}, i64 0, metadata !71), !dbg !244
  %9 = icmp eq i8* %8, null, !dbg !245
  br i1 %9, label %16, label %10, !dbg !245

; <label>:10                                      ; preds = %7
  %11 = ptrtoint i8* %8 to i64, !dbg !247
  %12 = ptrtoint i8* %p.0 to i64, !dbg !247
  %13 = sub i64 %11, %12, !dbg !247
  call void @llvm.dbg.value(metadata !{i64 %13}, i64 0, metadata !75), !dbg !247
  %14 = getelementptr inbounds i8* %8, i64 1, !dbg !249
  call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !71), !dbg !249
  %.neg6 = add i64 %total.0, -1, !dbg !250
  %15 = sub i64 %.neg6, %13, !dbg !250
  call void @llvm.dbg.value(metadata !{i64 %15}, i64 0, metadata !72), !dbg !250
  br label %16, !dbg !251

; <label>:16                                      ; preds = %7, %10
  %sep.0 = phi i8* [ %14, %10 ], [ null, %7 ]
  %total.1 = phi i64 [ %15, %10 ], [ 0, %7 ]
  %len.0 = phi i64 [ %13, %10 ], [ %total.0, %7 ]
  %17 = load %struct.patterns** @patterns, align 8, !dbg !252, !tbaa !253
  %18 = bitcast %struct.patterns* %17 to i8*, !dbg !252
  %19 = load i64* @pcount, align 8, !dbg !252, !tbaa !255
  %20 = mul i64 %19, 88, !dbg !252
  %21 = add i64 %20, 88, !dbg !252
  %22 = call i8* @realloc(i8* %18, i64 %21) #8, !dbg !252
  %23 = bitcast i8* %22 to %struct.patterns*, !dbg !252
  store %struct.patterns* %23, %struct.patterns** @patterns, align 8, !dbg !252, !tbaa !253
  %24 = icmp eq i8* %22, null, !dbg !257
  br i1 %24, label %25, label %29, !dbg !257

; <label>:25                                      ; preds = %16
  %26 = call i32* @__errno_location() #1, !dbg !259
  %27 = load i32* %26, align 4, !dbg !259, !tbaa !237
  %28 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([17 x i8]* @.str2, i64 0, i64 0), i32 5) #8, !dbg !259
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 %27, i8* %28) #8, !dbg !259
  %.pre = load %struct.patterns** @patterns, align 8, !dbg !260, !tbaa !253
  br label %29, !dbg !259

; <label>:29                                      ; preds = %25, %16
  %30 = phi %struct.patterns* [ %.pre, %25 ], [ %23, %16 ]
  %31 = load i64* @pcount, align 8, !dbg !260, !tbaa !255
  %32 = getelementptr inbounds %struct.patterns* %30, i64 %31, !dbg !260
  %33 = bitcast %struct.patterns* %32 to i8*, !dbg !260
  call void @llvm.memset.p0i8.i64(i8* %33, i8 0, i64 88, i32 8, i1 false), !dbg !260
  %34 = getelementptr inbounds %struct.patterns* %30, i64 %31, i32 0, !dbg !261
  %35 = call i8* @re_compile_pattern(i8* %p.0, i64 %len.0, %struct.re_pattern_buffer* %34) #8, !dbg !261
  call void @llvm.dbg.value(metadata !{i8* %35}, i64 0, metadata !69), !dbg !261
  %36 = icmp eq i8* %35, null, !dbg !261
  br i1 %36, label %38, label %37, !dbg !261

; <label>:37                                      ; preds = %29
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %35) #8, !dbg !263
  br label %38, !dbg !263

; <label>:38                                      ; preds = %29, %37
  %39 = load i64* @pcount, align 8, !dbg !264, !tbaa !255
  %40 = add i64 %39, 1, !dbg !264
  store i64 %40, i64* @pcount, align 8, !dbg !264, !tbaa !255
  call void @llvm.dbg.value(metadata !{i8* %sep.0}, i64 0, metadata !70), !dbg !265
  %41 = icmp ne i8* %sep.0, null, !dbg !266
  %42 = icmp ne i64 %total.1, 0, !dbg !266
  %or.cond3 = and i1 %41, %42, !dbg !266
  br i1 %or.cond3, label %7, label %.critedge, !dbg !266

.critedge:                                        ; preds = %38
  %43 = load i32* @match_words, align 4, !dbg !267, !tbaa !237
  %44 = load i32* @match_lines, align 4, !dbg !267, !tbaa !237
  %45 = or i32 %44, %43, !dbg !267
  %46 = icmp eq i32 %45, 0, !dbg !267
  br i1 %46, label %76, label %47, !dbg !267

; <label>:47                                      ; preds = %.critedge
  %48 = and i64 %syntax_bits., 8192, !dbg !268
  %49 = icmp eq i64 %48, 0, !dbg !268
  %50 = add i64 %size, 45, !dbg !269
  %51 = call noalias i8* @xmalloc(i64 %50) #8, !dbg !269
  call void @llvm.dbg.value(metadata !{i8* %51}, i64 0, metadata !81), !dbg !269
  %52 = load i32* @match_lines, align 4, !dbg !270, !tbaa !237
  %53 = icmp eq i32 %52, 0, !dbg !270
  br i1 %53, label %56, label %54, !dbg !270

; <label>:54                                      ; preds = %47
  %55 = select i1 %49, i8* getelementptr inbounds ([4 x i8]* @GEAcompile.line_beg_bk, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @GEAcompile.line_beg_no_bk, i64 0, i64 0), !dbg !270
  br label %58, !dbg !270

; <label>:56                                      ; preds = %47
  %57 = select i1 %49, i8* getelementptr inbounds ([23 x i8]* @GEAcompile.word_beg_bk, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @GEAcompile.word_beg_no_bk, i64 0, i64 0), !dbg !270
  br label %58, !dbg !270

; <label>:58                                      ; preds = %56, %54
  %59 = phi i8* [ %55, %54 ], [ %57, %56 ], !dbg !270
  %60 = call i8* @strcpy(i8* %51, i8* %59) #8, !dbg !270
  %61 = call i64 @strlen(i8* %51) #11, !dbg !271
  call void @llvm.dbg.value(metadata !{i64 %61}, i64 0, metadata !72), !dbg !271
  %62 = getelementptr inbounds i8* %51, i64 %61, !dbg !272
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %62, i8* %pattern, i64 %size, i32 1, i1 false), !dbg !272
  %63 = add i64 %61, %size, !dbg !273
  call void @llvm.dbg.value(metadata !{i64 %63}, i64 0, metadata !72), !dbg !273
  %64 = getelementptr inbounds i8* %51, i64 %63, !dbg !274
  %65 = load i32* @match_lines, align 4, !dbg !274, !tbaa !237
  %66 = icmp eq i32 %65, 0, !dbg !274
  br i1 %66, label %69, label %67, !dbg !274

; <label>:67                                      ; preds = %58
  %68 = select i1 %49, i8* getelementptr inbounds ([4 x i8]* @GEAcompile.line_end_bk, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8]* @GEAcompile.line_end_no_bk, i64 0, i64 0), !dbg !274
  br label %71, !dbg !274

; <label>:69                                      ; preds = %58
  %70 = select i1 %49, i8* getelementptr inbounds ([23 x i8]* @GEAcompile.word_end_bk, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8]* @GEAcompile.word_end_no_bk, i64 0, i64 0), !dbg !274
  br label %71, !dbg !274

; <label>:71                                      ; preds = %69, %67
  %72 = phi i8* [ %68, %67 ], [ %70, %69 ], !dbg !274
  %73 = call i8* @strcpy(i8* %64, i8* %72) #8, !dbg !274
  %74 = call i64 @strlen(i8* %64) #11, !dbg !275
  %75 = add i64 %74, %63, !dbg !275
  call void @llvm.dbg.value(metadata !{i64 %75}, i64 0, metadata !72), !dbg !275
  call void @llvm.dbg.value(metadata !{i8* %51}, i64 0, metadata !73), !dbg !276
  call void @llvm.dbg.value(metadata !{i8* %51}, i64 0, metadata !66), !dbg !276
  call void @llvm.dbg.value(metadata !{i64 %75}, i64 0, metadata !67), !dbg !277
  br label %76, !dbg !278

; <label>:76                                      ; preds = %.critedge, %71
  %motif.0 = phi i8* [ %51, %71 ], [ null, %.critedge ]
  %.04 = phi i64 [ %75, %71 ], [ %size, %.critedge ]
  %.0 = phi i8* [ %51, %71 ], [ %pattern, %.critedge ]
  %77 = call %struct.dfa* @dfaalloc() #8, !dbg !279
  store %struct.dfa* %77, %struct.dfa** @dfa, align 8, !dbg !279, !tbaa !253
  call void @dfacomp(i8* %.0, i64 %.04, %struct.dfa* %77, i32 1) #8, !dbg !280
  %78 = load %struct.dfa** @dfa, align 8, !dbg !281, !tbaa !253
  %79 = call %struct.dfamust* @dfamusts(%struct.dfa* %78) #8, !dbg !281
  call void @llvm.dbg.value(metadata !{%struct.dfamust* %79}, i64 0, metadata !283) #8, !dbg !281
  %80 = icmp eq %struct.dfamust* %79, null, !dbg !284
  br i1 %80, label %kwsmusts.exit, label %.lr.ph8.i, !dbg !284

.lr.ph8.i:                                        ; preds = %76
  call void @kwsinit(%struct.kwset** @kwset) #8, !dbg !286
  %81 = bitcast i64* %n.i.i to i8*, !dbg !288
  br label %82, !dbg !293

; <label>:82                                      ; preds = %104, %.lr.ph8.i
  %dm.06.i = phi %struct.dfamust* [ %79, %.lr.ph8.i ], [ %106, %104 ]
  %83 = getelementptr inbounds %struct.dfamust* %dm.06.i, i64 0, i32 0, !dbg !294
  %84 = load i32* %83, align 4, !dbg !294, !tbaa !296
  %85 = icmp eq i32 %84, 0, !dbg !294
  br i1 %85, label %104, label %86, !dbg !294

; <label>:86                                      ; preds = %82
  %87 = load i32* @kwset_exact_matches, align 4, !dbg !298, !tbaa !237
  %88 = add nsw i32 %87, 1, !dbg !298
  store i32 %88, i32* @kwset_exact_matches, align 4, !dbg !298, !tbaa !237
  %89 = getelementptr inbounds %struct.dfamust* %dm.06.i, i64 0, i32 1, !dbg !289
  %90 = load i8** %89, align 8, !dbg !289, !tbaa !299
  call void @llvm.lifetime.start(i64 8, i8* %81) #8, !dbg !288
  call void @llvm.dbg.value(metadata !{i8* %90}, i64 0, metadata !300) #8, !dbg !288
  call void @llvm.dbg.declare(metadata !{i64* %n.i.i}, metadata !149) #8, !dbg !301
  %91 = call i64 @strlen(i8* %90) #11, !dbg !302
  call void @llvm.dbg.value(metadata !{i64 %91}, i64 0, metadata !303) #8, !dbg !302
  call void @llvm.dbg.value(metadata !{i64 %91}, i64 0, metadata !303) #8, !dbg !302
  call void @llvm.dbg.value(metadata !{i64 %91}, i64 0, metadata !149), !dbg !302
  store i64 %91, i64* %n.i.i, align 8, !dbg !302, !tbaa !255
  %92 = load i32* @match_icase, align 4, !dbg !304, !tbaa !237
  %93 = icmp eq i32 %92, 0, !dbg !304
  br i1 %93, label %kwsincr_case.exit.i, label %94, !dbg !304

; <label>:94                                      ; preds = %86
  %95 = call i64 @__ctype_get_mb_cur_max() #8, !dbg !304
  %96 = icmp ugt i64 %95, 1, !dbg !304
  br i1 %96, label %97, label %kwsincr_case.exit.i, !dbg !304

; <label>:97                                      ; preds = %94
  %98 = call i8* @mbtolower(i8* %90, i64* %n.i.i) #8, !dbg !306
  call void @llvm.dbg.value(metadata !{i8* %98}, i64 0, metadata !307) #8, !dbg !306
  call void @llvm.dbg.value(metadata !{i64* %n.i.i}, i64 0, metadata !303) #8, !dbg !308
  call void @llvm.dbg.value(metadata !{i64* %n.i.i}, i64 0, metadata !303) #8, !dbg !308
  call void @llvm.dbg.value(metadata !{i64* %n.i.i}, i64 0, metadata !149), !dbg !308
  %.pre.i.i = load i64* %n.i.i, align 8, !dbg !308, !tbaa !255
  br label %kwsincr_case.exit.i, !dbg !306

kwsincr_case.exit.i:                              ; preds = %97, %94, %86
  %99 = phi i64 [ %.pre.i.i, %97 ], [ %91, %86 ], [ %91, %94 ]
  %buf.0.i.i = phi i8* [ %98, %97 ], [ %90, %86 ], [ %90, %94 ]
  %100 = load %struct.kwset** @kwset, align 8, !dbg !308, !tbaa !253
  call void @llvm.dbg.value(metadata !{i64* %n.i.i}, i64 0, metadata !303) #8, !dbg !308
  %101 = call i8* @kwsincr(%struct.kwset* %100, i8* %buf.0.i.i, i64 %99) #8, !dbg !308
  call void @llvm.lifetime.end(i64 8, i8* %81) #8, !dbg !308
  call void @llvm.dbg.value(metadata !{i8* %101}, i64 0, metadata !309) #8, !dbg !289
  %102 = icmp eq i8* %101, null, !dbg !289
  br i1 %102, label %104, label %103, !dbg !289

; <label>:103                                     ; preds = %kwsincr_case.exit.i
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %101) #8, !dbg !310
  br label %104, !dbg !310

; <label>:104                                     ; preds = %103, %kwsincr_case.exit.i, %82
  %105 = getelementptr inbounds %struct.dfamust* %dm.06.i, i64 0, i32 2, !dbg !293
  %106 = load %struct.dfamust** %105, align 8, !dbg !293, !tbaa !311
  call void @llvm.dbg.value(metadata !{%struct.dfamust* %106}, i64 0, metadata !283) #8, !dbg !293
  %107 = icmp eq %struct.dfamust* %106, null, !dbg !293
  br i1 %107, label %._crit_edge9.i, label %82, !dbg !293

._crit_edge9.i:                                   ; preds = %104
  %108 = load %struct.dfa** @dfa, align 8, !dbg !312, !tbaa !253
  %109 = call %struct.dfamust* @dfamusts(%struct.dfa* %108) #8, !dbg !312
  call void @llvm.dbg.value(metadata !{%struct.dfamust* %109}, i64 0, metadata !283) #8, !dbg !312
  %110 = icmp eq %struct.dfamust* %109, null, !dbg !312
  br i1 %110, label %._crit_edge.i, label %.lr.ph.i, !dbg !312

.lr.ph.i:                                         ; preds = %._crit_edge9.i
  %111 = bitcast i64* %n.i1.i to i8*, !dbg !314
  br label %112, !dbg !312

; <label>:112                                     ; preds = %132, %.lr.ph.i
  %dm.15.i = phi %struct.dfamust* [ %109, %.lr.ph.i ], [ %134, %132 ]
  %113 = getelementptr inbounds %struct.dfamust* %dm.15.i, i64 0, i32 0, !dbg !318
  %114 = load i32* %113, align 4, !dbg !318, !tbaa !296
  %115 = icmp eq i32 %114, 0, !dbg !318
  br i1 %115, label %116, label %132, !dbg !318

; <label>:116                                     ; preds = %112
  %117 = getelementptr inbounds %struct.dfamust* %dm.15.i, i64 0, i32 1, !dbg !315
  %118 = load i8** %117, align 8, !dbg !315, !tbaa !299
  call void @llvm.lifetime.start(i64 8, i8* %111) #8, !dbg !314
  call void @llvm.dbg.value(metadata !{i8* %118}, i64 0, metadata !320) #8, !dbg !314
  call void @llvm.dbg.declare(metadata !{i64* %n.i1.i}, metadata !149) #8, !dbg !321
  %119 = call i64 @strlen(i8* %118) #11, !dbg !322
  call void @llvm.dbg.value(metadata !{i64 %119}, i64 0, metadata !323) #8, !dbg !322
  call void @llvm.dbg.value(metadata !{i64 %119}, i64 0, metadata !323) #8, !dbg !322
  call void @llvm.dbg.value(metadata !{i64 %119}, i64 0, metadata !149), !dbg !322
  store i64 %119, i64* %n.i1.i, align 8, !dbg !322, !tbaa !255
  %120 = load i32* @match_icase, align 4, !dbg !324, !tbaa !237
  %121 = icmp eq i32 %120, 0, !dbg !324
  br i1 %121, label %kwsincr_case.exit4.i, label %122, !dbg !324

; <label>:122                                     ; preds = %116
  %123 = call i64 @__ctype_get_mb_cur_max() #8, !dbg !324
  %124 = icmp ugt i64 %123, 1, !dbg !324
  br i1 %124, label %125, label %kwsincr_case.exit4.i, !dbg !324

; <label>:125                                     ; preds = %122
  %126 = call i8* @mbtolower(i8* %118, i64* %n.i1.i) #8, !dbg !325
  call void @llvm.dbg.value(metadata !{i8* %126}, i64 0, metadata !326) #8, !dbg !325
  call void @llvm.dbg.value(metadata !{i64* %n.i1.i}, i64 0, metadata !323) #8, !dbg !327
  call void @llvm.dbg.value(metadata !{i64* %n.i1.i}, i64 0, metadata !323) #8, !dbg !327
  call void @llvm.dbg.value(metadata !{i64* %n.i1.i}, i64 0, metadata !149), !dbg !327
  %.pre.i2.i = load i64* %n.i1.i, align 8, !dbg !327, !tbaa !255
  br label %kwsincr_case.exit4.i, !dbg !325

kwsincr_case.exit4.i:                             ; preds = %125, %122, %116
  %127 = phi i64 [ %.pre.i2.i, %125 ], [ %119, %116 ], [ %119, %122 ]
  %buf.0.i3.i = phi i8* [ %126, %125 ], [ %118, %116 ], [ %118, %122 ]
  %128 = load %struct.kwset** @kwset, align 8, !dbg !327, !tbaa !253
  call void @llvm.dbg.value(metadata !{i64* %n.i1.i}, i64 0, metadata !323) #8, !dbg !327
  %129 = call i8* @kwsincr(%struct.kwset* %128, i8* %buf.0.i3.i, i64 %127) #8, !dbg !327
  call void @llvm.lifetime.end(i64 8, i8* %111) #8, !dbg !327
  call void @llvm.dbg.value(metadata !{i8* %129}, i64 0, metadata !309) #8, !dbg !315
  %130 = icmp eq i8* %129, null, !dbg !315
  br i1 %130, label %132, label %131, !dbg !315

; <label>:131                                     ; preds = %kwsincr_case.exit4.i
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %129) #8, !dbg !328
  br label %132, !dbg !328

; <label>:132                                     ; preds = %131, %kwsincr_case.exit4.i, %112
  %133 = getelementptr inbounds %struct.dfamust* %dm.15.i, i64 0, i32 2, !dbg !312
  %134 = load %struct.dfamust** %133, align 8, !dbg !312, !tbaa !311
  call void @llvm.dbg.value(metadata !{%struct.dfamust* %134}, i64 0, metadata !283) #8, !dbg !312
  %135 = icmp eq %struct.dfamust* %134, null, !dbg !312
  br i1 %135, label %._crit_edge.i, label %112, !dbg !312

._crit_edge.i:                                    ; preds = %132, %._crit_edge9.i
  %136 = load %struct.kwset** @kwset, align 8, !dbg !329, !tbaa !253
  %137 = call i8* @kwsprep(%struct.kwset* %136) #8, !dbg !329
  call void @llvm.dbg.value(metadata !{i8* %137}, i64 0, metadata !309) #8, !dbg !329
  %138 = icmp eq i8* %137, null, !dbg !329
  br i1 %138, label %kwsmusts.exit, label %139, !dbg !329

; <label>:139                                     ; preds = %._crit_edge.i
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %137) #8, !dbg !331
  br label %kwsmusts.exit, !dbg !331

kwsmusts.exit:                                    ; preds = %76, %._crit_edge.i, %139
  call void @free(i8* %motif.0) #8, !dbg !332
  ret void, !dbg !333
}

declare i64 @re_set_syntax(i64) #2

declare void @dfasyntax(i64, i32, i8 zeroext) #2

; Function Attrs: nounwind readonly
declare i8* @memchr(i8*, i32, i64) #5

; Function Attrs: nounwind
declare noalias i8* @realloc(i8* nocapture, i64) #6

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #7

; Function Attrs: nounwind
declare i8* @dcgettext(i8*, i8*, i32) #6

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #8

declare i8* @re_compile_pattern(i8*, i64, %struct.re_pattern_buffer*) #2

declare noalias i8* @xmalloc(i64) #2

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8* nocapture readonly) #6

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #5

declare %struct.dfa* @dfaalloc() #2

declare void @dfacomp(i8*, i64, %struct.dfa*, i32) #2

; Function Attrs: nounwind
declare void @free(i8* nocapture) #6

; Function Attrs: nounwind uwtable
define i64 @EGexecute(i8* %buf, i64 %size, i64* nocapture %match_size, i8* %start_ptr) #4 {
  %1 = alloca i64, align 8
  %mb_start = alloca i8*, align 8
  %backref = alloca i32, align 4
  %kwsm = alloca %struct.kwsmatch, align 8
  call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !87), !dbg !334
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !88), !dbg !334
  store i64 %size, i64* %1, align 8, !tbaa !255
  call void @llvm.dbg.declare(metadata !{i64* %1}, metadata !88), !dbg !334
  call void @llvm.dbg.value(metadata !{i64* %match_size}, i64 0, metadata !89), !dbg !334
  call void @llvm.dbg.value(metadata !{i8* %start_ptr}, i64 0, metadata !90), !dbg !335
  call void @llvm.dbg.declare(metadata !{i8** %mb_start}, metadata !96), !dbg !336
  %2 = load i8* @eolbyte, align 1, !dbg !337, !tbaa !225
  call void @llvm.dbg.value(metadata !{i8 %2}, i64 0, metadata !97), !dbg !337
  call void @llvm.dbg.declare(metadata !{i32* %backref}, metadata !98), !dbg !338
  call void @llvm.dbg.declare(metadata !{%struct.kwsmatch* %kwsm}, metadata !102), !dbg !339
  %3 = call i64 @__ctype_get_mb_cur_max() #8, !dbg !340
  %4 = icmp ugt i64 %3, 1, !dbg !340
  %5 = load i32* @match_icase, align 4, !dbg !341, !tbaa !237
  %6 = icmp ne i32 %5, 0, !dbg !341
  %or.cond6 = and i1 %4, %6, !dbg !340
  br i1 %or.cond6, label %7, label %15, !dbg !340

; <label>:7                                       ; preds = %0
  %8 = call i8* @mbtolower(i8* %buf, i64* %1) #8, !dbg !342
  call void @llvm.dbg.value(metadata !{i8* %8}, i64 0, metadata !114), !dbg !342
  %9 = icmp eq i8* %start_ptr, null, !dbg !343
  br i1 %9, label %15, label %10, !dbg !343

; <label>:10                                      ; preds = %7
  %11 = ptrtoint i8* %start_ptr to i64, !dbg !345
  %12 = ptrtoint i8* %buf to i64, !dbg !345
  %13 = sub i64 %11, %12, !dbg !345
  %14 = getelementptr inbounds i8* %8, i64 %13, !dbg !345
  call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !90), !dbg !345
  br label %15, !dbg !345

; <label>:15                                      ; preds = %10, %7, %0
  %.1 = phi i8* [ %start_ptr, %0 ], [ %14, %10 ], [ null, %7 ]
  %.0 = phi i8* [ %buf, %0 ], [ %8, %10 ], [ %8, %7 ]
  call void @llvm.dbg.value(metadata !{i8* %.0}, i64 0, metadata !96), !dbg !346
  store i8* %.0, i8** %mb_start, align 8, !dbg !346, !tbaa !253
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !88), !dbg !347
  %16 = load i64* %1, align 8, !dbg !347, !tbaa !255
  %17 = getelementptr inbounds i8* %.0, i64 %16, !dbg !347
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !91), !dbg !347
  call void @llvm.dbg.value(metadata !{i8* %.0}, i64 0, metadata !93), !dbg !348
  call void @llvm.dbg.value(metadata !{i8* %.0}, i64 0, metadata !92), !dbg !348
  %18 = icmp sgt i64 %16, 0, !dbg !348
  br i1 %18, label %.lr.ph44, label %.loopexit16, !dbg !348

.lr.ph44:                                         ; preds = %15
  %19 = icmp ne i8* %.1, null, !dbg !349
  %20 = ptrtoint i8* %.0 to i64, !dbg !350
  %21 = icmp eq i8* %.1, null, !dbg !354
  %22 = sext i8 %2 to i32, !dbg !357
  %23 = ptrtoint i8* %17 to i64, !dbg !357
  %24 = getelementptr inbounds %struct.kwsmatch* %kwsm, i64 0, i32 0, !dbg !359
  %25 = getelementptr inbounds %struct.kwsmatch* %kwsm, i64 0, i32 2, i64 0, !dbg !361
  br label %26, !dbg !348

; <label>:26                                      ; preds = %.lr.ph44, %.backedge
  %end.042 = phi i8* [ %.0, %.lr.ph44 ], [ %end.0.be, %.backedge ]
  br i1 %19, label %83, label %27, !dbg !349

; <label>:27                                      ; preds = %26
  %28 = load %struct.kwset** @kwset, align 8, !dbg !364, !tbaa !253
  %29 = icmp eq %struct.kwset* %28, null, !dbg !364
  br i1 %29, label %65, label %30, !dbg !364

; <label>:30                                      ; preds = %27
  %31 = ptrtoint i8* %end.042 to i64, !dbg !365
  %32 = sub i64 %23, %31, !dbg !365
  %33 = call i64 @kwsexec(%struct.kwset* %28, i8* %end.042, i64 %32, %struct.kwsmatch* %kwsm) #8, !dbg !365
  call void @llvm.dbg.value(metadata !{i64 %33}, i64 0, metadata !119), !dbg !365
  %34 = icmp eq i64 %33, -1, !dbg !366
  br i1 %34, label %.loopexit16, label %35, !dbg !366

; <label>:35                                      ; preds = %30
  %36 = getelementptr inbounds i8* %end.042, i64 %33, !dbg !368
  call void @llvm.dbg.value(metadata !{i8* %36}, i64 0, metadata !92), !dbg !368
  %37 = ptrtoint i8* %36 to i64, !dbg !369
  %38 = sub i64 %23, %37, !dbg !369
  %39 = call i8* @memchr(i8* %36, i32 %22, i64 %38) #11, !dbg !369
  call void @llvm.dbg.value(metadata !{i8* %39}, i64 0, metadata !93), !dbg !369
  %40 = icmp eq i8* %39, null, !dbg !369
  %41 = getelementptr inbounds i8* %39, i64 1, !dbg !371
  call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !93), !dbg !371
  %end.1 = select i1 %40, i8* %17, i8* %41, !dbg !369
  br label %42, !dbg !369

; <label>:42                                      ; preds = %44, %35
  %beg.1 = phi i8* [ %36, %35 ], [ %45, %44 ]
  %43 = icmp ugt i8* %beg.1, %.0, !dbg !372
  br i1 %43, label %44, label %.critedge, !dbg !372

; <label>:44                                      ; preds = %42
  %45 = getelementptr inbounds i8* %beg.1, i64 -1, !dbg !372
  %46 = load i8* %45, align 1, !dbg !372, !tbaa !225
  %47 = icmp eq i8 %46, %2, !dbg !372
  br i1 %47, label %.critedge, label %42

.critedge:                                        ; preds = %44, %42
  %48 = load i32* %24, align 8, !dbg !359, !tbaa !373
  %49 = load i32* @kwset_exact_matches, align 4, !dbg !359, !tbaa !237
  %50 = icmp slt i32 %48, %49, !dbg !359
  br i1 %50, label %51, label %61, !dbg !359

; <label>:51                                      ; preds = %.critedge
  call void @llvm.dbg.value(metadata !{i8** %mb_start}, i64 0, metadata !96), !dbg !375
  %52 = load i8** %mb_start, align 8, !dbg !375, !tbaa !253
  %53 = icmp ult i8* %52, %beg.1, !dbg !375
  br i1 %53, label %54, label %55, !dbg !375

; <label>:54                                      ; preds = %51
  call void @llvm.dbg.value(metadata !{i8* %beg.1}, i64 0, metadata !96), !dbg !377
  store i8* %beg.1, i8** %mb_start, align 8, !dbg !377, !tbaa !253
  br label %55, !dbg !377

; <label>:55                                      ; preds = %54, %51
  %56 = call i64 @__ctype_get_mb_cur_max() #8, !dbg !378
  %57 = icmp eq i64 %56, 1, !dbg !378
  br i1 %57, label %.loopexit15, label %58, !dbg !378

; <label>:58                                      ; preds = %55
  %59 = load i64* %25, align 8, !dbg !361, !tbaa !255
  %60 = call zeroext i1 @is_mb_middle(i8** %mb_start, i8* %36, i8* %17, i64 %59) #8, !dbg !361
  br i1 %60, label %61, label %.loopexit15, !dbg !361

; <label>:61                                      ; preds = %58, %.critedge
  %62 = load %struct.dfa** @dfa, align 8, !dbg !379, !tbaa !253
  %63 = call i8* @dfaexec(%struct.dfa* %62, i8* %beg.1, i8* %end.1, i32 0, i32* null, i32* %backref) #8, !dbg !379
  %64 = icmp eq i8* %63, null, !dbg !379
  br i1 %64, label %.backedge, label %.critedge1, !dbg !379

; <label>:65                                      ; preds = %27
  %66 = load %struct.dfa** @dfa, align 8, !dbg !381, !tbaa !253
  %67 = call i8* @dfaexec(%struct.dfa* %66, i8* %end.042, i8* %17, i32 0, i32* null, i32* %backref) #8, !dbg !381
  call void @llvm.dbg.value(metadata !{i8* %67}, i64 0, metadata !126), !dbg !381
  %68 = icmp eq i8* %67, null, !dbg !382
  br i1 %68, label %.loopexit16, label %69, !dbg !382

; <label>:69                                      ; preds = %65
  call void @llvm.dbg.value(metadata !{i8* %67}, i64 0, metadata !92), !dbg !384
  %70 = ptrtoint i8* %67 to i64, !dbg !357
  %71 = sub i64 %23, %70, !dbg !357
  %72 = call i8* @memchr(i8* %67, i32 %22, i64 %71) #11, !dbg !357
  call void @llvm.dbg.value(metadata !{i8* %72}, i64 0, metadata !93), !dbg !357
  %73 = icmp eq i8* %72, null, !dbg !357
  %74 = getelementptr inbounds i8* %72, i64 1, !dbg !385
  call void @llvm.dbg.value(metadata !{i8* %74}, i64 0, metadata !93), !dbg !385
  %. = select i1 %73, i8* %17, i8* %74, !dbg !357
  br label %75, !dbg !357

; <label>:75                                      ; preds = %77, %69
  %beg.2 = phi i8* [ %67, %69 ], [ %78, %77 ]
  %76 = icmp ugt i8* %beg.2, %.0, !dbg !386
  br i1 %76, label %77, label %.critedge1, !dbg !386

; <label>:77                                      ; preds = %75
  %78 = getelementptr inbounds i8* %beg.2, i64 -1, !dbg !386
  %79 = load i8* %78, align 1, !dbg !386, !tbaa !225
  %80 = icmp eq i8 %79, %2, !dbg !386
  br i1 %80, label %.critedge1, label %75

.critedge1:                                       ; preds = %77, %75, %61
  %end.3 = phi i8* [ %end.1, %61 ], [ %., %75 ], [ %., %77 ]
  %beg.3 = phi i8* [ %beg.1, %61 ], [ %beg.2, %75 ], [ %beg.2, %77 ]
  call void @llvm.dbg.value(metadata !{i32* %backref}, i64 0, metadata !98), !dbg !387
  %81 = load i32* %backref, align 4, !dbg !387, !tbaa !237
  %82 = icmp eq i32 %81, 0, !dbg !387
  br i1 %82, label %.loopexit15, label %83, !dbg !387

; <label>:83                                      ; preds = %26, %.critedge1
  %end.4 = phi i8* [ %end.3, %.critedge1 ], [ %17, %26 ]
  %beg.4 = phi i8* [ %beg.3, %.critedge1 ], [ %.1, %26 ]
  call void @llvm.dbg.value(metadata !{i8* %end.4}, i64 0, metadata !95), !dbg !389
  call void @llvm.dbg.value(metadata !52, i64 0, metadata !101), !dbg !390
  call void @llvm.dbg.value(metadata !391, i64 0, metadata !112), !dbg !392
  %84 = load i64* @pcount, align 8, !dbg !392, !tbaa !255
  %85 = icmp eq i64 %84, 0, !dbg !392
  br i1 %85, label %.backedge, label %.lr.ph, !dbg !392

.lr.ph:                                           ; preds = %83
  %86 = ptrtoint i8* %end.4 to i64, !dbg !350
  %87 = sub i64 %86, %20, !dbg !350
  %88 = add nsw i64 %87, -1, !dbg !350
  %89 = trunc i64 %88 to i32, !dbg !350
  %90 = ptrtoint i8* %beg.4 to i64, !dbg !350
  %91 = sub i64 %90, %20, !dbg !350
  %92 = trunc i64 %91 to i32, !dbg !350
  %93 = sub i64 %86, %90, !dbg !350
  %94 = add nsw i64 %93, -1, !dbg !350
  %95 = trunc i64 %94 to i32, !dbg !350
  %96 = trunc i64 %93 to i32, !dbg !393
  %97 = getelementptr inbounds i8* %end.4, i64 -1, !dbg !396
  %98 = add i64 %86, 4294967295, !dbg !402
  br label %99, !dbg !392

; <label>:99                                      ; preds = %.lr.ph, %.loopexit
  %i.035 = phi i64 [ 0, %.lr.ph ], [ %210, %.loopexit ]
  %best_len.033 = phi i32 [ 0, %.lr.ph ], [ %best_len.1, %.loopexit ]
  %best_match.031 = phi i8* [ %end.4, %.lr.ph ], [ %best_match.1, %.loopexit ]
  %100 = load %struct.patterns** @patterns, align 8, !dbg !403, !tbaa !253
  %101 = getelementptr inbounds %struct.patterns* %100, i64 %i.035, i32 0, i32 7, !dbg !403
  %102 = load i8* %101, align 8, !dbg !403
  %103 = and i8 %102, -65, !dbg !403
  store i8 %103, i8* %101, align 8, !dbg !403
  %104 = load %struct.patterns** @patterns, align 8, !dbg !350, !tbaa !253
  %105 = getelementptr inbounds %struct.patterns* %104, i64 %i.035, i32 0, !dbg !350
  %106 = getelementptr inbounds %struct.patterns* %104, i64 %i.035, i32 1, !dbg !350
  %107 = call i32 @re_search(%struct.re_pattern_buffer* %105, i8* %.0, i32 %89, i32 %92, i32 %95, %struct.re_registers* %106) #8, !dbg !350
  call void @llvm.dbg.value(metadata !{i32 %107}, i64 0, metadata !99), !dbg !350
  %108 = icmp sgt i32 %107, -1, !dbg !350
  br i1 %108, label %109, label %.loopexit, !dbg !350

; <label>:109                                     ; preds = %99
  %110 = load %struct.patterns** @patterns, align 8, !dbg !404, !tbaa !253
  %111 = getelementptr inbounds %struct.patterns* %110, i64 %i.035, i32 1, i32 2, !dbg !404
  %112 = load i32** %111, align 8, !dbg !404, !tbaa !405
  %113 = load i32* %112, align 4, !dbg !404, !tbaa !237
  %114 = sub nsw i32 %113, %107, !dbg !404
  call void @llvm.dbg.value(metadata !{i32 %114}, i64 0, metadata !100), !dbg !404
  %115 = sext i32 %107 to i64, !dbg !409
  %116 = getelementptr inbounds i8* %.0, i64 %115, !dbg !409
  call void @llvm.dbg.value(metadata !{i8* %116}, i64 0, metadata !94), !dbg !409
  %117 = icmp ugt i8* %116, %best_match.031, !dbg !410
  br i1 %117, label %.loopexit, label %118, !dbg !410

; <label>:118                                     ; preds = %109
  %119 = load i32* @match_words, align 4, !dbg !354, !tbaa !237
  %120 = icmp ne i32 %119, 0, !dbg !354
  %or.cond = or i1 %21, %120, !dbg !354
  br i1 %or.cond, label %121, label %.loopexit13, !dbg !354

; <label>:121                                     ; preds = %118
  %122 = load i32* @match_lines, align 4, !dbg !412, !tbaa !237
  %123 = or i32 %122, %119, !dbg !412
  %124 = icmp eq i32 %123, 0, !dbg !412
  br i1 %124, label %.loopexit13, label %125, !dbg !412

; <label>:125                                     ; preds = %121
  %126 = icmp ne i32 %122, 0, !dbg !412
  %127 = sext i32 %114 to i64, !dbg !412
  %128 = icmp eq i64 %127, %94, !dbg !412
  %or.cond9 = and i1 %126, %128, !dbg !412
  br i1 %or.cond9, label %.loopexit13, label %129, !dbg !412

; <label>:129                                     ; preds = %125
  %130 = icmp eq i32 %119, 0, !dbg !413
  br i1 %130, label %.loopexit, label %.outer..outer.split_crit_edge, !dbg !413

.outer..outer.split_crit_edge:                    ; preds = %129, %.outer
  %.sum.pn.in = phi i64 [ %201, %.outer ], [ %115, %129 ]
  %131 = phi i32 [ %194, %.outer ], [ %107, %129 ]
  %len.0.ph30 = phi i32 [ %200, %.outer ], [ %114, %129 ]
  %match.0.ph28 = phi i8* [ %202, %.outer ], [ %116, %129 ]
  %.sum.pn = add i64 %.sum.pn.in, -1, !dbg !414
  %132 = getelementptr inbounds i8* %.0, i64 %.sum.pn, !dbg !414
  %133 = icmp eq i32 %131, 0, !dbg !414
  br label %134

; <label>:134                                     ; preds = %163, %.outer..outer.split_crit_edge
  %len.0 = phi i32 [ %177, %163 ], [ %len.0.ph30, %.outer..outer.split_crit_edge ]
  br i1 %133, label %145, label %135, !dbg !414

; <label>:135                                     ; preds = %134
  %136 = load i8* %132, align 1, !dbg !414, !tbaa !225
  %137 = zext i8 %136 to i64, !dbg !414
  %138 = call i16** @__ctype_b_loc() #1, !dbg !414
  %139 = load i16** %138, align 8, !dbg !414, !tbaa !253
  %140 = getelementptr inbounds i16* %139, i64 %137, !dbg !414
  %141 = load i16* %140, align 2, !dbg !414, !tbaa !416
  %142 = and i16 %141, 8, !dbg !414
  %143 = icmp ne i16 %142, 0, !dbg !414
  %144 = icmp eq i8 %136, 95, !dbg !414
  %or.cond10 = or i1 %143, %144, !dbg !414
  br i1 %or.cond10, label %161, label %145, !dbg !414

; <label>:145                                     ; preds = %135, %134
  %146 = add nsw i32 %len.0, %131, !dbg !414
  %147 = sext i32 %146 to i64, !dbg !414
  %148 = icmp eq i64 %147, %88, !dbg !414
  br i1 %148, label %.loopexit13, label %149, !dbg !414

; <label>:149                                     ; preds = %145
  %150 = sext i32 %len.0 to i64, !dbg !414
  %151 = getelementptr inbounds i8* %match.0.ph28, i64 %150, !dbg !414
  %152 = load i8* %151, align 1, !dbg !414, !tbaa !225
  %153 = zext i8 %152 to i64, !dbg !414
  %154 = call i16** @__ctype_b_loc() #1, !dbg !418
  %155 = load i16** %154, align 8, !dbg !418, !tbaa !253
  %156 = getelementptr inbounds i16* %155, i64 %153, !dbg !418
  %157 = load i16* %156, align 2, !dbg !418, !tbaa !416
  %158 = and i16 %157, 8, !dbg !418
  %159 = icmp ne i16 %158, 0, !dbg !418
  %160 = icmp eq i8 %152, 95, !dbg !418
  %or.cond11 = or i1 %159, %160, !dbg !418
  br i1 %or.cond11, label %161, label %.loopexit13, !dbg !418

; <label>:161                                     ; preds = %149, %135
  %162 = icmp sgt i32 %len.0, 0, !dbg !419
  br i1 %162, label %163, label %.thread, !dbg !419

; <label>:163                                     ; preds = %161
  %164 = add nsw i32 %len.0, -1, !dbg !421
  call void @llvm.dbg.value(metadata !{i32 %164}, i64 0, metadata !100), !dbg !421
  %165 = load %struct.patterns** @patterns, align 8, !dbg !423, !tbaa !253
  %166 = getelementptr inbounds %struct.patterns* %165, i64 %i.035, i32 0, i32 7, !dbg !423
  %167 = load i8* %166, align 8, !dbg !423
  %168 = or i8 %167, 64, !dbg !423
  store i8 %168, i8* %166, align 8, !dbg !423
  %169 = load %struct.patterns** @patterns, align 8, !dbg !424, !tbaa !253
  %170 = getelementptr inbounds %struct.patterns* %169, i64 %i.035, i32 0, !dbg !424
  %171 = sext i32 %164 to i64, !dbg !424
  %172 = getelementptr inbounds i8* %match.0.ph28, i64 %171, !dbg !424
  %173 = ptrtoint i8* %172 to i64, !dbg !424
  %174 = sub i64 %173, %90, !dbg !424
  %175 = trunc i64 %174 to i32, !dbg !424
  %176 = getelementptr inbounds %struct.patterns* %169, i64 %i.035, i32 1, !dbg !424
  %177 = call i32 @re_match(%struct.re_pattern_buffer* %170, i8* %.0, i32 %175, i32 %131, %struct.re_registers* %176) #8, !dbg !424
  call void @llvm.dbg.value(metadata !{i32 %177}, i64 0, metadata !100), !dbg !424
  %178 = icmp slt i32 %177, 1, !dbg !425
  br i1 %178, label %.thread, label %134, !dbg !425

.thread:                                          ; preds = %161, %163
  %179 = icmp eq i8* %match.0.ph28, %97, !dbg !396
  br i1 %179, label %.loopexit, label %180, !dbg !396

; <label>:180                                     ; preds = %.thread
  %181 = getelementptr inbounds i8* %match.0.ph28, i64 1, !dbg !426
  call void @llvm.dbg.value(metadata !{i8* %181}, i64 0, metadata !94), !dbg !426
  %182 = load %struct.patterns** @patterns, align 8, !dbg !427, !tbaa !253
  %183 = getelementptr inbounds %struct.patterns* %182, i64 %i.035, i32 0, i32 7, !dbg !427
  %184 = load i8* %183, align 8, !dbg !427
  %185 = and i8 %184, -65, !dbg !427
  store i8 %185, i8* %183, align 8, !dbg !427
  %186 = load %struct.patterns** @patterns, align 8, !dbg !402, !tbaa !253
  %187 = getelementptr inbounds %struct.patterns* %186, i64 %i.035, i32 0, !dbg !402
  %188 = ptrtoint i8* %181 to i64, !dbg !402
  %189 = sub i64 %188, %20, !dbg !402
  %190 = trunc i64 %189 to i32, !dbg !402
  %191 = sub i64 %98, %188, !dbg !402
  %192 = trunc i64 %191 to i32, !dbg !402
  %193 = getelementptr inbounds %struct.patterns* %186, i64 %i.035, i32 1, !dbg !402
  %194 = call i32 @re_search(%struct.re_pattern_buffer* %187, i8* %.0, i32 %89, i32 %190, i32 %192, %struct.re_registers* %193) #8, !dbg !402
  call void @llvm.dbg.value(metadata !{i32 %194}, i64 0, metadata !99), !dbg !402
  %195 = icmp slt i32 %194, 0, !dbg !428
  br i1 %195, label %.loopexit, label %.outer, !dbg !428

.outer:                                           ; preds = %180
  %196 = load %struct.patterns** @patterns, align 8, !dbg !430, !tbaa !253
  %197 = getelementptr inbounds %struct.patterns* %196, i64 %i.035, i32 1, i32 2, !dbg !430
  %198 = load i32** %197, align 8, !dbg !430, !tbaa !405
  %199 = load i32* %198, align 4, !dbg !430, !tbaa !237
  %200 = sub nsw i32 %199, %194, !dbg !430
  call void @llvm.dbg.value(metadata !{i32 %200}, i64 0, metadata !100), !dbg !430
  %201 = sext i32 %194 to i64, !dbg !431
  %202 = getelementptr inbounds i8* %.0, i64 %201, !dbg !431
  call void @llvm.dbg.value(metadata !{i8* %202}, i64 0, metadata !94), !dbg !431
  %203 = icmp ugt i8* %202, %best_match.031, !dbg !432
  br i1 %203, label %.loopexit, label %.outer..outer.split_crit_edge

.loopexit13:                                      ; preds = %149, %145, %121, %125, %118
  %match.1 = phi i8* [ %116, %118 ], [ %beg.4, %125 ], [ %beg.4, %121 ], [ %match.0.ph28, %145 ], [ %match.0.ph28, %149 ]
  %len.2 = phi i32 [ %114, %118 ], [ %96, %125 ], [ %96, %121 ], [ %len.0, %145 ], [ %len.0, %149 ]
  br i1 %19, label %204, label %.loopexit15, !dbg !433

; <label>:204                                     ; preds = %.loopexit13
  %205 = icmp ult i8* %match.1, %best_match.031, !dbg !435
  br i1 %205, label %209, label %206, !dbg !435

; <label>:206                                     ; preds = %204
  %207 = icmp eq i8* %match.1, %best_match.031, !dbg !435
  %208 = icmp sgt i32 %len.2, %best_len.033, !dbg !435
  %or.cond12 = and i1 %207, %208, !dbg !435
  br i1 %or.cond12, label %209, label %.loopexit, !dbg !435

; <label>:209                                     ; preds = %206, %204
  call void @llvm.dbg.value(metadata !{i8* %match.1}, i64 0, metadata !95), !dbg !437
  call void @llvm.dbg.value(metadata !{i32 %len.2}, i64 0, metadata !101), !dbg !439
  br label %.loopexit, !dbg !440

.loopexit:                                        ; preds = %.outer, %180, %.thread, %129, %99, %209, %206, %109
  %best_match.1 = phi i8* [ %best_match.031, %109 ], [ %match.1, %209 ], [ %best_match.031, %206 ], [ %best_match.031, %129 ], [ %best_match.031, %99 ], [ %best_match.031, %.thread ], [ %best_match.031, %180 ], [ %best_match.031, %.outer ]
  %best_len.1 = phi i32 [ %best_len.033, %109 ], [ %len.2, %209 ], [ %best_len.033, %206 ], [ %best_len.033, %129 ], [ %best_len.033, %99 ], [ %best_len.033, %.thread ], [ %best_len.033, %180 ], [ %best_len.033, %.outer ]
  %210 = add i64 %i.035, 1, !dbg !392
  call void @llvm.dbg.value(metadata !{i64 %210}, i64 0, metadata !112), !dbg !392
  %211 = load i64* @pcount, align 8, !dbg !392, !tbaa !255
  %212 = icmp ult i64 %210, %211, !dbg !392
  br i1 %212, label %99, label %._crit_edge, !dbg !392

._crit_edge:                                      ; preds = %.loopexit
  %213 = icmp ult i8* %best_match.1, %end.4, !dbg !441
  br i1 %213, label %.loopexit18, label %.backedge, !dbg !441

.backedge:                                        ; preds = %83, %._crit_edge, %61
  %end.0.be = phi i8* [ %end.4, %._crit_edge ], [ %end.1, %61 ], [ %end.4, %83 ]
  %214 = icmp ult i8* %end.0.be, %17, !dbg !348
  br i1 %214, label %26, label %.loopexit16, !dbg !348

.loopexit15:                                      ; preds = %.critedge1, %55, %58, %.loopexit13
  %end.6 = phi i8* [ %end.4, %.loopexit13 ], [ %end.3, %.critedge1 ], [ %end.1, %55 ], [ %end.1, %58 ]
  %beg.5 = phi i8* [ %beg.4, %.loopexit13 ], [ %beg.3, %.critedge1 ], [ %beg.1, %55 ], [ %beg.1, %58 ]
  %215 = ptrtoint i8* %end.6 to i64, !dbg !443
  %216 = ptrtoint i8* %beg.5 to i64, !dbg !443
  %217 = sub i64 %215, %216, !dbg !443
  %218 = trunc i64 %217 to i32, !dbg !443
  call void @llvm.dbg.value(metadata !{i32 %218}, i64 0, metadata !100), !dbg !443
  br label %.loopexit18, !dbg !443

.loopexit18:                                      ; preds = %._crit_edge, %.loopexit15
  %len.3 = phi i32 [ %218, %.loopexit15 ], [ %best_len.1, %._crit_edge ]
  %beg.6 = phi i8* [ %beg.5, %.loopexit15 ], [ %best_match.1, %._crit_edge ]
  %219 = sext i32 %len.3 to i64, !dbg !444
  store i64 %219, i64* %match_size, align 8, !dbg !444, !tbaa !255
  %220 = ptrtoint i8* %beg.6 to i64, !dbg !445
  %221 = sub i64 %220, %20, !dbg !445
  call void @llvm.dbg.value(metadata !{i64 %221}, i64 0, metadata !113), !dbg !445
  br label %.loopexit16, !dbg !445

.loopexit16:                                      ; preds = %30, %65, %.backedge, %15, %.loopexit18
  %ret_val.0 = phi i64 [ %221, %.loopexit18 ], [ -1, %15 ], [ -1, %.backedge ], [ -1, %65 ], [ -1, %30 ]
  ret i64 %ret_val.0, !dbg !446
}

; Function Attrs: nounwind
declare i64 @__ctype_get_mb_cur_max() #6

declare i8* @mbtolower(i8*, i64*) #2

declare i64 @kwsexec(%struct.kwset*, i8*, i64, %struct.kwsmatch*) #2

declare zeroext i1 @is_mb_middle(i8**, i8*, i8*, i64) #2

declare i8* @dfaexec(%struct.dfa*, i8*, i8*, i32, i32*, i32*) #2

declare i32 @re_search(%struct.re_pattern_buffer*, i8*, i32, i32, i32, %struct.re_registers*) #2

; Function Attrs: nounwind readnone
declare i16** @__ctype_b_loc() #7

declare i32 @re_match(%struct.re_pattern_buffer*, i8*, i32, i32, %struct.re_registers*) #2

declare %struct.dfamust* @dfamusts(%struct.dfa*) #2

declare void @kwsinit(%struct.kwset**) #2

declare i8* @kwsprep(%struct.kwset*) #2

declare i8* @kwsincr(%struct.kwset*, i8*, i64) #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #8

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #8

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #8

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind }
attributes #9 = { noreturn nounwind }
attributes #10 = { noreturn }
attributes #11 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!216, !217}
!llvm.ident = !{!218}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !52, metadata !53, metadata !150, metadata !52, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c] [DW_LANG_C99]
!1 = metadata !{metadata !"dfasearch.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3, metadata !7, metadata !21, metadata !37}
!3 = metadata !{i32 786436, metadata !4, null, metadata !"", i32 44, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 44, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"./system.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!5 = metadata !{metadata !6}
!6 = metadata !{i32 786472, metadata !"EXIT_TROUBLE", i64 2} ; [ DW_TAG_enumerator ] [EXIT_TROUBLE :: 2]
!7 = metadata !{i32 786436, metadata !1, metadata !8, metadata !"", i32 64, i64 32, i64 32, i32 0, i32 0, null, metadata !17, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 64, size 32, align 32, offset 0] [def] [from ]
!8 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"dfawarn", metadata !"dfawarn", metadata !"", i32 62, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @dfawarn, null, null, metadata !15, i32 63} ; [ DW_TAG_subprogram ] [line 62] [def] [scope 63] [dfawarn]
!9 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!10 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{null, metadata !12}
!12 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!14 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786689, metadata !8, metadata !"mesg", metadata !9, i32 16777278, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mesg] [line 62]
!17 = metadata !{metadata !18, metadata !19, metadata !20}
!18 = metadata !{i32 786472, metadata !"NONE", i64 0} ; [ DW_TAG_enumerator ] [NONE :: 0]
!19 = metadata !{i32 786472, metadata !"POSIX", i64 1} ; [ DW_TAG_enumerator ] [POSIX :: 1]
!20 = metadata !{i32 786472, metadata !"GNU", i64 2} ; [ DW_TAG_enumerator ] [GNU :: 2]
!21 = metadata !{i32 786436, metadata !22, null, metadata !"", i32 27, i64 32, i64 32, i32 0, i32 0, null, metadata !23, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 27, size 32, align 32, offset 0] [def] [from ]
!22 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/locale.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!23 = metadata !{metadata !24, metadata !25, metadata !26, metadata !27, metadata !28, metadata !29, metadata !30, metadata !31, metadata !32, metadata !33, metadata !34, metadata !35, metadata !36}
!24 = metadata !{i32 786472, metadata !"__LC_CTYPE", i64 0} ; [ DW_TAG_enumerator ] [__LC_CTYPE :: 0]
!25 = metadata !{i32 786472, metadata !"__LC_NUMERIC", i64 1} ; [ DW_TAG_enumerator ] [__LC_NUMERIC :: 1]
!26 = metadata !{i32 786472, metadata !"__LC_TIME", i64 2} ; [ DW_TAG_enumerator ] [__LC_TIME :: 2]
!27 = metadata !{i32 786472, metadata !"__LC_COLLATE", i64 3} ; [ DW_TAG_enumerator ] [__LC_COLLATE :: 3]
!28 = metadata !{i32 786472, metadata !"__LC_MONETARY", i64 4} ; [ DW_TAG_enumerator ] [__LC_MONETARY :: 4]
!29 = metadata !{i32 786472, metadata !"__LC_MESSAGES", i64 5} ; [ DW_TAG_enumerator ] [__LC_MESSAGES :: 5]
!30 = metadata !{i32 786472, metadata !"__LC_ALL", i64 6} ; [ DW_TAG_enumerator ] [__LC_ALL :: 6]
!31 = metadata !{i32 786472, metadata !"__LC_PAPER", i64 7} ; [ DW_TAG_enumerator ] [__LC_PAPER :: 7]
!32 = metadata !{i32 786472, metadata !"__LC_NAME", i64 8} ; [ DW_TAG_enumerator ] [__LC_NAME :: 8]
!33 = metadata !{i32 786472, metadata !"__LC_ADDRESS", i64 9} ; [ DW_TAG_enumerator ] [__LC_ADDRESS :: 9]
!34 = metadata !{i32 786472, metadata !"__LC_TELEPHONE", i64 10} ; [ DW_TAG_enumerator ] [__LC_TELEPHONE :: 10]
!35 = metadata !{i32 786472, metadata !"__LC_MEASUREMENT", i64 11} ; [ DW_TAG_enumerator ] [__LC_MEASUREMENT :: 11]
!36 = metadata !{i32 786472, metadata !"__LC_IDENTIFICATION", i64 12} ; [ DW_TAG_enumerator ] [__LC_IDENTIFICATION :: 12]
!37 = metadata !{i32 786436, metadata !38, null, metadata !"", i32 48, i64 32, i64 32, i32 0, i32 0, null, metadata !39, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 48, size 32, align 32, offset 0] [def] [from ]
!38 = metadata !{metadata !"/usr/include/ctype.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!39 = metadata !{metadata !40, metadata !41, metadata !42, metadata !43, metadata !44, metadata !45, metadata !46, metadata !47, metadata !48, metadata !49, metadata !50, metadata !51}
!40 = metadata !{i32 786472, metadata !"_ISupper", i64 256} ; [ DW_TAG_enumerator ] [_ISupper :: 256]
!41 = metadata !{i32 786472, metadata !"_ISlower", i64 512} ; [ DW_TAG_enumerator ] [_ISlower :: 512]
!42 = metadata !{i32 786472, metadata !"_ISalpha", i64 1024} ; [ DW_TAG_enumerator ] [_ISalpha :: 1024]
!43 = metadata !{i32 786472, metadata !"_ISdigit", i64 2048} ; [ DW_TAG_enumerator ] [_ISdigit :: 2048]
!44 = metadata !{i32 786472, metadata !"_ISxdigit", i64 4096} ; [ DW_TAG_enumerator ] [_ISxdigit :: 4096]
!45 = metadata !{i32 786472, metadata !"_ISspace", i64 8192} ; [ DW_TAG_enumerator ] [_ISspace :: 8192]
!46 = metadata !{i32 786472, metadata !"_ISprint", i64 16384} ; [ DW_TAG_enumerator ] [_ISprint :: 16384]
!47 = metadata !{i32 786472, metadata !"_ISgraph", i64 32768} ; [ DW_TAG_enumerator ] [_ISgraph :: 32768]
!48 = metadata !{i32 786472, metadata !"_ISblank", i64 1} ; [ DW_TAG_enumerator ] [_ISblank :: 1]
!49 = metadata !{i32 786472, metadata !"_IScntrl", i64 2} ; [ DW_TAG_enumerator ] [_IScntrl :: 2]
!50 = metadata !{i32 786472, metadata !"_ISpunct", i64 4} ; [ DW_TAG_enumerator ] [_ISpunct :: 4]
!51 = metadata !{i32 786472, metadata !"_ISalnum", i64 8} ; [ DW_TAG_enumerator ] [_ISalnum :: 8]
!52 = metadata !{i32 0}
!53 = metadata !{metadata !54, metadata !8, metadata !57, metadata !82, metadata !128, metadata !143}
!54 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"dfaerror", metadata !"dfaerror", metadata !"", i32 49, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @dfaerror, null, null, metadata !55, i32 50} ; [ DW_TAG_subprogram ] [line 49] [def] [scope 50] [dfaerror]
!55 = metadata !{metadata !56}
!56 = metadata !{i32 786689, metadata !54, metadata !"mesg", metadata !9, i32 16777265, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mesg] [line 49]
!57 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"GEAcompile", metadata !"GEAcompile", metadata !"", i32 132, metadata !58, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64, i64)* @GEAcompile, null, null, metadata !65, i32 133} ; [ DW_TAG_subprogram ] [line 132] [def] [scope 133] [GEAcompile]
!58 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !59, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!59 = metadata !{null, metadata !12, metadata !60, metadata !63}
!60 = metadata !{i32 786454, metadata !61, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !62} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!61 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!62 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!63 = metadata !{i32 786454, metadata !64, null, metadata !"reg_syntax_t", i32 97, i64 0, i64 0, i64 0, i32 0, metadata !62} ; [ DW_TAG_typedef ] [reg_syntax_t] [line 97, size 0, align 0, offset 0] [from long unsigned int]
!64 = metadata !{metadata !"../lib/regex.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!65 = metadata !{metadata !66, metadata !67, metadata !68, metadata !69, metadata !70, metadata !71, metadata !72, metadata !73, metadata !75, metadata !77, metadata !81}
!66 = metadata !{i32 786689, metadata !57, metadata !"pattern", metadata !9, i32 16777348, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 132]
!67 = metadata !{i32 786689, metadata !57, metadata !"size", metadata !9, i32 33554564, metadata !60, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 132]
!68 = metadata !{i32 786689, metadata !57, metadata !"syntax_bits", metadata !9, i32 50331780, metadata !63, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [syntax_bits] [line 132]
!69 = metadata !{i32 786688, metadata !57, metadata !"err", metadata !9, i32 134, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [err] [line 134]
!70 = metadata !{i32 786688, metadata !57, metadata !"p", metadata !9, i32 135, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 135]
!71 = metadata !{i32 786688, metadata !57, metadata !"sep", metadata !9, i32 135, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sep] [line 135]
!72 = metadata !{i32 786688, metadata !57, metadata !"total", metadata !9, i32 136, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [total] [line 136]
!73 = metadata !{i32 786688, metadata !57, metadata !"motif", metadata !9, i32 137, metadata !74, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [motif] [line 137]
!74 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!75 = metadata !{i32 786688, metadata !76, metadata !"len", metadata !9, i32 151, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 151]
!76 = metadata !{i32 786443, metadata !1, metadata !57, i32 150, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!77 = metadata !{i32 786688, metadata !78, metadata !"bk", metadata !9, i32 192, metadata !80, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bk] [line 192]
!78 = metadata !{i32 786443, metadata !1, metadata !79, i32 183, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!79 = metadata !{i32 786443, metadata !1, metadata !57, i32 182, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!80 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!81 = metadata !{i32 786688, metadata !78, metadata !"n", metadata !9, i32 193, metadata !74, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 193]
!82 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"EGexecute", metadata !"EGexecute", metadata !"", i32 217, metadata !83, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i8*, i64, i64*, i8*)* @EGexecute, null, null, metadata !86, i32 219} ; [ DW_TAG_subprogram ] [line 217] [def] [scope 219] [EGexecute]
!83 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !84, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!84 = metadata !{metadata !60, metadata !12, metadata !60, metadata !85, metadata !12}
!85 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !60} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!86 = metadata !{metadata !87, metadata !88, metadata !89, metadata !90, metadata !91, metadata !92, metadata !93, metadata !94, metadata !95, metadata !96, metadata !97, metadata !98, metadata !99, metadata !100, metadata !101, metadata !102, metadata !112, metadata !113, metadata !114, metadata !119, metadata !126}
!87 = metadata !{i32 786689, metadata !82, metadata !"buf", metadata !9, i32 16777433, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 217]
!88 = metadata !{i32 786689, metadata !82, metadata !"size", metadata !9, i32 33554649, metadata !60, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 217]
!89 = metadata !{i32 786689, metadata !82, metadata !"match_size", metadata !9, i32 50331865, metadata !85, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_size] [line 217]
!90 = metadata !{i32 786689, metadata !82, metadata !"start_ptr", metadata !9, i32 67109082, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start_ptr] [line 218]
!91 = metadata !{i32 786688, metadata !82, metadata !"buflim", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buflim] [line 220]
!92 = metadata !{i32 786688, metadata !82, metadata !"beg", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 220]
!93 = metadata !{i32 786688, metadata !82, metadata !"end", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 220]
!94 = metadata !{i32 786688, metadata !82, metadata !"match", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [match] [line 220]
!95 = metadata !{i32 786688, metadata !82, metadata !"best_match", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [best_match] [line 220]
!96 = metadata !{i32 786688, metadata !82, metadata !"mb_start", metadata !9, i32 220, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mb_start] [line 220]
!97 = metadata !{i32 786688, metadata !82, metadata !"eol", metadata !9, i32 221, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eol] [line 221]
!98 = metadata !{i32 786688, metadata !82, metadata !"backref", metadata !9, i32 222, metadata !80, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [backref] [line 222]
!99 = metadata !{i32 786688, metadata !82, metadata !"start", metadata !9, i32 222, metadata !80, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [start] [line 222]
!100 = metadata !{i32 786688, metadata !82, metadata !"len", metadata !9, i32 222, metadata !80, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 222]
!101 = metadata !{i32 786688, metadata !82, metadata !"best_len", metadata !9, i32 222, metadata !80, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [best_len] [line 222]
!102 = metadata !{i32 786688, metadata !82, metadata !"kwsm", metadata !9, i32 223, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwsm] [line 223]
!103 = metadata !{i32 786451, metadata !104, null, metadata !"kwsmatch", i32 24, i64 192, i64 64, i32 0, i32 0, null, metadata !105, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwsmatch] [line 24, size 192, align 64, offset 0] [def] [from ]
!104 = metadata !{metadata !"./kwset.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!105 = metadata !{metadata !106, metadata !107, metadata !111}
!106 = metadata !{i32 786445, metadata !104, metadata !103, metadata !"index", i32 26, i64 32, i64 32, i64 0, i32 0, metadata !80} ; [ DW_TAG_member ] [index] [line 26, size 32, align 32, offset 0] [from int]
!107 = metadata !{i32 786445, metadata !104, metadata !103, metadata !"offset", i32 27, i64 64, i64 64, i64 64, i32 0, metadata !108} ; [ DW_TAG_member ] [offset] [line 27, size 64, align 64, offset 64] [from ]
!108 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 64, i64 64, i32 0, i32 0, metadata !60, metadata !109, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!109 = metadata !{metadata !110}
!110 = metadata !{i32 786465, i64 0, i64 1}       ; [ DW_TAG_subrange_type ] [0, 0]
!111 = metadata !{i32 786445, metadata !104, metadata !103, metadata !"size", i32 28, i64 64, i64 64, i64 128, i32 0, metadata !108} ; [ DW_TAG_member ] [size] [line 28, size 64, align 64, offset 128] [from ]
!112 = metadata !{i32 786688, metadata !82, metadata !"i", metadata !9, i32 224, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 224]
!113 = metadata !{i32 786688, metadata !82, metadata !"ret_val", metadata !9, i32 224, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ret_val] [line 224]
!114 = metadata !{i32 786688, metadata !115, metadata !"case_buf", metadata !9, i32 232, metadata !74, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [case_buf] [line 232]
!115 = metadata !{i32 786443, metadata !1, metadata !116, i32 229, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!116 = metadata !{i32 786443, metadata !1, metadata !117, i32 228, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!117 = metadata !{i32 786443, metadata !1, metadata !118, i32 227, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!118 = metadata !{i32 786443, metadata !1, metadata !82, i32 226, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!119 = metadata !{i32 786688, metadata !120, metadata !"offset", metadata !9, i32 251, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 251]
!120 = metadata !{i32 786443, metadata !1, metadata !121, i32 249, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!121 = metadata !{i32 786443, metadata !1, metadata !122, i32 248, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!122 = metadata !{i32 786443, metadata !1, metadata !123, i32 246, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!123 = metadata !{i32 786443, metadata !1, metadata !124, i32 245, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!124 = metadata !{i32 786443, metadata !1, metadata !125, i32 244, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!125 = metadata !{i32 786443, metadata !1, metadata !82, i32 243, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!126 = metadata !{i32 786688, metadata !127, metadata !"next_beg", metadata !9, i32 281, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [next_beg] [line 281]
!127 = metadata !{i32 786443, metadata !1, metadata !121, i32 279, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!128 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"kwsmusts", metadata !"kwsmusts", metadata !"", i32 97, metadata !129, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !131, i32 98} ; [ DW_TAG_subprogram ] [line 97] [local] [def] [scope 98] [kwsmusts]
!129 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !130, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!130 = metadata !{null}
!131 = metadata !{metadata !132, metadata !142}
!132 = metadata !{i32 786688, metadata !128, metadata !"dm", metadata !9, i32 99, metadata !133, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dm] [line 99]
!133 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !134} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!134 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !135} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from dfamust]
!135 = metadata !{i32 786451, metadata !136, null, metadata !"dfamust", i32 27, i64 192, i64 64, i32 0, i32 0, null, metadata !137, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [dfamust] [line 27, size 192, align 64, offset 0] [def] [from ]
!136 = metadata !{metadata !"./dfa.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!137 = metadata !{metadata !138, metadata !139, metadata !140}
!138 = metadata !{i32 786445, metadata !136, metadata !135, metadata !"exact", i32 29, i64 32, i64 32, i64 0, i32 0, metadata !80} ; [ DW_TAG_member ] [exact] [line 29, size 32, align 32, offset 0] [from int]
!139 = metadata !{i32 786445, metadata !136, metadata !135, metadata !"must", i32 30, i64 64, i64 64, i64 64, i32 0, metadata !74} ; [ DW_TAG_member ] [must] [line 30, size 64, align 64, offset 64] [from ]
!140 = metadata !{i32 786445, metadata !136, metadata !135, metadata !"next", i32 31, i64 64, i64 64, i64 128, i32 0, metadata !141} ; [ DW_TAG_member ] [next] [line 31, size 64, align 64, offset 128] [from ]
!141 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !135} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dfamust]
!142 = metadata !{i32 786688, metadata !128, metadata !"err", metadata !9, i32 100, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [err] [line 100]
!143 = metadata !{i32 786478, metadata !1, metadata !9, metadata !"kwsincr_case", metadata !"kwsincr_case", metadata !"", i32 77, metadata !144, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !146, i32 78} ; [ DW_TAG_subprogram ] [line 77] [local] [def] [scope 78] [kwsincr_case]
!144 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !145, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!145 = metadata !{metadata !12, metadata !12}
!146 = metadata !{metadata !147, metadata !148, metadata !149}
!147 = metadata !{i32 786689, metadata !143, metadata !"must", metadata !9, i32 16777293, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [must] [line 77]
!148 = metadata !{i32 786688, metadata !143, metadata !"buf", metadata !9, i32 79, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buf] [line 79]
!149 = metadata !{i32 786688, metadata !143, metadata !"n", metadata !9, i32 80, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 80]
!150 = metadata !{metadata !151, metadata !152, metadata !156, metadata !157, metadata !161, metadata !162, metadata !166, metadata !167, metadata !171, metadata !172, metadata !176, metadata !179, metadata !212, metadata !214, metadata !215}
!151 = metadata !{i32 786484, i32 0, metadata !8, metadata !"mode", metadata !"mode", metadata !"", metadata !9, i32 64, metadata !7, i32 1, i32 1, i32* @dfawarn.mode, null} ; [ DW_TAG_variable ] [mode] [line 64] [local] [def]
!152 = metadata !{i32 786484, i32 0, metadata !57, metadata !"line_beg_no_bk", metadata !"line_beg_no_bk", metadata !"", metadata !9, i32 184, metadata !153, i32 1, i32 1, [3 x i8]* @GEAcompile.line_beg_no_bk, null} ; [ DW_TAG_variable ] [line_beg_no_bk] [line 184] [local] [def]
!153 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 24, i64 8, i32 0, i32 0, metadata !13, metadata !154, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 24, align 8, offset 0] [from ]
!154 = metadata !{metadata !155}
!155 = metadata !{i32 786465, i64 0, i64 3}       ; [ DW_TAG_subrange_type ] [0, 2]
!156 = metadata !{i32 786484, i32 0, metadata !57, metadata !"line_end_no_bk", metadata !"line_end_no_bk", metadata !"", metadata !9, i32 185, metadata !153, i32 1, i32 1, [3 x i8]* @GEAcompile.line_end_no_bk, null} ; [ DW_TAG_variable ] [line_end_no_bk] [line 185] [local] [def]
!157 = metadata !{i32 786484, i32 0, metadata !57, metadata !"word_beg_no_bk", metadata !"word_beg_no_bk", metadata !"", metadata !9, i32 186, metadata !158, i32 1, i32 1, [19 x i8]* @GEAcompile.word_beg_no_bk, null} ; [ DW_TAG_variable ] [word_beg_no_bk] [line 186] [local] [def]
!158 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 152, i64 8, i32 0, i32 0, metadata !13, metadata !159, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 152, align 8, offset 0] [from ]
!159 = metadata !{metadata !160}
!160 = metadata !{i32 786465, i64 0, i64 19}      ; [ DW_TAG_subrange_type ] [0, 18]
!161 = metadata !{i32 786484, i32 0, metadata !57, metadata !"word_end_no_bk", metadata !"word_end_no_bk", metadata !"", metadata !9, i32 187, metadata !158, i32 1, i32 1, [19 x i8]* @GEAcompile.word_end_no_bk, null} ; [ DW_TAG_variable ] [word_end_no_bk] [line 187] [local] [def]
!162 = metadata !{i32 786484, i32 0, metadata !57, metadata !"line_beg_bk", metadata !"line_beg_bk", metadata !"", metadata !9, i32 188, metadata !163, i32 1, i32 1, [4 x i8]* @GEAcompile.line_beg_bk, null} ; [ DW_TAG_variable ] [line_beg_bk] [line 188] [local] [def]
!163 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32, i64 8, i32 0, i32 0, metadata !13, metadata !164, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from ]
!164 = metadata !{metadata !165}
!165 = metadata !{i32 786465, i64 0, i64 4}       ; [ DW_TAG_subrange_type ] [0, 3]
!166 = metadata !{i32 786484, i32 0, metadata !57, metadata !"line_end_bk", metadata !"line_end_bk", metadata !"", metadata !9, i32 189, metadata !163, i32 1, i32 1, [4 x i8]* @GEAcompile.line_end_bk, null} ; [ DW_TAG_variable ] [line_end_bk] [line 189] [local] [def]
!167 = metadata !{i32 786484, i32 0, metadata !57, metadata !"word_beg_bk", metadata !"word_beg_bk", metadata !"", metadata !9, i32 190, metadata !168, i32 1, i32 1, [23 x i8]* @GEAcompile.word_beg_bk, null} ; [ DW_TAG_variable ] [word_beg_bk] [line 190] [local] [def]
!168 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 184, i64 8, i32 0, i32 0, metadata !13, metadata !169, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 184, align 8, offset 0] [from ]
!169 = metadata !{metadata !170}
!170 = metadata !{i32 786465, i64 0, i64 23}      ; [ DW_TAG_subrange_type ] [0, 22]
!171 = metadata !{i32 786484, i32 0, metadata !57, metadata !"word_end_bk", metadata !"word_end_bk", metadata !"", metadata !9, i32 191, metadata !168, i32 1, i32 1, [23 x i8]* @GEAcompile.word_end_bk, null} ; [ DW_TAG_variable ] [word_end_bk] [line 191] [local] [def]
!172 = metadata !{i32 786484, i32 0, null, metadata !"kwset", metadata !"kwset", metadata !"", metadata !9, i32 31, metadata !173, i32 1, i32 1, %struct.kwset** @kwset, null} ; [ DW_TAG_variable ] [kwset] [line 31] [local] [def]
!173 = metadata !{i32 786454, metadata !104, null, metadata !"kwset_t", i32 34, i64 0, i64 0, i64 0, i32 0, metadata !174} ; [ DW_TAG_typedef ] [kwset_t] [line 34, size 0, align 0, offset 0] [from ]
!174 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !175} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwset]
!175 = metadata !{i32 786451, metadata !104, null, metadata !"kwset", i32 33, i64 0, i64 0, i32 0, i32 4, null, null, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwset] [line 33, size 0, align 0, offset 0] [decl] [from ]
!176 = metadata !{i32 786484, i32 0, null, metadata !"dfa", metadata !"dfa", metadata !"", metadata !9, i32 34, metadata !177, i32 1, i32 1, %struct.dfa** @dfa, null} ; [ DW_TAG_variable ] [dfa] [line 34] [local] [def]
!177 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !178} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dfa]
!178 = metadata !{i32 786451, metadata !136, null, metadata !"dfa", i32 35, i64 0, i64 0, i32 0, i32 4, null, null, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [dfa] [line 35, size 0, align 0, offset 0] [decl] [from ]
!179 = metadata !{i32 786484, i32 0, null, metadata !"patterns0", metadata !"patterns0", metadata !"", metadata !9, i32 43, metadata !180, i32 1, i32 1, null, null} ; [ DW_TAG_variable ] [patterns0] [line 43] [local] [def]
!180 = metadata !{i32 786451, metadata !1, null, metadata !"patterns", i32 37, i64 704, i64 64, i32 0, i32 0, null, metadata !181, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [patterns] [line 37, size 704, align 64, offset 0] [def] [from ]
!181 = metadata !{metadata !182, metadata !203}
!182 = metadata !{i32 786445, metadata !1, metadata !180, metadata !"regexbuf", i32 40, i64 512, i64 64, i64 0, i32 0, metadata !183} ; [ DW_TAG_member ] [regexbuf] [line 40, size 512, align 64, offset 0] [from re_pattern_buffer]
!183 = metadata !{i32 786451, metadata !64, null, metadata !"re_pattern_buffer", i32 453, i64 512, i64 64, i32 0, i32 0, null, metadata !184, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [re_pattern_buffer] [line 453, size 512, align 64, offset 0] [def] [from ]
!184 = metadata !{metadata !185, metadata !188, metadata !190, metadata !191, metadata !192, metadata !193, metadata !194, metadata !195, metadata !197, metadata !198, metadata !199, metadata !200, metadata !201, metadata !202}
!185 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"buffer", i32 458, i64 64, i64 64, i64 0, i32 0, metadata !186} ; [ DW_TAG_member ] [buffer] [line 458, size 64, align 64, offset 0] [from ]
!186 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !187} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned char]
!187 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!188 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"allocated", i32 461, i64 64, i64 64, i64 64, i32 0, metadata !189} ; [ DW_TAG_member ] [allocated] [line 461, size 64, align 64, offset 64] [from __re_long_size_t]
!189 = metadata !{i32 786454, metadata !64, null, metadata !"__re_long_size_t", i32 81, i64 0, i64 0, i64 0, i32 0, metadata !62} ; [ DW_TAG_typedef ] [__re_long_size_t] [line 81, size 0, align 0, offset 0] [from long unsigned int]
!190 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"used", i32 464, i64 64, i64 64, i64 128, i32 0, metadata !189} ; [ DW_TAG_member ] [used] [line 464, size 64, align 64, offset 128] [from __re_long_size_t]
!191 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"syntax", i32 467, i64 64, i64 64, i64 192, i32 0, metadata !63} ; [ DW_TAG_member ] [syntax] [line 467, size 64, align 64, offset 192] [from reg_syntax_t]
!192 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"fastmap", i32 472, i64 64, i64 64, i64 256, i32 0, metadata !74} ; [ DW_TAG_member ] [fastmap] [line 472, size 64, align 64, offset 256] [from ]
!193 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"translate", i32 478, i64 64, i64 64, i64 320, i32 0, metadata !186} ; [ DW_TAG_member ] [translate] [line 478, size 64, align 64, offset 320] [from ]
!194 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"re_nsub", i32 481, i64 64, i64 64, i64 384, i32 0, metadata !60} ; [ DW_TAG_member ] [re_nsub] [line 481, size 64, align 64, offset 384] [from size_t]
!195 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"can_be_null", i32 487, i64 1, i64 32, i64 448, i32 0, metadata !196} ; [ DW_TAG_member ] [can_be_null] [line 487, size 1, align 32, offset 448] [from unsigned int]
!196 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!197 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"regs_allocated", i32 498, i64 2, i64 32, i64 449, i32 0, metadata !196} ; [ DW_TAG_member ] [regs_allocated] [line 498, size 2, align 32, offset 449] [from unsigned int]
!198 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"fastmap_accurate", i32 502, i64 1, i64 32, i64 451, i32 0, metadata !196} ; [ DW_TAG_member ] [fastmap_accurate] [line 502, size 1, align 32, offset 451] [from unsigned int]
!199 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"no_sub", i32 506, i64 1, i64 32, i64 452, i32 0, metadata !196} ; [ DW_TAG_member ] [no_sub] [line 506, size 1, align 32, offset 452] [from unsigned int]
!200 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"not_bol", i32 510, i64 1, i64 32, i64 453, i32 0, metadata !196} ; [ DW_TAG_member ] [not_bol] [line 510, size 1, align 32, offset 453] [from unsigned int]
!201 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"not_eol", i32 513, i64 1, i64 32, i64 454, i32 0, metadata !196} ; [ DW_TAG_member ] [not_eol] [line 513, size 1, align 32, offset 454] [from unsigned int]
!202 = metadata !{i32 786445, metadata !64, metadata !183, metadata !"newline_anchor", i32 516, i64 1, i64 32, i64 455, i32 0, metadata !196} ; [ DW_TAG_member ] [newline_anchor] [line 516, size 1, align 32, offset 455] [from unsigned int]
!203 = metadata !{i32 786445, metadata !1, metadata !180, metadata !"regs", i32 41, i64 192, i64 64, i64 512, i32 0, metadata !204} ; [ DW_TAG_member ] [regs] [line 41, size 192, align 64, offset 512] [from re_registers]
!204 = metadata !{i32 786451, metadata !64, null, metadata !"re_registers", i32 525, i64 192, i64 64, i32 0, i32 0, null, metadata !205, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [re_registers] [line 525, size 192, align 64, offset 0] [def] [from ]
!205 = metadata !{metadata !206, metadata !208, metadata !211}
!206 = metadata !{i32 786445, metadata !64, metadata !204, metadata !"num_regs", i32 527, i64 32, i64 32, i64 0, i32 0, metadata !207} ; [ DW_TAG_member ] [num_regs] [line 527, size 32, align 32, offset 0] [from __re_size_t]
!207 = metadata !{i32 786454, metadata !64, null, metadata !"__re_size_t", i32 80, i64 0, i64 0, i64 0, i32 0, metadata !196} ; [ DW_TAG_typedef ] [__re_size_t] [line 80, size 0, align 0, offset 0] [from unsigned int]
!208 = metadata !{i32 786445, metadata !64, metadata !204, metadata !"start", i32 528, i64 64, i64 64, i64 64, i32 0, metadata !209} ; [ DW_TAG_member ] [start] [line 528, size 64, align 64, offset 64] [from ]
!209 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !210} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from regoff_t]
!210 = metadata !{i32 786454, metadata !64, null, metadata !"regoff_t", i32 78, i64 0, i64 0, i64 0, i32 0, metadata !80} ; [ DW_TAG_typedef ] [regoff_t] [line 78, size 0, align 0, offset 0] [from int]
!211 = metadata !{i32 786445, metadata !64, metadata !204, metadata !"end", i32 529, i64 64, i64 64, i64 128, i32 0, metadata !209} ; [ DW_TAG_member ] [end] [line 529, size 64, align 64, offset 128] [from ]
!212 = metadata !{i32 786484, i32 0, null, metadata !"patterns", metadata !"patterns", metadata !"", metadata !9, i32 45, metadata !213, i32 1, i32 1, %struct.patterns** @patterns, null} ; [ DW_TAG_variable ] [patterns] [line 45] [local] [def]
!213 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !180} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from patterns]
!214 = metadata !{i32 786484, i32 0, null, metadata !"pcount", metadata !"pcount", metadata !"", metadata !9, i32 46, metadata !60, i32 1, i32 1, i64* @pcount, null} ; [ DW_TAG_variable ] [pcount] [line 46] [local] [def]
!215 = metadata !{i32 786484, i32 0, null, metadata !"kwset_exact_matches", metadata !"kwset_exact_matches", metadata !"", metadata !9, i32 74, metadata !80, i32 1, i32 1, i32* @kwset_exact_matches, null} ; [ DW_TAG_variable ] [kwset_exact_matches] [line 74] [local] [def]
!216 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!217 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!218 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!219 = metadata !{i32 49, i32 0, metadata !54, null}
!220 = metadata !{i32 51, i32 0, metadata !54, null}
!221 = metadata !{i32 55, i32 0, metadata !54, null}
!222 = metadata !{i32 62, i32 0, metadata !8, null}
!223 = metadata !{i32 65, i32 0, metadata !224, null}
!224 = metadata !{i32 786443, metadata !1, metadata !8, i32 65, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!225 = metadata !{metadata !226, metadata !226, i64 0}
!226 = metadata !{metadata !"omnipotent char", metadata !227, i64 0}
!227 = metadata !{metadata !"Simple C/C++ TBAA"}
!228 = metadata !{i32 66, i32 0, metadata !224, null}
!229 = metadata !{i32 67, i32 0, metadata !230, null}
!230 = metadata !{i32 786443, metadata !1, metadata !8, i32 67, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!231 = metadata !{i32 68, i32 0, metadata !230, null}
!232 = metadata !{i32 69, i32 0, metadata !8, null}
!233 = metadata !{i32 132, i32 0, metadata !57, null}
!234 = metadata !{i32 136, i32 0, metadata !57, null}
!235 = metadata !{i32 139, i32 0, metadata !236, null}
!236 = metadata !{i32 786443, metadata !1, metadata !57, i32 139, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!237 = metadata !{metadata !238, metadata !238, i64 0}
!238 = metadata !{metadata !"int", metadata !226, i64 0}
!239 = metadata !{i32 140, i32 0, metadata !236, null}
!240 = metadata !{i32 141, i32 0, metadata !57, null}
!241 = metadata !{i32 142, i32 0, metadata !57, null}
!242 = metadata !{i32 148, i32 0, metadata !57, null}
!243 = metadata !{i32 149, i32 0, metadata !57, null}
!244 = metadata !{i32 152, i32 0, metadata !76, null}
!245 = metadata !{i32 153, i32 0, metadata !246, null}
!246 = metadata !{i32 786443, metadata !1, metadata !76, i32 153, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!247 = metadata !{i32 155, i32 0, metadata !248, null}
!248 = metadata !{i32 786443, metadata !1, metadata !246, i32 154, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!249 = metadata !{i32 156, i32 0, metadata !248, null}
!250 = metadata !{i32 157, i32 0, metadata !248, null}
!251 = metadata !{i32 158, i32 0, metadata !248, null}
!252 = metadata !{i32 165, i32 0, metadata !76, null}
!253 = metadata !{metadata !254, metadata !254, i64 0}
!254 = metadata !{metadata !"any pointer", metadata !226, i64 0}
!255 = metadata !{metadata !256, metadata !256, i64 0}
!256 = metadata !{metadata !"long", metadata !226, i64 0}
!257 = metadata !{i32 166, i32 0, metadata !258, null}
!258 = metadata !{i32 786443, metadata !1, metadata !76, i32 166, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!259 = metadata !{i32 167, i32 0, metadata !258, null}
!260 = metadata !{i32 168, i32 0, metadata !76, null}
!261 = metadata !{i32 170, i32 0, metadata !262, null}
!262 = metadata !{i32 786443, metadata !1, metadata !76, i32 170, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!263 = metadata !{i32 172, i32 0, metadata !262, null}
!264 = metadata !{i32 173, i32 0, metadata !76, null}
!265 = metadata !{i32 175, i32 0, metadata !76, null}
!266 = metadata !{i32 176, i32 0, metadata !76, null}
!267 = metadata !{i32 182, i32 0, metadata !79, null}
!268 = metadata !{i32 192, i32 0, metadata !78, null}
!269 = metadata !{i32 193, i32 0, metadata !78, null}
!270 = metadata !{i32 195, i32 0, metadata !78, null}
!271 = metadata !{i32 197, i32 0, metadata !78, null}
!272 = metadata !{i32 198, i32 0, metadata !78, null}
!273 = metadata !{i32 199, i32 0, metadata !78, null}
!274 = metadata !{i32 200, i32 0, metadata !78, null}
!275 = metadata !{i32 202, i32 0, metadata !78, null}
!276 = metadata !{i32 203, i32 0, metadata !78, null}
!277 = metadata !{i32 204, i32 0, metadata !78, null}
!278 = metadata !{i32 205, i32 0, metadata !78, null}
!279 = metadata !{i32 209, i32 0, metadata !57, null}
!280 = metadata !{i32 210, i32 0, metadata !57, null}
!281 = metadata !{i32 102, i32 0, metadata !128, metadata !282}
!282 = metadata !{i32 211, i32 0, metadata !57, null}
!283 = metadata !{i32 786688, metadata !128, metadata !"dm", metadata !9, i32 99, metadata !133, i32 0, metadata !282} ; [ DW_TAG_auto_variable ] [dm] [line 99]
!284 = metadata !{i32 103, i32 0, metadata !285, metadata !282}
!285 = metadata !{i32 786443, metadata !1, metadata !128, i32 103, i32 0, i32 57} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!286 = metadata !{i32 105, i32 0, metadata !287, metadata !282}
!287 = metadata !{i32 786443, metadata !1, metadata !285, i32 104, i32 0, i32 58} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!288 = metadata !{i32 77, i32 0, metadata !143, metadata !289}
!289 = metadata !{i32 114, i32 0, metadata !290, metadata !282}
!290 = metadata !{i32 786443, metadata !1, metadata !291, i32 114, i32 0, i32 62} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!291 = metadata !{i32 786443, metadata !1, metadata !292, i32 110, i32 0, i32 60} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!292 = metadata !{i32 786443, metadata !1, metadata !287, i32 109, i32 0, i32 59} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!293 = metadata !{i32 109, i32 0, metadata !292, metadata !282}
!294 = metadata !{i32 111, i32 0, metadata !295, metadata !282}
!295 = metadata !{i32 786443, metadata !1, metadata !291, i32 111, i32 0, i32 61} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!296 = metadata !{metadata !297, metadata !238, i64 0}
!297 = metadata !{metadata !"dfamust", metadata !238, i64 0, metadata !254, i64 8, metadata !254, i64 16}
!298 = metadata !{i32 113, i32 0, metadata !291, metadata !282}
!299 = metadata !{metadata !297, metadata !254, i64 8}
!300 = metadata !{i32 786689, metadata !143, metadata !"must", metadata !9, i32 16777293, metadata !12, i32 0, metadata !289} ; [ DW_TAG_arg_variable ] [must] [line 77]
!301 = metadata !{i32 80, i32 0, metadata !143, metadata !289}
!302 = metadata !{i32 82, i32 0, metadata !143, metadata !289}
!303 = metadata !{i32 786688, metadata !143, metadata !"n", metadata !9, i32 80, metadata !60, i32 0, metadata !289} ; [ DW_TAG_auto_variable ] [n] [line 80]
!304 = metadata !{i32 84, i32 0, metadata !305, metadata !289}
!305 = metadata !{i32 786443, metadata !1, metadata !143, i32 84, i32 0, i32 68} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!306 = metadata !{i32 85, i32 0, metadata !305, metadata !289}
!307 = metadata !{i32 786688, metadata !143, metadata !"buf", metadata !9, i32 79, metadata !12, i32 0, metadata !289} ; [ DW_TAG_auto_variable ] [buf] [line 79]
!308 = metadata !{i32 89, i32 0, metadata !143, metadata !289}
!309 = metadata !{i32 786688, metadata !128, metadata !"err", metadata !9, i32 100, metadata !12, i32 0, metadata !282} ; [ DW_TAG_auto_variable ] [err] [line 100]
!310 = metadata !{i32 115, i32 0, metadata !290, metadata !282}
!311 = metadata !{metadata !297, metadata !254, i64 16}
!312 = metadata !{i32 119, i32 0, metadata !313, metadata !282}
!313 = metadata !{i32 786443, metadata !1, metadata !287, i32 119, i32 0, i32 63} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!314 = metadata !{i32 77, i32 0, metadata !143, metadata !315}
!315 = metadata !{i32 123, i32 0, metadata !316, metadata !282}
!316 = metadata !{i32 786443, metadata !1, metadata !317, i32 123, i32 0, i32 66} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!317 = metadata !{i32 786443, metadata !1, metadata !313, i32 120, i32 0, i32 64} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!318 = metadata !{i32 121, i32 0, metadata !319, metadata !282}
!319 = metadata !{i32 786443, metadata !1, metadata !317, i32 121, i32 0, i32 65} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!320 = metadata !{i32 786689, metadata !143, metadata !"must", metadata !9, i32 16777293, metadata !12, i32 0, metadata !315} ; [ DW_TAG_arg_variable ] [must] [line 77]
!321 = metadata !{i32 80, i32 0, metadata !143, metadata !315}
!322 = metadata !{i32 82, i32 0, metadata !143, metadata !315}
!323 = metadata !{i32 786688, metadata !143, metadata !"n", metadata !9, i32 80, metadata !60, i32 0, metadata !315} ; [ DW_TAG_auto_variable ] [n] [line 80]
!324 = metadata !{i32 84, i32 0, metadata !305, metadata !315}
!325 = metadata !{i32 85, i32 0, metadata !305, metadata !315}
!326 = metadata !{i32 786688, metadata !143, metadata !"buf", metadata !9, i32 79, metadata !12, i32 0, metadata !315} ; [ DW_TAG_auto_variable ] [buf] [line 79]
!327 = metadata !{i32 89, i32 0, metadata !143, metadata !315}
!328 = metadata !{i32 124, i32 0, metadata !316, metadata !282}
!329 = metadata !{i32 126, i32 0, metadata !330, metadata !282}
!330 = metadata !{i32 786443, metadata !1, metadata !287, i32 126, i32 0, i32 67} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!331 = metadata !{i32 127, i32 0, metadata !330, metadata !282}
!332 = metadata !{i32 213, i32 0, metadata !57, null}
!333 = metadata !{i32 214, i32 0, metadata !57, null}
!334 = metadata !{i32 217, i32 0, metadata !82, null}
!335 = metadata !{i32 218, i32 0, metadata !82, null}
!336 = metadata !{i32 220, i32 0, metadata !82, null}
!337 = metadata !{i32 221, i32 0, metadata !82, null}
!338 = metadata !{i32 222, i32 0, metadata !82, null}
!339 = metadata !{i32 223, i32 0, metadata !82, null}
!340 = metadata !{i32 226, i32 0, metadata !118, null}
!341 = metadata !{i32 228, i32 0, metadata !116, null}
!342 = metadata !{i32 232, i32 0, metadata !115, null}
!343 = metadata !{i32 233, i32 0, metadata !344, null}
!344 = metadata !{i32 786443, metadata !1, metadata !115, i32 233, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!345 = metadata !{i32 234, i32 0, metadata !344, null}
!346 = metadata !{i32 240, i32 0, metadata !82, null}
!347 = metadata !{i32 241, i32 0, metadata !82, null}
!348 = metadata !{i32 243, i32 0, metadata !125, null}
!349 = metadata !{i32 245, i32 0, metadata !123, null}
!350 = metadata !{i32 313, i32 0, metadata !351, null}
!351 = metadata !{i32 786443, metadata !1, metadata !352, i32 313, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!352 = metadata !{i32 786443, metadata !1, metadata !353, i32 311, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!353 = metadata !{i32 786443, metadata !1, metadata !124, i32 310, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!354 = metadata !{i32 322, i32 0, metadata !355, null}
!355 = metadata !{i32 786443, metadata !1, metadata !356, i32 322, i32 0, i32 39} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!356 = metadata !{i32 786443, metadata !1, metadata !351, i32 317, i32 0, i32 37} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!357 = metadata !{i32 287, i32 0, metadata !358, null}
!358 = metadata !{i32 786443, metadata !1, metadata !127, i32 287, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!359 = metadata !{i32 264, i32 0, metadata !360, null}
!360 = metadata !{i32 786443, metadata !1, metadata !120, i32 264, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!361 = metadata !{i32 270, i32 0, metadata !362, null}
!362 = metadata !{i32 786443, metadata !1, metadata !363, i32 269, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!363 = metadata !{i32 786443, metadata !1, metadata !360, i32 265, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!364 = metadata !{i32 248, i32 0, metadata !121, null}
!365 = metadata !{i32 251, i32 0, metadata !120, null}
!366 = metadata !{i32 252, i32 0, metadata !367, null}
!367 = metadata !{i32 786443, metadata !1, metadata !120, i32 252, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!368 = metadata !{i32 254, i32 0, metadata !120, null}
!369 = metadata !{i32 257, i32 0, metadata !370, null}
!370 = metadata !{i32 786443, metadata !1, metadata !120, i32 257, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!371 = metadata !{i32 258, i32 0, metadata !370, null}
!372 = metadata !{i32 262, i32 0, metadata !120, null}
!373 = metadata !{metadata !374, metadata !238, i64 0}
!374 = metadata !{metadata !"kwsmatch", metadata !238, i64 0, metadata !226, i64 8, metadata !226, i64 16}
!375 = metadata !{i32 267, i32 0, metadata !376, null}
!376 = metadata !{i32 786443, metadata !1, metadata !363, i32 267, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!377 = metadata !{i32 268, i32 0, metadata !376, null}
!378 = metadata !{i32 269, i32 0, metadata !362, null}
!379 = metadata !{i32 275, i32 0, metadata !380, null}
!380 = metadata !{i32 786443, metadata !1, metadata !120, i32 275, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!381 = metadata !{i32 281, i32 0, metadata !127, null}
!382 = metadata !{i32 283, i32 0, metadata !383, null}
!383 = metadata !{i32 786443, metadata !1, metadata !127, i32 283, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!384 = metadata !{i32 286, i32 0, metadata !127, null}
!385 = metadata !{i32 288, i32 0, metadata !358, null}
!386 = metadata !{i32 291, i32 0, metadata !127, null}
!387 = metadata !{i32 295, i32 0, metadata !388, null}
!388 = metadata !{i32 786443, metadata !1, metadata !122, i32 295, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!389 = metadata !{i32 308, i32 0, metadata !124, null}
!390 = metadata !{i32 309, i32 0, metadata !124, null}
!391 = metadata !{i64 0}
!392 = metadata !{i32 310, i32 0, metadata !353, null}
!393 = metadata !{i32 328, i32 0, metadata !394, null}
!394 = metadata !{i32 786443, metadata !1, metadata !395, i32 326, i32 0, i32 41} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!395 = metadata !{i32 786443, metadata !1, metadata !356, i32 324, i32 0, i32 40} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!396 = metadata !{i32 357, i32 0, metadata !397, null}
!397 = metadata !{i32 786443, metadata !1, metadata !398, i32 357, i32 0, i32 49} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!398 = metadata !{i32 786443, metadata !1, metadata !399, i32 355, i32 0, i32 48} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!399 = metadata !{i32 786443, metadata !1, metadata !400, i32 354, i32 0, i32 47} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!400 = metadata !{i32 786443, metadata !1, metadata !401, i32 340, i32 0, i32 43} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!401 = metadata !{i32 786443, metadata !1, metadata !356, i32 338, i32 0, i32 42} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!402 = metadata !{i32 361, i32 0, metadata !398, null}
!403 = metadata !{i32 312, i32 0, metadata !352, null}
!404 = metadata !{i32 318, i32 0, metadata !356, null}
!405 = metadata !{metadata !406, metadata !254, i64 80}
!406 = metadata !{metadata !"patterns", metadata !407, i64 0, metadata !408, i64 64}
!407 = metadata !{metadata !"re_pattern_buffer", metadata !254, i64 0, metadata !256, i64 8, metadata !256, i64 16, metadata !256, i64 24, metadata !254, i64 32, metadata !254, i64 40, metadata !256, i64 48, metadata !238, i64 56, metadata !238, i64 56, metadata !238, i64 56, metadata !238, i64 56, metadata !238, i64 56, metadata !238, i64 56, metadata !238, i64 56}
!408 = metadata !{metadata !"re_registers", metadata !238, i64 0, metadata !254, i64 8, metadata !254, i64 16}
!409 = metadata !{i32 319, i32 0, metadata !356, null}
!410 = metadata !{i32 320, i32 0, metadata !411, null}
!411 = metadata !{i32 786443, metadata !1, metadata !356, i32 320, i32 0, i32 38} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!412 = metadata !{i32 324, i32 0, metadata !395, null}
!413 = metadata !{i32 338, i32 0, metadata !401, null}
!414 = metadata !{i32 341, i32 0, metadata !415, null}
!415 = metadata !{i32 786443, metadata !1, metadata !400, i32 341, i32 0, i32 44} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!416 = metadata !{metadata !417, metadata !417, i64 0}
!417 = metadata !{metadata !"short", metadata !226, i64 0}
!418 = metadata !{i32 343, i32 0, metadata !415, null}
!419 = metadata !{i32 345, i32 0, metadata !420, null}
!420 = metadata !{i32 786443, metadata !1, metadata !400, i32 345, i32 0, i32 45} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!421 = metadata !{i32 348, i32 0, metadata !422, null}
!422 = metadata !{i32 786443, metadata !1, metadata !420, i32 346, i32 0, i32 46} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!423 = metadata !{i32 349, i32 0, metadata !422, null}
!424 = metadata !{i32 350, i32 0, metadata !422, null}
!425 = metadata !{i32 354, i32 0, metadata !399, null}
!426 = metadata !{i32 359, i32 0, metadata !398, null}
!427 = metadata !{i32 360, i32 0, metadata !398, null}
!428 = metadata !{i32 365, i32 0, metadata !429, null}
!429 = metadata !{i32 786443, metadata !1, metadata !398, i32 365, i32 0, i32 50} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!430 = metadata !{i32 367, i32 0, metadata !398, null}
!431 = metadata !{i32 368, i32 0, metadata !398, null}
!432 = metadata !{i32 339, i32 0, metadata !401, null}
!433 = metadata !{i32 373, i32 0, metadata !434, null}
!434 = metadata !{i32 786443, metadata !1, metadata !356, i32 373, i32 0, i32 51} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!435 = metadata !{i32 379, i32 0, metadata !436, null}
!436 = metadata !{i32 786443, metadata !1, metadata !356, i32 379, i32 0, i32 53} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!437 = metadata !{i32 382, i32 0, metadata !438, null}
!438 = metadata !{i32 786443, metadata !1, metadata !436, i32 380, i32 0, i32 54} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!439 = metadata !{i32 383, i32 0, metadata !438, null}
!440 = metadata !{i32 384, i32 0, metadata !438, null}
!441 = metadata !{i32 387, i32 0, metadata !442, null}
!442 = metadata !{i32 786443, metadata !1, metadata !124, i32 387, i32 0, i32 55} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/dfasearch.c]
!443 = metadata !{i32 402, i32 0, metadata !82, null}
!444 = metadata !{i32 404, i32 0, metadata !82, null}
!445 = metadata !{i32 405, i32 0, metadata !82, null}
!446 = metadata !{i32 407, i32 0, metadata !82, null}
