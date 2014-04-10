; ModuleID = 'kwset.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.kwset = type { %struct.obstack, i32, %struct.trie*, i32, i32, [256 x i8], [256 x %struct.trie*], i8*, i32, i8* }
%struct.obstack = type { i64, %struct._obstack_chunk*, i8*, i8*, i8*, %union.anon, i32, %struct._obstack_chunk* (i8*, i64)*, void (i8*, %struct._obstack_chunk*)*, i8*, i8 }
%struct._obstack_chunk = type { i8*, %struct._obstack_chunk*, [4 x i8] }
%union.anon = type { i64 }
%struct.trie = type { i32, %struct.tree*, %struct.trie*, %struct.trie*, %struct.trie*, i32, i32, i32 }
%struct.tree = type { %struct.tree*, %struct.tree*, %struct.trie*, i8, i8 }
%struct.kwsmatch = type { i32, [1 x i64], [1 x i64] }

@.str = private unnamed_addr constant [17 x i8] c"memory exhausted\00", align 1

; Function Attrs: nounwind uwtable
define %struct.kwset* @kwsalloc(i8* %trans) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %trans}, i64 0, metadata !163), !dbg !314
  %1 = tail call noalias i8* @xmalloc(i64 2440) #4, !dbg !315
  %2 = bitcast i8* %1 to %struct.kwset*, !dbg !315
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %2}, i64 0, metadata !164), !dbg !315
  %3 = icmp eq i8* %1, null, !dbg !316
  br i1 %3, label %71, label %4, !dbg !316

; <label>:4                                       ; preds = %0
  %5 = bitcast i8* %1 to %struct.obstack*, !dbg !318
  %6 = tail call i32 @_obstack_begin(%struct.obstack* %5, i32 0, i32 0, i8* (i64)* @xmalloc, void (i8*)* @free) #4, !dbg !318
  %7 = getelementptr inbounds i8* %1, i64 88, !dbg !319
  %8 = bitcast i8* %7 to i32*, !dbg !319
  store i32 0, i32* %8, align 4, !dbg !319, !tbaa !320
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %5}, i64 0, metadata !165), !dbg !328
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %5}, i64 0, metadata !167), !dbg !329
  tail call void @llvm.dbg.value(metadata !330, i64 0, metadata !169), !dbg !329
  %9 = getelementptr inbounds i8* %1, i64 32, !dbg !331
  %10 = bitcast i8* %9 to i8**, !dbg !331
  %11 = load i8** %10, align 8, !dbg !331, !tbaa !333
  %12 = getelementptr inbounds i8* %1, i64 24, !dbg !331
  %13 = bitcast i8* %12 to i8**, !dbg !331
  %14 = load i8** %13, align 8, !dbg !331, !tbaa !334
  %15 = ptrtoint i8* %11 to i64, !dbg !331
  %16 = ptrtoint i8* %14 to i64, !dbg !331
  %17 = sub i64 %15, %16, !dbg !331
  %18 = icmp slt i64 %17, 56, !dbg !331
  br i1 %18, label %19, label %20, !dbg !331

; <label>:19                                      ; preds = %4
  tail call void @_obstack_newchunk(%struct.obstack* %5, i32 56) #4, !dbg !331
  %.pre = load i8** %13, align 8, !dbg !329, !tbaa !334
  br label %20, !dbg !331

; <label>:20                                      ; preds = %19, %4
  %21 = phi i8* [ %.pre, %19 ], [ %14, %4 ]
  %22 = getelementptr inbounds i8* %21, i64 56, !dbg !329
  store i8* %22, i8** %13, align 8, !dbg !329, !tbaa !334
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %5}, i64 0, metadata !170), !dbg !335
  %23 = getelementptr inbounds i8* %1, i64 16, !dbg !335
  %24 = bitcast i8* %23 to i8**, !dbg !335
  %25 = load i8** %24, align 8, !dbg !335, !tbaa !336
  tail call void @llvm.dbg.value(metadata !{i8* %25}, i64 0, metadata !172), !dbg !335
  %26 = icmp eq i8* %22, %25, !dbg !337
  br i1 %26, label %27, label %31, !dbg !337

; <label>:27                                      ; preds = %20
  %28 = getelementptr inbounds i8* %1, i64 80, !dbg !337
  %29 = load i8* %28, align 8, !dbg !337
  %30 = or i8 %29, 2, !dbg !337
  store i8 %30, i8* %28, align 8, !dbg !337
  br label %31, !dbg !337

; <label>:31                                      ; preds = %27, %20
  %32 = ptrtoint i8* %22 to i64, !dbg !335
  %33 = getelementptr inbounds i8* %1, i64 48, !dbg !335
  %34 = bitcast i8* %33 to i32*, !dbg !335
  %35 = load i32* %34, align 4, !dbg !335, !tbaa !339
  %36 = sext i32 %35 to i64, !dbg !335
  %37 = add nsw i64 %36, %32, !dbg !335
  %38 = xor i32 %35, -1, !dbg !335
  %39 = sext i32 %38 to i64, !dbg !335
  %40 = and i64 %37, %39, !dbg !335
  %41 = getelementptr inbounds i8* null, i64 %40, !dbg !335
  store i8* %41, i8** %13, align 8, !dbg !335, !tbaa !334
  %42 = getelementptr inbounds i8* %1, i64 8, !dbg !340
  %43 = bitcast i8* %42 to %struct._obstack_chunk**, !dbg !340
  %44 = load %struct._obstack_chunk** %43, align 8, !dbg !340, !tbaa !342
  %45 = ptrtoint i8* %41 to i64, !dbg !340
  %46 = ptrtoint %struct._obstack_chunk* %44 to i64, !dbg !340
  %47 = sub i64 %45, %46, !dbg !340
  %48 = load i8** %10, align 8, !dbg !340, !tbaa !333
  %49 = ptrtoint i8* %48 to i64, !dbg !340
  %50 = sub i64 %49, %46, !dbg !340
  %51 = icmp sgt i64 %47, %50, !dbg !340
  br i1 %51, label %52, label %53, !dbg !340

; <label>:52                                      ; preds = %31
  store i8* %48, i8** %13, align 8, !dbg !340, !tbaa !334
  br label %53, !dbg !340

; <label>:53                                      ; preds = %52, %31
  %54 = phi i8* [ %48, %52 ], [ %41, %31 ]
  store i8* %54, i8** %24, align 8, !dbg !335, !tbaa !336
  %55 = bitcast i8* %25 to %struct.trie*, !dbg !328
  %56 = getelementptr inbounds i8* %1, i64 96, !dbg !328
  %57 = bitcast i8* %56 to %struct.trie**, !dbg !328
  store %struct.trie* %55, %struct.trie** %57, align 8, !dbg !328, !tbaa !343
  %58 = icmp eq i8* %25, null, !dbg !344
  br i1 %58, label %59, label %60, !dbg !344

; <label>:59                                      ; preds = %53
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %2}, i64 0, metadata !346) #4, !dbg !349
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %2}, i64 0, metadata !350) #4, !dbg !351
  tail call void @llvm.dbg.value(metadata !352, i64 0, metadata !353) #4, !dbg !354
  tail call void @obstack_free(%struct.obstack* %5, i8* null) #4, !dbg !355
  tail call void @free(i8* %1) #4, !dbg !357
  br label %71, !dbg !358

; <label>:60                                      ; preds = %53
  %61 = bitcast i8* %25 to i32*, !dbg !359
  store i32 0, i32* %61, align 4, !dbg !359, !tbaa !360
  %62 = getelementptr inbounds i8* %25, i64 8, !dbg !362
  %63 = getelementptr inbounds i8* %1, i64 104, !dbg !363
  %64 = bitcast i8* %63 to i32*, !dbg !363
  call void @llvm.memset.p0i8.i64(i8* %62, i8 0, i64 40, i32 8, i1 false), !dbg !362
  store i32 2147483647, i32* %64, align 4, !dbg !363, !tbaa !364
  %65 = getelementptr inbounds i8* %1, i64 108, !dbg !365
  %66 = bitcast i8* %65 to i32*, !dbg !365
  store i32 -1, i32* %66, align 4, !dbg !365, !tbaa !366
  %67 = getelementptr inbounds i8* %1, i64 2416, !dbg !367
  %68 = bitcast i8* %67 to i8**, !dbg !367
  store i8* null, i8** %68, align 8, !dbg !367, !tbaa !368
  %69 = getelementptr inbounds i8* %1, i64 2432, !dbg !369
  %70 = bitcast i8* %69 to i8**, !dbg !369
  store i8* %trans, i8** %70, align 8, !dbg !369, !tbaa !370
  br label %71, !dbg !371

; <label>:71                                      ; preds = %0, %60, %59
  %.0 = phi %struct.kwset* [ %2, %60 ], [ null, %59 ], [ null, %0 ]
  ret %struct.kwset* %.0, !dbg !372
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare noalias i8* @xmalloc(i64) #2

declare i32 @_obstack_begin(%struct.obstack*, i32, i32, i8* (i64)*, void (i8*)*) #2

; Function Attrs: nounwind
declare void @free(i8* nocapture) #3

declare void @_obstack_newchunk(%struct.obstack*, i32) #2

; Function Attrs: nounwind uwtable
define void @kwsfree(%struct.kwset* %kws) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !225), !dbg !373
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !226), !dbg !374
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %1}, i64 0, metadata !227), !dbg !375
  tail call void @llvm.dbg.value(metadata !352, i64 0, metadata !229), !dbg !375
  %1 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, !dbg !375
  tail call void @obstack_free(%struct.obstack* %1, i8* null) #4, !dbg !376
  %2 = bitcast %struct.kwset* %kws to i8*, !dbg !377
  tail call void @free(i8* %2) #4, !dbg !377
  ret void, !dbg !378
}

; Function Attrs: nounwind uwtable
define i8* @kwsincr(%struct.kwset* %kws, i8* nocapture readonly %text, i64 %len) #0 {
  %links = alloca [12 x %struct.tree*], align 16
  %dirs = alloca [12 x i32], align 16
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !94), !dbg !379
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !95), !dbg !379
  tail call void @llvm.dbg.value(metadata !{i64 %len}, i64 0, metadata !96), !dbg !379
  %1 = bitcast [12 x %struct.tree*]* %links to i8*, !dbg !380
  call void @llvm.lifetime.start(i64 96, i8* %1) #4, !dbg !380
  tail call void @llvm.dbg.declare(metadata !{[12 x %struct.tree*]* %links}, metadata !102), !dbg !380
  %2 = bitcast [12 x i32]* %dirs to i8*, !dbg !381
  call void @llvm.lifetime.start(i64 48, i8* %2) #4, !dbg !381
  tail call void @llvm.dbg.declare(metadata !{[12 x i32]* %dirs}, metadata !106), !dbg !381
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !97), !dbg !382
  %3 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 2, !dbg !383
  tail call void @llvm.dbg.value(metadata !{i8* %5}, i64 0, metadata !95), !dbg !384
  %trie.063 = load %struct.trie** %3, align 8, !dbg !383
  %4 = icmp eq i64 %len, 0, !dbg !385
  br i1 %4, label %._crit_edge, label %.lr.ph66, !dbg !385

.lr.ph66:                                         ; preds = %0
  %5 = getelementptr inbounds i8* %text, i64 %len, !dbg !384
  %6 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !386
  %7 = getelementptr inbounds [12 x %struct.tree*]* %links, i64 0, i64 0, !dbg !387
  %8 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 0, !dbg !388
  %9 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, !dbg !389
  %10 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 4, !dbg !390
  %11 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 3, !dbg !390
  %12 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 2, !dbg !392
  %13 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 10, !dbg !393
  %14 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 6, !dbg !392
  %15 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 1, !dbg !395
  br label %16, !dbg !385

; <label>:16                                      ; preds = %.lr.ph66, %.critedge14
  %.in = phi i64 [ %len, %.lr.ph66 ], [ %17, %.critedge14 ]
  %trie.065 = phi %struct.trie* [ %trie.063, %.lr.ph66 ], [ %trie.0, %.critedge14 ]
  %.0764 = phi i8* [ %5, %.lr.ph66 ], [ %20, %.critedge14 ]
  %17 = add i64 %.in, -1, !dbg !385
  %18 = load i8** %6, align 8, !dbg !386, !tbaa !370
  %19 = icmp eq i8* %18, null, !dbg !386
  %20 = getelementptr inbounds i8* %.0764, i64 -1, !dbg !386
  tail call void @llvm.dbg.value(metadata !{i8* %20}, i64 0, metadata !95), !dbg !386
  %21 = load i8* %20, align 1, !dbg !386, !tbaa !397
  br i1 %19, label %26, label %22, !dbg !386

; <label>:22                                      ; preds = %16
  %23 = zext i8 %21 to i64, !dbg !386
  %24 = getelementptr inbounds i8* %18, i64 %23, !dbg !386
  %25 = load i8* %24, align 1, !dbg !386, !tbaa !397
  br label %26, !dbg !386

; <label>:26                                      ; preds = %16, %22
  %.sink = phi i8 [ %25, %22 ], [ %21, %16 ]
  tail call void @llvm.dbg.value(metadata !{i8 %.sink}, i64 0, metadata !99), !dbg !386
  %27 = getelementptr inbounds %struct.trie* %trie.065, i64 0, i32 1, !dbg !398
  %28 = load %struct.tree** %27, align 8, !dbg !398, !tbaa !399
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %28}, i64 0, metadata !100), !dbg !398
  %29 = bitcast %struct.tree** %27 to %struct.tree*, !dbg !387
  store %struct.tree* %29, %struct.tree** %7, align 16, !dbg !387, !tbaa !400
  store i32 0, i32* %8, align 16, !dbg !388, !tbaa !397
  tail call void @llvm.dbg.value(metadata !401, i64 0, metadata !101), !dbg !402
  %30 = icmp eq %struct.tree* %28, null, !dbg !403
  br i1 %30, label %.critedge12, label %.lr.ph, !dbg !403

.lr.ph:                                           ; preds = %26, %.backedge
  %indvars.iv = phi i64 [ %indvars.iv.next, %.backedge ], [ 1, %26 ]
  %kwset_link.060 = phi %struct.tree* [ %kwset_link.0.be, %.backedge ], [ %28, %26 ]
  %31 = getelementptr inbounds %struct.tree* %kwset_link.060, i64 0, i32 3, !dbg !403
  %32 = load i8* %31, align 1, !dbg !403, !tbaa !404
  %33 = icmp eq i8 %.sink, %32, !dbg !403
  br i1 %33, label %.critedge14, label %34

; <label>:34                                      ; preds = %.lr.ph
  %35 = getelementptr inbounds [12 x %struct.tree*]* %links, i64 0, i64 %indvars.iv, !dbg !406
  store %struct.tree* %kwset_link.060, %struct.tree** %35, align 8, !dbg !406, !tbaa !400
  %36 = icmp ult i8 %.sink, %32, !dbg !408
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !403
  %37 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %indvars.iv, !dbg !410
  br i1 %36, label %38, label %40, !dbg !408

; <label>:38                                      ; preds = %34
  store i32 0, i32* %37, align 4, !dbg !410, !tbaa !397
  %39 = getelementptr inbounds %struct.tree* %kwset_link.060, i64 0, i32 0, !dbg !410
  br label %.backedge, !dbg !410

; <label>:40                                      ; preds = %34
  store i32 1, i32* %37, align 4, !dbg !411, !tbaa !397
  %41 = getelementptr inbounds %struct.tree* %kwset_link.060, i64 0, i32 1, !dbg !411
  br label %.backedge

.backedge:                                        ; preds = %40, %38
  %kwset_link.0.be.in = phi %struct.tree** [ %39, %38 ], [ %41, %40 ]
  %kwset_link.0.be = load %struct.tree** %kwset_link.0.be.in, align 8, !dbg !410
  %42 = icmp eq %struct.tree* %kwset_link.0.be, null, !dbg !403
  br i1 %42, label %..critedge12_crit_edge, label %.lr.ph, !dbg !403

..critedge12_crit_edge:                           ; preds = %.backedge
  %43 = trunc i64 %indvars.iv to i32, !dbg !403
  br label %.critedge12, !dbg !403

.critedge12:                                      ; preds = %..critedge12_crit_edge, %26
  %depth.0.lcssa = phi i32 [ %43, %..critedge12_crit_edge ], [ 0, %26 ]
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !113), !dbg !389
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !119), !dbg !412
  tail call void @llvm.dbg.value(metadata !413, i64 0, metadata !121), !dbg !412
  %44 = load i8** %10, align 8, !dbg !390, !tbaa !333
  %45 = load i8** %11, align 8, !dbg !390, !tbaa !334
  %46 = ptrtoint i8* %44 to i64, !dbg !390
  %47 = ptrtoint i8* %45 to i64, !dbg !390
  %48 = sub i64 %46, %47, !dbg !390
  %49 = icmp slt i64 %48, 32, !dbg !390
  br i1 %49, label %50, label %51, !dbg !390

; <label>:50                                      ; preds = %.critedge12
  tail call void @_obstack_newchunk(%struct.obstack* %9, i32 32) #4, !dbg !390
  %.pre91 = load i8** %11, align 8, !dbg !412, !tbaa !334
  br label %51, !dbg !390

; <label>:51                                      ; preds = %50, %.critedge12
  %52 = phi i8* [ %.pre91, %50 ], [ %45, %.critedge12 ]
  %53 = getelementptr inbounds i8* %52, i64 32, !dbg !412
  store i8* %53, i8** %11, align 8, !dbg !412, !tbaa !334
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !122), !dbg !392
  %54 = load i8** %12, align 8, !dbg !392, !tbaa !336
  tail call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !124), !dbg !392
  %55 = icmp eq i8* %53, %54, !dbg !393
  br i1 %55, label %56, label %59, !dbg !393

; <label>:56                                      ; preds = %51
  %57 = load i8* %13, align 8, !dbg !393
  %58 = or i8 %57, 2, !dbg !393
  store i8 %58, i8* %13, align 8, !dbg !393
  br label %59, !dbg !393

; <label>:59                                      ; preds = %56, %51
  %60 = ptrtoint i8* %53 to i64, !dbg !392
  %61 = load i32* %14, align 4, !dbg !392, !tbaa !339
  %62 = sext i32 %61 to i64, !dbg !392
  %63 = add nsw i64 %62, %60, !dbg !392
  %64 = xor i32 %61, -1, !dbg !392
  %65 = sext i32 %64 to i64, !dbg !392
  %66 = and i64 %63, %65, !dbg !392
  %67 = getelementptr inbounds i8* null, i64 %66, !dbg !392
  store i8* %67, i8** %11, align 8, !dbg !392, !tbaa !334
  %68 = load %struct._obstack_chunk** %15, align 8, !dbg !395, !tbaa !342
  %69 = ptrtoint i8* %67 to i64, !dbg !395
  %70 = ptrtoint %struct._obstack_chunk* %68 to i64, !dbg !395
  %71 = sub i64 %69, %70, !dbg !395
  %72 = load i8** %10, align 8, !dbg !395, !tbaa !333
  %73 = ptrtoint i8* %72 to i64, !dbg !395
  %74 = sub i64 %73, %70, !dbg !395
  %75 = icmp sgt i64 %71, %74, !dbg !395
  br i1 %75, label %76, label %77, !dbg !395

; <label>:76                                      ; preds = %59
  store i8* %72, i8** %11, align 8, !dbg !395, !tbaa !334
  br label %77, !dbg !395

; <label>:77                                      ; preds = %76, %59
  %78 = phi i8* [ %72, %76 ], [ %67, %59 ]
  store i8* %78, i8** %12, align 8, !dbg !392, !tbaa !336
  %79 = bitcast i8* %54 to %struct.tree*, !dbg !389
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %79}, i64 0, metadata !100), !dbg !389
  %80 = icmp eq i8* %54, null, !dbg !414
  br i1 %80, label %81, label %83, !dbg !414

; <label>:81                                      ; preds = %77
  %82 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), i32 5) #4, !dbg !416
  br label %264, !dbg !416

; <label>:83                                      ; preds = %77
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !125), !dbg !417
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !127), !dbg !418
  tail call void @llvm.dbg.value(metadata !330, i64 0, metadata !129), !dbg !418
  %84 = ptrtoint i8* %78 to i64, !dbg !419
  %85 = sub i64 %73, %84, !dbg !419
  %86 = icmp slt i64 %85, 56, !dbg !419
  call void @llvm.memset.p0i8.i64(i8* %54, i8 0, i64 16, i32 8, i1 false), !dbg !421
  br i1 %86, label %87, label %88, !dbg !419

; <label>:87                                      ; preds = %83
  tail call void @_obstack_newchunk(%struct.obstack* %9, i32 56) #4, !dbg !419
  %.pre92 = load i8** %11, align 8, !dbg !418, !tbaa !334
  %.pre93 = load i8** %12, align 8, !dbg !422, !tbaa !336
  br label %88, !dbg !419

; <label>:88                                      ; preds = %87, %83
  %89 = phi i8* [ %.pre93, %87 ], [ %78, %83 ]
  %90 = phi i8* [ %.pre92, %87 ], [ %78, %83 ]
  %91 = getelementptr inbounds i8* %90, i64 56, !dbg !418
  store i8* %91, i8** %11, align 8, !dbg !418, !tbaa !334
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !130), !dbg !422
  tail call void @llvm.dbg.value(metadata !{i8* %89}, i64 0, metadata !132), !dbg !422
  %92 = icmp eq i8* %91, %89, !dbg !423
  br i1 %92, label %93, label %96, !dbg !423

; <label>:93                                      ; preds = %88
  %94 = load i8* %13, align 8, !dbg !423
  %95 = or i8 %94, 2, !dbg !423
  store i8 %95, i8* %13, align 8, !dbg !423
  br label %96, !dbg !423

; <label>:96                                      ; preds = %93, %88
  %97 = ptrtoint i8* %91 to i64, !dbg !422
  %98 = load i32* %14, align 4, !dbg !422, !tbaa !339
  %99 = sext i32 %98 to i64, !dbg !422
  %100 = add nsw i64 %99, %97, !dbg !422
  %101 = xor i32 %98, -1, !dbg !422
  %102 = sext i32 %101 to i64, !dbg !422
  %103 = and i64 %100, %102, !dbg !422
  %104 = getelementptr inbounds i8* null, i64 %103, !dbg !422
  store i8* %104, i8** %11, align 8, !dbg !422, !tbaa !334
  %105 = load %struct._obstack_chunk** %15, align 8, !dbg !425, !tbaa !342
  %106 = ptrtoint i8* %104 to i64, !dbg !425
  %107 = ptrtoint %struct._obstack_chunk* %105 to i64, !dbg !425
  %108 = sub i64 %106, %107, !dbg !425
  %109 = load i8** %10, align 8, !dbg !425, !tbaa !333
  %110 = ptrtoint i8* %109 to i64, !dbg !425
  %111 = sub i64 %110, %107, !dbg !425
  %112 = icmp sgt i64 %108, %111, !dbg !425
  br i1 %112, label %113, label %114, !dbg !425

; <label>:113                                     ; preds = %96
  store i8* %109, i8** %11, align 8, !dbg !425, !tbaa !334
  br label %114, !dbg !425

; <label>:114                                     ; preds = %113, %96
  %115 = phi i8* [ %109, %113 ], [ %104, %96 ]
  store i8* %115, i8** %12, align 8, !dbg !422, !tbaa !336
  %116 = bitcast i8* %89 to %struct.trie*, !dbg !417
  %117 = getelementptr inbounds i8* %54, i64 16, !dbg !417
  %118 = bitcast i8* %117 to %struct.trie**, !dbg !417
  store %struct.trie* %116, %struct.trie** %118, align 8, !dbg !417, !tbaa !427
  %119 = icmp eq i8* %89, null, !dbg !428
  br i1 %119, label %120, label %128, !dbg !428

; <label>:120                                     ; preds = %114
  tail call void @llvm.dbg.value(metadata !{%struct.obstack* %9}, i64 0, metadata !133), !dbg !429
  tail call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !137), !dbg !429
  %121 = bitcast %struct._obstack_chunk* %105 to i8*, !dbg !430
  %122 = icmp ugt i8* %54, %121, !dbg !430
  %123 = icmp ult i8* %54, %109, !dbg !430
  %or.cond = and i1 %122, %123, !dbg !430
  br i1 %or.cond, label %124, label %125, !dbg !430

; <label>:124                                     ; preds = %120
  store i8* %54, i8** %12, align 8, !dbg !430, !tbaa !336
  store i8* %54, i8** %11, align 8, !dbg !430, !tbaa !334
  br label %126, !dbg !430

; <label>:125                                     ; preds = %120
  tail call void @obstack_free(%struct.obstack* %9, i8* %54) #4, !dbg !430
  br label %126

; <label>:126                                     ; preds = %125, %124
  %127 = tail call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), i32 5) #4, !dbg !432
  br label %264, !dbg !432

; <label>:128                                     ; preds = %114
  %129 = bitcast i8* %89 to i32*, !dbg !433
  store i32 0, i32* %129, align 4, !dbg !433, !tbaa !360
  %130 = getelementptr inbounds i8* %89, i64 8, !dbg !434
  %131 = bitcast i8* %130 to %struct.tree**, !dbg !434
  store %struct.tree* null, %struct.tree** %131, align 8, !dbg !434, !tbaa !399
  %132 = getelementptr inbounds i8* %89, i64 16, !dbg !435
  %133 = bitcast i8* %132 to %struct.trie**, !dbg !435
  store %struct.trie* %trie.065, %struct.trie** %133, align 8, !dbg !435, !tbaa !436
  %134 = getelementptr inbounds i8* %89, i64 24, !dbg !437
  %135 = getelementptr inbounds %struct.trie* %trie.065, i64 0, i32 5, !dbg !438
  call void @llvm.memset.p0i8.i64(i8* %134, i8 0, i64 16, i32 8, i1 false), !dbg !439
  %136 = load i32* %135, align 4, !dbg !438, !tbaa !440
  %137 = add nsw i32 %136, 1, !dbg !438
  %138 = getelementptr inbounds i8* %89, i64 40, !dbg !438
  %139 = bitcast i8* %138 to i32*, !dbg !438
  store i32 %137, i32* %139, align 4, !dbg !438, !tbaa !440
  %140 = getelementptr inbounds i8* %89, i64 44, !dbg !441
  %141 = bitcast i8* %140 to i32*, !dbg !441
  store i32 0, i32* %141, align 4, !dbg !441, !tbaa !442
  %142 = getelementptr inbounds i8* %54, i64 24, !dbg !443
  store i8 %.sink, i8* %142, align 1, !dbg !443, !tbaa !404
  %143 = getelementptr inbounds i8* %54, i64 25, !dbg !444
  store i8 0, i8* %143, align 1, !dbg !444, !tbaa !445
  tail call void @llvm.dbg.value(metadata !{i32 %depth.0.lcssa}, i64 0, metadata !101), !dbg !446
  %144 = sext i32 %depth.0.lcssa to i64, !dbg !446
  %145 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %144, !dbg !446
  %146 = load i32* %145, align 4, !dbg !446, !tbaa !397
  %147 = icmp eq i32 %146, 0, !dbg !446
  %148 = getelementptr inbounds [12 x %struct.tree*]* %links, i64 0, i64 %144, !dbg !448
  %149 = load %struct.tree** %148, align 8, !dbg !448, !tbaa !400
  br i1 %147, label %150, label %152, !dbg !446

