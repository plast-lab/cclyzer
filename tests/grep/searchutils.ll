; ModuleID = 'searchutils.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.kwset = type opaque
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }

@kwsinit.trans = internal global [256 x i8] zeroinitializer, align 16
@match_icase = external global i32
@mbtolower.out = internal unnamed_addr global i8* null, align 8
@mbtolower.outalloc = internal global i64 0, align 8
@.str = private unnamed_addr constant [4 x i8] c"out\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"searchutils.c\00", align 1
@__PRETTY_FUNCTION__.mbtolower = private unnamed_addr constant [40 x i8] c"char *mbtolower(const char *, size_t *)\00", align 1

; Function Attrs: nounwind uwtable
define void @kwsinit(%struct.kwset** nocapture %kwset) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.kwset** %kwset}, i64 0, metadata !34), !dbg !120
  %1 = load i32* @match_icase, align 4, !dbg !121, !tbaa !122
  %2 = icmp eq i32 %1, 0, !dbg !121
  br i1 %2, label %13, label %3, !dbg !121

; <label>:3                                       ; preds = %0
  %4 = tail call i64 @__ctype_get_mb_cur_max() #7, !dbg !126
  %5 = icmp eq i64 %4, 1, !dbg !126
  br i1 %5, label %tolower.exit, label %13, !dbg !126

tolower.exit:                                     ; preds = %3, %tolower.exit
  %indvars.iv = phi i64 [ %indvars.iv.next, %tolower.exit ], [ 0, %3 ]
  tail call void @llvm.dbg.value(metadata !127, i64 0, metadata !128) #7, !dbg !133
  %6 = tail call i32** @__ctype_tolower_loc() #1, !dbg !134
  %7 = load i32** %6, align 8, !dbg !134, !tbaa !136
  %8 = getelementptr inbounds i32* %7, i64 %indvars.iv, !dbg !134
  %9 = load i32* %8, align 4, !dbg !134, !tbaa !122
  %phitmp = trunc i32 %9 to i8, !dbg !134
  %10 = getelementptr inbounds [256 x i8]* @kwsinit.trans, i64 0, i64 %indvars.iv, !dbg !138
  store i8 %phitmp, i8* %10, align 1, !dbg !138, !tbaa !139
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !140
  %exitcond = icmp eq i64 %indvars.iv.next, 256, !dbg !140
  br i1 %exitcond, label %11, label %tolower.exit, !dbg !140

; <label>:11                                      ; preds = %tolower.exit
  %12 = tail call %struct.kwset* @kwsalloc(i8* getelementptr inbounds ([256 x i8]* @kwsinit.trans, i64 0, i64 0)) #7, !dbg !141
  br label %15, !dbg !142

; <label>:13                                      ; preds = %0, %3
  %14 = tail call %struct.kwset* @kwsalloc(i8* null) #7, !dbg !143
  br label %15

; <label>:15                                      ; preds = %13, %11
  %storemerge = phi %struct.kwset* [ %14, %13 ], [ %12, %11 ]
  store %struct.kwset* %storemerge, %struct.kwset** %kwset, align 8, !dbg !141, !tbaa !136
  %16 = icmp eq %struct.kwset* %storemerge, null, !dbg !144
  br i1 %16, label %17, label %18, !dbg !144

; <label>:17                                      ; preds = %15
  tail call void @xalloc_die() #8, !dbg !146
  unreachable, !dbg !146

; <label>:18                                      ; preds = %15
  ret void, !dbg !147
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare i64 @__ctype_get_mb_cur_max() #2

declare %struct.kwset* @kwsalloc(i8*) #3

; Function Attrs: noreturn
declare void @xalloc_die() #4

; Function Attrs: nounwind uwtable
define i8* @mbtolower(i8* %beg, i64* nocapture %n) #0 {
  %is = alloca i64, align 8, !dbg !148
  %tmpcast = bitcast i64* %is to %struct.__mbstate_t*, !dbg !148
  %os = alloca i64, align 8, !dbg !149
  %tmpcast7 = bitcast i64* %os to %struct.__mbstate_t*, !dbg !149
  %wc = alloca i32, align 4
  call void @llvm.dbg.value(metadata !{i8* %beg}, i64 0, metadata !50), !dbg !150
  call void @llvm.dbg.value(metadata !{i64* %n}, i64 0, metadata !51), !dbg !150
  call void @llvm.dbg.declare(metadata !{%struct.__mbstate_t* %tmpcast}, metadata !54), !dbg !151
  call void @llvm.dbg.declare(metadata !{%struct.__mbstate_t* %tmpcast7}, metadata !70), !dbg !151
  %1 = load i64* %n, align 8, !dbg !152, !tbaa !154
  %2 = load i64* @mbtolower.outalloc, align 8, !dbg !152, !tbaa !154
  %3 = icmp ugt i64 %1, %2, !dbg !152
  %4 = icmp eq i64 %2, 0, !dbg !152
  %or.cond = or i1 %3, %4, !dbg !152
  br i1 %or.cond, label %5, label %thread-pre-split, !dbg !152

; <label>:5                                       ; preds = %0
  %6 = icmp eq i64 %1, 0, !dbg !156
  %. = select i1 %6, i64 1, i64 %1, !dbg !156
  store i64 %., i64* @mbtolower.outalloc, align 8, !dbg !156, !tbaa !154
  %7 = load i8** @mbtolower.out, align 8, !dbg !158, !tbaa !136
  %8 = call i8* @xrealloc(i8* %7, i64 %.) #7, !dbg !158
  store i8* %8, i8** @mbtolower.out, align 8, !dbg !158, !tbaa !136
  br label %9, !dbg !159

thread-pre-split:                                 ; preds = %0
  %.pr = load i8** @mbtolower.out, align 8, !dbg !160, !tbaa !136
  br label %9