; <label>:150                                     ; preds = %128
  %151 = getelementptr inbounds %struct.tree* %149, i64 0, i32 0, !dbg !448
  store %struct.tree* %79, %struct.tree** %151, align 8, !dbg !448, !tbaa !449
  br label %.preheader, !dbg !448

; <label>:152                                     ; preds = %128
  %153 = getelementptr inbounds %struct.tree* %149, i64 0, i32 1, !dbg !450
  store %struct.tree* %79, %struct.tree** %153, align 8, !dbg !450, !tbaa !451
  br label %.preheader

.preheader:                                       ; preds = %152, %150
  %154 = icmp eq i32 %depth.0.lcssa, 0, !dbg !452
  br i1 %154, label %.critedge14, label %.lr.ph62, !dbg !452

.lr.ph62:                                         ; preds = %.preheader, %._crit_edge94
  %.pr = phi i32 [ %.pre98, %._crit_edge94 ], [ %146, %.preheader ]
  %155 = phi %struct.tree* [ %.pre96, %._crit_edge94 ], [ %149, %.preheader ]
  %indvars.iv88 = phi i64 [ %indvars.iv.next89, %._crit_edge94 ], [ %144, %.preheader ]
  %156 = getelementptr inbounds %struct.tree* %155, i64 0, i32 4, !dbg !452
  %157 = load i8* %156, align 1, !dbg !452, !tbaa !445
  %158 = icmp eq i8 %157, 0, !dbg !452
  %159 = icmp eq i32 %.pr, 0, !dbg !453
  br i1 %158, label %160, label %163

; <label>:160                                     ; preds = %.lr.ph62
  %storemerge.v = select i1 %159, i8 -1, i8 1, !dbg !453
  store i8 %storemerge.v, i8* %156, align 1, !dbg !456, !tbaa !445
  %indvars.iv.next89 = add nsw i64 %indvars.iv88, -1, !dbg !452
  %161 = trunc i64 %indvars.iv.next89 to i32, !dbg !452
  %162 = icmp eq i32 %161, 0, !dbg !452
  br i1 %162, label %.critedge14, label %._crit_edge94, !dbg !452

._crit_edge94:                                    ; preds = %160
  %.phi.trans.insert95 = getelementptr inbounds [12 x %struct.tree*]* %links, i64 0, i64 %indvars.iv.next89
  %.pre96 = load %struct.tree** %.phi.trans.insert95, align 8, !dbg !452, !tbaa !400
  %.phi.trans.insert97 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %indvars.iv.next89
  %.pre98 = load i32* %.phi.trans.insert97, align 4, !dbg !453, !tbaa !397
  br label %.lr.ph62, !dbg !452

; <label>:163                                     ; preds = %.lr.ph62
  br i1 %159, label %164, label %thread-pre-split, !dbg !457

; <label>:164                                     ; preds = %163
  %165 = add i8 %157, -1, !dbg !457
  store i8 %165, i8* %156, align 1, !dbg !457, !tbaa !445
  %166 = icmp eq i8 %165, 0, !dbg !457
  br i1 %166, label %.critedge14, label %171, !dbg !457

thread-pre-split:                                 ; preds = %163
  %167 = icmp eq i32 %.pr, 1, !dbg !457
  br i1 %167, label %168, label %.critedge14, !dbg !457

; <label>:168                                     ; preds = %thread-pre-split
  %169 = add i8 %157, 1, !dbg !457
  store i8 %169, i8* %156, align 1, !dbg !457, !tbaa !445
  %170 = icmp eq i8 %169, 0, !dbg !457
  br i1 %170, label %.critedge14, label %171, !dbg !457

; <label>:171                                     ; preds = %164, %168
  %172 = phi i8 [ %165, %164 ], [ %169, %168 ]
  %173 = sext i8 %172 to i32, !dbg !459
  switch i32 %173, label %228 [
    i32 -2, label %174
    i32 2, label %201
  ], !dbg !459

; <label>:174                                     ; preds = %171
  %175 = shl i64 %indvars.iv88, 32, !dbg !461
  %sext100 = add i64 %175, 4294967296, !dbg !461
  %176 = ashr exact i64 %sext100, 32, !dbg !461
  %177 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %176, !dbg !461
  %178 = load i32* %177, align 4, !dbg !461, !tbaa !397
  switch i32 %178, label %200 [
    i32 0, label %179
    i32 1, label %185
  ], !dbg !461

; <label>:179                                     ; preds = %174
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %155}, i64 0, metadata !109), !dbg !463
  %180 = getelementptr inbounds %struct.tree* %155, i64 0, i32 0, !dbg !463
  %181 = load %struct.tree** %180, align 8, !dbg !463, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %181}, i64 0, metadata !108), !dbg !463
  %182 = getelementptr inbounds %struct.tree* %181, i64 0, i32 1, !dbg !463
  %183 = load %struct.tree** %182, align 8, !dbg !463, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %183}, i64 0, metadata !111), !dbg !463
  store %struct.tree* %155, %struct.tree** %182, align 8, !dbg !465, !tbaa !451
  store %struct.tree* %183, %struct.tree** %180, align 8, !dbg !465, !tbaa !449
  store i8 0, i8* %156, align 1, !dbg !466, !tbaa !445
  %184 = getelementptr inbounds %struct.tree* %181, i64 0, i32 4, !dbg !466
  store i8 0, i8* %184, align 1, !dbg !466, !tbaa !445
  br label %229, !dbg !467

; <label>:185                                     ; preds = %174
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %155}, i64 0, metadata !109), !dbg !468
  %186 = getelementptr inbounds %struct.tree* %155, i64 0, i32 0, !dbg !468
  %187 = load %struct.tree** %186, align 8, !dbg !468, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %187}, i64 0, metadata !110), !dbg !468
  %188 = getelementptr inbounds %struct.tree* %187, i64 0, i32 1, !dbg !468
  %189 = load %struct.tree** %188, align 8, !dbg !468, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %189}, i64 0, metadata !108), !dbg !468
  %190 = getelementptr inbounds %struct.tree* %189, i64 0, i32 1, !dbg !469
  %191 = load %struct.tree** %190, align 8, !dbg !469, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %191}, i64 0, metadata !111), !dbg !469
  %192 = getelementptr inbounds %struct.tree* %189, i64 0, i32 0, !dbg !469
  %193 = load %struct.tree** %192, align 8, !dbg !469, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %193}, i64 0, metadata !112), !dbg !469
  store %struct.tree* %187, %struct.tree** %192, align 8, !dbg !470, !tbaa !449
  store %struct.tree* %193, %struct.tree** %188, align 8, !dbg !470, !tbaa !451
  store %struct.tree* %155, %struct.tree** %190, align 8, !dbg !470, !tbaa !451
  store %struct.tree* %191, %struct.tree** %186, align 8, !dbg !470, !tbaa !449
  %194 = getelementptr inbounds %struct.tree* %189, i64 0, i32 4, !dbg !471
  %195 = load i8* %194, align 1, !dbg !471, !tbaa !445
  %not.10 = icmp eq i8 %195, 1, !dbg !471
  %196 = sext i1 %not.10 to i8, !dbg !471
  %197 = getelementptr inbounds %struct.tree* %187, i64 0, i32 4, !dbg !471
  store i8 %196, i8* %197, align 1, !dbg !471, !tbaa !445
  %198 = load i8* %194, align 1, !dbg !472, !tbaa !445
  %not.11 = icmp eq i8 %198, -1, !dbg !472
  %199 = zext i1 %not.11 to i8, !dbg !472
  store i8 %199, i8* %156, align 1, !dbg !472, !tbaa !445
  store i8 0, i8* %194, align 1, !dbg !473, !tbaa !445
  br label %229, !dbg !474

; <label>:200                                     ; preds = %174
  tail call void @abort() #8, !dbg !475
  unreachable, !dbg !475

; <label>:201                                     ; preds = %171
  %202 = shl i64 %indvars.iv88, 32, !dbg !476
  %sext = add i64 %202, 4294967296, !dbg !476
  %203 = ashr exact i64 %sext, 32, !dbg !476
  %204 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %203, !dbg !476
  %205 = load i32* %204, align 4, !dbg !476, !tbaa !397
  switch i32 %205, label %227 [
    i32 1, label %206
    i32 0, label %212
  ], !dbg !476

; <label>:206                                     ; preds = %201
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %155}, i64 0, metadata !110), !dbg !477
  %207 = getelementptr inbounds %struct.tree* %155, i64 0, i32 1, !dbg !477
  %208 = load %struct.tree** %207, align 8, !dbg !477, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %208}, i64 0, metadata !108), !dbg !477
  %209 = getelementptr inbounds %struct.tree* %208, i64 0, i32 0, !dbg !477
  %210 = load %struct.tree** %209, align 8, !dbg !477, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %210}, i64 0, metadata !112), !dbg !477
  store %struct.tree* %155, %struct.tree** %209, align 8, !dbg !479, !tbaa !449
  store %struct.tree* %210, %struct.tree** %207, align 8, !dbg !479, !tbaa !451
  store i8 0, i8* %156, align 1, !dbg !480, !tbaa !445
  %211 = getelementptr inbounds %struct.tree* %208, i64 0, i32 4, !dbg !480
  store i8 0, i8* %211, align 1, !dbg !480, !tbaa !445
  br label %229, !dbg !481

; <label>:212                                     ; preds = %201
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %155}, i64 0, metadata !110), !dbg !482
  %213 = getelementptr inbounds %struct.tree* %155, i64 0, i32 1, !dbg !482
  %214 = load %struct.tree** %213, align 8, !dbg !482, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %214}, i64 0, metadata !109), !dbg !482
  %215 = getelementptr inbounds %struct.tree* %214, i64 0, i32 0, !dbg !482
  %216 = load %struct.tree** %215, align 8, !dbg !482, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %216}, i64 0, metadata !108), !dbg !482
  %217 = getelementptr inbounds %struct.tree* %216, i64 0, i32 0, !dbg !483
  %218 = load %struct.tree** %217, align 8, !dbg !483, !tbaa !449
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %218}, i64 0, metadata !112), !dbg !483
  %219 = getelementptr inbounds %struct.tree* %216, i64 0, i32 1, !dbg !483
  %220 = load %struct.tree** %219, align 8, !dbg !483, !tbaa !451
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %220}, i64 0, metadata !111), !dbg !483
  store %struct.tree* %155, %struct.tree** %217, align 8, !dbg !484, !tbaa !449
  store %struct.tree* %218, %struct.tree** %213, align 8, !dbg !484, !tbaa !451
  store %struct.tree* %214, %struct.tree** %219, align 8, !dbg !484, !tbaa !451
  store %struct.tree* %220, %struct.tree** %215, align 8, !dbg !484, !tbaa !449
  %221 = getelementptr inbounds %struct.tree* %216, i64 0, i32 4, !dbg !485
  %222 = load i8* %221, align 1, !dbg !485, !tbaa !445
  %not. = icmp eq i8 %222, 1, !dbg !485
  %223 = sext i1 %not. to i8, !dbg !485
  store i8 %223, i8* %156, align 1, !dbg !485, !tbaa !445
  %224 = load i8* %221, align 1, !dbg !486, !tbaa !445
  %not.9 = icmp eq i8 %224, -1, !dbg !486
  %225 = zext i1 %not.9 to i8, !dbg !486
  %226 = getelementptr inbounds %struct.tree* %214, i64 0, i32 4, !dbg !486
  store i8 %225, i8* %226, align 1, !dbg !486, !tbaa !445
  store i8 0, i8* %221, align 1, !dbg !487, !tbaa !445
  br label %229, !dbg !488

; <label>:227                                     ; preds = %201
  tail call void @abort() #8, !dbg !489
  unreachable, !dbg !489

; <label>:228                                     ; preds = %171
  tail call void @abort() #8, !dbg !490
  unreachable, !dbg !490

; <label>:229                                     ; preds = %206, %212, %179, %185
  %t.0 = phi %struct.tree* [ %216, %212 ], [ %208, %206 ], [ %189, %185 ], [ %181, %179 ]
  %230 = shl i64 %indvars.iv88, 32, !dbg !491
  %sext99 = add i64 %230, -4294967296, !dbg !491
  %231 = ashr exact i64 %sext99, 32, !dbg !491
  %232 = getelementptr inbounds [12 x i32]* %dirs, i64 0, i64 %231, !dbg !491
  %233 = load i32* %232, align 4, !dbg !491, !tbaa !397
  %234 = icmp eq i32 %233, 0, !dbg !491
  %235 = getelementptr inbounds [12 x %struct.tree*]* %links, i64 0, i64 %231, !dbg !493
  %236 = load %struct.tree** %235, align 8, !dbg !493, !tbaa !400
  br i1 %234, label %237, label %239, !dbg !491

; <label>:237                                     ; preds = %229
  %238 = getelementptr inbounds %struct.tree* %236, i64 0, i32 0, !dbg !493
  store %struct.tree* %t.0, %struct.tree** %238, align 8, !dbg !493, !tbaa !449
  br label %.critedge14, !dbg !493

; <label>:239                                     ; preds = %229
  %240 = getelementptr inbounds %struct.tree* %236, i64 0, i32 1, !dbg !494
  store %struct.tree* %t.0, %struct.tree** %240, align 8, !dbg !494, !tbaa !451
  br label %.critedge14

.critedge14:                                      ; preds = %.lr.ph, %160, %164, %.preheader, %168, %thread-pre-split, %239, %237
  %kwset_link.1 = phi %struct.tree* [ %79, %237 ], [ %79, %239 ], [ %79, %168 ], [ %79, %thread-pre-split ], [ %79, %.preheader ], [ %79, %164 ], [ %79, %160 ], [ %kwset_link.060, %.lr.ph ]
  %241 = getelementptr inbounds %struct.tree* %kwset_link.1, i64 0, i32 2, !dbg !495
  %trie.0 = load %struct.trie** %241, align 8, !dbg !383
  tail call void @llvm.dbg.value(metadata !{i64 %17}, i64 0, metadata !96), !dbg !385
  %242 = icmp eq i64 %17, 0, !dbg !385
  br i1 %242, label %._crit_edge, label %16, !dbg !385

._crit_edge:                                      ; preds = %.critedge14, %0
  %trie.0.lcssa = phi %struct.trie* [ %trie.063, %0 ], [ %trie.0, %.critedge14 ]
  %243 = getelementptr inbounds %struct.trie* %trie.0.lcssa, i64 0, i32 0, !dbg !496
  %244 = load i32* %243, align 4, !dbg !496, !tbaa !360
  %245 = icmp eq i32 %244, 0, !dbg !496
  %246 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 1, !dbg !498
  %247 = load i32* %246, align 4, !dbg !498, !tbaa !320
  br i1 %245, label %248, label %._crit_edge90, !dbg !496

; <label>:248                                     ; preds = %._crit_edge
  %249 = shl nsw i32 %247, 1, !dbg !498
  %250 = or i32 %249, 1, !dbg !498
  store i32 %250, i32* %243, align 4, !dbg !498, !tbaa !360
  br label %._crit_edge90, !dbg !498

._crit_edge90:                                    ; preds = %._crit_edge, %248
  %251 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 1, !dbg !499
  %252 = add nsw i32 %247, 1, !dbg !499
  store i32 %252, i32* %251, align 4, !dbg !499, !tbaa !320
  %253 = getelementptr inbounds %struct.trie* %trie.0.lcssa, i64 0, i32 5, !dbg !500
  %254 = load i32* %253, align 4, !dbg !500, !tbaa !440
  %255 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 3, !dbg !500
  %256 = load i32* %255, align 4, !dbg !500, !tbaa !364
  %257 = icmp slt i32 %254, %256, !dbg !500
  br i1 %257, label %258, label %259, !dbg !500

; <label>:258                                     ; preds = %._crit_edge90
  store i32 %254, i32* %255, align 4, !dbg !502, !tbaa !364
  br label %259, !dbg !502

; <label>:259                                     ; preds = %258, %._crit_edge90
  %260 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 4, !dbg !503
  %261 = load i32* %260, align 4, !dbg !503, !tbaa !366
  %262 = icmp sgt i32 %254, %261, !dbg !503
  br i1 %262, label %263, label %264, !dbg !503

; <label>:263                                     ; preds = %259
  store i32 %254, i32* %260, align 4, !dbg !505, !tbaa !366
  br label %264, !dbg !505

; <label>:264                                     ; preds = %259, %263, %126, %81
  %.0 = phi i8* [ %127, %126 ], [ %82, %81 ], [ null, %263 ], [ null, %259 ]
  call void @llvm.lifetime.end(i64 48, i8* %2) #4, !dbg !506
  call void @llvm.lifetime.end(i64 96, i8* %1) #4, !dbg !506
  ret i8* %.0, !dbg !506
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #4

; Function Attrs: nounwind
declare i8* @dcgettext(i8*, i8*, i32) #3

declare void @obstack_free(%struct.obstack*, i8*) #2

; Function Attrs: noreturn nounwind
declare void @abort() #5

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #4

; Function Attrs: nounwind uwtable
define i8* @kwsprep(%struct.kwset* %kws) #0 {
  %delta = alloca [256 x i8], align 16
  %last = alloca %struct.trie*, align 8
  %next = alloca [256 x %struct.trie*], align 16
  %1 = bitcast [256 x %struct.trie*]* %next to i8*
  call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !177), !dbg !507
  %2 = getelementptr inbounds [256 x i8]* %delta, i64 0, i64 0, !dbg !508
  call void @llvm.lifetime.start(i64 256, i8* %2) #4, !dbg !508
  call void @llvm.dbg.declare(metadata !{[256 x i8]* %delta}, metadata !182), !dbg !508
  call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !178), !dbg !509
  %3 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 3, !dbg !510
  %4 = load i32* %3, align 4, !dbg !510, !tbaa !364
  %5 = icmp slt i32 %4, 255, !dbg !510
  %phitmp = trunc i32 %4 to i8, !dbg !510
  %phitmp. = select i1 %5, i8 %phitmp, i8 -1, !dbg !510
  call void @llvm.memset.p0i8.i64(i8* %2, i8 %phitmp., i64 256, i32 16, i1 false), !dbg !510
  %6 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 1, !dbg !511
  %7 = load i32* %6, align 4, !dbg !511, !tbaa !320
  %8 = icmp eq i32 %7, 1, !dbg !511
  br i1 %8, label %9, label %107, !dbg !511

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !511
  %11 = load i8** %10, align 8, !dbg !511, !tbaa !370
  %12 = icmp eq i8* %11, null, !dbg !511
  br i1 %12, label %13, label %107, !dbg !511

; <label>:13                                      ; preds = %9
  call void @llvm.dbg.value(metadata !{%struct.obstack* %24}, i64 0, metadata !186), !dbg !512
  call void @llvm.dbg.value(metadata !{%struct.obstack* %24}, i64 0, metadata !188), !dbg !513
  call void @llvm.dbg.value(metadata !{i32 %4}, i64 0, metadata !190), !dbg !513
  %14 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 4, !dbg !514
  %15 = load i8** %14, align 8, !dbg !514, !tbaa !333
  %16 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 3, !dbg !514
  %17 = load i8** %16, align 8, !dbg !514, !tbaa !334
  %18 = ptrtoint i8* %15 to i64, !dbg !514
  %19 = ptrtoint i8* %17 to i64, !dbg !514
  %20 = sub i64 %18, %19, !dbg !514
  %21 = sext i32 %4 to i64, !dbg !514
  %22 = icmp slt i64 %20, %21, !dbg !514
  br i1 %22, label %23, label %25, !dbg !514

; <label>:23                                      ; preds = %13
  %24 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, !dbg !512
  call void @_obstack_newchunk(%struct.obstack* %24, i32 %4) #4, !dbg !514
  %.pre = load i8** %16, align 8, !dbg !513, !tbaa !334
  br label %25, !dbg !514

; <label>:25                                      ; preds = %23, %13
  %26 = phi i8* [ %.pre, %23 ], [ %17, %13 ]
  %27 = getelementptr inbounds i8* %26, i64 %21, !dbg !513
  store i8* %27, i8** %16, align 8, !dbg !513, !tbaa !334
  call void @llvm.dbg.value(metadata !{%struct.obstack* %24}, i64 0, metadata !191), !dbg !516
  %28 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 2, !dbg !516
  %29 = load i8** %28, align 8, !dbg !516, !tbaa !336
  call void @llvm.dbg.value(metadata !{i8* %29}, i64 0, metadata !193), !dbg !516
  %30 = icmp eq i8* %27, %29, !dbg !517
  br i1 %30, label %31, label %35, !dbg !517

; <label>:31                                      ; preds = %25
  %32 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 10, !dbg !517
  %33 = load i8* %32, align 8, !dbg !517
  %34 = or i8 %33, 2, !dbg !517
  store i8 %34, i8* %32, align 8, !dbg !517
  br label %35, !dbg !517

; <label>:35                                      ; preds = %31, %25
  %36 = ptrtoint i8* %27 to i64, !dbg !516
  %37 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 6, !dbg !516
  %38 = load i32* %37, align 4, !dbg !516, !tbaa !339
  %39 = sext i32 %38 to i64, !dbg !516
  %40 = add nsw i64 %39, %36, !dbg !516
  %41 = xor i32 %38, -1, !dbg !516
  %42 = sext i32 %41 to i64, !dbg !516
  %43 = and i64 %40, %42, !dbg !516
  %44 = getelementptr inbounds i8* null, i64 %43, !dbg !516
  store i8* %44, i8** %16, align 8, !dbg !516, !tbaa !334
  %45 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 0, i32 1, !dbg !519
  %46 = load %struct._obstack_chunk** %45, align 8, !dbg !519, !tbaa !342
  %47 = ptrtoint i8* %44 to i64, !dbg !519
  %48 = ptrtoint %struct._obstack_chunk* %46 to i64, !dbg !519
  %49 = sub i64 %47, %48, !dbg !519
  %50 = load i8** %14, align 8, !dbg !519, !tbaa !333
  %51 = ptrtoint i8* %50 to i64, !dbg !519
  %52 = sub i64 %51, %48, !dbg !519
  %53 = icmp sgt i64 %49, %52, !dbg !519
  br i1 %53, label %54, label %55, !dbg !519

; <label>:54                                      ; preds = %35
  store i8* %50, i8** %16, align 8, !dbg !519, !tbaa !334
  br label %55, !dbg !519

; <label>:55                                      ; preds = %54, %35
  %56 = phi i8* [ %50, %54 ], [ %44, %35 ]
  store i8* %56, i8** %28, align 8, !dbg !516, !tbaa !336
  %57 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 7, !dbg !512
  store i8* %29, i8** %57, align 8, !dbg !512, !tbaa !368
  %58 = icmp eq i8* %29, null, !dbg !521
  br i1 %58, label %59, label %61, !dbg !521

; <label>:59                                      ; preds = %55
  %60 = call i8* @dcgettext(i8* null, i8* getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), i32 5) #4, !dbg !523
  br label %.loopexit, !dbg !523

; <label>:61                                      ; preds = %55
  %62 = load i32* %3, align 4, !dbg !524, !tbaa !364
  %63 = icmp sgt i32 %62, 0, !dbg !524
  br i1 %63, label %.lr.ph16, label %.preheader1._crit_edge, !dbg !524

.lr.ph16:                                         ; preds = %61
  %64 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 2, !dbg !524
  %65 = sext i32 %62 to i64
  br label %68, !dbg !524

.preheader1:                                      ; preds = %68
  %.pre49 = load i32* %3, align 4, !dbg !526, !tbaa !364
  %66 = icmp sgt i32 %.pre49, 0, !dbg !526
  br i1 %66, label %.lr.ph9, label %.preheader1._crit_edge, !dbg !526

.preheader1._crit_edge:                           ; preds = %61, %.preheader1
  %67 = phi i32 [ %.pre49, %.preheader1 ], [ %62, %61 ]
  %.pre50 = load i8** %57, align 8, !dbg !528, !tbaa !368
  br label %._crit_edge10, !dbg !526

.lr.ph9:                                          ; preds = %.preheader1
  %.pre51 = load i8** %57, align 8, !dbg !529, !tbaa !368
  br label %79, !dbg !526

; <label>:68                                      ; preds = %._crit_edge52, %.lr.ph16
  %69 = phi i8* [ %29, %.lr.ph16 ], [ %.pre53, %._crit_edge52 ]
  %indvars.iv41 = phi i64 [ %65, %.lr.ph16 ], [ %indvars.iv.next42, %._crit_edge52 ]
  %curr.0.in13 = phi %struct.trie** [ %64, %.lr.ph16 ], [ %78, %._crit_edge52 ]
  %indvars.iv.next42 = add nsw i64 %indvars.iv41, -1, !dbg !524
  %curr.0 = load %struct.trie** %curr.0.in13, align 8, !dbg !524
  %70 = getelementptr inbounds %struct.trie* %curr.0, i64 0, i32 1, !dbg !530
  %71 = load %struct.tree** %70, align 8, !dbg !530, !tbaa !399
  %72 = getelementptr inbounds %struct.tree* %71, i64 0, i32 3, !dbg !530
  %73 = load i8* %72, align 1, !dbg !530, !tbaa !404
  %74 = getelementptr inbounds i8* %69, i64 %indvars.iv.next42, !dbg !530
  store i8 %73, i8* %74, align 1, !dbg !530, !tbaa !397
  %75 = trunc i64 %indvars.iv.next42 to i32, !dbg !524
  %76 = icmp sgt i32 %75, 0, !dbg !524
  br i1 %76, label %._crit_edge52, label %.preheader1, !dbg !524

._crit_edge52:                                    ; preds = %68
  %77 = load %struct.tree** %70, align 8, !dbg !532, !tbaa !399
  %78 = getelementptr inbounds %struct.tree* %77, i64 0, i32 2, !dbg !532
  %.pre53 = load i8** %57, align 8, !dbg !530, !tbaa !368
  br label %68, !dbg !524

; <label>:79                                      ; preds = %.lr.ph9, %79
  %indvars.iv39 = phi i64 [ 0, %.lr.ph9 ], [ %indvars.iv.next40, %79 ]
  %indvars.iv.next40 = add nuw nsw i64 %indvars.iv39, 1, !dbg !526
  %80 = trunc i64 %indvars.iv.next40 to i32, !dbg !529
  %81 = sub nsw i32 %.pre49, %80, !dbg !529
  %82 = trunc i32 %81 to i8, !dbg !529
  %83 = getelementptr inbounds i8* %.pre51, i64 %indvars.iv39, !dbg !529
  %84 = load i8* %83, align 1, !dbg !529, !tbaa !397
  %85 = zext i8 %84 to i64, !dbg !529
  %86 = getelementptr inbounds [256 x i8]* %delta, i64 0, i64 %85, !dbg !529
  store i8 %82, i8* %86, align 1, !dbg !529, !tbaa !397
  %87 = icmp sgt i32 %.pre49, %80, !dbg !526
  br i1 %87, label %79, label %._crit_edge10, !dbg !526

._crit_edge10:                                    ; preds = %79, %.preheader1._crit_edge
  %88 = phi i32 [ %67, %.preheader1._crit_edge ], [ %.pre49, %79 ]
  %89 = phi i8* [ %.pre50, %.preheader1._crit_edge ], [ %.pre51, %79 ]
  %90 = add nsw i32 %88, -1, !dbg !528
  %91 = sext i32 %90 to i64, !dbg !528
  %92 = getelementptr inbounds i8* %89, i64 %91, !dbg !528
  %93 = load i8* %92, align 1, !dbg !528, !tbaa !397
  call void @llvm.dbg.value(metadata !{i8 %93}, i64 0, metadata !183), !dbg !528
  %94 = add i32 %88, -2, !dbg !533
  call void @llvm.dbg.value(metadata !{i32 %94}, i64 0, metadata !179), !dbg !533
  %95 = icmp sgt i32 %94, -1, !dbg !533
  br i1 %95, label %.lr.ph, label %._crit_edge, !dbg !533