; <label>:9                                       ; preds = %thread-pre-split, %5
  %10 = phi i8* [ %.pr, %thread-pre-split ], [ %8, %5 ], !dbg !160
  %11 = icmp eq i8* %10, null, !dbg !160
  br i1 %11, label %12, label %13, !dbg !160

; <label>:12                                      ; preds = %9
  call void @__assert_fail(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 78, i8* getelementptr inbounds ([40 x i8]* @__PRETTY_FUNCTION__.mbtolower, i64 0, i64 0)) #8, !dbg !160
  unreachable, !dbg !160

; <label>:13                                      ; preds = %9
  %14 = load i64* %n, align 8, !dbg !161, !tbaa !154
  %15 = icmp eq i64 %14, 0, !dbg !161
  br i1 %15, label %65, label %16, !dbg !161

; <label>:16                                      ; preds = %13
  store i64 0, i64* %is, align 8, !dbg !148
  store i64 0, i64* %os, align 8, !dbg !149
  %17 = getelementptr inbounds i8* %beg, i64 %14, !dbg !163
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !71), !dbg !163
  %18 = call i64 @__ctype_get_mb_cur_max() #7, !dbg !164
  call void @llvm.dbg.value(metadata !{i64 %18}, i64 0, metadata !53), !dbg !164
  %19 = load i8** @mbtolower.out, align 8, !dbg !165, !tbaa !136
  call void @llvm.dbg.value(metadata !{i8* %19}, i64 0, metadata !72), !dbg !165
  call void @llvm.dbg.value(metadata !166, i64 0, metadata !52), !dbg !167
  %20 = icmp sgt i64 %14, 0, !dbg !168
  br i1 %20, label %.lr.ph, label %59, !dbg !168

.lr.ph:                                           ; preds = %16
  %21 = ptrtoint i8* %17 to i64, !dbg !169
  br label %22, !dbg !168

; <label>:22                                      ; preds = %.lr.ph, %.backedge
  %p.011 = phi i8* [ %19, %.lr.ph ], [ %p.0.be, %.backedge ]
  %.0610 = phi i8* [ %beg, %.lr.ph ], [ %.06.be, %.backedge ]
  %outlen.09 = phi i64 [ 0, %.lr.ph ], [ %outlen.0.be, %.backedge ]
  call void @llvm.dbg.declare(metadata !{i32* %wc}, metadata !73), !dbg !170
  %23 = ptrtoint i8* %.0610 to i64, !dbg !169
  %24 = sub i64 %21, %23, !dbg !169
  %25 = call i64 @mbrtowc(i32* %wc, i8* %.0610, i64 %24, %struct.__mbstate_t* %tmpcast) #7, !dbg !169
  call void @llvm.dbg.value(metadata !{i64 %25}, i64 0, metadata !76), !dbg !169
  %26 = add i64 %outlen.09, %18, !dbg !171
  %27 = load i64* @mbtolower.outalloc, align 8, !dbg !171, !tbaa !154
  %28 = icmp ult i64 %26, %27, !dbg !171
  br i1 %28, label %43, label %29, !dbg !171

; <label>:29                                      ; preds = %22
  %30 = load i8** @mbtolower.out, align 8, !dbg !173, !tbaa !136
  call void @llvm.dbg.value(metadata !175, i64 0, metadata !176) #7, !dbg !177
  call void @llvm.dbg.value(metadata !178, i64 0, metadata !179) #7, !dbg !177
  call void @llvm.dbg.value(metadata !{i64 %27}, i64 0, metadata !180) #7, !dbg !181
  %31 = icmp eq i8* %30, null, !dbg !182
  br i1 %31, label %32, label %34, !dbg !182

; <label>:32                                      ; preds = %29
  %33 = icmp eq i64 %27, 0, !dbg !184
  call void @llvm.dbg.value(metadata !187, i64 0, metadata !180) #7, !dbg !188
  call void @llvm.dbg.value(metadata !187, i64 0, metadata !180) #7, !dbg !190
  %..i = select i1 %33, i64 64, i64 %27, !dbg !184
  br label %x2nrealloc.exit, !dbg !184

; <label>:34                                      ; preds = %29
  %35 = icmp ugt i64 %27, -6148914691236517207, !dbg !191
  br i1 %35, label %36, label %37, !dbg !191

; <label>:36                                      ; preds = %34
  call void @xalloc_die() #8, !dbg !194
  unreachable, !dbg !194

; <label>:37                                      ; preds = %34
  %38 = add i64 %27, 1, !dbg !195
  %39 = lshr i64 %38, 1, !dbg !195
  %40 = add i64 %39, %27, !dbg !195
  call void @llvm.dbg.value(metadata !{i64 %40}, i64 0, metadata !180) #7, !dbg !195
  br label %x2nrealloc.exit

x2nrealloc.exit:                                  ; preds = %32, %37
  %n.0.i = phi i64 [ %40, %37 ], [ %..i, %32 ]
  store i64 %n.0.i, i64* @mbtolower.outalloc, align 8, !dbg !196, !tbaa !154
  %41 = call i8* @xrealloc(i8* %30, i64 %n.0.i) #7, !dbg !197
  store i8* %41, i8** @mbtolower.out, align 8, !dbg !173, !tbaa !136
  %42 = getelementptr inbounds i8* %41, i64 %outlen.09, !dbg !198
  call void @llvm.dbg.value(metadata !{i8* %42}, i64 0, metadata !72), !dbg !198
  br label %43, !dbg !199

; <label>:43                                      ; preds = %22, %x2nrealloc.exit
  %p.1 = phi i8* [ %42, %x2nrealloc.exit ], [ %p.011, %22 ]
  %44 = add i64 %25, -1, !dbg !200
  %45 = icmp ugt i64 %44, -4, !dbg !200
  br i1 %45, label %46, label %51, !dbg !200