.lr.ph:                                           ; preds = %._crit_edge10
  %96 = sext i32 %94 to i64
  br label %99, !dbg !533

; <label>:97                                      ; preds = %99
  %98 = icmp sgt i32 %104, 0, !dbg !533
  %indvars.iv.next38 = add nsw i64 %indvars.iv37, -1, !dbg !533
  br i1 %98, label %99, label %._crit_edge, !dbg !533

; <label>:99                                      ; preds = %.lr.ph, %97
  %indvars.iv37 = phi i64 [ %96, %.lr.ph ], [ %indvars.iv.next38, %97 ]
  %i.26 = phi i32 [ %94, %.lr.ph ], [ %103, %97 ]
  %100 = getelementptr inbounds i8* %89, i64 %indvars.iv37, !dbg !535
  %101 = load i8* %100, align 1, !dbg !535, !tbaa !397
  %102 = icmp eq i8 %101, %93, !dbg !535
  %103 = add nsw i32 %i.26, -1, !dbg !533
  call void @llvm.dbg.value(metadata !{i32 %103}, i64 0, metadata !179), !dbg !533
  %104 = trunc i64 %indvars.iv37 to i32
  br i1 %102, label %._crit_edge, label %97, !dbg !535

._crit_edge:                                      ; preds = %99, %97, %._crit_edge10
  %i.2.lcssa = phi i32 [ %94, %._crit_edge10 ], [ %104, %99 ], [ %103, %97 ]
  %.neg = xor i32 %i.2.lcssa, -1, !dbg !537
  %105 = add i32 %88, %.neg, !dbg !537
  %106 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 8, !dbg !537
  store i32 %105, i32* %106, align 4, !dbg !537, !tbaa !538
  br label %.loopexit3, !dbg !539

; <label>:107                                     ; preds = %9, %0
  call void @llvm.dbg.declare(metadata !{%struct.trie** %last}, metadata !196), !dbg !540
  call void @llvm.lifetime.start(i64 2048, i8* %1) #4, !dbg !540
  call void @llvm.dbg.declare(metadata !{[256 x %struct.trie*]* %next}, metadata !197), !dbg !540
  %108 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 2, !dbg !541
  %109 = load %struct.trie** %108, align 8, !dbg !541, !tbaa !343
  call void @llvm.dbg.value(metadata !{%struct.trie* %109}, i64 0, metadata !196), !dbg !541
  store %struct.trie* %109, %struct.trie** %last, align 8, !dbg !541, !tbaa !400
  call void @llvm.dbg.value(metadata !{%struct.trie* %109}, i64 0, metadata !180), !dbg !541
  %110 = icmp eq %struct.trie* %109, null, !dbg !541
  br i1 %110, label %157, label %.lr.ph31, !dbg !541

.lr.ph31:                                         ; preds = %107, %._crit_edge28
  %curr.129 = phi %struct.trie* [ %155, %._crit_edge28 ], [ %109, %107 ]
  %111 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 1, !dbg !543
  %112 = load %struct.tree** %111, align 8, !dbg !543, !tbaa !399
  call fastcc void @enqueue(%struct.tree* %112, %struct.trie** %last), !dbg !543
  %113 = load i32* %3, align 4, !dbg !545, !tbaa !364
  %114 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 6, !dbg !545
  store i32 %113, i32* %114, align 4, !dbg !545, !tbaa !442
  %115 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 7, !dbg !546
  store i32 %113, i32* %115, align 4, !dbg !546, !tbaa !547
  %116 = load %struct.tree** %111, align 8, !dbg !548, !tbaa !399
  %117 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 5, !dbg !548
  %118 = load i32* %117, align 4, !dbg !548, !tbaa !440
  call fastcc void @treedelta(%struct.tree* %116, i32 %118, i8* %2), !dbg !548
  %119 = load %struct.tree** %111, align 8, !dbg !549, !tbaa !399
  %120 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 4, !dbg !549
  %121 = load %struct.trie** %120, align 8, !dbg !549, !tbaa !550
  %122 = load %struct.trie** %108, align 8, !dbg !549, !tbaa !343
  call fastcc void @treefails(%struct.tree* %119, %struct.trie* %121, %struct.trie* %122), !dbg !549
  %fail.024 = load %struct.trie** %120, align 8, !dbg !551
  %123 = icmp eq %struct.trie* %fail.024, null, !dbg !551
  br i1 %123, label %._crit_edge28, label %.lr.ph27, !dbg !551

.lr.ph27:                                         ; preds = %.lr.ph31
  %124 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 0, !dbg !553
  %.pre55 = load %struct.tree** %111, align 8, !dbg !556, !tbaa !399
  br label %125, !dbg !551

; <label>:125                                     ; preds = %.lr.ph27, %151
  %fail.025 = phi %struct.trie* [ %fail.024, %.lr.ph27 ], [ %fail.0, %151 ]
  %126 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 1, !dbg !556
  %127 = load %struct.tree** %126, align 8, !dbg !556, !tbaa !399
  %128 = call fastcc i32 @hasevery(%struct.tree* %127, %struct.tree* %.pre55), !dbg !556
  %129 = icmp eq i32 %128, 0, !dbg !556
  br i1 %129, label %130, label %139, !dbg !556

; <label>:130                                     ; preds = %125
  %131 = load i32* %117, align 4, !dbg !558, !tbaa !440
  %132 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 5, !dbg !558
  %133 = load i32* %132, align 4, !dbg !558, !tbaa !440
  %134 = sub nsw i32 %131, %133, !dbg !558
  %135 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 6, !dbg !558
  %136 = load i32* %135, align 4, !dbg !558, !tbaa !442
  %137 = icmp slt i32 %134, %136, !dbg !558
  br i1 %137, label %138, label %139, !dbg !558

; <label>:138                                     ; preds = %130
  store i32 %134, i32* %135, align 4, !dbg !560, !tbaa !442
  br label %139, !dbg !560

; <label>:139                                     ; preds = %125, %130, %138
  %140 = load i32* %124, align 4, !dbg !553, !tbaa !360
  %141 = icmp eq i32 %140, 0, !dbg !553
  br i1 %141, label %151, label %142, !dbg !553

; <label>:142                                     ; preds = %139
  %143 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 7, !dbg !553
  %144 = load i32* %143, align 4, !dbg !553, !tbaa !547
  %145 = load i32* %117, align 4, !dbg !553, !tbaa !440
  %146 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 5, !dbg !553
  %147 = load i32* %146, align 4, !dbg !553, !tbaa !440
  %148 = sub nsw i32 %145, %147, !dbg !553
  %149 = icmp sgt i32 %144, %148, !dbg !553
  br i1 %149, label %150, label %151, !dbg !553

; <label>:150                                     ; preds = %142
  store i32 %148, i32* %143, align 4, !dbg !561, !tbaa !547
  br label %151, !dbg !561

; <label>:151                                     ; preds = %139, %142, %150
  %152 = getelementptr inbounds %struct.trie* %fail.025, i64 0, i32 4, !dbg !551
  %fail.0 = load %struct.trie** %152, align 8, !dbg !551
  %153 = icmp eq %struct.trie* %fail.0, null, !dbg !551
  br i1 %153, label %._crit_edge28, label %125, !dbg !551

._crit_edge28:                                    ; preds = %151, %.lr.ph31
  %154 = getelementptr inbounds %struct.trie* %curr.129, i64 0, i32 3, !dbg !541
  %155 = load %struct.trie** %154, align 8, !dbg !541, !tbaa !562
  call void @llvm.dbg.value(metadata !{%struct.trie* %155}, i64 0, metadata !180), !dbg !541
  %156 = icmp eq %struct.trie* %155, null, !dbg !541
  br i1 %156, label %._crit_edge32, label %.lr.ph31, !dbg !541

._crit_edge32:                                    ; preds = %._crit_edge28
  %.pre54 = load %struct.trie** %108, align 8, !dbg !563, !tbaa !343
  br label %157, !dbg !541

; <label>:157                                     ; preds = %._crit_edge32, %107
  %158 = phi %struct.trie* [ %.pre54, %._crit_edge32 ], [ null, %107 ]
  %curr.2.in19 = getelementptr inbounds %struct.trie* %158, i64 0, i32 3, !dbg !563
  %curr.220 = load %struct.trie** %curr.2.in19, align 8, !dbg !563
  %159 = icmp eq %struct.trie* %curr.220, null, !dbg !563
  br i1 %159, label %.preheader4, label %.lr.ph23, !dbg !563

.preheader4:                                      ; preds = %.backedge, %157
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 2048, i32 16, i1 false), !dbg !565
  %160 = getelementptr inbounds %struct.trie* %158, i64 0, i32 1, !dbg !567
  %161 = load %struct.tree** %160, align 8, !dbg !567, !tbaa !399
  %162 = getelementptr inbounds [256 x %struct.trie*]* %next, i64 0, i64 0, !dbg !567
  call fastcc void @treenext(%struct.tree* %161, %struct.trie** %162), !dbg !567
  %163 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !568
  %164 = load i8** %163, align 8, !dbg !568, !tbaa !370
  call void @llvm.dbg.value(metadata !{i8* %164}, i64 0, metadata !181), !dbg !568
  %165 = icmp eq i8* %164, null, !dbg !568
  br i1 %165, label %187, label %.preheader2, !dbg !568

.lr.ph23:                                         ; preds = %157, %.backedge
  %curr.221 = phi %struct.trie* [ %curr.2, %.backedge ], [ %curr.220, %157 ]
  %166 = getelementptr inbounds %struct.trie* %curr.221, i64 0, i32 7, !dbg !570
  %167 = load i32* %166, align 4, !dbg !570, !tbaa !547
  %168 = getelementptr inbounds %struct.trie* %curr.221, i64 0, i32 2, !dbg !570
  %169 = load %struct.trie** %168, align 8, !dbg !570, !tbaa !436
  %170 = getelementptr inbounds %struct.trie* %169, i64 0, i32 7, !dbg !570
  %171 = load i32* %170, align 4, !dbg !570, !tbaa !547
  %172 = icmp sgt i32 %167, %171, !dbg !570
  br i1 %172, label %173, label %174, !dbg !570

; <label>:173                                     ; preds = %.lr.ph23
  store i32 %171, i32* %166, align 4, !dbg !573, !tbaa !547
  br label %174, !dbg !573

; <label>:174                                     ; preds = %173, %.lr.ph23
  %175 = phi i32 [ %171, %173 ], [ %167, %.lr.ph23 ]
  %176 = getelementptr inbounds %struct.trie* %curr.221, i64 0, i32 6, !dbg !574
  %177 = load i32* %176, align 4, !dbg !574, !tbaa !442
  %178 = icmp sgt i32 %177, %175, !dbg !574
  br i1 %178, label %180, label %.backedge, !dbg !574

.backedge:                                        ; preds = %174, %180
  %curr.2.in = getelementptr inbounds %struct.trie* %curr.221, i64 0, i32 3, !dbg !563
  %curr.2 = load %struct.trie** %curr.2.in, align 8, !dbg !563
  %179 = icmp eq %struct.trie* %curr.2, null, !dbg !563
  br i1 %179, label %.preheader4, label %.lr.ph23, !dbg !563

; <label>:180                                     ; preds = %174
  store i32 %175, i32* %176, align 4, !dbg !576, !tbaa !442
  br label %.backedge, !dbg !576

.preheader2:                                      ; preds = %.preheader4, %.preheader2
  %indvars.iv43 = phi i64 [ %indvars.iv.next44, %.preheader2 ], [ 0, %.preheader4 ]
  %181 = getelementptr inbounds i8* %164, i64 %indvars.iv43, !dbg !577
  %182 = load i8* %181, align 1, !dbg !577, !tbaa !397
  %183 = zext i8 %182 to i64, !dbg !577
  %184 = getelementptr inbounds [256 x %struct.trie*]* %next, i64 0, i64 %183, !dbg !577
  %185 = load %struct.trie** %184, align 8, !dbg !577, !tbaa !400
  %186 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 6, i64 %indvars.iv43, !dbg !577
  store %struct.trie* %185, %struct.trie** %186, align 8, !dbg !577, !tbaa !400
  %indvars.iv.next44 = add nuw nsw i64 %indvars.iv43, 1, !dbg !579
  %exitcond45 = icmp eq i64 %indvars.iv.next44, 256, !dbg !579
  br i1 %exitcond45, label %.loopexit3, label %.preheader2, !dbg !579

; <label>:187                                     ; preds = %.preheader4
  %188 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 6, !dbg !580
  %189 = bitcast [256 x %struct.trie*]* %188 to i8*, !dbg !580
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %189, i8* %1, i64 2048, i32 8, i1 false), !dbg !580
  br label %.loopexit3

.loopexit3:                                       ; preds = %.preheader2, %187, %._crit_edge
  %190 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !581
  %191 = load i8** %190, align 8, !dbg !581, !tbaa !370
  call void @llvm.dbg.value(metadata !{i8* %191}, i64 0, metadata !181), !dbg !581
  %192 = icmp eq i8* %191, null, !dbg !581
  br i1 %192, label %199, label %.preheader, !dbg !581

.preheader:                                       ; preds = %.loopexit3, %.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %.preheader ], [ 0, %.loopexit3 ]
  %193 = getelementptr inbounds i8* %191, i64 %indvars.iv, !dbg !583
  %194 = load i8* %193, align 1, !dbg !583, !tbaa !397
  %195 = zext i8 %194 to i64, !dbg !583
  %196 = getelementptr inbounds [256 x i8]* %delta, i64 0, i64 %195, !dbg !583
  %197 = load i8* %196, align 1, !dbg !583, !tbaa !397
  %198 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %indvars.iv, !dbg !583
  store i8 %197, i8* %198, align 1, !dbg !583, !tbaa !397
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !585
  %exitcond = icmp eq i64 %indvars.iv.next, 256, !dbg !585
  br i1 %exitcond, label %.loopexit, label %.preheader, !dbg !585

; <label>:199                                     ; preds = %.loopexit3
  %200 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 0, !dbg !586
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %200, i8* %2, i64 256, i32 8, i1 false), !dbg !586
  br label %.loopexit

.loopexit:                                        ; preds = %.preheader, %199, %59
  %.0 = phi i8* [ %60, %59 ], [ null, %199 ], [ null, %.preheader ]
  call void @llvm.lifetime.end(i64 256, i8* %2) #4, !dbg !587
  ret i8* %.0, !dbg !587
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define internal fastcc void @enqueue(%struct.tree* readonly %tree, %struct.trie** %last) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %tree}, i64 0, metadata !309), !dbg !588
  tail call void @llvm.dbg.value(metadata !{%struct.trie** %last}, i64 0, metadata !310), !dbg !588
  %1 = icmp eq %struct.tree* %tree, null, !dbg !589
  br i1 %1, label %11, label %2, !dbg !589

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 0, !dbg !591
  %4 = load %struct.tree** %3, align 8, !dbg !591, !tbaa !449
  tail call fastcc void @enqueue(%struct.tree* %4, %struct.trie** %last), !dbg !591
  %5 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 1, !dbg !592
  %6 = load %struct.tree** %5, align 8, !dbg !592, !tbaa !451
  tail call fastcc void @enqueue(%struct.tree* %6, %struct.trie** %last), !dbg !592
  %7 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 2, !dbg !593
  %8 = load %struct.trie** %7, align 8, !dbg !593, !tbaa !427
  %9 = load %struct.trie** %last, align 8, !dbg !593, !tbaa !400
  %10 = getelementptr inbounds %struct.trie* %9, i64 0, i32 3, !dbg !593
  store %struct.trie* %8, %struct.trie** %10, align 8, !dbg !593, !tbaa !562
  store %struct.trie* %8, %struct.trie** %last, align 8, !dbg !593, !tbaa !400
  ret void, !dbg !594

; <label>:11                                      ; preds = %0
  ret void, !dbg !594
}

; Function Attrs: nounwind uwtable
define internal fastcc void @treedelta(%struct.tree* readonly %tree, i32 %depth, i8* %delta) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %tree}, i64 0, metadata !302), !dbg !595
  tail call void @llvm.dbg.value(metadata !{i32 %depth}, i64 0, metadata !303), !dbg !596
  tail call void @llvm.dbg.value(metadata !{i8* %delta}, i64 0, metadata !304), !dbg !597
  %1 = icmp eq %struct.tree* %tree, null, !dbg !598
  br i1 %1, label %16, label %2, !dbg !598

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 0, !dbg !600
  %4 = load %struct.tree** %3, align 8, !dbg !600, !tbaa !449
  tail call fastcc void @treedelta(%struct.tree* %4, i32 %depth, i8* %delta), !dbg !600
  %5 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 1, !dbg !601
  %6 = load %struct.tree** %5, align 8, !dbg !601, !tbaa !451
  tail call fastcc void @treedelta(%struct.tree* %6, i32 %depth, i8* %delta), !dbg !601
  %7 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 3, !dbg !602
  %8 = load i8* %7, align 1, !dbg !602, !tbaa !404
  %9 = zext i8 %8 to i64, !dbg !602
  %10 = getelementptr inbounds i8* %delta, i64 %9, !dbg !602
  %11 = load i8* %10, align 1, !dbg !602, !tbaa !397
  %12 = zext i8 %11 to i32, !dbg !602
  %13 = icmp ugt i32 %12, %depth, !dbg !602
  br i1 %13, label %14, label %16, !dbg !602

; <label>:14                                      ; preds = %2
  %15 = trunc i32 %depth to i8, !dbg !604
  store i8 %15, i8* %10, align 1, !dbg !604, !tbaa !397
  br label %16, !dbg !604

; <label>:16                                      ; preds = %0, %14, %2
  ret void, !dbg !605
}

; Function Attrs: nounwind uwtable
define internal fastcc void @treefails(%struct.tree* readonly %tree, %struct.trie* readonly %fail, %struct.trie* %recourse) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %tree}, i64 0, metadata !293), !dbg !606
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %fail}, i64 0, metadata !294), !dbg !606
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %recourse}, i64 0, metadata !295), !dbg !607
  %1 = icmp eq %struct.tree* %tree, null, !dbg !608
  br i1 %1, label %32, label %2, !dbg !608

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 0, !dbg !610
  %4 = load %struct.tree** %3, align 8, !dbg !610, !tbaa !449
  tail call fastcc void @treefails(%struct.tree* %4, %struct.trie* %fail, %struct.trie* %recourse), !dbg !610
  %5 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 1, !dbg !611
  %6 = load %struct.tree** %5, align 8, !dbg !611, !tbaa !451
  tail call fastcc void @treefails(%struct.tree* %6, %struct.trie* %fail, %struct.trie* %recourse), !dbg !611
  %7 = icmp eq %struct.trie* %fail, null, !dbg !612
  br i1 %7, label %._crit_edge, label %.lr.ph6, !dbg !612

.lr.ph6:                                          ; preds = %2
  %8 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 3, !dbg !613
  br label %9, !dbg !612

; <label>:9                                       ; preds = %.lr.ph6, %.critedge1
  %.05 = phi %struct.trie* [ %fail, %.lr.ph6 ], [ %27, %.critedge1 ]
  %10 = getelementptr inbounds %struct.trie* %.05, i64 0, i32 1, !dbg !615
  %kwset_link.03 = load %struct.tree** %10, align 8, !dbg !615
  %11 = icmp eq %struct.tree* %kwset_link.03, null, !dbg !613
  br i1 %11, label %.critedge1, label %.lr.ph, !dbg !613

.lr.ph:                                           ; preds = %9
  %12 = load i8* %8, align 1, !dbg !613, !tbaa !404
  br label %13, !dbg !613

; <label>:13                                      ; preds = %.lr.ph, %.backedge
  %kwset_link.04 = phi %struct.tree* [ %kwset_link.03, %.lr.ph ], [ %kwset_link.0, %.backedge ]
  %14 = getelementptr inbounds %struct.tree* %kwset_link.04, i64 0, i32 3, !dbg !613
  %15 = load i8* %14, align 1, !dbg !613, !tbaa !404
  %16 = icmp eq i8 %12, %15, !dbg !613
  br i1 %16, label %.critedge, label %.backedge

.backedge:                                        ; preds = %13
  %17 = icmp ult i8 %12, %15, !dbg !616
  %18 = getelementptr inbounds %struct.tree* %kwset_link.04, i64 0, i32 0, !dbg !618
  %19 = getelementptr inbounds %struct.tree* %kwset_link.04, i64 0, i32 1, !dbg !619
  %kwset_link.0.in.be = select i1 %17, %struct.tree** %18, %struct.tree** %19, !dbg !616
  %kwset_link.0 = load %struct.tree** %kwset_link.0.in.be, align 8, !dbg !615
  %20 = icmp eq %struct.tree* %kwset_link.0, null, !dbg !613
  br i1 %20, label %.critedge1, label %13, !dbg !613

.critedge:                                        ; preds = %13
  %21 = getelementptr inbounds %struct.tree* %kwset_link.04, i64 0, i32 2, !dbg !620
  %22 = load %struct.trie** %21, align 8, !dbg !620, !tbaa !427
  %23 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 2, !dbg !620
  %24 = load %struct.trie** %23, align 8, !dbg !620, !tbaa !427
  %25 = getelementptr inbounds %struct.trie* %24, i64 0, i32 4, !dbg !620
  store %struct.trie* %22, %struct.trie** %25, align 8, !dbg !620, !tbaa !550
  br label %32, !dbg !623

.critedge1:                                       ; preds = %.backedge, %9
  %26 = getelementptr inbounds %struct.trie* %.05, i64 0, i32 4, !dbg !624
  %27 = load %struct.trie** %26, align 8, !dbg !624, !tbaa !550
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %27}, i64 0, metadata !294), !dbg !624
  %28 = icmp eq %struct.trie* %27, null, !dbg !612
  br i1 %28, label %._crit_edge, label %9, !dbg !612

._crit_edge:                                      ; preds = %.critedge1, %2
  %29 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 2, !dbg !625
  %30 = load %struct.trie** %29, align 8, !dbg !625, !tbaa !427
  %31 = getelementptr inbounds %struct.trie* %30, i64 0, i32 4, !dbg !625
  store %struct.trie* %recourse, %struct.trie** %31, align 8, !dbg !625, !tbaa !550
  br label %32, !dbg !626

; <label>:32                                      ; preds = %0, %._crit_edge, %.critedge
  ret void, !dbg !626
}

; Function Attrs: nounwind readonly uwtable
define internal fastcc i32 @hasevery(%struct.tree* readonly %a, %struct.tree* readonly %b) #6 {
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %a}, i64 0, metadata !287), !dbg !627
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %b}, i64 0, metadata !288), !dbg !627
  %1 = icmp eq %struct.tree* %b, null, !dbg !628
  br i1 %1, label %.critedge, label %2, !dbg !628

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct.tree* %b, i64 0, i32 0, !dbg !630
  %4 = load %struct.tree** %3, align 8, !dbg !630, !tbaa !449
  %5 = tail call fastcc i32 @hasevery(%struct.tree* %a, %struct.tree* %4), !dbg !630
  %6 = icmp eq i32 %5, 0, !dbg !630
  br i1 %6, label %.critedge, label %7, !dbg !630

; <label>:7                                       ; preds = %2
  %8 = getelementptr inbounds %struct.tree* %b, i64 0, i32 1, !dbg !632
  %9 = load %struct.tree** %8, align 8, !dbg !632, !tbaa !451
  %10 = tail call fastcc i32 @hasevery(%struct.tree* %a, %struct.tree* %9), !dbg !632
  %11 = icmp eq i32 %10, 0, !dbg !632
  %12 = icmp eq %struct.tree* %a, null, !dbg !634
  %or.cond = or i1 %11, %12, !dbg !632
  br i1 %or.cond, label %.critedge, label %.lr.ph, !dbg !632

.lr.ph:                                           ; preds = %7
  %13 = getelementptr inbounds %struct.tree* %b, i64 0, i32 3, !dbg !634
  %14 = load i8* %13, align 1, !dbg !634, !tbaa !404
  br label %15, !dbg !634

; <label>:15                                      ; preds = %.backedge, %.lr.ph
  %.012 = phi %struct.tree* [ %a, %.lr.ph ], [ %.01.be, %.backedge ]
  %16 = getelementptr inbounds %struct.tree* %.012, i64 0, i32 3, !dbg !634
  %17 = load i8* %16, align 1, !dbg !634, !tbaa !404
  %18 = icmp eq i8 %14, %17, !dbg !634
  br i1 %18, label %.critedge, label %.backedge

.backedge:                                        ; preds = %15
  %19 = icmp ult i8 %14, %17, !dbg !635
  %20 = getelementptr inbounds %struct.tree* %.012, i64 0, i32 0, !dbg !637
  %21 = getelementptr inbounds %struct.tree* %.012, i64 0, i32 1, !dbg !638
  %.01.be.in = select i1 %19, %struct.tree** %20, %struct.tree** %21, !dbg !635
  %.01.be = load %struct.tree** %.01.be.in, align 8, !dbg !637
  %22 = icmp eq %struct.tree* %.01.be, null, !dbg !634
  br i1 %22, label %.critedge, label %15, !dbg !634

.critedge:                                        ; preds = %15, %.backedge, %7, %2, %0
  %.0 = phi i32 [ 1, %0 ], [ 0, %2 ], [ 0, %7 ], [ 1, %15 ], [ 0, %.backedge ]
  ret i32 %.0, !dbg !639
}

; Function Attrs: nounwind uwtable
define internal fastcc void @treenext(%struct.tree* readonly %tree, %struct.trie** %next) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.tree* %tree}, i64 0, metadata !281), !dbg !640
  tail call void @llvm.dbg.value(metadata !{%struct.trie** %next}, i64 0, metadata !282), !dbg !640
  %1 = icmp eq %struct.tree* %tree, null, !dbg !641
  br i1 %1, label %13, label %2, !dbg !641

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 0, !dbg !643
  %4 = load %struct.tree** %3, align 8, !dbg !643, !tbaa !449
  tail call fastcc void @treenext(%struct.tree* %4, %struct.trie** %next), !dbg !643
  %5 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 1, !dbg !644
  %6 = load %struct.tree** %5, align 8, !dbg !644, !tbaa !451
  tail call fastcc void @treenext(%struct.tree* %6, %struct.trie** %next), !dbg !644
  %7 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 2, !dbg !645
  %8 = load %struct.trie** %7, align 8, !dbg !645, !tbaa !427
  %9 = getelementptr inbounds %struct.tree* %tree, i64 0, i32 3, !dbg !645
  %10 = load i8* %9, align 1, !dbg !645, !tbaa !404
  %11 = zext i8 %10 to i64, !dbg !645
  %12 = getelementptr inbounds %struct.trie** %next, i64 %11, !dbg !645
  store %struct.trie* %8, %struct.trie** %12, align 8, !dbg !645, !tbaa !400
  ret void, !dbg !646

; <label>:13                                      ; preds = %0
  ret void, !dbg !646
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: nounwind uwtable
define i64 @kwsexec(%struct.kwset* %kws, i8* %text, i64 %size, %struct.kwsmatch* nocapture %kwsmatch) #0 {
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !211), !dbg !647
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !212), !dbg !647
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !213), !dbg !647
  tail call void @llvm.dbg.value(metadata !{%struct.kwsmatch* %kwsmatch}, i64 0, metadata !214), !dbg !647
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !215), !dbg !648
  %1 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 1, !dbg !649
  %2 = load i32* %1, align 4, !dbg !649, !tbaa !320
  %3 = icmp eq i32 %2, 1, !dbg !649
  br i1 %3, label %4, label %183, !dbg !649

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !649
  %6 = load i8** %5, align 8, !dbg !649, !tbaa !370
  %7 = icmp eq i8* %6, null, !dbg !649
  br i1 %7, label %8, label %183, !dbg !649

; <label>:8                                       ; preds = %4
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !650) #4, !dbg !652
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !653) #4, !dbg !652
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !654) #4, !dbg !652
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !655) #4, !dbg !656
  %9 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 3, !dbg !657
  %10 = load i32* %9, align 4, !dbg !657, !tbaa !364
  tail call void @llvm.dbg.value(metadata !{i32 %10}, i64 0, metadata !658) #4, !dbg !657
  %11 = icmp eq i32 %10, 0, !dbg !659
  %.pre = sext i32 %10 to i64, !dbg !661
  br i1 %11, label %bmexec.exit.thread11, label %12, !dbg !659

; <label>:12                                      ; preds = %8
  %13 = icmp ugt i64 %.pre, %size, !dbg !664
  br i1 %13, label %cwexec.exit, label %14, !dbg !664

; <label>:14                                      ; preds = %12
  %15 = icmp eq i32 %10, 1, !dbg !666
  %16 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 7, !dbg !668
  %17 = load i8** %16, align 8, !dbg !668, !tbaa !368
  br i1 %15, label %18, label %27, !dbg !666

; <label>:18                                      ; preds = %14
  %19 = load i8* %17, align 1, !dbg !668, !tbaa !397
  %20 = sext i8 %19 to i32, !dbg !668
  %21 = tail call i8* @memchr(i8* %text, i32 %20, i64 %size) #9, !dbg !668
  tail call void @llvm.dbg.value(metadata !{i8* %21}, i64 0, metadata !670) #4, !dbg !668
  %22 = icmp eq i8* %21, null, !dbg !671
  br i1 %22, label %cwexec.exit, label %23, !dbg !671

; <label>:23                                      ; preds = %18
  %24 = ptrtoint i8* %21 to i64, !dbg !671
  %25 = ptrtoint i8* %text to i64, !dbg !671
  %26 = sub i64 %24, %25, !dbg !671
  br label %bmexec.exit, !dbg !671

; <label>:27                                      ; preds = %14
  %.sum.i = add i64 %.pre, -2, !dbg !672
  %28 = getelementptr inbounds i8* %17, i64 %.sum.i, !dbg !672
  %29 = load i8* %28, align 1, !dbg !672, !tbaa !397
  %30 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 8, !dbg !673
  %31 = load i32* %30, align 4, !dbg !673, !tbaa !538
  tail call void @llvm.dbg.value(metadata !{i32 %31}, i64 0, metadata !674) #4, !dbg !673
  %32 = getelementptr inbounds i8* %text, i64 %.pre, !dbg !675
  tail call void @llvm.dbg.value(metadata !{i8* %32}, i64 0, metadata !670) #4, !dbg !675
  %33 = mul nsw i32 %10, 12, !dbg !676
  %34 = sext i32 %33 to i64, !dbg !676
  %35 = icmp ult i64 %34, %size, !dbg !676
  br i1 %35, label %36, label %.loopexit30.i, !dbg !676

; <label>:36                                      ; preds = %27
  %37 = mul nsw i32 %10, 11, !dbg !678
  %38 = sext i32 %37 to i64, !dbg !678
  %.sum7.i = sub i64 %size, %38, !dbg !678
  %39 = getelementptr inbounds i8* %text, i64 %.sum7.i, !dbg !678
  tail call void @llvm.dbg.value(metadata !{i8* %39}, i64 0, metadata !680) #4, !dbg !678
  %40 = icmp sgt i64 %.pre, %.sum7.i, !dbg !681
  br i1 %40, label %.loopexit30.i, label %.lr.ph46.i, !dbg !681

.lr.ph46.i:                                       ; preds = %36
  %41 = sext i32 %31 to i64, !dbg !683
  %42 = icmp slt i32 %10, 3, !dbg !684
  br label %43, !dbg !681

; <label>:43                                      ; preds = %.backedge.i, %.lr.ph46.i
  %tp.044.i = phi i8* [ %32, %.lr.ph46.i ], [ %tp.0.be.i, %.backedge.i ]
  %44 = getelementptr inbounds i8* %tp.044.i, i64 -1, !dbg !688
  %45 = load i8* %44, align 1, !dbg !688, !tbaa !397
  %46 = zext i8 %45 to i64, !dbg !688
  %47 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %46, !dbg !688
  %48 = load i8* %47, align 1, !dbg !688, !tbaa !397
  %49 = zext i8 %48 to i64, !dbg !688
  %.sum8.i = add i64 %49, -1, !dbg !690
  %50 = getelementptr inbounds i8* %tp.044.i, i64 %.sum8.i, !dbg !690
  %51 = load i8* %50, align 1, !dbg !690, !tbaa !397
  %52 = zext i8 %51 to i64, !dbg !690
  %53 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %52, !dbg !690
  %54 = load i8* %53, align 1, !dbg !690, !tbaa !397
  %55 = zext i8 %54 to i64, !dbg !690
  %.sum9.i = add i64 %55, %49, !dbg !690
  %56 = getelementptr inbounds i8* %tp.044.i, i64 %.sum9.i, !dbg !690
  tail call void @llvm.dbg.value(metadata !{i8* %56}, i64 0, metadata !670) #4, !dbg !690
  %57 = icmp eq i8 %54, 0, !dbg !691
  br i1 %57, label %115, label %58, !dbg !691

; <label>:58                                      ; preds = %43
  %.sum10.i = add i64 %.sum9.i, -1, !dbg !693
  %59 = getelementptr inbounds i8* %tp.044.i, i64 %.sum10.i, !dbg !693
  %60 = load i8* %59, align 1, !dbg !693, !tbaa !397
  %61 = zext i8 %60 to i64, !dbg !693
  %62 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %61, !dbg !693
  %63 = load i8* %62, align 1, !dbg !693, !tbaa !397
  %64 = zext i8 %63 to i64, !dbg !693
  %.sum11.i = add i64 %64, %.sum9.i, !dbg !693
  %.sum12.i = add i64 %.sum11.i, -1, !dbg !694
  %65 = getelementptr inbounds i8* %tp.044.i, i64 %.sum12.i, !dbg !694
  %66 = load i8* %65, align 1, !dbg !694, !tbaa !397
  %67 = zext i8 %66 to i64, !dbg !694
  %68 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %67, !dbg !694
  %69 = load i8* %68, align 1, !dbg !694, !tbaa !397
  %70 = zext i8 %69 to i64, !dbg !694
  %.sum13.i = add i64 %70, %.sum11.i, !dbg !694
  %.sum14.i = add i64 %.sum13.i, -1, !dbg !695
  %71 = getelementptr inbounds i8* %tp.044.i, i64 %.sum14.i, !dbg !695
  %72 = load i8* %71, align 1, !dbg !695, !tbaa !397
  %73 = zext i8 %72 to i64, !dbg !695
  %74 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %73, !dbg !695
  %75 = load i8* %74, align 1, !dbg !695, !tbaa !397
  %76 = zext i8 %75 to i64, !dbg !695
  %.sum15.i = add i64 %76, %.sum13.i, !dbg !695
  %77 = getelementptr inbounds i8* %tp.044.i, i64 %.sum15.i, !dbg !695
  tail call void @llvm.dbg.value(metadata !{i8* %77}, i64 0, metadata !670) #4, !dbg !695
  %78 = icmp eq i8 %75, 0, !dbg !696
  br i1 %78, label %115, label %79, !dbg !696

; <label>:79                                      ; preds = %58
  %.sum16.i = add i64 %.sum15.i, -1, !dbg !698
  %80 = getelementptr inbounds i8* %tp.044.i, i64 %.sum16.i, !dbg !698
  %81 = load i8* %80, align 1, !dbg !698, !tbaa !397
  %82 = zext i8 %81 to i64, !dbg !698
  %83 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %82, !dbg !698
  %84 = load i8* %83, align 1, !dbg !698, !tbaa !397
  %85 = zext i8 %84 to i64, !dbg !698
  %.sum17.i = add i64 %85, %.sum15.i, !dbg !698
  %.sum18.i = add i64 %.sum17.i, -1, !dbg !699
  %86 = getelementptr inbounds i8* %tp.044.i, i64 %.sum18.i, !dbg !699
  %87 = load i8* %86, align 1, !dbg !699, !tbaa !397
  %88 = zext i8 %87 to i64, !dbg !699
  %89 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %88, !dbg !699
  %90 = load i8* %89, align 1, !dbg !699, !tbaa !397
  %91 = zext i8 %90 to i64, !dbg !699
  %.sum19.i = add i64 %91, %.sum17.i, !dbg !699
  %.sum20.i = add i64 %.sum19.i, -1, !dbg !700
  %92 = getelementptr inbounds i8* %tp.044.i, i64 %.sum20.i, !dbg !700
  %93 = load i8* %92, align 1, !dbg !700, !tbaa !397
  %94 = zext i8 %93 to i64, !dbg !700
  %95 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %94, !dbg !700
  %96 = load i8* %95, align 1, !dbg !700, !tbaa !397
  %97 = zext i8 %96 to i64, !dbg !700
  %.sum21.i = add i64 %97, %.sum19.i, !dbg !700
  %98 = getelementptr inbounds i8* %tp.044.i, i64 %.sum21.i, !dbg !700
  tail call void @llvm.dbg.value(metadata !{i8* %98}, i64 0, metadata !670) #4, !dbg !700
  %99 = icmp eq i8 %96, 0, !dbg !701
  br i1 %99, label %115, label %100, !dbg !701

; <label>:100                                     ; preds = %79
  %.sum22.i = add i64 %.sum21.i, -1, !dbg !703
  %101 = getelementptr inbounds i8* %tp.044.i, i64 %.sum22.i, !dbg !703
  %102 = load i8* %101, align 1, !dbg !703, !tbaa !397
  %103 = zext i8 %102 to i64, !dbg !703
  %104 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %103, !dbg !703
  %105 = load i8* %104, align 1, !dbg !703, !tbaa !397
  %106 = zext i8 %105 to i64, !dbg !703
  %.sum23.i = add i64 %106, %.sum21.i, !dbg !703
  %.sum24.i = add i64 %.sum23.i, -1, !dbg !704
  %107 = getelementptr inbounds i8* %tp.044.i, i64 %.sum24.i, !dbg !704
  %108 = load i8* %107, align 1, !dbg !704, !tbaa !397
  %109 = zext i8 %108 to i64, !dbg !704
  %110 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %109, !dbg !704
  %111 = load i8* %110, align 1, !dbg !704, !tbaa !397
  %112 = zext i8 %111 to i64, !dbg !704
  %.sum25.i = add i64 %112, %.sum23.i, !dbg !704
  %113 = getelementptr inbounds i8* %tp.044.i, i64 %.sum25.i, !dbg !704
  tail call void @llvm.dbg.value(metadata !{i8* %113}, i64 0, metadata !670) #4, !dbg !704
  br label %.backedge.i, !dbg !705

.backedge.i:                                      ; preds = %.critedge.thread27.i, %100
  %tp.0.be.i = phi i8* [ %134, %.critedge.thread27.i ], [ %113, %100 ]
  %114 = icmp ugt i8* %tp.0.be.i, %39, !dbg !681
  br i1 %114, label %.loopexit30.i, label %43, !dbg !681

; <label>:115                                     ; preds = %79, %58, %43
  %tp.1.i = phi i8* [ %56, %43 ], [ %77, %58 ], [ %98, %79 ]
  %116 = getelementptr inbounds i8* %tp.1.i, i64 -2, !dbg !706
  %117 = load i8* %116, align 1, !dbg !706, !tbaa !397
  %118 = icmp eq i8 %117, %29, !dbg !706
  br i1 %118, label %.preheader29.i, label %.critedge.thread27.i, !dbg !706

.preheader29.i:                                   ; preds = %115
  br i1 %42, label %._crit_edge42.i, label %.lr.ph41.i, !dbg !684

; <label>:119                                     ; preds = %.lr.ph41.i
  %120 = trunc i64 %indvars.iv56.i to i32, !dbg !684
  %indvars.iv.next57.i = add nuw nsw i64 %indvars.iv56.i, 1, !dbg !684
  %121 = icmp slt i32 %120, %10, !dbg !684
  br i1 %121, label %.lr.ph41.i, label %._crit_edge42.i, !dbg !684

.lr.ph41.i:                                       ; preds = %.preheader29.i, %119
  %indvars.iv56.i = phi i64 [ %indvars.iv.next57.i, %119 ], [ 3, %.preheader29.i ]
  %122 = sub i64 0, %indvars.iv56.i, !dbg !684
  %sext58.i = shl i64 %122, 32, !dbg !684
  %123 = ashr exact i64 %sext58.i, 32, !dbg !684
  %124 = getelementptr inbounds i8* %tp.1.i, i64 %123, !dbg !684
  %125 = load i8* %124, align 1, !dbg !684, !tbaa !397
  %.sum26.i = add i64 %123, %.pre, !dbg !684
  %126 = getelementptr inbounds i8* %17, i64 %.sum26.i, !dbg !684
  %127 = load i8* %126, align 1, !dbg !684, !tbaa !397
  %128 = icmp eq i8 %125, %127, !dbg !684
  br i1 %128, label %119, label %.critedge.thread27.i

._crit_edge42.i:                                  ; preds = %.preheader29.i, %119
  %129 = sub i64 0, %.pre, !dbg !707
  %130 = getelementptr inbounds i8* %tp.1.i, i64 %129, !dbg !707
  %131 = ptrtoint i8* %130 to i64, !dbg !707
  %132 = ptrtoint i8* %text to i64, !dbg !707
  %133 = sub i64 %131, %132, !dbg !707
  br label %bmexec.exit, !dbg !707

.critedge.thread27.i:                             ; preds = %.lr.ph41.i, %115
  %134 = getelementptr inbounds i8* %tp.1.i, i64 %41, !dbg !683
  tail call void @llvm.dbg.value(metadata !{i8* %134}, i64 0, metadata !670) #4, !dbg !683
  br label %.backedge.i, !dbg !709

.loopexit30.i:                                    ; preds = %.backedge.i, %36, %27
  %tp.2.i = phi i8* [ %32, %27 ], [ %32, %36 ], [ %tp.0.be.i, %.backedge.i ]
  %135 = getelementptr inbounds i8* %text, i64 %size, !dbg !710
  tail call void @llvm.dbg.value(metadata !{i8* %135}, i64 0, metadata !680) #4, !dbg !710
  %136 = getelementptr inbounds i8* %tp.2.i, i64 -1, !dbg !711
  %137 = load i8* %136, align 1, !dbg !711, !tbaa !397
  %138 = zext i8 %137 to i64, !dbg !711
  %139 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %138, !dbg !711
  %140 = load i8* %139, align 1, !dbg !711, !tbaa !397
  %141 = zext i8 %140 to i64, !dbg !712
  %142 = ptrtoint i8* %135 to i64, !dbg !712
  %143 = ptrtoint i8* %tp.2.i to i64, !dbg !712
  %144 = sub i64 %142, %143, !dbg !712
  %145 = icmp sgt i64 %141, %144, !dbg !712
  br i1 %145, label %cwexec.exit, label %.lr.ph38.i, !dbg !712

.lr.ph38.i:                                       ; preds = %.loopexit30.i
  %146 = icmp slt i32 %10, 3, !dbg !713
  br label %147, !dbg !712

; <label>:147                                     ; preds = %.critedge1.thread28.backedge.i, %.lr.ph38.i
  %148 = phi i64 [ %141, %.lr.ph38.i ], [ %157, %.critedge1.thread28.backedge.i ]
  %tp.336.i = phi i8* [ %tp.2.i, %.lr.ph38.i ], [ %149, %.critedge1.thread28.backedge.i ]
  %149 = getelementptr inbounds i8* %tp.336.i, i64 %148, !dbg !718
  tail call void @llvm.dbg.value(metadata !{i8* %149}, i64 0, metadata !670) #4, !dbg !718
  %.sum2.i = add i64 %148, -1, !dbg !718
  %150 = getelementptr inbounds i8* %tp.336.i, i64 %.sum2.i, !dbg !718
  %151 = load i8* %150, align 1, !dbg !718, !tbaa !397
  %152 = zext i8 %151 to i64, !dbg !718
  %153 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %152, !dbg !718
  %154 = load i8* %153, align 1, !dbg !718, !tbaa !397
  %155 = zext i8 %154 to i32, !dbg !718
  tail call void @llvm.dbg.value(metadata !{i32 %155}, i64 0, metadata !719) #4, !dbg !718
  %156 = icmp eq i8 %154, 0, !dbg !720
  br i1 %156, label %161, label %.critedge1.thread28.backedge.i, !dbg !720

.critedge1.thread28.backedge.i:                   ; preds = %.lr.ph.i, %161, %147
  %d.0.be.i = phi i32 [ %155, %147 ], [ %31, %161 ], [ %31, %.lr.ph.i ]
  %157 = sext i32 %d.0.be.i to i64, !dbg !712
  %158 = ptrtoint i8* %149 to i64, !dbg !712
  %159 = sub i64 %142, %158, !dbg !712
  %160 = icmp sgt i64 %157, %159, !dbg !712
  br i1 %160, label %cwexec.exit, label %147, !dbg !712

; <label>:161                                     ; preds = %147
  %.sum3.i = add i64 %148, -2, !dbg !722
  %162 = getelementptr inbounds i8* %tp.336.i, i64 %.sum3.i, !dbg !722
  %163 = load i8* %162, align 1, !dbg !722, !tbaa !397
  %164 = icmp eq i8 %163, %29, !dbg !722
  br i1 %164, label %.preheader.i, label %.critedge1.thread28.backedge.i, !dbg !722

.preheader.i:                                     ; preds = %161
  br i1 %146, label %._crit_edge.i, label %.lr.ph.i, !dbg !713

; <label>:165                                     ; preds = %.lr.ph.i
  %166 = trunc i64 %indvars.iv.i to i32, !dbg !713
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1, !dbg !713
  %167 = icmp slt i32 %166, %10, !dbg !713
  br i1 %167, label %.lr.ph.i, label %._crit_edge.i, !dbg !713

.lr.ph.i:                                         ; preds = %.preheader.i, %165
  %indvars.iv.i = phi i64 [ %indvars.iv.next.i, %165 ], [ 3, %.preheader.i ]
  %168 = sub i64 0, %indvars.iv.i, !dbg !713
  %sext.i = shl i64 %168, 32, !dbg !713
  %169 = ashr exact i64 %sext.i, 32, !dbg !713
  %.sum5.i = add i64 %169, %148, !dbg !713
  %170 = getelementptr inbounds i8* %tp.336.i, i64 %.sum5.i, !dbg !713
  %171 = load i8* %170, align 1, !dbg !713, !tbaa !397
  %.sum6.i = add i64 %169, %.pre, !dbg !713
  %172 = getelementptr inbounds i8* %17, i64 %.sum6.i, !dbg !713
  %173 = load i8* %172, align 1, !dbg !713, !tbaa !397
  %174 = icmp eq i8 %171, %173, !dbg !713
  br i1 %174, label %165, label %.critedge1.thread28.backedge.i

._crit_edge.i:                                    ; preds = %.preheader.i, %165
  %.sum4.i = sub i64 %148, %.pre, !dbg !723
  %175 = getelementptr inbounds i8* %tp.336.i, i64 %.sum4.i, !dbg !723
  %176 = ptrtoint i8* %175 to i64, !dbg !723
  %177 = ptrtoint i8* %text to i64, !dbg !723
  %178 = sub i64 %176, %177, !dbg !723
  br label %bmexec.exit, !dbg !723

bmexec.exit:                                      ; preds = %23, %._crit_edge42.i, %._crit_edge.i
  %.0.i = phi i64 [ %133, %._crit_edge42.i ], [ %178, %._crit_edge.i ], [ %26, %23 ]
  tail call void @llvm.dbg.value(metadata !{i64 %.0.i12}, i64 0, metadata !218), !dbg !651
  %179 = icmp eq i64 %.0.i, -1, !dbg !725
  br i1 %179, label %cwexec.exit, label %bmexec.exit.thread11, !dbg !725

bmexec.exit.thread11:                             ; preds = %8, %bmexec.exit
  %.0.i12 = phi i64 [ %.0.i, %bmexec.exit ], [ 0, %8 ]
  %180 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 0, !dbg !726
  store i32 0, i32* %180, align 4, !dbg !726, !tbaa !727
  %181 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 1, i64 0, !dbg !729
  store i64 %.0.i12, i64* %181, align 8, !dbg !729, !tbaa !730
  %182 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 2, i64 0, !dbg !661
  store i64 %.pre, i64* %182, align 8, !dbg !661, !tbaa !730
  br label %cwexec.exit, !dbg !731

; <label>:183                                     ; preds = %4, %0
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !732), !dbg !734
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !735), !dbg !734
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !736), !dbg !734
  tail call void @llvm.dbg.value(metadata !{%struct.kwsmatch* %kwsmatch}, i64 0, metadata !737), !dbg !734
  tail call void @llvm.dbg.value(metadata !{%struct.kwset* %kws}, i64 0, metadata !738), !dbg !739
  %184 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 3, !dbg !740
  %185 = load i32* %184, align 4, !dbg !740, !tbaa !364
  %186 = sext i32 %185 to i64, !dbg !740
  %187 = icmp ugt i64 %186, %size, !dbg !740
  br i1 %187, label %cwexec.exit, label %188, !dbg !740

; <label>:188                                     ; preds = %183
  %189 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 9, !dbg !742
  %190 = load i8** %189, align 8, !dbg !742, !tbaa !370
  tail call void @llvm.dbg.value(metadata !{i8* %190}, i64 0, metadata !743), !dbg !742
  %191 = getelementptr inbounds i8* %text, i64 %size, !dbg !744
  tail call void @llvm.dbg.value(metadata !{i8* %191}, i64 0, metadata !745), !dbg !744
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !746), !dbg !747
  tail call void @llvm.dbg.value(metadata !{i32 %185}, i64 0, metadata !748), !dbg !749
  %192 = icmp eq i32 %185, 0, !dbg !749
  br i1 %192, label %197, label %193, !dbg !749

; <label>:193                                     ; preds = %188
  tail call void @llvm.dbg.value(metadata !352, i64 0, metadata !751), !dbg !752
  %194 = shl nsw i32 %185, 2, !dbg !753
  %195 = sext i32 %194 to i64, !dbg !753
  %196 = icmp ugt i64 %195, %size, !dbg !753
  br i1 %196, label %.preheader18.i, label %200, !dbg !753

; <label>:197                                     ; preds = %188
  tail call void @llvm.dbg.value(metadata !{i8* %text}, i64 0, metadata !751), !dbg !755
  %198 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 2, !dbg !755
  %199 = load %struct.trie** %198, align 8, !dbg !755, !tbaa !343
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %199}, i64 0, metadata !757), !dbg !755
  br label %.preheader.i5, !dbg !758

; <label>:200                                     ; preds = %193
  %.sum7.i1 = sub i64 %size, %195, !dbg !759
  %201 = getelementptr inbounds i8* %text, i64 %.sum7.i1, !dbg !759
  tail call void @llvm.dbg.value(metadata !{i8* %201}, i64 0, metadata !760), !dbg !759
  br label %.preheader18.i, !dbg !759

.preheader18.i:                                   ; preds = %200, %193
  %qlim.0.ph.i = phi i8* [ null, %193 ], [ %201, %200 ]
  %202 = ptrtoint i8* %191 to i64, !dbg !761
  %203 = icmp eq i8* %qlim.0.ph.i, null, !dbg !762
  %204 = icmp eq i8* %190, null, !dbg !765
  br label %.outer20.i, !dbg !761

.outer20.i:                                       ; preds = %.critedge10.i, %.preheader18.i
  %accept.0.ph.i = phi %struct.trie* [ %accept.237.i, %.critedge10.i ], [ undef, %.preheader18.i ]
  %d.0.ph.i = phi i32 [ %d.241.i, %.critedge10.i ], [ %185, %.preheader18.i ]
  %end.0.ph.i = phi i8* [ %end.2.i, %.critedge10.i ], [ %text, %.preheader18.i ]
  br label %205

; <label>:205                                     ; preds = %251, %.outer20.i
  %d.0.i = phi i32 [ %d.1.i, %251 ], [ %d.0.ph.i, %.outer20.i ]
  %end.0.i = phi i8* [ %end.2.i, %251 ], [ %end.0.ph.i, %.outer20.i ]
  %206 = ptrtoint i8* %end.0.i to i64, !dbg !761
  %207 = sub i64 %202, %206, !dbg !761
  %208 = sext i32 %d.0.i to i64, !dbg !761
  %209 = icmp slt i64 %207, %208, !dbg !761
  br i1 %209, label %cwexec.exit, label %210, !dbg !761

; <label>:210                                     ; preds = %205
  %211 = icmp ugt i8* %end.0.i, %qlim.0.ph.i, !dbg !762
  %or.cond.i = or i1 %203, %211, !dbg !762
  br i1 %or.cond.i, label %244, label %212, !dbg !762

; <label>:212                                     ; preds = %210
  %213 = add nsw i32 %d.0.i, -1, !dbg !767
  %214 = sext i32 %213 to i64, !dbg !767
  %215 = getelementptr inbounds i8* %end.0.i, i64 %214, !dbg !767
  tail call void @llvm.dbg.value(metadata !{i8* %215}, i64 0, metadata !746), !dbg !767
  %216 = load i8* %215, align 1, !dbg !769, !tbaa !397
  %217 = zext i8 %216 to i64, !dbg !769
  %218 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %217, !dbg !769
  %219 = load i8* %218, align 1, !dbg !769, !tbaa !397
  %220 = icmp ne i8 %219, 0, !dbg !769
  %221 = icmp ult i8* %215, %qlim.0.ph.i, !dbg !769
  %or.cond967.i = and i1 %220, %221, !dbg !769
  br i1 %or.cond967.i, label %.lr.ph70.i, label %.critedge.i, !dbg !769