; <label>:46                                      ; preds = %43
  %47 = getelementptr inbounds i8* %.0610, i64 1, !dbg !202
  call void @llvm.dbg.value(metadata !{i8* %47}, i64 0, metadata !50), !dbg !202
  %48 = load i8* %.0610, align 1, !dbg !202, !tbaa !139
  %49 = getelementptr inbounds i8* %p.1, i64 1, !dbg !202
  call void @llvm.dbg.value(metadata !{i8* %49}, i64 0, metadata !72), !dbg !202
  store i8 %48, i8* %p.1, align 1, !dbg !202, !tbaa !139
  %50 = add i64 %outlen.09, 1, !dbg !204
  call void @llvm.dbg.value(metadata !{i64 %50}, i64 0, metadata !52), !dbg !204
  store i64 0, i64* %is, align 8, !dbg !205
  store i64 0, i64* %os, align 8, !dbg !206
  br label %.backedge, !dbg !207

; <label>:51                                      ; preds = %43
  %52 = getelementptr inbounds i8* %.0610, i64 %25, !dbg !208
  call void @llvm.dbg.value(metadata !{i8* %52}, i64 0, metadata !50), !dbg !208
  call void @llvm.dbg.value(metadata !{i32* %wc}, i64 0, metadata !73), !dbg !210
  %53 = load i32* %wc, align 4, !dbg !210, !tbaa !122
  %54 = call i32 @towlower(i32 %53) #7, !dbg !210
  %55 = call i64 @wcrtomb(i8* %p.1, i32 %54, %struct.__mbstate_t* %tmpcast7) #7, !dbg !210
  call void @llvm.dbg.value(metadata !{i64 %55}, i64 0, metadata !76), !dbg !210
  %56 = getelementptr inbounds i8* %p.1, i64 %55, !dbg !211
  call void @llvm.dbg.value(metadata !{i8* %56}, i64 0, metadata !72), !dbg !211
  %57 = add i64 %55, %outlen.09, !dbg !212
  call void @llvm.dbg.value(metadata !{i64 %57}, i64 0, metadata !52), !dbg !212
  br label %.backedge

.backedge:                                        ; preds = %51, %46
  %outlen.0.be = phi i64 [ %50, %46 ], [ %57, %51 ]
  %.06.be = phi i8* [ %47, %46 ], [ %52, %51 ]
  %p.0.be = phi i8* [ %49, %46 ], [ %56, %51 ]
  %58 = icmp ult i8* %.06.be, %17, !dbg !168
  br i1 %58, label %22, label %._crit_edge, !dbg !168

._crit_edge:                                      ; preds = %.backedge
  %.pre = load i8** @mbtolower.out, align 8, !dbg !213, !tbaa !136
  br label %59, !dbg !168

; <label>:59                                      ; preds = %._crit_edge, %16
  %60 = phi i8* [ %.pre, %._crit_edge ], [ %19, %16 ]
  %p.0.lcssa = phi i8* [ %p.0.be, %._crit_edge ], [ %19, %16 ]
  %61 = ptrtoint i8* %p.0.lcssa to i64, !dbg !213
  %62 = ptrtoint i8* %60 to i64, !dbg !213
  %63 = sub i64 %61, %62, !dbg !213
  store i64 %63, i64* %n, align 8, !dbg !213, !tbaa !154
  store i8 0, i8* %p.0.lcssa, align 1, !dbg !214, !tbaa !139
  %64 = load i8** @mbtolower.out, align 8, !dbg !215, !tbaa !136
  br label %65, !dbg !215

; <label>:65                                      ; preds = %13, %59
  %.0 = phi i8* [ %64, %59 ], [ %10, %13 ]
  ret i8* %.0, !dbg !216
}

declare i8* @xrealloc(i8*, i64) #3

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #5

; Function Attrs: nounwind
declare i64 @mbrtowc(i32*, i8*, i64, %struct.__mbstate_t*) #2

; Function Attrs: nounwind
declare i64 @wcrtomb(i8*, i32, %struct.__mbstate_t*) #2

; Function Attrs: nounwind
declare i32 @towlower(i32) #2

; Function Attrs: nounwind uwtable
define zeroext i1 @is_mb_middle(i8** nocapture %good, i8* readnone %buf, i8* %end, i64 %match_len) #0 {
  %cur_state = alloca i64, align 8, !dbg !217
  %tmpcast = bitcast i64* %cur_state to %struct.__mbstate_t*, !dbg !217
  call void @llvm.dbg.value(metadata !{i8** %good}, i64 0, metadata !83), !dbg !218
  call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !84), !dbg !218
  call void @llvm.dbg.value(metadata !{i8* %end}, i64 0, metadata !85), !dbg !218
  call void @llvm.dbg.value(metadata !{i64 %match_len}, i64 0, metadata !86), !dbg !219
  %1 = load i8** %good, align 8, !dbg !220, !tbaa !136
  call void @llvm.dbg.value(metadata !{i8* %1}, i64 0, metadata !87), !dbg !220
  call void @llvm.dbg.value(metadata !{i8* %1}, i64 0, metadata !88), !dbg !221
  call void @llvm.dbg.declare(metadata !{%struct.__mbstate_t* %tmpcast}, metadata !89), !dbg !222
  store i64 0, i64* %cur_state, align 8, !dbg !217
  %2 = icmp ult i8* %1, %buf, !dbg !223
  br i1 %2, label %.lr.ph, label %._crit_edge, !dbg !223

.lr.ph:                                           ; preds = %0
  %3 = ptrtoint i8* %end to i64, !dbg !224
  br label %4, !dbg !223