.lr.ph70.i:                                       ; preds = %212, %.lr.ph70.i
  %222 = phi i8 [ %240, %.lr.ph70.i ], [ %219, %212 ]
  %end.168.i = phi i8* [ %236, %.lr.ph70.i ], [ %215, %212 ]
  %223 = zext i8 %222 to i64, !dbg !770
  %224 = getelementptr inbounds i8* %end.168.i, i64 %223, !dbg !770
  tail call void @llvm.dbg.value(metadata !{i8* %224}, i64 0, metadata !746), !dbg !770
  %225 = load i8* %224, align 1, !dbg !772, !tbaa !397
  %226 = zext i8 %225 to i64, !dbg !772
  %227 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %226, !dbg !772
  %228 = load i8* %227, align 1, !dbg !772, !tbaa !397
  %229 = zext i8 %228 to i64, !dbg !772
  %.sum5.i2 = add i64 %229, %223, !dbg !772
  %230 = getelementptr inbounds i8* %end.168.i, i64 %.sum5.i2, !dbg !772
  tail call void @llvm.dbg.value(metadata !{i8* %230}, i64 0, metadata !746), !dbg !772
  %231 = load i8* %230, align 1, !dbg !773, !tbaa !397
  %232 = zext i8 %231 to i64, !dbg !773
  %233 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %232, !dbg !773
  %234 = load i8* %233, align 1, !dbg !773, !tbaa !397
  %235 = zext i8 %234 to i64, !dbg !773
  %.sum6.i3 = add i64 %235, %.sum5.i2, !dbg !773
  %236 = getelementptr inbounds i8* %end.168.i, i64 %.sum6.i3, !dbg !773
  tail call void @llvm.dbg.value(metadata !{i8* %236}, i64 0, metadata !746), !dbg !773
  %237 = load i8* %236, align 1, !dbg !769, !tbaa !397
  %238 = zext i8 %237 to i64, !dbg !769
  %239 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %238, !dbg !769
  %240 = load i8* %239, align 1, !dbg !769, !tbaa !397
  %241 = icmp ne i8 %240, 0, !dbg !769
  %242 = icmp ult i8* %236, %qlim.0.ph.i, !dbg !769
  %or.cond9.i = and i1 %241, %242, !dbg !769
  br i1 %or.cond9.i, label %.lr.ph70.i, label %.critedge.i, !dbg !769

.critedge.i:                                      ; preds = %.lr.ph70.i, %212
  %.lcssa34.i = phi i8 [ %219, %212 ], [ %240, %.lr.ph70.i ]
  %.lcssa33.i = phi i8 [ %216, %212 ], [ %237, %.lr.ph70.i ]
  %end.1.lcssa.i = phi i8* [ %215, %212 ], [ %236, %.lr.ph70.i ]
  %243 = getelementptr inbounds i8* %end.1.lcssa.i, i64 1, !dbg !774
  tail call void @llvm.dbg.value(metadata !{i8* %243}, i64 0, metadata !746), !dbg !774
  br label %251, !dbg !775

; <label>:244                                     ; preds = %210
  %245 = getelementptr inbounds i8* %end.0.i, i64 %208, !dbg !776
  tail call void @llvm.dbg.value(metadata !{i8* %245}, i64 0, metadata !746), !dbg !776
  %.sum4.i4 = add i64 %208, -1, !dbg !776
  %246 = getelementptr inbounds i8* %end.0.i, i64 %.sum4.i4, !dbg !776
  %247 = load i8* %246, align 1, !dbg !776, !tbaa !397
  tail call void @llvm.dbg.value(metadata !{i8 %247}, i64 0, metadata !777), !dbg !776
  %248 = zext i8 %247 to i64, !dbg !776
  %249 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %248, !dbg !776
  %250 = load i8* %249, align 1, !dbg !776, !tbaa !397
  br label %251

; <label>:251                                     ; preds = %244, %.critedge.i
  %c.0.i = phi i8 [ %.lcssa33.i, %.critedge.i ], [ %247, %244 ]
  %d.1.in.i = phi i8 [ %.lcssa34.i, %.critedge.i ], [ %250, %244 ]
  %end.2.i = phi i8* [ %243, %.critedge.i ], [ %245, %244 ]
  %d.1.i = zext i8 %d.1.in.i to i32, !dbg !769
  %252 = icmp eq i8 %d.1.in.i, 0, !dbg !778
  br i1 %252, label %253, label %205, !dbg !778

; <label>:253                                     ; preds = %251
  %254 = getelementptr inbounds i8* %end.2.i, i64 -1, !dbg !780
  tail call void @llvm.dbg.value(metadata !{i8* %254}, i64 0, metadata !781), !dbg !780
  %255 = zext i8 %c.0.i to i64, !dbg !782
  %256 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 6, i64 %255, !dbg !782
  %257 = load %struct.trie** %256, align 8, !dbg !782, !tbaa !400
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %257}, i64 0, metadata !783), !dbg !782
  %258 = getelementptr inbounds %struct.trie* %257, i64 0, i32 0, !dbg !784
  %259 = load i32* %258, align 4, !dbg !784, !tbaa !360
  %260 = icmp eq i32 %259, 0, !dbg !784
  tail call void @llvm.dbg.value(metadata !{i8* %254}, i64 0, metadata !751), !dbg !786
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %257}, i64 0, metadata !757), !dbg !788
  %accept.0..i = select i1 %260, %struct.trie* %accept.0.ph.i, %struct.trie* %257, !dbg !784
  %mch.0..i = select i1 %260, i8* null, i8* %254, !dbg !784
  %d.2.in81.i = getelementptr inbounds %struct.trie* %257, i64 0, i32 6, !dbg !789
  %d.282.i = load i32* %d.2.in81.i, align 4, !dbg !789
  %261 = icmp ugt i8* %254, %text, !dbg !790
  br i1 %261, label %.lr.ph89.i, label %.critedge10.i, !dbg !790

.lr.ph89.i:                                       ; preds = %253, %.critedge1.i
  %d.287.i = phi i32 [ %d.2.i, %.critedge1.i ], [ %d.282.i, %253 ]
  %trie.086.i = phi %struct.trie* [ %279, %.critedge1.i ], [ %257, %253 ]
  %mch.285.i = phi i8* [ %mch.2..i, %.critedge1.i ], [ %mch.0..i, %253 ]
  %beg.084.i = phi i8* [ %262, %.critedge1.i ], [ %254, %253 ]
  %accept.283.i = phi %struct.trie* [ %accept.2..i, %.critedge1.i ], [ %accept.0..i, %253 ]
  %262 = getelementptr inbounds i8* %beg.084.i, i64 -1, !dbg !765
  tail call void @llvm.dbg.value(metadata !{i8* %262}, i64 0, metadata !781), !dbg !765
  %263 = load i8* %262, align 1, !dbg !765, !tbaa !397
  br i1 %204, label %268, label %264, !dbg !765

; <label>:264                                     ; preds = %.lr.ph89.i
  %265 = zext i8 %263 to i64, !dbg !765
  %266 = getelementptr inbounds i8* %190, i64 %265, !dbg !765
  %267 = load i8* %266, align 1, !dbg !765, !tbaa !397
  br label %268, !dbg !765

; <label>:268                                     ; preds = %264, %.lr.ph89.i
  %.sink.i = phi i8 [ %267, %264 ], [ %263, %.lr.ph89.i ]
  tail call void @llvm.dbg.value(metadata !{i8 %.sink.i}, i64 0, metadata !777), !dbg !765
  %269 = getelementptr inbounds %struct.trie* %trie.086.i, i64 0, i32 1, !dbg !791
  %tree.074.i = load %struct.tree** %269, align 8, !dbg !791
  %270 = icmp eq %struct.tree* %tree.074.i, null, !dbg !792
  br i1 %270, label %.critedge10.i, label %.lr.ph77.i, !dbg !792

.lr.ph77.i:                                       ; preds = %268, %.backedge16.i
  %tree.075.i = phi %struct.tree* [ %tree.0.i, %.backedge16.i ], [ %tree.074.i, %268 ]
  %271 = getelementptr inbounds %struct.tree* %tree.075.i, i64 0, i32 3, !dbg !792
  %272 = load i8* %271, align 1, !dbg !792, !tbaa !404
  %273 = icmp eq i8 %.sink.i, %272, !dbg !792
  br i1 %273, label %.critedge1.i, label %.backedge16.i

.backedge16.i:                                    ; preds = %.lr.ph77.i
  %274 = icmp ult i8 %.sink.i, %272, !dbg !793
  %275 = getelementptr inbounds %struct.tree* %tree.075.i, i64 0, i32 0, !dbg !795
  %276 = getelementptr inbounds %struct.tree* %tree.075.i, i64 0, i32 1, !dbg !796
  %tree.0.in.be.i = select i1 %274, %struct.tree** %275, %struct.tree** %276, !dbg !793
  %tree.0.i = load %struct.tree** %tree.0.in.be.i, align 8, !dbg !791
  %277 = icmp eq %struct.tree* %tree.0.i, null, !dbg !792
  br i1 %277, label %.critedge10.i, label %.lr.ph77.i, !dbg !792

.critedge1.i:                                     ; preds = %.lr.ph77.i
  %278 = getelementptr inbounds %struct.tree* %tree.075.i, i64 0, i32 2, !dbg !797
  %279 = load %struct.trie** %278, align 8, !dbg !797, !tbaa !427
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %279}, i64 0, metadata !783), !dbg !797
  %280 = getelementptr inbounds %struct.trie* %279, i64 0, i32 0, !dbg !800
  %281 = load i32* %280, align 4, !dbg !800, !tbaa !360
  %282 = icmp eq i32 %281, 0, !dbg !800
  tail call void @llvm.dbg.value(metadata !{i8* %262}, i64 0, metadata !751), !dbg !802
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %279}, i64 0, metadata !757), !dbg !804
  %accept.2..i = select i1 %282, %struct.trie* %accept.283.i, %struct.trie* %279, !dbg !800
  %mch.2..i = select i1 %282, i8* %mch.285.i, i8* %262, !dbg !800
  %d.2.in.i = getelementptr inbounds %struct.trie* %279, i64 0, i32 6, !dbg !789
  %d.2.i = load i32* %d.2.in.i, align 4, !dbg !789
  %283 = icmp ugt i8* %262, %text, !dbg !790
  br i1 %283, label %.lr.ph89.i, label %.critedge10.i, !dbg !790

.critedge10.i:                                    ; preds = %.critedge1.i, %268, %.backedge16.i, %253
  %d.241.i = phi i32 [ %d.282.i, %253 ], [ %d.287.i, %.backedge16.i ], [ %d.2.i, %.critedge1.i ], [ %d.287.i, %268 ]
  %mch.239.i = phi i8* [ %mch.0..i, %253 ], [ %mch.285.i, %.backedge16.i ], [ %mch.2..i, %.critedge1.i ], [ %mch.285.i, %268 ]
  %accept.237.i = phi %struct.trie* [ %accept.0..i, %253 ], [ %accept.283.i, %.backedge16.i ], [ %accept.2..i, %.critedge1.i ], [ %accept.283.i, %268 ]
  %284 = icmp eq i8* %mch.239.i, null, !dbg !805
  br i1 %284, label %.outer20.i, label %.preheader.i5, !dbg !805

.preheader.i5:                                    ; preds = %.critedge10.i, %197
  %accept.4.ph.i = phi %struct.trie* [ %199, %197 ], [ %accept.237.i, %.critedge10.i ]
  %mch.4.ph.i = phi i8* [ %text, %197 ], [ %mch.239.i, %.critedge10.i ]
  %end.3.ph.i = phi i8* [ %text, %197 ], [ %end.2.i, %.critedge10.i ]
  %285 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 4, !dbg !807
  %286 = load i32* %285, align 4, !dbg !807, !tbaa !366
  %287 = sext i32 %286 to i64, !dbg !807
  %288 = icmp eq i8* %190, null, !dbg !809
  br label %.loopexit.i, !dbg !807

.loopexit.i:                                      ; preds = %.critedge12.i, %.preheader.i5
  %accept.4.i = phi %struct.trie* [ %accept.4.ph.i, %.preheader.i5 ], [ %accept.726.i, %.critedge12.i ]
  %lim.0.i = phi i8* [ %191, %.preheader.i5 ], [ %lim.1.i, %.critedge12.i ]
  %mch.4.i = phi i8* [ %mch.4.ph.i, %.preheader.i5 ], [ %lmch.228.i, %.critedge12.i ]
  %end.3.i = phi i8* [ %end.3.ph.i, %.preheader.i5 ], [ %303, %.critedge12.i ]
  %289 = ptrtoint i8* %lim.0.i to i64, !dbg !807
  %290 = ptrtoint i8* %mch.4.i to i64, !dbg !807
  %291 = sub i64 %289, %290, !dbg !807
  %292 = icmp sgt i64 %291, %287, !dbg !807
  br i1 %292, label %293, label %295, !dbg !807

; <label>:293                                     ; preds = %.loopexit.i
  %294 = getelementptr inbounds i8* %mch.4.i, i64 %287, !dbg !812
  tail call void @llvm.dbg.value(metadata !{i8* %294}, i64 0, metadata !745), !dbg !812
  br label %295, !dbg !812

; <label>:295                                     ; preds = %293, %.loopexit.i
  %lim.1.i = phi i8* [ %294, %293 ], [ %lim.0.i, %.loopexit.i ]
  tail call void @llvm.dbg.value(metadata !352, i64 0, metadata !813), !dbg !814
  tail call void @llvm.dbg.value(metadata !401, i64 0, metadata !748), !dbg !815
  %296 = ptrtoint i8* %lim.1.i to i64, !dbg !816
  %297 = ptrtoint i8* %end.3.i to i64, !dbg !816
  %298 = sub i64 %296, %297, !dbg !816
  %299 = icmp slt i64 %298, 1, !dbg !816
  br i1 %299, label %._crit_edge.i9, label %.lr.ph.i6, !dbg !816

.lr.ph.i6:                                        ; preds = %295, %.outer.i
  %300 = phi i64 [ %352, %.outer.i ], [ 1, %295 ]
  %end.4.ph64.i = phi i8* [ %303, %.outer.i ], [ %end.3.i, %295 ]
  %accept.5.ph63.i = phi %struct.trie* [ %accept.726.i, %.outer.i ], [ %accept.4.i, %295 ]
  br label %301, !dbg !816

; <label>:301                                     ; preds = %.backedge15.i, %.lr.ph.i6
  %302 = phi i64 [ %300, %.lr.ph.i6 ], [ %d.3.be.i, %.backedge15.i ]
  %end.442.i = phi i8* [ %end.4.ph64.i, %.lr.ph.i6 ], [ %303, %.backedge15.i ]
  %303 = getelementptr inbounds i8* %end.442.i, i64 %302, !dbg !817
  tail call void @llvm.dbg.value(metadata !{i8* %303}, i64 0, metadata !746), !dbg !817
  %.sum.i7 = add i64 %302, -1, !dbg !817
  %304 = getelementptr inbounds i8* %end.442.i, i64 %.sum.i7, !dbg !817
  %305 = load i8* %304, align 1, !dbg !817, !tbaa !397
  tail call void @llvm.dbg.value(metadata !{i8 %305}, i64 0, metadata !777), !dbg !817
  %306 = zext i8 %305 to i64, !dbg !817
  %307 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 5, i64 %306, !dbg !817
  %308 = load i8* %307, align 1, !dbg !817, !tbaa !397
  %309 = zext i8 %308 to i64, !dbg !817
  %310 = icmp eq i8 %308, 0, !dbg !817
  br i1 %310, label %314, label %.backedge15.i, !dbg !817

.backedge15.i:                                    ; preds = %314, %301
  %d.3.be.i = phi i64 [ %309, %301 ], [ 1, %314 ]
  %311 = ptrtoint i8* %303 to i64, !dbg !816
  %312 = sub i64 %296, %311, !dbg !816
  %313 = icmp slt i64 %312, %d.3.be.i, !dbg !816
  br i1 %313, label %._crit_edge.i9, label %301, !dbg !816

; <label>:314                                     ; preds = %301
  tail call void @llvm.dbg.value(metadata !{i8* %304}, i64 0, metadata !781), !dbg !819
  %315 = getelementptr inbounds %struct.kwset* %kws, i64 0, i32 6, i64 %306, !dbg !820
  %316 = load %struct.trie** %315, align 8, !dbg !820, !tbaa !400
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %316}, i64 0, metadata !783), !dbg !820
  %317 = icmp eq %struct.trie* %316, null, !dbg !820
  br i1 %317, label %.backedge15.i, label %318, !dbg !820

; <label>:318                                     ; preds = %314
  %319 = getelementptr inbounds %struct.trie* %316, i64 0, i32 0, !dbg !822
  %320 = load i32* %319, align 4, !dbg !822, !tbaa !360
  %321 = icmp eq i32 %320, 0, !dbg !822
  %322 = icmp ugt i8* %304, %mch.4.i, !dbg !822
  %or.cond11.i = or i1 %321, %322, !dbg !822
  tail call void @llvm.dbg.value(metadata !{i8* %304}, i64 0, metadata !813), !dbg !824
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %316}, i64 0, metadata !757), !dbg !826
  %accept.6.i = select i1 %or.cond11.i, %struct.trie* %accept.5.ph63.i, %struct.trie* %316, !dbg !822
  %lmch.1.i = select i1 %or.cond11.i, i8* null, i8* %304, !dbg !822
  %d.4.in51.i = getelementptr inbounds %struct.trie* %316, i64 0, i32 6, !dbg !827
  %d.452.i = load i32* %d.4.in51.i, align 4, !dbg !827
  %323 = icmp ugt i8* %304, %text, !dbg !828
  br i1 %323, label %.lr.ph59.i, label %.critedge12.i, !dbg !828

.lr.ph59.i:                                       ; preds = %318, %.critedge3.i
  %d.457.i = phi i32 [ %d.4.i, %.critedge3.i ], [ %d.452.i, %318 ]
  %trie.156.i = phi %struct.trie* [ %341, %.critedge3.i ], [ %316, %318 ]
  %lmch.255.i = phi i8* [ %lmch.3.i, %.critedge3.i ], [ %lmch.1.i, %318 ]
  %beg.154.i = phi i8* [ %324, %.critedge3.i ], [ %304, %318 ]
  %accept.753.i = phi %struct.trie* [ %accept.8.i, %.critedge3.i ], [ %accept.6.i, %318 ]
  %324 = getelementptr inbounds i8* %beg.154.i, i64 -1, !dbg !809
  tail call void @llvm.dbg.value(metadata !{i8* %324}, i64 0, metadata !781), !dbg !809
  %325 = load i8* %324, align 1, !dbg !809, !tbaa !397
  br i1 %288, label %330, label %326, !dbg !809

; <label>:326                                     ; preds = %.lr.ph59.i
  %327 = zext i8 %325 to i64, !dbg !809
  %328 = getelementptr inbounds i8* %190, i64 %327, !dbg !809
  %329 = load i8* %328, align 1, !dbg !809, !tbaa !397
  br label %330, !dbg !809

; <label>:330                                     ; preds = %326, %.lr.ph59.i
  %.sink2.i = phi i8 [ %329, %326 ], [ %325, %.lr.ph59.i ]
  tail call void @llvm.dbg.value(metadata !{i8 %.sink2.i}, i64 0, metadata !777), !dbg !809
  %331 = getelementptr inbounds %struct.trie* %trie.156.i, i64 0, i32 1, !dbg !829
  %tree.144.i = load %struct.tree** %331, align 8, !dbg !829
  %332 = icmp eq %struct.tree* %tree.144.i, null, !dbg !830
  br i1 %332, label %.critedge12.i, label %.lr.ph47.i, !dbg !830

.lr.ph47.i:                                       ; preds = %330, %.backedge.i8
  %tree.145.i = phi %struct.tree* [ %tree.1.i, %.backedge.i8 ], [ %tree.144.i, %330 ]
  %333 = getelementptr inbounds %struct.tree* %tree.145.i, i64 0, i32 3, !dbg !830
  %334 = load i8* %333, align 1, !dbg !830, !tbaa !404
  %335 = icmp eq i8 %.sink2.i, %334, !dbg !830
  br i1 %335, label %.critedge3.i, label %.backedge.i8

.backedge.i8:                                     ; preds = %.lr.ph47.i
  %336 = icmp ult i8 %.sink2.i, %334, !dbg !831
  %337 = getelementptr inbounds %struct.tree* %tree.145.i, i64 0, i32 0, !dbg !833
  %338 = getelementptr inbounds %struct.tree* %tree.145.i, i64 0, i32 1, !dbg !834
  %tree.1.in.be.i = select i1 %336, %struct.tree** %337, %struct.tree** %338, !dbg !831
  %tree.1.i = load %struct.tree** %tree.1.in.be.i, align 8, !dbg !829
  %339 = icmp eq %struct.tree* %tree.1.i, null, !dbg !830
  br i1 %339, label %.critedge12.i, label %.lr.ph47.i, !dbg !830

.critedge3.i:                                     ; preds = %.lr.ph47.i
  %340 = getelementptr inbounds %struct.tree* %tree.145.i, i64 0, i32 2, !dbg !835
  %341 = load %struct.trie** %340, align 8, !dbg !835, !tbaa !427
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %341}, i64 0, metadata !783), !dbg !835
  %342 = getelementptr inbounds %struct.trie* %341, i64 0, i32 0, !dbg !838
  %343 = load i32* %342, align 4, !dbg !838, !tbaa !360
  %344 = icmp eq i32 %343, 0, !dbg !838
  %345 = icmp ugt i8* %324, %mch.4.i, !dbg !838
  %or.cond13.i = or i1 %344, %345, !dbg !838
  tail call void @llvm.dbg.value(metadata !{i8* %324}, i64 0, metadata !813), !dbg !840
  tail call void @llvm.dbg.value(metadata !{%struct.trie* %341}, i64 0, metadata !757), !dbg !842
  %accept.8.i = select i1 %or.cond13.i, %struct.trie* %accept.753.i, %struct.trie* %341, !dbg !838
  %lmch.3.i = select i1 %or.cond13.i, i8* %lmch.255.i, i8* %324, !dbg !838
  %d.4.in.i = getelementptr inbounds %struct.trie* %341, i64 0, i32 6, !dbg !827
  %d.4.i = load i32* %d.4.in.i, align 4, !dbg !827
  %346 = icmp ugt i8* %324, %text, !dbg !828
  br i1 %346, label %.lr.ph59.i, label %.critedge12.i, !dbg !828

.critedge12.i:                                    ; preds = %.critedge3.i, %330, %.backedge.i8, %318
  %d.430.i = phi i32 [ %d.452.i, %318 ], [ %d.457.i, %.backedge.i8 ], [ %d.4.i, %.critedge3.i ], [ %d.457.i, %330 ]
  %lmch.228.i = phi i8* [ %lmch.1.i, %318 ], [ %lmch.255.i, %.backedge.i8 ], [ %lmch.3.i, %.critedge3.i ], [ %lmch.255.i, %330 ]
  %accept.726.i = phi %struct.trie* [ %accept.6.i, %318 ], [ %accept.753.i, %.backedge.i8 ], [ %accept.8.i, %.critedge3.i ], [ %accept.753.i, %330 ]
  %347 = icmp eq i8* %lmch.228.i, null, !dbg !843
  br i1 %347, label %.outer.i, label %.loopexit.i, !dbg !843

.outer.i:                                         ; preds = %.critedge12.i
  %348 = icmp eq i32 %d.430.i, 0, !dbg !845
  tail call void @llvm.dbg.value(metadata !401, i64 0, metadata !748), !dbg !847
  %349 = ptrtoint i8* %303 to i64, !dbg !816
  %350 = sub i64 %296, %349, !dbg !816
  %351 = sext i32 %d.430.i to i64, !dbg !816
  %352 = select i1 %348, i64 1, i64 %351, !dbg !816
  %353 = icmp slt i64 %350, %352, !dbg !816
  br i1 %353, label %._crit_edge.i9, label %.lr.ph.i6, !dbg !816

._crit_edge.i9:                                   ; preds = %295, %.outer.i, %.backedge15.i
  %accept.5.ph.lcssa31.i = phi %struct.trie* [ %accept.5.ph63.i, %.backedge15.i ], [ %accept.726.i, %.outer.i ], [ %accept.4.i, %295 ]
  %354 = getelementptr inbounds %struct.trie* %accept.5.ph.lcssa31.i, i64 0, i32 0, !dbg !848
  %355 = load i32* %354, align 4, !dbg !848, !tbaa !360
  %356 = lshr i32 %355, 1, !dbg !848
  %357 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 0, !dbg !848
  store i32 %356, i32* %357, align 4, !dbg !848, !tbaa !727
  %358 = ptrtoint i8* %text to i64, !dbg !849
  %359 = sub i64 %290, %358, !dbg !849
  %360 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 1, i64 0, !dbg !849
  store i64 %359, i64* %360, align 8, !dbg !849, !tbaa !730
  %361 = getelementptr inbounds %struct.trie* %accept.5.ph.lcssa31.i, i64 0, i32 5, !dbg !850
  %362 = load i32* %361, align 4, !dbg !850, !tbaa !440
  %363 = sext i32 %362 to i64, !dbg !850
  %364 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 2, i64 0, !dbg !850
  store i64 %363, i64* %364, align 8, !dbg !850, !tbaa !730
  br label %cwexec.exit, !dbg !851

cwexec.exit:                                      ; preds = %205, %.critedge1.thread28.backedge.i, %.loopexit30.i, %18, %12, %._crit_edge.i9, %183, %bmexec.exit.thread11, %bmexec.exit
  %.0 = phi i64 [ -1, %bmexec.exit ], [ %.0.i12, %bmexec.exit.thread11 ], [ %359, %._crit_edge.i9 ], [ -1, %183 ], [ -1, %12 ], [ -1, %18 ], [ -1, %.loopexit30.i ], [ -1, %.critedge1.thread28.backedge.i ], [ -1, %205 ]
  ret i64 %.0, !dbg !852
}