; <label>:4                                       ; preds = %.lr.ph, %12
  %prev.05 = phi i8* [ %1, %.lr.ph ], [ %prev.0.p.0, %12 ]
  %p.04 = phi i8* [ %1, %.lr.ph ], [ %13, %12 ]
  %5 = ptrtoint i8* %p.04 to i64, !dbg !224
  %6 = sub i64 %3, %5, !dbg !224
  call void @llvm.dbg.value(metadata !{i8* %p.0.lcssa}, i64 0, metadata !225) #7, !dbg !226
  call void @llvm.dbg.value(metadata !{i64 %6}, i64 0, metadata !227) #7, !dbg !226
  call void @llvm.dbg.value(metadata !{%struct.__mbstate_t* %tmpcast}, i64 0, metadata !228) #7, !dbg !226
  %7 = call i64 @mbrtowc(i32* null, i8* %p.04, i64 %6, %struct.__mbstate_t* %tmpcast) #7, !dbg !229
  call void @llvm.dbg.value(metadata !{i64 %7}, i64 0, metadata !90), !dbg !224
  %8 = icmp eq i64 %7, -2, !dbg !231
  call void @llvm.dbg.value(metadata !{i8* %p.0.lcssa}, i64 0, metadata !88), !dbg !233
  %prev.0.p.0 = select i1 %8, i8* %prev.05, i8* %p.04, !dbg !231
  %9 = add i64 %7, -1, !dbg !234
  %10 = icmp ugt i64 %9, -4, !dbg !234
  br i1 %10, label %11, label %12, !dbg !234

; <label>:11                                      ; preds = %4
  call void @llvm.dbg.value(metadata !178, i64 0, metadata !90), !dbg !236
  store i64 0, i64* %cur_state, align 8, !dbg !238
  br label %12, !dbg !239

; <label>:12                                      ; preds = %4, %11
  %mbclen.0 = phi i64 [ 1, %11 ], [ %7, %4 ]
  %13 = getelementptr inbounds i8* %p.04, i64 %mbclen.0, !dbg !240
  call void @llvm.dbg.value(metadata !{i8* %13}, i64 0, metadata !87), !dbg !240
  %14 = icmp ult i8* %13, %buf, !dbg !223
  br i1 %14, label %4, label %._crit_edge, !dbg !223

._crit_edge:                                      ; preds = %12, %0
  %prev.0.lcssa = phi i8* [ %1, %0 ], [ %prev.0.p.0, %12 ]
  %p.0.lcssa = phi i8* [ %1, %0 ], [ %13, %12 ]
  store i8* %prev.0.lcssa, i8** %good, align 8, !dbg !241, !tbaa !136
  %15 = icmp ugt i8* %p.0.lcssa, %buf, !dbg !242
  br i1 %15, label %24, label %16, !dbg !242

; <label>:16                                      ; preds = %._crit_edge
  %17 = icmp eq i64 %match_len, 0, !dbg !244
  br i1 %17, label %24, label %18, !dbg !244

; <label>:18                                      ; preds = %16
  %19 = ptrtoint i8* %end to i64, !dbg !245
  %20 = ptrtoint i8* %p.0.lcssa to i64, !dbg !245
  %21 = sub i64 %19, %20, !dbg !245
  call void @llvm.dbg.value(metadata !{i8* %p.0.lcssa}, i64 0, metadata !246) #7, !dbg !247
  call void @llvm.dbg.value(metadata !{i64 %21}, i64 0, metadata !248) #7, !dbg !247
  call void @llvm.dbg.value(metadata !{%struct.__mbstate_t* %tmpcast}, i64 0, metadata !249) #7, !dbg !247
  %22 = call i64 @mbrtowc(i32* null, i8* %p.0.lcssa, i64 %21, %struct.__mbstate_t* %tmpcast) #7, !dbg !250
  %23 = icmp ugt i64 %22, %match_len, !dbg !245
  br label %24

; <label>:24                                      ; preds = %18, %16, %._crit_edge
  %.0 = phi i1 [ true, %._crit_edge ], [ false, %16 ], [ %23, %18 ]
  ret i1 %.0, !dbg !251
}