; Function Attrs: nounwind readonly
declare i8* @memchr(i8*, i32, i64) #7

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!311, !312}
!llvm.ident = !{!313}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !157, metadata !158, metadata !157, metadata !157, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c] [DW_LANG_C99]
!1 = metadata !{metadata !"kwset.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3, metadata !141}
!3 = metadata !{i32 786436, metadata !1, metadata !4, metadata !"", i32 140, i64 32, i64 32, i32 0, i32 0, null, metadata !138, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 140, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"kwsincr", metadata !"kwsincr", metadata !"", i32 132, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (%struct.kwset*, i8*, i64)* @kwsincr, null, null, metadata !93, i32 133} ; [ DW_TAG_subprogram ] [line 132] [def] [scope 133] [kwsincr]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !11, metadata !8, metadata !90}
!8 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!9 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!10 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!11 = metadata !{i32 786454, metadata !12, null, metadata !"kwset_t", i32 34, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [kwset_t] [line 34, size 0, align 0, offset 0] [from ]
!12 = metadata !{metadata !"./kwset.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!13 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwset]
!14 = metadata !{i32 786451, metadata !1, null, metadata !"kwset", i32 76, i64 19520, i64 64, i32 0, i32 0, null, metadata !15, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwset] [line 76, size 19520, align 64, offset 0] [def] [from ]
!15 = metadata !{metadata !16, metadata !57, metadata !58, metadata !79, metadata !80, metadata !81, metadata !85, metadata !87, metadata !88, metadata !89}
!16 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"obstack", i32 78, i64 704, i64 64, i64 0, i32 0, metadata !17} ; [ DW_TAG_member ] [obstack] [line 78, size 704, align 64, offset 0] [from obstack]
!17 = metadata !{i32 786451, metadata !18, null, metadata !"obstack", i32 149, i64 704, i64 64, i32 0, i32 0, null, metadata !19, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [obstack] [line 149, size 704, align 64, offset 0] [def] [from ]
!18 = metadata !{metadata !"../lib/obstack.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!19 = metadata !{metadata !20, metadata !22, metadata !33, metadata !34, metadata !35, metadata !36, metadata !42, metadata !44, metadata !48, metadata !52, metadata !53, metadata !55, metadata !56}
!20 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"chunk_size", i32 151, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_member ] [chunk_size] [line 151, size 64, align 64, offset 0] [from long int]
!21 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!22 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"chunk", i32 152, i64 64, i64 64, i64 64, i32 0, metadata !23} ; [ DW_TAG_member ] [chunk] [line 152, size 64, align 64, offset 64] [from ]
!23 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !24} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from _obstack_chunk]
!24 = metadata !{i32 786451, metadata !18, null, metadata !"_obstack_chunk", i32 142, i64 192, i64 64, i32 0, i32 0, null, metadata !25, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [_obstack_chunk] [line 142, size 192, align 64, offset 0] [def] [from ]
!25 = metadata !{metadata !26, metadata !28, metadata !29}
!26 = metadata !{i32 786445, metadata !18, metadata !24, metadata !"limit", i32 144, i64 64, i64 64, i64 0, i32 0, metadata !27} ; [ DW_TAG_member ] [limit] [line 144, size 64, align 64, offset 0] [from ]
!27 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!28 = metadata !{i32 786445, metadata !18, metadata !24, metadata !"prev", i32 145, i64 64, i64 64, i64 64, i32 0, metadata !23} ; [ DW_TAG_member ] [prev] [line 145, size 64, align 64, offset 64] [from ]
!29 = metadata !{i32 786445, metadata !18, metadata !24, metadata !"contents", i32 146, i64 32, i64 8, i64 128, i32 0, metadata !30} ; [ DW_TAG_member ] [contents] [line 146, size 32, align 8, offset 128] [from ]
!30 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32, i64 8, i32 0, i32 0, metadata !10, metadata !31, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from char]
!31 = metadata !{metadata !32}
!32 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 3]
!33 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"object_base", i32 153, i64 64, i64 64, i64 128, i32 0, metadata !27} ; [ DW_TAG_member ] [object_base] [line 153, size 64, align 64, offset 128] [from ]
!34 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"next_free", i32 154, i64 64, i64 64, i64 192, i32 0, metadata !27} ; [ DW_TAG_member ] [next_free] [line 154, size 64, align 64, offset 192] [from ]
!35 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"chunk_limit", i32 155, i64 64, i64 64, i64 256, i32 0, metadata !27} ; [ DW_TAG_member ] [chunk_limit] [line 155, size 64, align 64, offset 256] [from ]
!36 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"temp", i32 160, i64 64, i64 64, i64 320, i32 0, metadata !37} ; [ DW_TAG_member ] [temp] [line 160, size 64, align 64, offset 320] [from ]
!37 = metadata !{i32 786455, metadata !18, metadata !17, metadata !"", i32 156, i64 64, i64 64, i64 0, i32 0, null, metadata !38, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 156, size 64, align 64, offset 0] [def] [from ]
!38 = metadata !{metadata !39, metadata !40}
!39 = metadata !{i32 786445, metadata !18, metadata !37, metadata !"tempint", i32 158, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_member ] [tempint] [line 158, size 64, align 64, offset 0] [from long int]
!40 = metadata !{i32 786445, metadata !18, metadata !37, metadata !"tempptr", i32 159, i64 64, i64 64, i64 0, i32 0, metadata !41} ; [ DW_TAG_member ] [tempptr] [line 159, size 64, align 64, offset 0] [from ]
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!42 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"alignment_mask", i32 161, i64 32, i64 32, i64 384, i32 0, metadata !43} ; [ DW_TAG_member ] [alignment_mask] [line 161, size 32, align 32, offset 384] [from int]
!43 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!44 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"chunkfun", i32 165, i64 64, i64 64, i64 448, i32 0, metadata !45} ; [ DW_TAG_member ] [chunkfun] [line 165, size 64, align 64, offset 448] [from ]
!45 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !46} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!46 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !47, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!47 = metadata !{metadata !23, metadata !41, metadata !21}
!48 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"freefun", i32 166, i64 64, i64 64, i64 512, i32 0, metadata !49} ; [ DW_TAG_member ] [freefun] [line 166, size 64, align 64, offset 512] [from ]
!49 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !50} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!50 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !51, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!51 = metadata !{null, metadata !41, metadata !23}
!52 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"extra_arg", i32 167, i64 64, i64 64, i64 576, i32 0, metadata !41} ; [ DW_TAG_member ] [extra_arg] [line 167, size 64, align 64, offset 576] [from ]
!53 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"use_extra_arg", i32 168, i64 1, i64 32, i64 640, i32 0, metadata !54} ; [ DW_TAG_member ] [use_extra_arg] [line 168, size 1, align 32, offset 640] [from unsigned int]
!54 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!55 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"maybe_empty_object", i32 169, i64 1, i64 32, i64 641, i32 0, metadata !54} ; [ DW_TAG_member ] [maybe_empty_object] [line 169, size 1, align 32, offset 641] [from unsigned int]
!56 = metadata !{i32 786445, metadata !18, metadata !17, metadata !"alloc_failed", i32 173, i64 1, i64 32, i64 642, i32 0, metadata !54} ; [ DW_TAG_member ] [alloc_failed] [line 173, size 1, align 32, offset 642] [from unsigned int]
!57 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"words", i32 79, i64 32, i64 32, i64 704, i32 0, metadata !43} ; [ DW_TAG_member ] [words] [line 79, size 32, align 32, offset 704] [from int]
!58 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"trie", i32 80, i64 64, i64 64, i64 768, i32 0, metadata !59} ; [ DW_TAG_member ] [trie] [line 80, size 64, align 64, offset 768] [from ]
!59 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !60} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from trie]
!60 = metadata !{i32 786451, metadata !1, null, metadata !"trie", i32 63, i64 448, i64 64, i32 0, i32 0, null, metadata !61, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [trie] [line 63, size 448, align 64, offset 0] [def] [from ]
!61 = metadata !{metadata !62, metadata !63, metadata !73, metadata !74, metadata !75, metadata !76, metadata !77, metadata !78}
!62 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"accepting", i32 65, i64 32, i64 32, i64 0, i32 0, metadata !54} ; [ DW_TAG_member ] [accepting] [line 65, size 32, align 32, offset 0] [from unsigned int]
!63 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"links", i32 66, i64 64, i64 64, i64 64, i32 0, metadata !64} ; [ DW_TAG_member ] [links] [line 66, size 64, align 64, offset 64] [from ]
!64 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !65} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from tree]
!65 = metadata !{i32 786451, metadata !1, null, metadata !"tree", i32 53, i64 256, i64 64, i32 0, i32 0, null, metadata !66, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [tree] [line 53, size 256, align 64, offset 0] [def] [from ]
!66 = metadata !{metadata !67, metadata !68, metadata !69, metadata !70, metadata !72}
!67 = metadata !{i32 786445, metadata !1, metadata !65, metadata !"llink", i32 55, i64 64, i64 64, i64 0, i32 0, metadata !64} ; [ DW_TAG_member ] [llink] [line 55, size 64, align 64, offset 0] [from ]
!68 = metadata !{i32 786445, metadata !1, metadata !65, metadata !"rlink", i32 56, i64 64, i64 64, i64 64, i32 0, metadata !64} ; [ DW_TAG_member ] [rlink] [line 56, size 64, align 64, offset 64] [from ]
!69 = metadata !{i32 786445, metadata !1, metadata !65, metadata !"trie", i32 57, i64 64, i64 64, i64 128, i32 0, metadata !59} ; [ DW_TAG_member ] [trie] [line 57, size 64, align 64, offset 128] [from ]
!70 = metadata !{i32 786445, metadata !1, metadata !65, metadata !"label", i32 58, i64 8, i64 8, i64 192, i32 0, metadata !71} ; [ DW_TAG_member ] [label] [line 58, size 8, align 8, offset 192] [from unsigned char]
!71 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!72 = metadata !{i32 786445, metadata !1, metadata !65, metadata !"balance", i32 59, i64 8, i64 8, i64 200, i32 0, metadata !10} ; [ DW_TAG_member ] [balance] [line 59, size 8, align 8, offset 200] [from char]
!73 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"parent", i32 67, i64 64, i64 64, i64 128, i32 0, metadata !59} ; [ DW_TAG_member ] [parent] [line 67, size 64, align 64, offset 128] [from ]
!74 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"next", i32 68, i64 64, i64 64, i64 192, i32 0, metadata !59} ; [ DW_TAG_member ] [next] [line 68, size 64, align 64, offset 192] [from ]
!75 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"fail", i32 69, i64 64, i64 64, i64 256, i32 0, metadata !59} ; [ DW_TAG_member ] [fail] [line 69, size 64, align 64, offset 256] [from ]
!76 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"depth", i32 70, i64 32, i64 32, i64 320, i32 0, metadata !43} ; [ DW_TAG_member ] [depth] [line 70, size 32, align 32, offset 320] [from int]
!77 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"shift", i32 71, i64 32, i64 32, i64 352, i32 0, metadata !43} ; [ DW_TAG_member ] [shift] [line 71, size 32, align 32, offset 352] [from int]
!78 = metadata !{i32 786445, metadata !1, metadata !60, metadata !"maxshift", i32 72, i64 32, i64 32, i64 384, i32 0, metadata !43} ; [ DW_TAG_member ] [maxshift] [line 72, size 32, align 32, offset 384] [from int]
!79 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"mind", i32 81, i64 32, i64 32, i64 832, i32 0, metadata !43} ; [ DW_TAG_member ] [mind] [line 81, size 32, align 32, offset 832] [from int]
!80 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"maxd", i32 82, i64 32, i64 32, i64 864, i32 0, metadata !43} ; [ DW_TAG_member ] [maxd] [line 82, size 32, align 32, offset 864] [from int]
!81 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"delta", i32 83, i64 2048, i64 8, i64 896, i32 0, metadata !82} ; [ DW_TAG_member ] [delta] [line 83, size 2048, align 8, offset 896] [from ]
!82 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2048, i64 8, i32 0, i32 0, metadata !71, metadata !83, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2048, align 8, offset 0] [from unsigned char]
!83 = metadata !{metadata !84}
!84 = metadata !{i32 786465, i64 0, i64 256}      ; [ DW_TAG_subrange_type ] [0, 255]
!85 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"next", i32 84, i64 16384, i64 64, i64 2944, i32 0, metadata !86} ; [ DW_TAG_member ] [next] [line 84, size 16384, align 64, offset 2944] [from ]
!86 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 16384, i64 64, i32 0, i32 0, metadata !59, metadata !83, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 16384, align 64, offset 0] [from ]
!87 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"target", i32 85, i64 64, i64 64, i64 19328, i32 0, metadata !27} ; [ DW_TAG_member ] [target] [line 85, size 64, align 64, offset 19328] [from ]
!88 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"mind2", i32 86, i64 32, i64 32, i64 19392, i32 0, metadata !43} ; [ DW_TAG_member ] [mind2] [line 86, size 32, align 32, offset 19392] [from int]
!89 = metadata !{i32 786445, metadata !1, metadata !14, metadata !"trans", i32 87, i64 64, i64 64, i64 19456, i32 0, metadata !8} ; [ DW_TAG_member ] [trans] [line 87, size 64, align 64, offset 19456] [from ]
!90 = metadata !{i32 786454, metadata !91, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !92} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!91 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!92 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!93 = metadata !{metadata !94, metadata !95, metadata !96, metadata !97, metadata !98, metadata !99, metadata !100, metadata !101, metadata !102, metadata !106, metadata !108, metadata !109, metadata !110, metadata !111, metadata !112, metadata !113, metadata !119, metadata !121, metadata !122, metadata !124, metadata !125, metadata !127, metadata !129, metadata !130, metadata !132, metadata !133, metadata !137}
!94 = metadata !{i32 786689, metadata !4, metadata !"kws", metadata !5, i32 16777348, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 132]
!95 = metadata !{i32 786689, metadata !4, metadata !"text", metadata !5, i32 33554564, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [text] [line 132]
!96 = metadata !{i32 786689, metadata !4, metadata !"len", metadata !5, i32 50331780, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 132]
!97 = metadata !{i32 786688, metadata !4, metadata !"kwset", metadata !5, i32 134, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 134]
!98 = metadata !{i32 786688, metadata !4, metadata !"trie", metadata !5, i32 135, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [trie] [line 135]
!99 = metadata !{i32 786688, metadata !4, metadata !"label", metadata !5, i32 136, metadata !71, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [label] [line 136]
!100 = metadata !{i32 786688, metadata !4, metadata !"kwset_link", metadata !5, i32 137, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset_link] [line 137]
!101 = metadata !{i32 786688, metadata !4, metadata !"depth", metadata !5, i32 138, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [depth] [line 138]
!102 = metadata !{i32 786688, metadata !4, metadata !"links", metadata !5, i32 139, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [links] [line 139]
!103 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 768, i64 64, i32 0, i32 0, metadata !64, metadata !104, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 768, align 64, offset 0] [from ]
!104 = metadata !{metadata !105}
!105 = metadata !{i32 786465, i64 0, i64 12}      ; [ DW_TAG_subrange_type ] [0, 11]
!106 = metadata !{i32 786688, metadata !4, metadata !"dirs", metadata !5, i32 140, metadata !107, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dirs] [line 140]
!107 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 384, i64 32, i32 0, i32 0, metadata !3, metadata !104, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 384, align 32, offset 0] [from ]
!108 = metadata !{i32 786688, metadata !4, metadata !"t", metadata !5, i32 141, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 141]
!109 = metadata !{i32 786688, metadata !4, metadata !"r", metadata !5, i32 141, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 141]
!110 = metadata !{i32 786688, metadata !4, metadata !"l", metadata !5, i32 141, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 141]
!111 = metadata !{i32 786688, metadata !4, metadata !"rl", metadata !5, i32 141, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rl] [line 141]
!112 = metadata !{i32 786688, metadata !4, metadata !"lr", metadata !5, i32 141, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lr] [line 141]
!113 = metadata !{i32 786688, metadata !114, metadata !"__h", metadata !5, i32 175, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__h] [line 175]
!114 = metadata !{i32 786443, metadata !1, metadata !115, i32 175, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!115 = metadata !{i32 786443, metadata !1, metadata !116, i32 174, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!116 = metadata !{i32 786443, metadata !1, metadata !117, i32 173, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!117 = metadata !{i32 786443, metadata !1, metadata !4, i32 150, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!118 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !17} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from obstack]
!119 = metadata !{i32 786688, metadata !120, metadata !"__o", metadata !5, i32 175, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 175]
!120 = metadata !{i32 786443, metadata !1, metadata !114, i32 175, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!121 = metadata !{i32 786688, metadata !120, metadata !"__len", metadata !5, i32 175, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__len] [line 175]
!122 = metadata !{i32 786688, metadata !123, metadata !"__o1", metadata !5, i32 175, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o1] [line 175]
!123 = metadata !{i32 786443, metadata !1, metadata !114, i32 175, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!124 = metadata !{i32 786688, metadata !123, metadata !"__value", metadata !5, i32 175, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__value] [line 175]
!125 = metadata !{i32 786688, metadata !126, metadata !"__h", metadata !5, i32 181, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__h] [line 181]
!126 = metadata !{i32 786443, metadata !1, metadata !115, i32 181, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!127 = metadata !{i32 786688, metadata !128, metadata !"__o", metadata !5, i32 181, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 181]
!128 = metadata !{i32 786443, metadata !1, metadata !126, i32 181, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!129 = metadata !{i32 786688, metadata !128, metadata !"__len", metadata !5, i32 181, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__len] [line 181]
!130 = metadata !{i32 786688, metadata !131, metadata !"__o1", metadata !5, i32 181, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o1] [line 181]
!131 = metadata !{i32 786443, metadata !1, metadata !126, i32 181, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!132 = metadata !{i32 786688, metadata !131, metadata !"__value", metadata !5, i32 181, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__value] [line 181]
!133 = metadata !{i32 786688, metadata !134, metadata !"__o", metadata !5, i32 185, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 185]
!134 = metadata !{i32 786443, metadata !1, metadata !135, i32 185, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!135 = metadata !{i32 786443, metadata !1, metadata !136, i32 184, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!136 = metadata !{i32 786443, metadata !1, metadata !115, i32 183, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!137 = metadata !{i32 786688, metadata !134, metadata !"__obj", metadata !5, i32 185, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__obj] [line 185]
!138 = metadata !{metadata !139, metadata !140}
!139 = metadata !{i32 786472, metadata !"L", i64 0} ; [ DW_TAG_enumerator ] [L :: 0]
!140 = metadata !{i32 786472, metadata !"R", i64 1} ; [ DW_TAG_enumerator ] [R :: 1]
!141 = metadata !{i32 786436, metadata !142, null, metadata !"", i32 27, i64 32, i64 32, i32 0, i32 0, null, metadata !143, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 27, size 32, align 32, offset 0] [def] [from ]
!142 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/locale.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!143 = metadata !{metadata !144, metadata !145, metadata !146, metadata !147, metadata !148, metadata !149, metadata !150, metadata !151, metadata !152, metadata !153, metadata !154, metadata !155, metadata !156}
!144 = metadata !{i32 786472, metadata !"__LC_CTYPE", i64 0} ; [ DW_TAG_enumerator ] [__LC_CTYPE :: 0]
!145 = metadata !{i32 786472, metadata !"__LC_NUMERIC", i64 1} ; [ DW_TAG_enumerator ] [__LC_NUMERIC :: 1]
!146 = metadata !{i32 786472, metadata !"__LC_TIME", i64 2} ; [ DW_TAG_enumerator ] [__LC_TIME :: 2]
!147 = metadata !{i32 786472, metadata !"__LC_COLLATE", i64 3} ; [ DW_TAG_enumerator ] [__LC_COLLATE :: 3]
!148 = metadata !{i32 786472, metadata !"__LC_MONETARY", i64 4} ; [ DW_TAG_enumerator ] [__LC_MONETARY :: 4]
!149 = metadata !{i32 786472, metadata !"__LC_MESSAGES", i64 5} ; [ DW_TAG_enumerator ] [__LC_MESSAGES :: 5]
!150 = metadata !{i32 786472, metadata !"__LC_ALL", i64 6} ; [ DW_TAG_enumerator ] [__LC_ALL :: 6]
!151 = metadata !{i32 786472, metadata !"__LC_PAPER", i64 7} ; [ DW_TAG_enumerator ] [__LC_PAPER :: 7]
!152 = metadata !{i32 786472, metadata !"__LC_NAME", i64 8} ; [ DW_TAG_enumerator ] [__LC_NAME :: 8]
!153 = metadata !{i32 786472, metadata !"__LC_ADDRESS", i64 9} ; [ DW_TAG_enumerator ] [__LC_ADDRESS :: 9]
!154 = metadata !{i32 786472, metadata !"__LC_TELEPHONE", i64 10} ; [ DW_TAG_enumerator ] [__LC_TELEPHONE :: 10]
!155 = metadata !{i32 786472, metadata !"__LC_MEASUREMENT", i64 11} ; [ DW_TAG_enumerator ] [__LC_MEASUREMENT :: 11]
!156 = metadata !{i32 786472, metadata !"__LC_IDENTIFICATION", i64 12} ; [ DW_TAG_enumerator ] [__LC_IDENTIFICATION :: 12]
!157 = metadata !{i32 0}
!158 = metadata !{metadata !159, metadata !4, metadata !173, metadata !198, metadata !221, metadata !230, metadata !259, metadata !276, metadata !283, metadata !289, metadata !297, metadata !305}
!159 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"kwsalloc", metadata !"kwsalloc", metadata !"", i32 93, metadata !160, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, %struct.kwset* (i8*)* @kwsalloc, null, null, metadata !162, i32 94} ; [ DW_TAG_subprogram ] [line 93] [def] [scope 94] [kwsalloc]
!160 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !161, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!161 = metadata !{metadata !11, metadata !8}
!162 = metadata !{metadata !163, metadata !164, metadata !165, metadata !167, metadata !169, metadata !170, metadata !172}
!163 = metadata !{i32 786689, metadata !159, metadata !"trans", metadata !5, i32 16777309, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [trans] [line 93]
!164 = metadata !{i32 786688, metadata !159, metadata !"kwset", metadata !5, i32 95, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 95]
!165 = metadata !{i32 786688, metadata !166, metadata !"__h", metadata !5, i32 104, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__h] [line 104]
!166 = metadata !{i32 786443, metadata !1, metadata !159, i32 104, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!167 = metadata !{i32 786688, metadata !168, metadata !"__o", metadata !5, i32 104, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 104]
!168 = metadata !{i32 786443, metadata !1, metadata !166, i32 104, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!169 = metadata !{i32 786688, metadata !168, metadata !"__len", metadata !5, i32 104, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__len] [line 104]
!170 = metadata !{i32 786688, metadata !171, metadata !"__o1", metadata !5, i32 104, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o1] [line 104]
!171 = metadata !{i32 786443, metadata !1, metadata !166, i32 104, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!172 = metadata !{i32 786688, metadata !171, metadata !"__value", metadata !5, i32 104, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__value] [line 104]
!173 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"kwsprep", metadata !"kwsprep", metadata !"", i32 385, metadata !174, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (%struct.kwset*)* @kwsprep, null, null, metadata !176, i32 386} ; [ DW_TAG_subprogram ] [line 385] [def] [scope 386] [kwsprep]
!174 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !175, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!175 = metadata !{metadata !8, metadata !11}
!176 = metadata !{metadata !177, metadata !178, metadata !179, metadata !180, metadata !181, metadata !182, metadata !183, metadata !186, metadata !188, metadata !190, metadata !191, metadata !193, metadata !194, metadata !196, metadata !197}
!177 = metadata !{i32 786689, metadata !173, metadata !"kws", metadata !5, i32 16777601, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 385]
!178 = metadata !{i32 786688, metadata !173, metadata !"kwset", metadata !5, i32 387, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 387]
!179 = metadata !{i32 786688, metadata !173, metadata !"i", metadata !5, i32 388, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 388]
!180 = metadata !{i32 786688, metadata !173, metadata !"curr", metadata !5, i32 389, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [curr] [line 389]
!181 = metadata !{i32 786688, metadata !173, metadata !"trans", metadata !5, i32 390, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [trans] [line 390]
!182 = metadata !{i32 786688, metadata !173, metadata !"delta", metadata !5, i32 391, metadata !82, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [delta] [line 391]
!183 = metadata !{i32 786688, metadata !184, metadata !"c", metadata !5, i32 404, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 404]
!184 = metadata !{i32 786443, metadata !1, metadata !185, i32 403, i32 0, i32 44} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!185 = metadata !{i32 786443, metadata !1, metadata !173, i32 402, i32 0, i32 43} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!186 = metadata !{i32 786688, metadata !187, metadata !"__h", metadata !5, i32 407, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__h] [line 407]
!187 = metadata !{i32 786443, metadata !1, metadata !184, i32 407, i32 0, i32 45} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!188 = metadata !{i32 786688, metadata !189, metadata !"__o", metadata !5, i32 407, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 407]
!189 = metadata !{i32 786443, metadata !1, metadata !187, i32 407, i32 0, i32 46} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!190 = metadata !{i32 786688, metadata !189, metadata !"__len", metadata !5, i32 407, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__len] [line 407]
!191 = metadata !{i32 786688, metadata !192, metadata !"__o1", metadata !5, i32 407, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o1] [line 407]
!192 = metadata !{i32 786443, metadata !1, metadata !187, i32 407, i32 0, i32 48} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!193 = metadata !{i32 786688, metadata !192, metadata !"__value", metadata !5, i32 407, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__value] [line 407]
!194 = metadata !{i32 786688, metadata !195, metadata !"fail", metadata !5, i32 428, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fail] [line 428]
!195 = metadata !{i32 786443, metadata !1, metadata !185, i32 427, i32 0, i32 57} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!196 = metadata !{i32 786688, metadata !195, metadata !"last", metadata !5, i32 429, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [last] [line 429]
!197 = metadata !{i32 786688, metadata !195, metadata !"next", metadata !5, i32 429, metadata !86, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [next] [line 429]
!198 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"kwsexec", metadata !"kwsexec", metadata !"", i32 747, metadata !199, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (%struct.kwset*, i8*, i64, %struct.kwsmatch*)* @kwsexec, null, null, metadata !210, i32 748} ; [ DW_TAG_subprogram ] [line 747] [def] [scope 748] [kwsexec]
!199 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !200, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!200 = metadata !{metadata !90, metadata !11, metadata !8, metadata !90, metadata !201}
!201 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !202} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwsmatch]
!202 = metadata !{i32 786451, metadata !12, null, metadata !"kwsmatch", i32 24, i64 192, i64 64, i32 0, i32 0, null, metadata !203, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwsmatch] [line 24, size 192, align 64, offset 0] [def] [from ]
!203 = metadata !{metadata !204, metadata !205, metadata !209}
!204 = metadata !{i32 786445, metadata !12, metadata !202, metadata !"index", i32 26, i64 32, i64 32, i64 0, i32 0, metadata !43} ; [ DW_TAG_member ] [index] [line 26, size 32, align 32, offset 0] [from int]
!205 = metadata !{i32 786445, metadata !12, metadata !202, metadata !"offset", i32 27, i64 64, i64 64, i64 64, i32 0, metadata !206} ; [ DW_TAG_member ] [offset] [line 27, size 64, align 64, offset 64] [from ]
!206 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 64, i64 64, i32 0, i32 0, metadata !90, metadata !207, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!207 = metadata !{metadata !208}
!208 = metadata !{i32 786465, i64 0, i64 1}       ; [ DW_TAG_subrange_type ] [0, 0]
!209 = metadata !{i32 786445, metadata !12, metadata !202, metadata !"size", i32 28, i64 64, i64 64, i64 128, i32 0, metadata !206} ; [ DW_TAG_member ] [size] [line 28, size 64, align 64, offset 128] [from ]
!210 = metadata !{metadata !211, metadata !212, metadata !213, metadata !214, metadata !215, metadata !218}
!211 = metadata !{i32 786689, metadata !198, metadata !"kws", metadata !5, i32 16777963, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 747]
!212 = metadata !{i32 786689, metadata !198, metadata !"text", metadata !5, i32 33555179, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [text] [line 747]
!213 = metadata !{i32 786689, metadata !198, metadata !"size", metadata !5, i32 50332395, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 747]
!214 = metadata !{i32 786689, metadata !198, metadata !"kwsmatch", metadata !5, i32 67109611, metadata !201, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kwsmatch] [line 747]
!215 = metadata !{i32 786688, metadata !198, metadata !"kwset", metadata !5, i32 749, metadata !216, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 749]
!216 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !217} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!217 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from kwset]
!218 = metadata !{i32 786688, metadata !219, metadata !"ret", metadata !5, i32 752, metadata !90, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ret] [line 752]
!219 = metadata !{i32 786443, metadata !1, metadata !220, i32 751, i32 0, i32 75} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!220 = metadata !{i32 786443, metadata !1, metadata !198, i32 750, i32 0, i32 74} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!221 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"kwsfree", metadata !"kwsfree", metadata !"", i32 767, metadata !222, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.kwset*)* @kwsfree, null, null, metadata !224, i32 768} ; [ DW_TAG_subprogram ] [line 767] [def] [scope 768] [kwsfree]
!222 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !223, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!223 = metadata !{null, metadata !11}
!224 = metadata !{metadata !225, metadata !226, metadata !227, metadata !229}
!225 = metadata !{i32 786689, metadata !221, metadata !"kws", metadata !5, i32 16777983, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 767]
!226 = metadata !{i32 786688, metadata !221, metadata !"kwset", metadata !5, i32 769, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 769]
!227 = metadata !{i32 786688, metadata !228, metadata !"__o", metadata !5, i32 772, metadata !118, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__o] [line 772]
!228 = metadata !{i32 786443, metadata !1, metadata !221, i32 772, i32 0, i32 78} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!229 = metadata !{i32 786688, metadata !228, metadata !"__obj", metadata !5, i32 772, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [__obj] [line 772]
!230 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"cwexec", metadata !"cwexec", metadata !"", i32 587, metadata !199, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !231, i32 588} ; [ DW_TAG_subprogram ] [line 587] [local] [def] [scope 588] [cwexec]
!231 = metadata !{metadata !232, metadata !233, metadata !234, metadata !235, metadata !236, metadata !237, metadata !240, metadata !243, metadata !244, metadata !245, metadata !246, metadata !247, metadata !248, metadata !249, metadata !252, metadata !253, metadata !254, metadata !255, metadata !258}
!232 = metadata !{i32 786689, metadata !230, metadata !"kws", metadata !5, i32 16777803, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 587]
!233 = metadata !{i32 786689, metadata !230, metadata !"text", metadata !5, i32 33555019, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [text] [line 587]
!234 = metadata !{i32 786689, metadata !230, metadata !"len", metadata !5, i32 50332235, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 587]
!235 = metadata !{i32 786689, metadata !230, metadata !"kwsmatch", metadata !5, i32 67109451, metadata !201, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kwsmatch] [line 587]
!236 = metadata !{i32 786688, metadata !230, metadata !"kwset", metadata !5, i32 589, metadata !216, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 589]
!237 = metadata !{i32 786688, metadata !230, metadata !"next", metadata !5, i32 590, metadata !238, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [next] [line 590]
!238 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !239} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!239 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !59} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!240 = metadata !{i32 786688, metadata !230, metadata !"trie", metadata !5, i32 591, metadata !241, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [trie] [line 591]
!241 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !242} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!242 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !60} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from trie]
!243 = metadata !{i32 786688, metadata !230, metadata !"accept", metadata !5, i32 592, metadata !241, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [accept] [line 592]
!244 = metadata !{i32 786688, metadata !230, metadata !"beg", metadata !5, i32 593, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 593]
!245 = metadata !{i32 786688, metadata !230, metadata !"lim", metadata !5, i32 593, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lim] [line 593]
!246 = metadata !{i32 786688, metadata !230, metadata !"mch", metadata !5, i32 593, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mch] [line 593]
!247 = metadata !{i32 786688, metadata !230, metadata !"lmch", metadata !5, i32 593, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lmch] [line 593]
!248 = metadata !{i32 786688, metadata !230, metadata !"c", metadata !5, i32 594, metadata !71, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 594]
!249 = metadata !{i32 786688, metadata !230, metadata !"delta", metadata !5, i32 595, metadata !250, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [delta] [line 595]
!250 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !251} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!251 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !71} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned char]
!252 = metadata !{i32 786688, metadata !230, metadata !"d", metadata !5, i32 596, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 596]
!253 = metadata !{i32 786688, metadata !230, metadata !"end", metadata !5, i32 597, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 597]
!254 = metadata !{i32 786688, metadata !230, metadata !"qlim", metadata !5, i32 597, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [qlim] [line 597]
!255 = metadata !{i32 786688, metadata !230, metadata !"tree", metadata !5, i32 598, metadata !256, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tree] [line 598]
!256 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !257} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!257 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !65} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from tree]
!258 = metadata !{i32 786688, metadata !230, metadata !"trans", metadata !5, i32 599, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [trans] [line 599]
!259 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bmexec", metadata !"bmexec", metadata !"", i32 501, metadata !260, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !262, i32 502} ; [ DW_TAG_subprogram ] [line 501] [local] [def] [scope 502] [bmexec]
!260 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !261, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!261 = metadata !{metadata !90, metadata !11, metadata !8, metadata !90}
!262 = metadata !{metadata !263, metadata !264, metadata !265, metadata !266, metadata !267, metadata !268, metadata !269, metadata !270, metadata !271, metadata !272, metadata !273, metadata !274, metadata !275}
!263 = metadata !{i32 786689, metadata !259, metadata !"kws", metadata !5, i32 16777717, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [kws] [line 501]
!264 = metadata !{i32 786689, metadata !259, metadata !"text", metadata !5, i32 33554933, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [text] [line 501]
!265 = metadata !{i32 786689, metadata !259, metadata !"size", metadata !5, i32 50332149, metadata !90, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 501]
!266 = metadata !{i32 786688, metadata !259, metadata !"kwset", metadata !5, i32 503, metadata !216, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset] [line 503]
!267 = metadata !{i32 786688, metadata !259, metadata !"d1", metadata !5, i32 504, metadata !250, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d1] [line 504]
!268 = metadata !{i32 786688, metadata !259, metadata !"ep", metadata !5, i32 505, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ep] [line 505]
!269 = metadata !{i32 786688, metadata !259, metadata !"sp", metadata !5, i32 505, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sp] [line 505]
!270 = metadata !{i32 786688, metadata !259, metadata !"tp", metadata !5, i32 505, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tp] [line 505]
!271 = metadata !{i32 786688, metadata !259, metadata !"d", metadata !5, i32 506, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 506]
!272 = metadata !{i32 786688, metadata !259, metadata !"gc", metadata !5, i32 506, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gc] [line 506]
!273 = metadata !{i32 786688, metadata !259, metadata !"i", metadata !5, i32 506, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 506]
!274 = metadata !{i32 786688, metadata !259, metadata !"len", metadata !5, i32 506, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 506]
!275 = metadata !{i32 786688, metadata !259, metadata !"md2", metadata !5, i32 506, metadata !43, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [md2] [line 506]
!276 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"treenext", metadata !"treenext", metadata !"", i32 373, metadata !277, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.tree*, %struct.trie**)* @treenext, null, null, metadata !280, i32 374} ; [ DW_TAG_subprogram ] [line 373] [local] [def] [scope 374] [treenext]
!277 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !278, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!278 = metadata !{null, metadata !256, metadata !279}
!279 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !59} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!280 = metadata !{metadata !281, metadata !282}
!281 = metadata !{i32 786689, metadata !276, metadata !"tree", metadata !5, i32 16777589, metadata !256, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tree] [line 373]
!282 = metadata !{i32 786689, metadata !276, metadata !"next", metadata !5, i32 33554805, metadata !279, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [next] [line 373]
!283 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"hasevery", metadata !"hasevery", metadata !"", i32 354, metadata !284, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (%struct.tree*, %struct.tree*)* @hasevery, null, null, metadata !286, i32 355} ; [ DW_TAG_subprogram ] [line 354] [local] [def] [scope 355] [hasevery]
!284 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !285, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!285 = metadata !{metadata !43, metadata !256, metadata !256}
!286 = metadata !{metadata !287, metadata !288}
!287 = metadata !{i32 786689, metadata !283, metadata !"a", metadata !5, i32 16777570, metadata !256, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 354]
!288 = metadata !{i32 786689, metadata !283, metadata !"b", metadata !5, i32 33554786, metadata !256, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 354]
!289 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"treefails", metadata !"treefails", metadata !"", i32 305, metadata !290, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.tree*, %struct.trie*, %struct.trie*)* @treefails, null, null, metadata !292, i32 307} ; [ DW_TAG_subprogram ] [line 305] [local] [def] [scope 307] [treefails]
!290 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !291, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!291 = metadata !{null, metadata !256, metadata !241, metadata !59}
!292 = metadata !{metadata !293, metadata !294, metadata !295, metadata !296}
!293 = metadata !{i32 786689, metadata !289, metadata !"tree", metadata !5, i32 16777521, metadata !256, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tree] [line 305]
!294 = metadata !{i32 786689, metadata !289, metadata !"fail", metadata !5, i32 33554737, metadata !241, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fail] [line 305]
!295 = metadata !{i32 786689, metadata !289, metadata !"recourse", metadata !5, i32 50331954, metadata !59, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [recourse] [line 306]
!296 = metadata !{i32 786688, metadata !289, metadata !"kwset_link", metadata !5, i32 308, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwset_link] [line 308]
!297 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"treedelta", metadata !"treedelta", metadata !"", i32 340, metadata !298, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.tree*, i32, i8*)* @treedelta, null, null, metadata !301, i32 343} ; [ DW_TAG_subprogram ] [line 340] [local] [def] [scope 343] [treedelta]
!298 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !299, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!299 = metadata !{null, metadata !256, metadata !54, metadata !300}
!300 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !71} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned char]
!301 = metadata !{metadata !302, metadata !303, metadata !304}
!302 = metadata !{i32 786689, metadata !297, metadata !"tree", metadata !5, i32 16777556, metadata !256, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tree] [line 340]
!303 = metadata !{i32 786689, metadata !297, metadata !"depth", metadata !5, i32 33554773, metadata !54, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [depth] [line 341]
!304 = metadata !{i32 786689, metadata !297, metadata !"delta", metadata !5, i32 50331990, metadata !300, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [delta] [line 342]
!305 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"enqueue", metadata !"enqueue", metadata !"", i32 292, metadata !306, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.tree*, %struct.trie**)* @enqueue, null, null, metadata !308, i32 293} ; [ DW_TAG_subprogram ] [line 292] [local] [def] [scope 293] [enqueue]
!306 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !307, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!307 = metadata !{null, metadata !64, metadata !279}
!308 = metadata !{metadata !309, metadata !310}
!309 = metadata !{i32 786689, metadata !305, metadata !"tree", metadata !5, i32 16777508, metadata !64, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tree] [line 292]
!310 = metadata !{i32 786689, metadata !305, metadata !"last", metadata !5, i32 33554724, metadata !279, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [last] [line 292]
!311 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!312 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!313 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!314 = metadata !{i32 93, i32 0, metadata !159, null}
!315 = metadata !{i32 97, i32 0, metadata !159, null}
!316 = metadata !{i32 98, i32 0, metadata !317, null}
!317 = metadata !{i32 786443, metadata !1, metadata !159, i32 98, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!318 = metadata !{i32 101, i32 0, metadata !159, null}
!319 = metadata !{i32 102, i32 0, metadata !159, null}
!320 = metadata !{metadata !321, metadata !327, i64 88}
!321 = metadata !{metadata !"kwset", metadata !322, i64 0, metadata !327, i64 88, metadata !326, i64 96, metadata !327, i64 104, metadata !327, i64 108, metadata !324, i64 112, metadata !324, i64 368, metadata !326, i64 2416, metadata !327, i64 2424, metadata !326, i64 2432}
!322 = metadata !{metadata !"obstack", metadata !323, i64 0, metadata !326, i64 8, metadata !326, i64 16, metadata !326, i64 24, metadata !326, i64 32, metadata !324, i64 40, metadata !327, i64 48, metadata !326, i64 56, metadata !326, i64 64, metadata !326, i64 72, metadata !327, i64 80, metadata !327, i64 80, metadata !327, i64 80}
!323 = metadata !{metadata !"long", metadata !324, i64 0}
!324 = metadata !{metadata !"omnipotent char", metadata !325, i64 0}
!325 = metadata !{metadata !"Simple C/C++ TBAA"}
!326 = metadata !{metadata !"any pointer", metadata !324, i64 0}
!327 = metadata !{metadata !"int", metadata !324, i64 0}
!328 = metadata !{i32 104, i32 0, metadata !166, null}
!329 = metadata !{i32 104, i32 0, metadata !168, null}
!330 = metadata !{i32 56}
!331 = metadata !{i32 104, i32 0, metadata !332, null}
!332 = metadata !{i32 786443, metadata !1, metadata !168, i32 104, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!333 = metadata !{metadata !322, metadata !326, i64 32}
!334 = metadata !{metadata !322, metadata !326, i64 24}
!335 = metadata !{i32 104, i32 0, metadata !171, null}
!336 = metadata !{metadata !322, metadata !326, i64 16}
!337 = metadata !{i32 104, i32 0, metadata !338, null}
!338 = metadata !{i32 786443, metadata !1, metadata !171, i32 104, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!339 = metadata !{metadata !322, metadata !327, i64 48}
!340 = metadata !{i32 104, i32 0, metadata !341, null}
!341 = metadata !{i32 786443, metadata !1, metadata !171, i32 104, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!342 = metadata !{metadata !322, metadata !326, i64 8}
!343 = metadata !{metadata !321, metadata !326, i64 96}
!344 = metadata !{i32 105, i32 0, metadata !345, null}
!345 = metadata !{i32 786443, metadata !1, metadata !159, i32 105, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!346 = metadata !{i32 786689, metadata !221, metadata !"kws", metadata !5, i32 16777983, metadata !11, i32 0, metadata !347} ; [ DW_TAG_arg_variable ] [kws] [line 767]
!347 = metadata !{i32 107, i32 0, metadata !348, null}
!348 = metadata !{i32 786443, metadata !1, metadata !345, i32 106, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!349 = metadata !{i32 767, i32 0, metadata !221, metadata !347}
!350 = metadata !{i32 786688, metadata !221, metadata !"kwset", metadata !5, i32 769, metadata !13, i32 0, metadata !347} ; [ DW_TAG_auto_variable ] [kwset] [line 769]
!351 = metadata !{i32 771, i32 0, metadata !221, metadata !347}
!352 = metadata !{i8* null}
!353 = metadata !{i32 786688, metadata !228, metadata !"__obj", metadata !5, i32 772, metadata !41, i32 0, metadata !347} ; [ DW_TAG_auto_variable ] [__obj] [line 772]
!354 = metadata !{i32 772, i32 0, metadata !228, metadata !347}
!355 = metadata !{i32 772, i32 0, metadata !356, metadata !347}
!356 = metadata !{i32 786443, metadata !1, metadata !228, i32 772, i32 0, i32 79} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!357 = metadata !{i32 773, i32 0, metadata !221, metadata !347}
!358 = metadata !{i32 108, i32 0, metadata !348, null}
!359 = metadata !{i32 110, i32 0, metadata !159, null}
!360 = metadata !{metadata !361, metadata !327, i64 0}
!361 = metadata !{metadata !"trie", metadata !327, i64 0, metadata !326, i64 8, metadata !326, i64 16, metadata !326, i64 24, metadata !326, i64 32, metadata !327, i64 40, metadata !327, i64 44, metadata !327, i64 48}
!362 = metadata !{i32 111, i32 0, metadata !159, null}
!363 = metadata !{i32 117, i32 0, metadata !159, null}
!364 = metadata !{metadata !321, metadata !327, i64 104}
!365 = metadata !{i32 118, i32 0, metadata !159, null}
!366 = metadata !{metadata !321, metadata !327, i64 108}
!367 = metadata !{i32 119, i32 0, metadata !159, null}
!368 = metadata !{metadata !321, metadata !326, i64 2416}
!369 = metadata !{i32 120, i32 0, metadata !159, null}
!370 = metadata !{metadata !321, metadata !326, i64 2432}
!371 = metadata !{i32 122, i32 0, metadata !159, null}
!372 = metadata !{i32 123, i32 0, metadata !159, null}
!373 = metadata !{i32 767, i32 0, metadata !221, null}
!374 = metadata !{i32 771, i32 0, metadata !221, null}
!375 = metadata !{i32 772, i32 0, metadata !228, null}
!376 = metadata !{i32 772, i32 0, metadata !356, null}
!377 = metadata !{i32 773, i32 0, metadata !221, null}
!378 = metadata !{i32 774, i32 0, metadata !221, null}
!379 = metadata !{i32 132, i32 0, metadata !4, null}
!380 = metadata !{i32 139, i32 0, metadata !4, null}
!381 = metadata !{i32 140, i32 0, metadata !4, null}
!382 = metadata !{i32 143, i32 0, metadata !4, null}
!383 = metadata !{i32 144, i32 0, metadata !4, null}
!384 = metadata !{i32 145, i32 0, metadata !4, null}
!385 = metadata !{i32 149, i32 0, metadata !4, null}
!386 = metadata !{i32 151, i32 0, metadata !117, null}
!387 = metadata !{i32 157, i32 0, metadata !117, null}
!388 = metadata !{i32 158, i32 0, metadata !117, null}
!389 = metadata !{i32 175, i32 0, metadata !114, null}
!390 = metadata !{i32 175, i32 0, metadata !391, null}
!391 = metadata !{i32 786443, metadata !1, metadata !120, i32 175, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!392 = metadata !{i32 175, i32 0, metadata !123, null}
!393 = metadata !{i32 175, i32 0, metadata !394, null}
!394 = metadata !{i32 786443, metadata !1, metadata !123, i32 175, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!395 = metadata !{i32 175, i32 0, metadata !396, null}
!396 = metadata !{i32 786443, metadata !1, metadata !123, i32 175, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!397 = metadata !{metadata !324, metadata !324, i64 0}
!398 = metadata !{i32 156, i32 0, metadata !117, null}
!399 = metadata !{metadata !361, metadata !326, i64 8}
!400 = metadata !{metadata !326, metadata !326, i64 0}
!401 = metadata !{i32 1}
!402 = metadata !{i32 159, i32 0, metadata !117, null}
!403 = metadata !{i32 161, i32 0, metadata !117, null}
!404 = metadata !{metadata !405, metadata !324, i64 24}
!405 = metadata !{metadata !"tree", metadata !326, i64 0, metadata !326, i64 8, metadata !326, i64 16, metadata !324, i64 24, metadata !324, i64 25}
!406 = metadata !{i32 163, i32 0, metadata !407, null}
!407 = metadata !{i32 786443, metadata !1, metadata !117, i32 162, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!408 = metadata !{i32 164, i32 0, metadata !409, null}
!409 = metadata !{i32 786443, metadata !1, metadata !407, i32 164, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!410 = metadata !{i32 165, i32 0, metadata !409, null}
!411 = metadata !{i32 167, i32 0, metadata !409, null}
!412 = metadata !{i32 175, i32 0, metadata !120, null}
!413 = metadata !{i32 32}
!414 = metadata !{i32 177, i32 0, metadata !415, null}
!415 = metadata !{i32 786443, metadata !1, metadata !115, i32 177, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!416 = metadata !{i32 178, i32 0, metadata !415, null}
!417 = metadata !{i32 181, i32 0, metadata !126, null}
!418 = metadata !{i32 181, i32 0, metadata !128, null}
!419 = metadata !{i32 181, i32 0, metadata !420, null}
!420 = metadata !{i32 786443, metadata !1, metadata !128, i32 181, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!421 = metadata !{i32 180, i32 0, metadata !115, null}
!422 = metadata !{i32 181, i32 0, metadata !131, null}
!423 = metadata !{i32 181, i32 0, metadata !424, null}
!424 = metadata !{i32 786443, metadata !1, metadata !131, i32 181, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!425 = metadata !{i32 181, i32 0, metadata !426, null}
!426 = metadata !{i32 786443, metadata !1, metadata !131, i32 181, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!427 = metadata !{metadata !405, metadata !326, i64 16}
!428 = metadata !{i32 183, i32 0, metadata !136, null}
!429 = metadata !{i32 185, i32 0, metadata !134, null}
!430 = metadata !{i32 185, i32 0, metadata !431, null}
!431 = metadata !{i32 786443, metadata !1, metadata !134, i32 185, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!432 = metadata !{i32 186, i32 0, metadata !135, null}
!433 = metadata !{i32 188, i32 0, metadata !115, null}
!434 = metadata !{i32 189, i32 0, metadata !115, null}
!435 = metadata !{i32 190, i32 0, metadata !115, null}
!436 = metadata !{metadata !361, metadata !326, i64 16}
!437 = metadata !{i32 191, i32 0, metadata !115, null}
!438 = metadata !{i32 193, i32 0, metadata !115, null}
!439 = metadata !{i32 192, i32 0, metadata !115, null}
!440 = metadata !{metadata !361, metadata !327, i64 40}
!441 = metadata !{i32 194, i32 0, metadata !115, null}
!442 = metadata !{metadata !361, metadata !327, i64 44}
!443 = metadata !{i32 195, i32 0, metadata !115, null}
!444 = metadata !{i32 196, i32 0, metadata !115, null}
!445 = metadata !{metadata !405, metadata !324, i64 25}
!446 = metadata !{i32 199, i32 0, metadata !447, null}
!447 = metadata !{i32 786443, metadata !1, metadata !115, i32 199, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!448 = metadata !{i32 200, i32 0, metadata !447, null}
!449 = metadata !{metadata !405, metadata !326, i64 0}
!450 = metadata !{i32 202, i32 0, metadata !447, null}
!451 = metadata !{metadata !405, metadata !326, i64 8}
!452 = metadata !{i32 205, i32 0, metadata !115, null}
!453 = metadata !{i32 207, i32 0, metadata !454, null}
!454 = metadata !{i32 786443, metadata !1, metadata !455, i32 207, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!455 = metadata !{i32 786443, metadata !1, metadata !115, i32 206, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!456 = metadata !{i32 208, i32 0, metadata !454, null}
!457 = metadata !{i32 215, i32 0, metadata !458, null}
!458 = metadata !{i32 786443, metadata !1, metadata !115, i32 215, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!459 = metadata !{i32 218, i32 0, metadata !460, null}
!460 = metadata !{i32 786443, metadata !1, metadata !458, i32 217, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!461 = metadata !{i32 221, i32 0, metadata !462, null}
!462 = metadata !{i32 786443, metadata !1, metadata !460, i32 219, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!463 = metadata !{i32 224, i32 0, metadata !464, null}
!464 = metadata !{i32 786443, metadata !1, metadata !462, i32 222, i32 0, i32 37} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!465 = metadata !{i32 225, i32 0, metadata !464, null}
!466 = metadata !{i32 226, i32 0, metadata !464, null}
!467 = metadata !{i32 227, i32 0, metadata !464, null}
!468 = metadata !{i32 229, i32 0, metadata !464, null}
!469 = metadata !{i32 230, i32 0, metadata !464, null}
!470 = metadata !{i32 231, i32 0, metadata !464, null}
!471 = metadata !{i32 232, i32 0, metadata !464, null}
!472 = metadata !{i32 233, i32 0, metadata !464, null}
!473 = metadata !{i32 234, i32 0, metadata !464, null}
!474 = metadata !{i32 235, i32 0, metadata !464, null}
!475 = metadata !{i32 237, i32 0, metadata !464, null}
!476 = metadata !{i32 241, i32 0, metadata !462, null}
!477 = metadata !{i32 244, i32 0, metadata !478, null}
!478 = metadata !{i32 786443, metadata !1, metadata !462, i32 242, i32 0, i32 38} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!479 = metadata !{i32 245, i32 0, metadata !478, null}
!480 = metadata !{i32 246, i32 0, metadata !478, null}
!481 = metadata !{i32 247, i32 0, metadata !478, null}
!482 = metadata !{i32 249, i32 0, metadata !478, null}
!483 = metadata !{i32 250, i32 0, metadata !478, null}
!484 = metadata !{i32 251, i32 0, metadata !478, null}
!485 = metadata !{i32 252, i32 0, metadata !478, null}
!486 = metadata !{i32 253, i32 0, metadata !478, null}
!487 = metadata !{i32 254, i32 0, metadata !478, null}
!488 = metadata !{i32 255, i32 0, metadata !478, null}
!489 = metadata !{i32 257, i32 0, metadata !478, null}
!490 = metadata !{i32 261, i32 0, metadata !462, null}
!491 = metadata !{i32 264, i32 0, metadata !492, null}
!492 = metadata !{i32 786443, metadata !1, metadata !460, i32 264, i32 0, i32 39} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!493 = metadata !{i32 265, i32 0, metadata !492, null}
!494 = metadata !{i32 267, i32 0, metadata !492, null}
!495 = metadata !{i32 271, i32 0, metadata !117, null}
!496 = metadata !{i32 276, i32 0, metadata !497, null}
!497 = metadata !{i32 786443, metadata !1, metadata !4, i32 276, i32 0, i32 40} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!498 = metadata !{i32 277, i32 0, metadata !497, null}
!499 = metadata !{i32 278, i32 0, metadata !4, null}
!500 = metadata !{i32 281, i32 0, metadata !501, null}
!501 = metadata !{i32 786443, metadata !1, metadata !4, i32 281, i32 0, i32 41} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!502 = metadata !{i32 282, i32 0, metadata !501, null}
!503 = metadata !{i32 283, i32 0, metadata !504, null}
!504 = metadata !{i32 786443, metadata !1, metadata !4, i32 283, i32 0, i32 42} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!505 = metadata !{i32 284, i32 0, metadata !504, null}
!506 = metadata !{i32 287, i32 0, metadata !4, null}
!507 = metadata !{i32 385, i32 0, metadata !173, null}
!508 = metadata !{i32 391, i32 0, metadata !173, null}
!509 = metadata !{i32 393, i32 0, metadata !173, null}
!510 = metadata !{i32 398, i32 0, metadata !173, null}
!511 = metadata !{i32 402, i32 0, metadata !185, null}
!512 = metadata !{i32 407, i32 0, metadata !187, null}
!513 = metadata !{i32 407, i32 0, metadata !189, null}
!514 = metadata !{i32 407, i32 0, metadata !515, null}
!515 = metadata !{i32 786443, metadata !1, metadata !189, i32 407, i32 0, i32 47} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!516 = metadata !{i32 407, i32 0, metadata !192, null}
!517 = metadata !{i32 407, i32 0, metadata !518, null}
!518 = metadata !{i32 786443, metadata !1, metadata !192, i32 407, i32 0, i32 49} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!519 = metadata !{i32 407, i32 0, metadata !520, null}
!520 = metadata !{i32 786443, metadata !1, metadata !192, i32 407, i32 0, i32 50} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!521 = metadata !{i32 408, i32 0, metadata !522, null}
!522 = metadata !{i32 786443, metadata !1, metadata !184, i32 408, i32 0, i32 51} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!523 = metadata !{i32 409, i32 0, metadata !522, null}
!524 = metadata !{i32 410, i32 0, metadata !525, null}
!525 = metadata !{i32 786443, metadata !1, metadata !184, i32 410, i32 0, i32 52} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!526 = metadata !{i32 416, i32 0, metadata !527, null}
!527 = metadata !{i32 786443, metadata !1, metadata !184, i32 416, i32 0, i32 54} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!528 = metadata !{i32 420, i32 0, metadata !184, null}
!529 = metadata !{i32 417, i32 0, metadata !527, null}
!530 = metadata !{i32 412, i32 0, metadata !531, null}
!531 = metadata !{i32 786443, metadata !1, metadata !525, i32 411, i32 0, i32 53} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!532 = metadata !{i32 413, i32 0, metadata !531, null}
!533 = metadata !{i32 421, i32 0, metadata !534, null}
!534 = metadata !{i32 786443, metadata !1, metadata !184, i32 421, i32 0, i32 55} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!535 = metadata !{i32 422, i32 0, metadata !536, null}
!536 = metadata !{i32 786443, metadata !1, metadata !534, i32 422, i32 0, i32 56} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!537 = metadata !{i32 424, i32 0, metadata !184, null}
!538 = metadata !{metadata !321, metadata !327, i64 2424}
!539 = metadata !{i32 425, i32 0, metadata !184, null}
!540 = metadata !{i32 429, i32 0, metadata !195, null}
!541 = metadata !{i32 433, i32 0, metadata !542, null}
!542 = metadata !{i32 786443, metadata !1, metadata !195, i32 433, i32 0, i32 58} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!543 = metadata !{i32 436, i32 0, metadata !544, null}
!544 = metadata !{i32 786443, metadata !1, metadata !542, i32 434, i32 0, i32 59} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!545 = metadata !{i32 438, i32 0, metadata !544, null}
!546 = metadata !{i32 439, i32 0, metadata !544, null}
!547 = metadata !{metadata !361, metadata !327, i64 48}
!548 = metadata !{i32 442, i32 0, metadata !544, null}
!549 = metadata !{i32 445, i32 0, metadata !544, null}
!550 = metadata !{metadata !361, metadata !326, i64 32}
!551 = metadata !{i32 449, i32 0, metadata !552, null}
!552 = metadata !{i32 786443, metadata !1, metadata !544, i32 449, i32 0, i32 60} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!553 = metadata !{i32 461, i32 0, metadata !554, null}
!554 = metadata !{i32 786443, metadata !1, metadata !555, i32 461, i32 0, i32 64} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!555 = metadata !{i32 786443, metadata !1, metadata !552, i32 450, i32 0, i32 61} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!556 = metadata !{i32 454, i32 0, metadata !557, null}
!557 = metadata !{i32 786443, metadata !1, metadata !555, i32 454, i32 0, i32 62} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!558 = metadata !{i32 455, i32 0, metadata !559, null}
!559 = metadata !{i32 786443, metadata !1, metadata !557, i32 455, i32 0, i32 63} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!560 = metadata !{i32 456, i32 0, metadata !559, null}
!561 = metadata !{i32 462, i32 0, metadata !554, null}
!562 = metadata !{metadata !361, metadata !326, i64 24}
!563 = metadata !{i32 468, i32 0, metadata !564, null}
!564 = metadata !{i32 786443, metadata !1, metadata !195, i32 468, i32 0, i32 65} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!565 = metadata !{i32 479, i32 0, metadata !566, null}
!566 = metadata !{i32 786443, metadata !1, metadata !195, i32 478, i32 0, i32 69} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!567 = metadata !{i32 480, i32 0, metadata !195, null}
!568 = metadata !{i32 482, i32 0, metadata !569, null}
!569 = metadata !{i32 786443, metadata !1, metadata !195, i32 482, i32 0, i32 70} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!570 = metadata !{i32 470, i32 0, metadata !571, null}
!571 = metadata !{i32 786443, metadata !1, metadata !572, i32 470, i32 0, i32 67} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!572 = metadata !{i32 786443, metadata !1, metadata !564, i32 469, i32 0, i32 66} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!573 = metadata !{i32 471, i32 0, metadata !571, null}
!574 = metadata !{i32 472, i32 0, metadata !575, null}
!575 = metadata !{i32 786443, metadata !1, metadata !572, i32 472, i32 0, i32 68} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!576 = metadata !{i32 473, i32 0, metadata !575, null}
!577 = metadata !{i32 484, i32 0, metadata !578, null}
!578 = metadata !{i32 786443, metadata !1, metadata !569, i32 483, i32 0, i32 71} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!579 = metadata !{i32 483, i32 0, metadata !578, null}
!580 = metadata !{i32 486, i32 0, metadata !569, null}
!581 = metadata !{i32 490, i32 0, metadata !582, null}
!582 = metadata !{i32 786443, metadata !1, metadata !173, i32 490, i32 0, i32 72} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!583 = metadata !{i32 492, i32 0, metadata !584, null}
!584 = metadata !{i32 786443, metadata !1, metadata !582, i32 491, i32 0, i32 73} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!585 = metadata !{i32 491, i32 0, metadata !584, null}
!586 = metadata !{i32 494, i32 0, metadata !582, null}
!587 = metadata !{i32 497, i32 0, metadata !173, null}
!588 = metadata !{i32 292, i32 0, metadata !305, null}
!589 = metadata !{i32 294, i32 0, metadata !590, null}
!590 = metadata !{i32 786443, metadata !1, metadata !305, i32 294, i32 0, i32 147} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!591 = metadata !{i32 296, i32 0, metadata !305, null}
!592 = metadata !{i32 297, i32 0, metadata !305, null}
!593 = metadata !{i32 298, i32 0, metadata !305, null}
!594 = metadata !{i32 299, i32 0, metadata !305, null}
!595 = metadata !{i32 340, i32 0, metadata !297, null}
!596 = metadata !{i32 341, i32 0, metadata !297, null}
!597 = metadata !{i32 342, i32 0, metadata !297, null}
!598 = metadata !{i32 344, i32 0, metadata !599, null}
!599 = metadata !{i32 786443, metadata !1, metadata !297, i32 344, i32 0, i32 145} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!600 = metadata !{i32 346, i32 0, metadata !297, null}
!601 = metadata !{i32 347, i32 0, metadata !297, null}
!602 = metadata !{i32 348, i32 0, metadata !603, null}
!603 = metadata !{i32 786443, metadata !1, metadata !297, i32 348, i32 0, i32 146} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!604 = metadata !{i32 349, i32 0, metadata !603, null}
!605 = metadata !{i32 350, i32 0, metadata !297, null}
!606 = metadata !{i32 305, i32 0, metadata !289, null}
!607 = metadata !{i32 306, i32 0, metadata !289, null}
!608 = metadata !{i32 310, i32 0, metadata !609, null}
!609 = metadata !{i32 786443, metadata !1, metadata !289, i32 310, i32 0, i32 140} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!610 = metadata !{i32 313, i32 0, metadata !289, null}
!611 = metadata !{i32 314, i32 0, metadata !289, null}
!612 = metadata !{i32 318, i32 0, metadata !289, null}
!613 = metadata !{i32 321, i32 0, metadata !614, null}
!614 = metadata !{i32 786443, metadata !1, metadata !289, i32 319, i32 0, i32 141} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!615 = metadata !{i32 320, i32 0, metadata !614, null}
!616 = metadata !{i32 322, i32 0, metadata !617, null}
!617 = metadata !{i32 786443, metadata !1, metadata !614, i32 322, i32 0, i32 142} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!618 = metadata !{i32 323, i32 0, metadata !617, null}
!619 = metadata !{i32 325, i32 0, metadata !617, null}
!620 = metadata !{i32 328, i32 0, metadata !621, null}
!621 = metadata !{i32 786443, metadata !1, metadata !622, i32 327, i32 0, i32 144} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!622 = metadata !{i32 786443, metadata !1, metadata !614, i32 326, i32 0, i32 143} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!623 = metadata !{i32 329, i32 0, metadata !621, null}
!624 = metadata !{i32 331, i32 0, metadata !614, null}
!625 = metadata !{i32 334, i32 0, metadata !289, null}
!626 = metadata !{i32 335, i32 0, metadata !289, null}
!627 = metadata !{i32 354, i32 0, metadata !283, null}
!628 = metadata !{i32 356, i32 0, metadata !629, null}
!629 = metadata !{i32 786443, metadata !1, metadata !283, i32 356, i32 0, i32 136} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!630 = metadata !{i32 358, i32 0, metadata !631, null}
!631 = metadata !{i32 786443, metadata !1, metadata !283, i32 358, i32 0, i32 137} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!632 = metadata !{i32 360, i32 0, metadata !633, null}
!633 = metadata !{i32 786443, metadata !1, metadata !283, i32 360, i32 0, i32 138} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!634 = metadata !{i32 362, i32 0, metadata !283, null}
!635 = metadata !{i32 363, i32 0, metadata !636, null}
!636 = metadata !{i32 786443, metadata !1, metadata !283, i32 363, i32 0, i32 139} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!637 = metadata !{i32 364, i32 0, metadata !636, null}
!638 = metadata !{i32 366, i32 0, metadata !636, null}
!639 = metadata !{i32 368, i32 0, metadata !283, null}
!640 = metadata !{i32 373, i32 0, metadata !276, null}
!641 = metadata !{i32 375, i32 0, metadata !642, null}
!642 = metadata !{i32 786443, metadata !1, metadata !276, i32 375, i32 0, i32 135} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!643 = metadata !{i32 377, i32 0, metadata !276, null}
!644 = metadata !{i32 378, i32 0, metadata !276, null}
!645 = metadata !{i32 379, i32 0, metadata !276, null}
!646 = metadata !{i32 380, i32 0, metadata !276, null}
!647 = metadata !{i32 747, i32 0, metadata !198, null}
!648 = metadata !{i32 749, i32 0, metadata !198, null}
!649 = metadata !{i32 750, i32 0, metadata !220, null}
!650 = metadata !{i32 786689, metadata !259, metadata !"kws", metadata !5, i32 16777717, metadata !11, i32 0, metadata !651} ; [ DW_TAG_arg_variable ] [kws] [line 501]
!651 = metadata !{i32 752, i32 0, metadata !219, null}
!652 = metadata !{i32 501, i32 0, metadata !259, metadata !651}
!653 = metadata !{i32 786689, metadata !259, metadata !"text", metadata !5, i32 33554933, metadata !8, i32 0, metadata !651} ; [ DW_TAG_arg_variable ] [text] [line 501]
!654 = metadata !{i32 786689, metadata !259, metadata !"size", metadata !5, i32 50332149, metadata !90, i32 0, metadata !651} ; [ DW_TAG_arg_variable ] [size] [line 501]
!655 = metadata !{i32 786688, metadata !259, metadata !"kwset", metadata !5, i32 503, metadata !216, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [kwset] [line 503]
!656 = metadata !{i32 508, i32 0, metadata !259, metadata !651}
!657 = metadata !{i32 509, i32 0, metadata !259, metadata !651}
!658 = metadata !{i32 786688, metadata !259, metadata !"len", metadata !5, i32 506, metadata !43, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [len] [line 506]
!659 = metadata !{i32 511, i32 0, metadata !660, metadata !651}
!660 = metadata !{i32 786443, metadata !1, metadata !259, i32 511, i32 0, i32 114} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!661 = metadata !{i32 757, i32 0, metadata !662, null}
!662 = metadata !{i32 786443, metadata !1, metadata !663, i32 754, i32 0, i32 77} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!663 = metadata !{i32 786443, metadata !1, metadata !219, i32 753, i32 0, i32 76} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!664 = metadata !{i32 513, i32 0, metadata !665, metadata !651}
!665 = metadata !{i32 786443, metadata !1, metadata !259, i32 513, i32 0, i32 115} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!666 = metadata !{i32 515, i32 0, metadata !667, metadata !651}
!667 = metadata !{i32 786443, metadata !1, metadata !259, i32 515, i32 0, i32 116} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!668 = metadata !{i32 517, i32 0, metadata !669, metadata !651}
!669 = metadata !{i32 786443, metadata !1, metadata !667, i32 516, i32 0, i32 117} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!670 = metadata !{i32 786688, metadata !259, metadata !"tp", metadata !5, i32 505, metadata !8, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [tp] [line 505]
!671 = metadata !{i32 518, i32 0, metadata !669, metadata !651}
!672 = metadata !{i32 523, i32 0, metadata !259, metadata !651}
!673 = metadata !{i32 524, i32 0, metadata !259, metadata !651}
!674 = metadata !{i32 786688, metadata !259, metadata !"md2", metadata !5, i32 506, metadata !43, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [md2] [line 506]
!675 = metadata !{i32 525, i32 0, metadata !259, metadata !651}
!676 = metadata !{i32 528, i32 0, metadata !677, metadata !651}
!677 = metadata !{i32 786443, metadata !1, metadata !259, i32 528, i32 0, i32 118} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!678 = metadata !{i32 530, i32 0, metadata !679, metadata !651}
!679 = metadata !{i32 786443, metadata !1, metadata !677, i32 530, i32 0, i32 119} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!680 = metadata !{i32 786688, metadata !259, metadata !"ep", metadata !5, i32 505, metadata !8, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [ep] [line 505]
!681 = metadata !{i32 532, i32 0, metadata !682, metadata !651}
!682 = metadata !{i32 786443, metadata !1, metadata !679, i32 531, i32 0, i32 120} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!683 = metadata !{i32 560, i32 0, metadata !682, metadata !651}
!684 = metadata !{i32 555, i32 0, metadata !685, metadata !651}
!685 = metadata !{i32 786443, metadata !1, metadata !686, i32 555, i32 0, i32 127} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!686 = metadata !{i32 786443, metadata !1, metadata !687, i32 554, i32 0, i32 126} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!687 = metadata !{i32 786443, metadata !1, metadata !682, i32 553, i32 0, i32 125} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!688 = metadata !{i32 534, i32 0, metadata !689, metadata !651}
!689 = metadata !{i32 786443, metadata !1, metadata !682, i32 533, i32 0, i32 121} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!690 = metadata !{i32 535, i32 0, metadata !689, metadata !651}
!691 = metadata !{i32 536, i32 0, metadata !692, metadata !651}
!692 = metadata !{i32 786443, metadata !1, metadata !689, i32 536, i32 0, i32 122} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!693 = metadata !{i32 538, i32 0, metadata !689, metadata !651}
!694 = metadata !{i32 539, i32 0, metadata !689, metadata !651}
!695 = metadata !{i32 540, i32 0, metadata !689, metadata !651}
!696 = metadata !{i32 541, i32 0, metadata !697, metadata !651}
!697 = metadata !{i32 786443, metadata !1, metadata !689, i32 541, i32 0, i32 123} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!698 = metadata !{i32 543, i32 0, metadata !689, metadata !651}
!699 = metadata !{i32 544, i32 0, metadata !689, metadata !651}
!700 = metadata !{i32 545, i32 0, metadata !689, metadata !651}
!701 = metadata !{i32 546, i32 0, metadata !702, metadata !651}
!702 = metadata !{i32 786443, metadata !1, metadata !689, i32 546, i32 0, i32 124} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!703 = metadata !{i32 548, i32 0, metadata !689, metadata !651}
!704 = metadata !{i32 549, i32 0, metadata !689, metadata !651}
!705 = metadata !{i32 550, i32 0, metadata !689, metadata !651}
!706 = metadata !{i32 553, i32 0, metadata !687, metadata !651}
!707 = metadata !{i32 558, i32 0, metadata !708, metadata !651}
!708 = metadata !{i32 786443, metadata !1, metadata !686, i32 557, i32 0, i32 128} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!709 = metadata !{i32 561, i32 0, metadata !682, metadata !651}
!710 = metadata !{i32 565, i32 0, metadata !259, metadata !651}
!711 = metadata !{i32 566, i32 0, metadata !259, metadata !651}
!712 = metadata !{i32 567, i32 0, metadata !259, metadata !651}
!713 = metadata !{i32 574, i32 0, metadata !714, metadata !651}
!714 = metadata !{i32 786443, metadata !1, metadata !715, i32 574, i32 0, i32 133} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!715 = metadata !{i32 786443, metadata !1, metadata !716, i32 573, i32 0, i32 132} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!716 = metadata !{i32 786443, metadata !1, metadata !717, i32 572, i32 0, i32 131} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!717 = metadata !{i32 786443, metadata !1, metadata !259, i32 568, i32 0, i32 129} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!718 = metadata !{i32 569, i32 0, metadata !717, metadata !651}
!719 = metadata !{i32 786688, metadata !259, metadata !"d", metadata !5, i32 506, metadata !43, i32 0, metadata !651} ; [ DW_TAG_auto_variable ] [d] [line 506]
!720 = metadata !{i32 570, i32 0, metadata !721, metadata !651}
!721 = metadata !{i32 786443, metadata !1, metadata !717, i32 570, i32 0, i32 130} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!722 = metadata !{i32 572, i32 0, metadata !716, metadata !651}
!723 = metadata !{i32 577, i32 0, metadata !724, metadata !651}
!724 = metadata !{i32 786443, metadata !1, metadata !715, i32 576, i32 0, i32 134} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!725 = metadata !{i32 753, i32 0, metadata !663, null}
!726 = metadata !{i32 755, i32 0, metadata !662, null}
!727 = metadata !{metadata !728, metadata !327, i64 0}
!728 = metadata !{metadata !"kwsmatch", metadata !327, i64 0, metadata !324, i64 8, metadata !324, i64 16}
!729 = metadata !{i32 756, i32 0, metadata !662, null}
!730 = metadata !{metadata !323, metadata !323, i64 0}
!731 = metadata !{i32 758, i32 0, metadata !662, null}
!732 = metadata !{i32 786689, metadata !230, metadata !"kws", metadata !5, i32 16777803, metadata !11, i32 0, metadata !733} ; [ DW_TAG_arg_variable ] [kws] [line 587]
!733 = metadata !{i32 762, i32 0, metadata !220, null}
!734 = metadata !{i32 587, i32 0, metadata !230, metadata !733}
!735 = metadata !{i32 786689, metadata !230, metadata !"text", metadata !5, i32 33555019, metadata !8, i32 0, metadata !733} ; [ DW_TAG_arg_variable ] [text] [line 587]
!736 = metadata !{i32 786689, metadata !230, metadata !"len", metadata !5, i32 50332235, metadata !90, i32 0, metadata !733} ; [ DW_TAG_arg_variable ] [len] [line 587]
!737 = metadata !{i32 786689, metadata !230, metadata !"kwsmatch", metadata !5, i32 67109451, metadata !201, i32 0, metadata !733} ; [ DW_TAG_arg_variable ] [kwsmatch] [line 587]
!738 = metadata !{i32 786688, metadata !230, metadata !"kwset", metadata !5, i32 589, metadata !216, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [kwset] [line 589]
!739 = metadata !{i32 606, i32 0, metadata !230, metadata !733}
!740 = metadata !{i32 607, i32 0, metadata !741, metadata !733}
!741 = metadata !{i32 786443, metadata !1, metadata !230, i32 607, i32 0, i32 80} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!742 = metadata !{i32 611, i32 0, metadata !230, metadata !733}
!743 = metadata !{i32 786688, metadata !230, metadata !"trans", metadata !5, i32 599, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [trans] [line 599]
!744 = metadata !{i32 612, i32 0, metadata !230, metadata !733}
!745 = metadata !{i32 786688, metadata !230, metadata !"lim", metadata !5, i32 593, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [lim] [line 593]
!746 = metadata !{i32 786688, metadata !230, metadata !"end", metadata !5, i32 597, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [end] [line 597]
!747 = metadata !{i32 613, i32 0, metadata !230, metadata !733}
!748 = metadata !{i32 786688, metadata !230, metadata !"d", metadata !5, i32 596, metadata !43, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [d] [line 596]
!749 = metadata !{i32 614, i32 0, metadata !750, metadata !733}
!750 = metadata !{i32 786443, metadata !1, metadata !230, i32 614, i32 0, i32 81} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!751 = metadata !{i32 786688, metadata !230, metadata !"mch", metadata !5, i32 593, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [mch] [line 593]
!752 = metadata !{i32 615, i32 0, metadata !750, metadata !733}
!753 = metadata !{i32 622, i32 0, metadata !754, metadata !733}
!754 = metadata !{i32 786443, metadata !1, metadata !230, i32 622, i32 0, i32 83} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!755 = metadata !{i32 618, i32 0, metadata !756, metadata !733}
!756 = metadata !{i32 786443, metadata !1, metadata !750, i32 617, i32 0, i32 82} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!757 = metadata !{i32 786688, metadata !230, metadata !"accept", metadata !5, i32 592, metadata !241, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [accept] [line 592]
!758 = metadata !{i32 619, i32 0, metadata !756, metadata !733}
!759 = metadata !{i32 623, i32 0, metadata !754, metadata !733}
!760 = metadata !{i32 786688, metadata !230, metadata !"qlim", metadata !5, i32 597, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [qlim] [line 597]
!761 = metadata !{i32 627, i32 0, metadata !230, metadata !733}
!762 = metadata !{i32 629, i32 0, metadata !763, metadata !733}
!763 = metadata !{i32 786443, metadata !1, metadata !764, i32 629, i32 0, i32 85} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!764 = metadata !{i32 786443, metadata !1, metadata !230, i32 628, i32 0, i32 84} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!765 = metadata !{i32 654, i32 0, metadata !766, metadata !733}
!766 = metadata !{i32 786443, metadata !1, metadata !764, i32 653, i32 0, i32 91} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!767 = metadata !{i32 631, i32 0, metadata !768, metadata !733}
!768 = metadata !{i32 786443, metadata !1, metadata !763, i32 630, i32 0, i32 86} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!769 = metadata !{i32 632, i32 0, metadata !768, metadata !733}
!770 = metadata !{i32 634, i32 0, metadata !771, metadata !733}
!771 = metadata !{i32 786443, metadata !1, metadata !768, i32 633, i32 0, i32 87} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!772 = metadata !{i32 635, i32 0, metadata !771, metadata !733}
!773 = metadata !{i32 636, i32 0, metadata !771, metadata !733}
!774 = metadata !{i32 638, i32 0, metadata !768, metadata !733}
!775 = metadata !{i32 639, i32 0, metadata !768, metadata !733}
!776 = metadata !{i32 641, i32 0, metadata !763, metadata !733}
!777 = metadata !{i32 786688, metadata !230, metadata !"c", metadata !5, i32 594, metadata !71, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [c] [line 594]
!778 = metadata !{i32 642, i32 0, metadata !779, metadata !733}
!779 = metadata !{i32 786443, metadata !1, metadata !764, i32 642, i32 0, i32 88} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!780 = metadata !{i32 644, i32 0, metadata !764, metadata !733}
!781 = metadata !{i32 786688, metadata !230, metadata !"beg", metadata !5, i32 593, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [beg] [line 593]
!782 = metadata !{i32 645, i32 0, metadata !764, metadata !733}
!783 = metadata !{i32 786688, metadata !230, metadata !"trie", metadata !5, i32 591, metadata !241, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [trie] [line 591]
!784 = metadata !{i32 646, i32 0, metadata !785, metadata !733}
!785 = metadata !{i32 786443, metadata !1, metadata !764, i32 646, i32 0, i32 89} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!786 = metadata !{i32 648, i32 0, metadata !787, metadata !733}
!787 = metadata !{i32 786443, metadata !1, metadata !785, i32 647, i32 0, i32 90} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!788 = metadata !{i32 649, i32 0, metadata !787, metadata !733}
!789 = metadata !{i32 651, i32 0, metadata !764, metadata !733}
!790 = metadata !{i32 652, i32 0, metadata !764, metadata !733}
!791 = metadata !{i32 655, i32 0, metadata !766, metadata !733}
!792 = metadata !{i32 656, i32 0, metadata !766, metadata !733}
!793 = metadata !{i32 657, i32 0, metadata !794, metadata !733}
!794 = metadata !{i32 786443, metadata !1, metadata !766, i32 657, i32 0, i32 92} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!795 = metadata !{i32 658, i32 0, metadata !794, metadata !733}
!796 = metadata !{i32 660, i32 0, metadata !794, metadata !733}
!797 = metadata !{i32 663, i32 0, metadata !798, metadata !733}
!798 = metadata !{i32 786443, metadata !1, metadata !799, i32 662, i32 0, i32 94} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!799 = metadata !{i32 786443, metadata !1, metadata !766, i32 661, i32 0, i32 93} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!800 = metadata !{i32 664, i32 0, metadata !801, metadata !733}
!801 = metadata !{i32 786443, metadata !1, metadata !798, i32 664, i32 0, i32 95} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!802 = metadata !{i32 666, i32 0, metadata !803, metadata !733}
!803 = metadata !{i32 786443, metadata !1, metadata !801, i32 665, i32 0, i32 96} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!804 = metadata !{i32 667, i32 0, metadata !803, metadata !733}
!805 = metadata !{i32 674, i32 0, metadata !806, metadata !733}
!806 = metadata !{i32 786443, metadata !1, metadata !764, i32 674, i32 0, i32 97} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!807 = metadata !{i32 683, i32 0, metadata !808, metadata !733}
!808 = metadata !{i32 786443, metadata !1, metadata !230, i32 683, i32 0, i32 98} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!809 = metadata !{i32 705, i32 0, metadata !810, metadata !733}
!810 = metadata !{i32 786443, metadata !1, metadata !811, i32 704, i32 0, i32 105} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!811 = metadata !{i32 786443, metadata !1, metadata !230, i32 688, i32 0, i32 99} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!812 = metadata !{i32 684, i32 0, metadata !808, metadata !733}
!813 = metadata !{i32 786688, metadata !230, metadata !"lmch", metadata !5, i32 593, metadata !8, i32 0, metadata !733} ; [ DW_TAG_auto_variable ] [lmch] [line 593]
!814 = metadata !{i32 685, i32 0, metadata !230, metadata !733}
!815 = metadata !{i32 686, i32 0, metadata !230, metadata !733}
!816 = metadata !{i32 687, i32 0, metadata !230, metadata !733}
!817 = metadata !{i32 689, i32 0, metadata !818, metadata !733}
!818 = metadata !{i32 786443, metadata !1, metadata !811, i32 689, i32 0, i32 100} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!819 = metadata !{i32 691, i32 0, metadata !811, metadata !733}
!820 = metadata !{i32 692, i32 0, metadata !821, metadata !733}
!821 = metadata !{i32 786443, metadata !1, metadata !811, i32 692, i32 0, i32 101} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!822 = metadata !{i32 697, i32 0, metadata !823, metadata !733}
!823 = metadata !{i32 786443, metadata !1, metadata !811, i32 697, i32 0, i32 103} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!824 = metadata !{i32 699, i32 0, metadata !825, metadata !733}
!825 = metadata !{i32 786443, metadata !1, metadata !823, i32 698, i32 0, i32 104} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!826 = metadata !{i32 700, i32 0, metadata !825, metadata !733}
!827 = metadata !{i32 702, i32 0, metadata !811, metadata !733}
!828 = metadata !{i32 703, i32 0, metadata !811, metadata !733}
!829 = metadata !{i32 706, i32 0, metadata !810, metadata !733}
!830 = metadata !{i32 707, i32 0, metadata !810, metadata !733}
!831 = metadata !{i32 708, i32 0, metadata !832, metadata !733}
!832 = metadata !{i32 786443, metadata !1, metadata !810, i32 708, i32 0, i32 106} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!833 = metadata !{i32 709, i32 0, metadata !832, metadata !733}
!834 = metadata !{i32 711, i32 0, metadata !832, metadata !733}
!835 = metadata !{i32 714, i32 0, metadata !836, metadata !733}
!836 = metadata !{i32 786443, metadata !1, metadata !837, i32 713, i32 0, i32 108} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!837 = metadata !{i32 786443, metadata !1, metadata !810, i32 712, i32 0, i32 107} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!838 = metadata !{i32 715, i32 0, metadata !839, metadata !733}
!839 = metadata !{i32 786443, metadata !1, metadata !836, i32 715, i32 0, i32 109} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!840 = metadata !{i32 717, i32 0, metadata !841, metadata !733}
!841 = metadata !{i32 786443, metadata !1, metadata !839, i32 716, i32 0, i32 110} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!842 = metadata !{i32 718, i32 0, metadata !841, metadata !733}
!843 = metadata !{i32 725, i32 0, metadata !844, metadata !733}
!844 = metadata !{i32 786443, metadata !1, metadata !811, i32 725, i32 0, i32 111} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!845 = metadata !{i32 730, i32 0, metadata !846, metadata !733}
!846 = metadata !{i32 786443, metadata !1, metadata !811, i32 730, i32 0, i32 113} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwset.c]
!847 = metadata !{i32 731, i32 0, metadata !846, metadata !733}
!848 = metadata !{i32 734, i32 0, metadata !230, metadata !733}
!849 = metadata !{i32 735, i32 0, metadata !230, metadata !733}
!850 = metadata !{i32 736, i32 0, metadata !230, metadata !733}
!851 = metadata !{i32 738, i32 0, metadata !230, metadata !733}
!852 = metadata !{i32 763, i32 0, metadata !198, null}