; Function Attrs: nounwind readnone
declare i32** @__ctype_tolower_loc() #6

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!117, !118}
!llvm.ident = !{!119}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !22, metadata !23, metadata !110, metadata !22, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c] [DW_LANG_C99]
!1 = metadata !{metadata !"searchutils.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 786436, metadata !4, metadata !5, metadata !"", i32 208, i64 32, i64 32, i32 0, i32 0, null, metadata !20, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 208, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"../lib/xalloc.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!5 = metadata !{i32 786478, metadata !4, metadata !6, metadata !"x2nrealloc", metadata !"x2nrealloc", metadata !"", i32 196, metadata !7, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !14, i32 197} ; [ DW_TAG_subprogram ] [line 196] [local] [def] [scope 197] [x2nrealloc]
!6 = metadata !{i32 786473, metadata !4}          ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!7 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !9, metadata !10, metadata !11}
!9 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!10 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!11 = metadata !{i32 786454, metadata !12, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!12 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!13 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!14 = metadata !{metadata !15, metadata !16, metadata !17, metadata !18}
!15 = metadata !{i32 786689, metadata !5, metadata !"p", metadata !6, i32 16777412, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [p] [line 196]
!16 = metadata !{i32 786689, metadata !5, metadata !"pn", metadata !6, i32 33554628, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pn] [line 196]
!17 = metadata !{i32 786689, metadata !5, metadata !"s", metadata !6, i32 50331844, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 196]
!18 = metadata !{i32 786688, metadata !19, metadata !"n", metadata !6, i32 198, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 198]
!19 = metadata !{i32 786443, metadata !4, metadata !5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!20 = metadata !{metadata !21}
!21 = metadata !{i32 786472, metadata !"DEFAULT_MXFAST", i64 64} ; [ DW_TAG_enumerator ] [DEFAULT_MXFAST :: 64]
!22 = metadata !{i32 0}
!23 = metadata !{metadata !24, metadata !42, metadata !77, metadata !92, metadata !5, metadata !103}
!24 = metadata !{i32 786478, metadata !1, metadata !25, metadata !"kwsinit", metadata !"kwsinit", metadata !"", i32 26, metadata !26, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.kwset**)* @kwsinit, null, null, metadata !33, i32 27} ; [ DW_TAG_subprogram ] [line 26] [def] [scope 27] [kwsinit]
!25 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!26 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !27, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!27 = metadata !{null, metadata !28}
!28 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !29} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwset_t]
!29 = metadata !{i32 786454, metadata !30, null, metadata !"kwset_t", i32 34, i64 0, i64 0, i64 0, i32 0, metadata !31} ; [ DW_TAG_typedef ] [kwset_t] [line 34, size 0, align 0, offset 0] [from ]
!30 = metadata !{metadata !"./kwset.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!31 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !32} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwset]
!32 = metadata !{i32 786451, metadata !30, null, metadata !"kwset", i32 33, i64 0, i64 0, i32 0, i32 4, null, null, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwset] [line 33, size 0, align 0, offset 0] [decl] [from ]
!33 = metadata !{metadata !34, metadata !35, metadata !37}
!34 = metadata !{i32 786689, metadata !24, metadata !"kwset", metadata !25, i32 16777242, metadata !28, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kwset] [line 26]
!35 = metadata !{i32 786688, metadata !24, metadata !"i", metadata !25, i32 29, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 29]
!36 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!37 = metadata !{i32 786688, metadata !38, metadata !"__res", metadata !25, i32 38, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__res] [line 38]
!38 = metadata !{i32 786443, metadata !1, metadata !39, i32 38, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!39 = metadata !{i32 786443, metadata !1, metadata !40, i32 37, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!40 = metadata !{i32 786443, metadata !1, metadata !41, i32 36, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!41 = metadata !{i32 786443, metadata !1, metadata !24, i32 31, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!42 = metadata !{i32 786478, metadata !1, metadata !25, metadata !"mbtolower", metadata !"mbtolower", metadata !"", i32 62, metadata !43, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i64*)* @mbtolower, null, null, metadata !49, i32 63} ; [ DW_TAG_subprogram ] [line 62] [def] [scope 63] [mbtolower]
!43 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !44, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!44 = metadata !{metadata !45, metadata !47, metadata !10}
!45 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !46} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!46 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!47 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !48} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!48 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !46} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!49 = metadata !{metadata !50, metadata !51, metadata !52, metadata !53, metadata !54, metadata !70, metadata !71, metadata !72, metadata !73, metadata !76}
!50 = metadata !{i32 786689, metadata !42, metadata !"beg", metadata !25, i32 16777278, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beg] [line 62]
!51 = metadata !{i32 786689, metadata !42, metadata !"n", metadata !25, i32 33554494, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 62]
!52 = metadata !{i32 786688, metadata !42, metadata !"outlen", metadata !25, i32 66, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [outlen] [line 66]
!53 = metadata !{i32 786688, metadata !42, metadata !"mb_cur_max", metadata !25, i32 66, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mb_cur_max] [line 66]
!54 = metadata !{i32 786688, metadata !42, metadata !"is", metadata !25, i32 67, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [is] [line 67]
!55 = metadata !{i32 786454, metadata !56, null, metadata !"mbstate_t", i32 106, i64 0, i64 0, i64 0, i32 0, metadata !57} ; [ DW_TAG_typedef ] [mbstate_t] [line 106, size 0, align 0, offset 0] [from __mbstate_t]
!56 = metadata !{metadata !"/usr/include/wchar.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!57 = metadata !{i32 786454, metadata !56, null, metadata !"__mbstate_t", i32 95, i64 0, i64 0, i64 0, i32 0, metadata !58} ; [ DW_TAG_typedef ] [__mbstate_t] [line 95, size 0, align 0, offset 0] [from ]
!58 = metadata !{i32 786451, metadata !56, null, metadata !"", i32 83, i64 64, i64 32, i32 0, i32 0, null, metadata !59, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 83, size 64, align 32, offset 0] [def] [from ]
!59 = metadata !{metadata !60, metadata !61}
!60 = metadata !{i32 786445, metadata !56, metadata !58, metadata !"__count", i32 85, i64 32, i64 32, i64 0, i32 0, metadata !36} ; [ DW_TAG_member ] [__count] [line 85, size 32, align 32, offset 0] [from int]
!61 = metadata !{i32 786445, metadata !56, metadata !58, metadata !"__value", i32 94, i64 32, i64 32, i64 32, i32 0, metadata !62} ; [ DW_TAG_member ] [__value] [line 94, size 32, align 32, offset 32] [from ]
!62 = metadata !{i32 786455, metadata !56, metadata !58, metadata !"", i32 86, i64 32, i64 32, i64 0, i32 0, null, metadata !63, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 86, size 32, align 32, offset 0] [def] [from ]
!63 = metadata !{metadata !64, metadata !66}
!64 = metadata !{i32 786445, metadata !56, metadata !62, metadata !"__wch", i32 89, i64 32, i64 32, i64 0, i32 0, metadata !65} ; [ DW_TAG_member ] [__wch] [line 89, size 32, align 32, offset 0] [from unsigned int]
!65 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!66 = metadata !{i32 786445, metadata !56, metadata !62, metadata !"__wchb", i32 93, i64 32, i64 8, i64 0, i32 0, metadata !67} ; [ DW_TAG_member ] [__wchb] [line 93, size 32, align 8, offset 0] [from ]
!67 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32, i64 8, i32 0, i32 0, metadata !46, metadata !68, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from char]
!68 = metadata !{metadata !69}
!69 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 3]
!70 = metadata !{i32 786688, metadata !42, metadata !"os", metadata !25, i32 67, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os] [line 67]
!71 = metadata !{i32 786688, metadata !42, metadata !"end", metadata !25, i32 68, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 68]
!72 = metadata !{i32 786688, metadata !42, metadata !"p", metadata !25, i32 69, metadata !45, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 69]
!73 = metadata !{i32 786688, metadata !74, metadata !"wc", metadata !25, i32 91, metadata !75, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wc] [line 91]
!74 = metadata !{i32 786443, metadata !1, metadata !42, i32 90, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!75 = metadata !{i32 786454, metadata !12, null, metadata !"wchar_t", i32 65, i64 0, i64 0, i64 0, i32 0, metadata !36} ; [ DW_TAG_typedef ] [wchar_t] [line 65, size 0, align 0, offset 0] [from int]
!76 = metadata !{i32 786688, metadata !74, metadata !"mbclen", metadata !25, i32 92, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mbclen] [line 92]
!77 = metadata !{i32 786478, metadata !1, metadata !25, metadata !"is_mb_middle", metadata !"is_mb_middle", metadata !"", i32 124, metadata !78, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i1 (i8**, i8*, i8*, i64)* @is_mb_middle, null, null, metadata !82, i32 126} ; [ DW_TAG_subprogram ] [line 124] [def] [scope 126] [is_mb_middle]
!78 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !79, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!79 = metadata !{metadata !80, metadata !81, metadata !47, metadata !47, metadata !11}
!80 = metadata !{i32 786468, null, null, metadata !"_Bool", i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [_Bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!81 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !47} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!82 = metadata !{metadata !83, metadata !84, metadata !85, metadata !86, metadata !87, metadata !88, metadata !89, metadata !90}
!83 = metadata !{i32 786689, metadata !77, metadata !"good", metadata !25, i32 16777340, metadata !81, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [good] [line 124]
!84 = metadata !{i32 786689, metadata !77, metadata !"buf", metadata !25, i32 33554556, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 124]
!85 = metadata !{i32 786689, metadata !77, metadata !"end", metadata !25, i32 50331772, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 124]
!86 = metadata !{i32 786689, metadata !77, metadata !"match_len", metadata !25, i32 67108989, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_len] [line 125]
!87 = metadata !{i32 786688, metadata !77, metadata !"p", metadata !25, i32 127, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 127]
!88 = metadata !{i32 786688, metadata !77, metadata !"prev", metadata !25, i32 128, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [prev] [line 128]
!89 = metadata !{i32 786688, metadata !77, metadata !"cur_state", metadata !25, i32 129, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cur_state] [line 129]
!90 = metadata !{i32 786688, metadata !91, metadata !"mbclen", metadata !25, i32 135, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mbclen] [line 135]
!91 = metadata !{i32 786443, metadata !1, metadata !77, i32 134, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!92 = metadata !{i32 786478, metadata !56, metadata !93, metadata !"mbrlen", metadata !"mbrlen", metadata !"", i32 396, metadata !94, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !99, i32 398} ; [ DW_TAG_subprogram ] [line 396] [def] [scope 398] [mbrlen]
!93 = metadata !{i32 786473, metadata !56}        ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/wchar.h]
!94 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !95, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!95 = metadata !{metadata !11, metadata !96, metadata !11, metadata !97}
!96 = metadata !{i32 786487, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !47} ; [ DW_TAG_restrict_type ] [line 0, size 0, align 0, offset 0] [from ]
!97 = metadata !{i32 786487, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !98} ; [ DW_TAG_restrict_type ] [line 0, size 0, align 0, offset 0] [from ]
!98 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !55} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from mbstate_t]
!99 = metadata !{metadata !100, metadata !101, metadata !102}
!100 = metadata !{i32 786689, metadata !92, metadata !"__s", metadata !93, i32 16777612, metadata !96, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__s] [line 396]
!101 = metadata !{i32 786689, metadata !92, metadata !"__n", metadata !93, i32 33554828, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__n] [line 396]
!102 = metadata !{i32 786689, metadata !92, metadata !"__ps", metadata !93, i32 50332044, metadata !97, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__ps] [line 396]
!103 = metadata !{i32 786478, metadata !104, metadata !105, metadata !"tolower", metadata !"tolower", metadata !"", i32 217, metadata !106, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !108, i32 218} ; [ DW_TAG_subprogram ] [line 217] [def] [scope 218] [tolower]
!104 = metadata !{metadata !"/usr/include/ctype.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!105 = metadata !{i32 786473, metadata !104}      ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/ctype.h]
!106 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !107, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!107 = metadata !{metadata !36, metadata !36}
!108 = metadata !{metadata !109}
!109 = metadata !{i32 786689, metadata !103, metadata !"__c", metadata !105, i32 16777433, metadata !36, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__c] [line 217]
!110 = metadata !{metadata !111, metadata !115, metadata !116}
!111 = metadata !{i32 786484, i32 0, metadata !24, metadata !"trans", metadata !"trans", metadata !"", metadata !25, i32 28, metadata !112, i32 1, i32 1, [256 x i8]* @kwsinit.trans, null} ; [ DW_TAG_variable ] [trans] [line 28] [local] [def]
!112 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2048, i64 8, i32 0, i32 0, metadata !46, metadata !113, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2048, align 8, offset 0] [from char]
!113 = metadata !{metadata !114}
!114 = metadata !{i32 786465, i64 0, i64 256}     ; [ DW_TAG_subrange_type ] [0, 255]
!115 = metadata !{i32 786484, i32 0, metadata !42, metadata !"out", metadata !"out", metadata !"", metadata !25, i32 64, metadata !45, i32 1, i32 1, i8** @mbtolower.out, null} ; [ DW_TAG_variable ] [out] [line 64] [local] [def]
!116 = metadata !{i32 786484, i32 0, metadata !42, metadata !"outalloc", metadata !"outalloc", metadata !"", metadata !25, i32 65, metadata !11, i32 1, i32 1, i64* @mbtolower.outalloc, null} ; [ DW_TAG_variable ] [outalloc] [line 65] [local] [def]
!117 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!118 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!119 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!120 = metadata !{i32 26, i32 0, metadata !24, null}
!121 = metadata !{i32 31, i32 0, metadata !41, null}
!122 = metadata !{metadata !123, metadata !123, i64 0}
!123 = metadata !{metadata !"int", metadata !124, i64 0}
!124 = metadata !{metadata !"omnipotent char", metadata !125, i64 0}
!125 = metadata !{metadata !"Simple C/C++ TBAA"}
!126 = metadata !{i32 33, i32 0, metadata !41, null}
!127 = metadata !{i32 undef}
!128 = metadata !{i32 786689, metadata !103, metadata !"__c", metadata !105, i32 16777433, metadata !36, i32 0, metadata !129} ; [ DW_TAG_arg_variable ] [__c] [line 217]
!129 = metadata !{i32 38, i32 0, metadata !130, null}
!130 = metadata !{i32 786443, metadata !1, metadata !131, i32 38, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!131 = metadata !{i32 786443, metadata !1, metadata !132, i32 38, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!132 = metadata !{i32 786443, metadata !1, metadata !38, i32 38, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!133 = metadata !{i32 217, i32 0, metadata !103, metadata !129}
!134 = metadata !{i32 219, i32 0, metadata !135, metadata !129}
!135 = metadata !{i32 786443, metadata !104, metadata !103} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/ctype.h]
!136 = metadata !{metadata !137, metadata !137, i64 0}
!137 = metadata !{metadata !"any pointer", metadata !124, i64 0}
!138 = metadata !{i32 38, i32 0, metadata !38, null}
!139 = metadata !{metadata !124, metadata !124, i64 0}
!140 = metadata !{i32 37, i32 0, metadata !39, null}
!141 = metadata !{i32 40, i32 0, metadata !40, null}
!142 = metadata !{i32 41, i32 0, metadata !40, null}
!143 = metadata !{i32 43, i32 0, metadata !41, null}
!144 = metadata !{i32 45, i32 0, metadata !145, null}
!145 = metadata !{i32 786443, metadata !1, metadata !24, i32 45, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!146 = metadata !{i32 46, i32 0, metadata !145, null}
!147 = metadata !{i32 47, i32 0, metadata !24, null}
!148 = metadata !{i32 82, i32 0, metadata !42, null}
!149 = metadata !{i32 83, i32 0, metadata !42, null}
!150 = metadata !{i32 62, i32 0, metadata !42, null}
!151 = metadata !{i32 67, i32 0, metadata !42, null}
!152 = metadata !{i32 71, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !1, metadata !42, i32 71, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!154 = metadata !{metadata !155, metadata !155, i64 0}
!155 = metadata !{metadata !"long", metadata !124, i64 0}
!156 = metadata !{i32 73, i32 0, metadata !157, null}
!157 = metadata !{i32 786443, metadata !1, metadata !153, i32 72, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!158 = metadata !{i32 74, i32 0, metadata !157, null}
!159 = metadata !{i32 75, i32 0, metadata !157, null}
!160 = metadata !{i32 78, i32 0, metadata !42, null}
!161 = metadata !{i32 79, i32 0, metadata !162, null}
!162 = metadata !{i32 786443, metadata !1, metadata !42, i32 79, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!163 = metadata !{i32 84, i32 0, metadata !42, null}
!164 = metadata !{i32 86, i32 0, metadata !42, null}
!165 = metadata !{i32 87, i32 0, metadata !42, null}
!166 = metadata !{i64 0}
!167 = metadata !{i32 88, i32 0, metadata !42, null}
!168 = metadata !{i32 89, i32 0, metadata !42, null}
!169 = metadata !{i32 92, i32 0, metadata !74, null}
!170 = metadata !{i32 91, i32 0, metadata !74, null}
!171 = metadata !{i32 93, i32 0, metadata !172, null}
!172 = metadata !{i32 786443, metadata !1, metadata !74, i32 93, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!173 = metadata !{i32 95, i32 17, metadata !174, null}
!174 = metadata !{i32 786443, metadata !1, metadata !172, i32 94, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!175 = metadata !{i64* @mbtolower.outalloc}
!176 = metadata !{i32 786689, metadata !5, metadata !"pn", metadata !6, i32 33554628, metadata !10, i32 0, metadata !173} ; [ DW_TAG_arg_variable ] [pn] [line 196]
!177 = metadata !{i32 196, i32 0, metadata !5, metadata !173}
!178 = metadata !{i64 1}
!179 = metadata !{i32 786689, metadata !5, metadata !"s", metadata !6, i32 50331844, metadata !11, i32 0, metadata !173} ; [ DW_TAG_arg_variable ] [s] [line 196]
!180 = metadata !{i32 786688, metadata !19, metadata !"n", metadata !6, i32 198, metadata !11, i32 0, metadata !173} ; [ DW_TAG_auto_variable ] [n] [line 198]
!181 = metadata !{i32 198, i32 0, metadata !19, metadata !173}
!182 = metadata !{i32 200, i32 0, metadata !183, metadata !173}
!183 = metadata !{i32 786443, metadata !4, metadata !19, i32 200, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!184 = metadata !{i32 202, i32 0, metadata !185, metadata !173}
!185 = metadata !{i32 786443, metadata !4, metadata !186, i32 202, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!186 = metadata !{i32 786443, metadata !4, metadata !183, i32 201, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!187 = metadata !{i64 64}
!188 = metadata !{i32 210, i32 0, metadata !189, metadata !173}
!189 = metadata !{i32 786443, metadata !4, metadata !185, i32 203, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!190 = metadata !{i32 211, i32 0, metadata !189, metadata !173}
!191 = metadata !{i32 220, i32 0, metadata !192, metadata !173}
!192 = metadata !{i32 786443, metadata !4, metadata !193, i32 220, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!193 = metadata !{i32 786443, metadata !4, metadata !183, i32 215, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/../lib/xalloc.h]
!194 = metadata !{i32 221, i32 0, metadata !192, metadata !173}
!195 = metadata !{i32 222, i32 0, metadata !193, metadata !173}
!196 = metadata !{i32 225, i32 0, metadata !19, metadata !173}
!197 = metadata !{i32 226, i32 0, metadata !19, metadata !173}
!198 = metadata !{i32 96, i32 0, metadata !174, null}
!199 = metadata !{i32 97, i32 0, metadata !174, null}
!200 = metadata !{i32 99, i32 0, metadata !201, null}
!201 = metadata !{i32 786443, metadata !1, metadata !74, i32 99, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!202 = metadata !{i32 103, i32 0, metadata !203, null}
!203 = metadata !{i32 786443, metadata !1, metadata !201, i32 100, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!204 = metadata !{i32 104, i32 0, metadata !203, null}
!205 = metadata !{i32 105, i32 0, metadata !203, null}
!206 = metadata !{i32 106, i32 0, metadata !203, null}
!207 = metadata !{i32 107, i32 0, metadata !203, null}
!208 = metadata !{i32 110, i32 0, metadata !209, null}
!209 = metadata !{i32 786443, metadata !1, metadata !201, i32 109, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!210 = metadata !{i32 111, i32 0, metadata !209, null}
!211 = metadata !{i32 112, i32 0, metadata !209, null}
!212 = metadata !{i32 113, i32 0, metadata !209, null}
!213 = metadata !{i32 117, i32 0, metadata !42, null}
!214 = metadata !{i32 118, i32 0, metadata !42, null}
!215 = metadata !{i32 119, i32 0, metadata !42, null}
!216 = metadata !{i32 120, i32 0, metadata !42, null}
!217 = metadata !{i32 132, i32 0, metadata !77, null}
!218 = metadata !{i32 124, i32 0, metadata !77, null}
!219 = metadata !{i32 125, i32 0, metadata !77, null}
!220 = metadata !{i32 127, i32 0, metadata !77, null}
!221 = metadata !{i32 128, i32 0, metadata !77, null}
!222 = metadata !{i32 129, i32 0, metadata !77, null}
!223 = metadata !{i32 133, i32 0, metadata !77, null}
!224 = metadata !{i32 135, i32 23, metadata !91, null}
!225 = metadata !{i32 786689, metadata !92, metadata !"__s", metadata !93, i32 16777612, metadata !96, i32 0, metadata !224} ; [ DW_TAG_arg_variable ] [__s] [line 396]
!226 = metadata !{i32 396, i32 0, metadata !92, metadata !224}
!227 = metadata !{i32 786689, metadata !92, metadata !"__n", metadata !93, i32 33554828, metadata !11, i32 0, metadata !224} ; [ DW_TAG_arg_variable ] [__n] [line 396]
!228 = metadata !{i32 786689, metadata !92, metadata !"__ps", metadata !93, i32 50332044, metadata !97, i32 0, metadata !224} ; [ DW_TAG_arg_variable ] [__ps] [line 396]
!229 = metadata !{i32 399, i32 0, metadata !230, metadata !224}
!230 = metadata !{i32 786443, metadata !56, metadata !92} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/wchar.h]
!231 = metadata !{i32 138, i32 0, metadata !232, null}
!232 = metadata !{i32 786443, metadata !1, metadata !91, i32 138, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!233 = metadata !{i32 139, i32 0, metadata !232, null}
!234 = metadata !{i32 141, i32 0, metadata !235, null}
!235 = metadata !{i32 786443, metadata !1, metadata !91, i32 141, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!236 = metadata !{i32 145, i32 0, metadata !237, null}
!237 = metadata !{i32 786443, metadata !1, metadata !235, i32 142, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!238 = metadata !{i32 146, i32 0, metadata !237, null}
!239 = metadata !{i32 147, i32 0, metadata !237, null}
!240 = metadata !{i32 148, i32 0, metadata !91, null}
!241 = metadata !{i32 151, i32 0, metadata !77, null}
!242 = metadata !{i32 153, i32 0, metadata !243, null}
!243 = metadata !{i32 786443, metadata !1, metadata !77, i32 153, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/searchutils.c]
!244 = metadata !{i32 157, i32 0, metadata !77, null}
!245 = metadata !{i32 157, i32 39, metadata !77, null}
!246 = metadata !{i32 786689, metadata !92, metadata !"__s", metadata !93, i32 16777612, metadata !96, i32 0, metadata !245} ; [ DW_TAG_arg_variable ] [__s] [line 396]
!247 = metadata !{i32 396, i32 0, metadata !92, metadata !245}
!248 = metadata !{i32 786689, metadata !92, metadata !"__n", metadata !93, i32 33554828, metadata !11, i32 0, metadata !245} ; [ DW_TAG_arg_variable ] [__n] [line 396]
!249 = metadata !{i32 786689, metadata !92, metadata !"__ps", metadata !93, i32 50332044, metadata !97, i32 0, metadata !245} ; [ DW_TAG_arg_variable ] [__ps] [line 396]
!250 = metadata !{i32 399, i32 0, metadata !230, metadata !245}
!251 = metadata !{i32 158, i32 0, metadata !77, null}
