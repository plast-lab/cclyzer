; ModuleID = 'kwsearch.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.kwset = type opaque
%struct.kwsmatch = type { i32, [1 x i64], [1 x i64] }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }

@kwset = internal global %struct.kwset* null, align 8
@match_icase = external global i32
@.str = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@eolbyte = external global i8
@match_words = external global i32
@match_lines = external global i32

; Function Attrs: nounwind uwtable
define void @Fcompile(i8* %pattern, i64 %size) #0 {
  %psize = alloca i64, align 8
  call void @llvm.dbg.value(metadata !{i8* %pattern}, i64 0, metadata !35), !dbg !117
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !36), !dbg !117
  call void @llvm.dbg.declare(metadata !{i64* %psize}, metadata !42), !dbg !118
  call void @kwsinit(%struct.kwset** @kwset) #6, !dbg !119
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !42), !dbg !120
  store i64 %size, i64* %psize, align 8, !dbg !120, !tbaa !121
  %1 = load i32* @match_icase, align 4, !dbg !125, !tbaa !127
  %2 = icmp eq i32 %1, 0, !dbg !125
  br i1 %2, label %8, label %3, !dbg !125

; <label>:3                                       ; preds = %0
  %4 = call i64 @__ctype_get_mb_cur_max() #6, !dbg !125
  %5 = icmp ugt i64 %4, 1, !dbg !125
  br i1 %5, label %6, label %8, !dbg !125

; <label>:6                                       ; preds = %3
  %7 = call i8* @mbtolower(i8* %pattern, i64* %psize) #6, !dbg !129
  call void @llvm.dbg.value(metadata !{i8* %7}, i64 0, metadata !41), !dbg !129
  call void @llvm.dbg.value(metadata !{i64* %psize}, i64 0, metadata !42), !dbg !130
  %.pre.pre = load i64* %psize, align 8, !dbg !130, !tbaa !121
  br label %8, !dbg !129

; <label>:8                                       ; preds = %3, %0, %6
  %.pre = phi i64 [ %.pre.pre, %6 ], [ %size, %0 ], [ %size, %3 ]
  %pat.0 = phi i8* [ %7, %6 ], [ %pattern, %0 ], [ %pattern, %3 ]
  call void @llvm.dbg.value(metadata !{i8* %pat.0}, i64 0, metadata !37), !dbg !135
  br label %9, !dbg !136

; <label>:9                                       ; preds = %26, %8
  %10 = phi i64 [ %.pre, %8 ], [ %27, %26 ]
  %beg.0 = phi i8* [ %pat.0, %8 ], [ %lim.1, %26 ]
  call void @llvm.dbg.value(metadata !{i8* %beg.0}, i64 0, metadata !39), !dbg !137
  call void @llvm.dbg.value(metadata !{i64* %psize}, i64 0, metadata !42), !dbg !130
  %11 = getelementptr inbounds i8* %pat.0, i64 %10, !dbg !130
  br label %12, !dbg !137

; <label>:12                                      ; preds = %14, %9
  %lim.0 = phi i8* [ %beg.0, %9 ], [ %17, %14 ]
  call void @llvm.dbg.value(metadata !{i8* %lim.0}, i64 0, metadata !38), !dbg !138
  call void @llvm.dbg.value(metadata !{i64* %psize}, i64 0, metadata !42), !dbg !130
  %13 = icmp ult i8* %lim.0, %11, !dbg !130
  br i1 %13, label %14, label %18, !dbg !130

; <label>:14                                      ; preds = %12
  %15 = load i8* %lim.0, align 1, !dbg !139, !tbaa !141
  %16 = icmp eq i8 %15, 10, !dbg !139
  %17 = getelementptr inbounds i8* %lim.0, i64 1, !dbg !142
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !39), !dbg !142
  br i1 %16, label %18, label %12, !dbg !139

; <label>:18                                      ; preds = %12, %14
  %lim.1 = phi i8* [ %lim.0, %12 ], [ %17, %14 ]
  %19 = load %struct.kwset** @kwset, align 8, !dbg !144, !tbaa !146
  %20 = ptrtoint i8* %lim.0 to i64, !dbg !144
  %21 = ptrtoint i8* %beg.0 to i64, !dbg !144
  %22 = sub i64 %20, %21, !dbg !144
  %23 = call i8* @kwsincr(%struct.kwset* %19, i8* %beg.0, i64 %22) #6, !dbg !144
  call void @llvm.dbg.value(metadata !{i8* %23}, i64 0, metadata !40), !dbg !144
  %24 = icmp eq i8* %23, null, !dbg !144
  br i1 %24, label %26, label %25, !dbg !144

; <label>:25                                      ; preds = %18
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %23) #6, !dbg !148
  br label %26, !dbg !148

; <label>:26                                      ; preds = %18, %25
  call void @llvm.dbg.value(metadata !{i8* %lim.1}, i64 0, metadata !37), !dbg !149
  call void @llvm.dbg.value(metadata !{i64* %psize}, i64 0, metadata !42), !dbg !150
  %27 = load i64* %psize, align 8, !dbg !150, !tbaa !121
  %28 = getelementptr inbounds i8* %pat.0, i64 %27, !dbg !150
  %29 = icmp ult i8* %lim.1, %28, !dbg !150
  br i1 %29, label %9, label %30, !dbg !150

; <label>:30                                      ; preds = %26
  %31 = load %struct.kwset** @kwset, align 8, !dbg !151, !tbaa !146
  %32 = call i8* @kwsprep(%struct.kwset* %31) #6, !dbg !151
  call void @llvm.dbg.value(metadata !{i8* %32}, i64 0, metadata !40), !dbg !151
  %33 = icmp eq i8* %32, null, !dbg !151
  br i1 %33, label %35, label %34, !dbg !151

; <label>:34                                      ; preds = %30
  call void (i32, i32, i8*, ...)* @error(i32 2, i32 0, i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i8* %32) #6, !dbg !153
  br label %35, !dbg !153

; <label>:35                                      ; preds = %30, %34
  ret void, !dbg !154
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare void @kwsinit(%struct.kwset**) #2

; Function Attrs: nounwind
declare i64 @__ctype_get_mb_cur_max() #3

declare i8* @mbtolower(i8*, i64*) #2

declare i8* @kwsincr(%struct.kwset*, i8*, i64) #2

declare void @error(i32, i32, i8*, ...) #2

declare i8* @kwsprep(%struct.kwset*) #2

; Function Attrs: nounwind uwtable
define i64 @Fexecute(i8* %buf, i64 %size, i64* nocapture %match_size, i8* %start_ptr) #0 {
  %1 = alloca i64, align 8
  %mb_start = alloca i8*, align 8
  %kwsmatch = alloca %struct.kwsmatch, align 8
  %s = alloca i64, align 8, !dbg !155
  %tmpcast = bitcast i64* %s to %struct.__mbstate_t*, !dbg !155
  call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !48), !dbg !156
  call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !49), !dbg !156
  store i64 %size, i64* %1, align 8, !tbaa !121
  call void @llvm.dbg.declare(metadata !{i64* %1}, metadata !49), !dbg !156
  call void @llvm.dbg.value(metadata !{i64* %match_size}, i64 0, metadata !50), !dbg !156
  call void @llvm.dbg.value(metadata !{i8* %start_ptr}, i64 0, metadata !51), !dbg !157
  call void @llvm.dbg.declare(metadata !{i8** %mb_start}, metadata !55), !dbg !158
  %2 = load i8* @eolbyte, align 1, !dbg !159, !tbaa !141
  call void @llvm.dbg.value(metadata !{i8 %2}, i64 0, metadata !57), !dbg !159
  call void @llvm.dbg.declare(metadata !{%struct.kwsmatch* %kwsmatch}, metadata !58), !dbg !160
  %3 = call i64 @__ctype_get_mb_cur_max() #6, !dbg !161
  %4 = icmp ugt i64 %3, 1, !dbg !161
  %5 = load i32* @match_icase, align 4, !dbg !162, !tbaa !127
  %6 = icmp ne i32 %5, 0, !dbg !162
  %or.cond3 = and i1 %4, %6, !dbg !161
  br i1 %or.cond3, label %7, label %15, !dbg !161

; <label>:7                                       ; preds = %0
  %8 = call i8* @mbtolower(i8* %buf, i64* %1) #6, !dbg !163
  call void @llvm.dbg.value(metadata !{i8* %8}, i64 0, metadata !70), !dbg !163
  %9 = icmp eq i8* %start_ptr, null, !dbg !164
  br i1 %9, label %15, label %10, !dbg !164

; <label>:10                                      ; preds = %7
  %11 = ptrtoint i8* %start_ptr to i64, !dbg !166
  %12 = ptrtoint i8* %buf to i64, !dbg !166
  %13 = sub i64 %11, %12, !dbg !166
  %14 = getelementptr inbounds i8* %8, i64 %13, !dbg !166
  call void @llvm.dbg.value(metadata !{i8* %14}, i64 0, metadata !51), !dbg !166
  br label %15, !dbg !166

; <label>:15                                      ; preds = %10, %7, %0
  %.1 = phi i8* [ %start_ptr, %0 ], [ %14, %10 ], [ null, %7 ]
  %.0 = phi i8* [ %buf, %0 ], [ %8, %10 ], [ %8, %7 ]
  %16 = icmp ne i8* %.1, null, !dbg !167
  %17 = select i1 %16, i8* %.1, i8* %.0, !dbg !167
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !52), !dbg !167
  call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !55), !dbg !167
  store i8* %17, i8** %mb_start, align 8, !dbg !167, !tbaa !146
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !167
  %18 = load i64* %1, align 8, !dbg !167, !tbaa !121
  %19 = getelementptr inbounds i8* %.0, i64 %18, !dbg !167
  %20 = icmp ugt i8* %17, %19, !dbg !167
  br i1 %20, label %.loopexit10, label %.lr.ph, !dbg !167

.lr.ph:                                           ; preds = %15
  %21 = getelementptr inbounds %struct.kwsmatch* %kwsmatch, i64 0, i32 2, i64 0, !dbg !168
  %22 = icmp eq i8* %.1, null, !dbg !169
  br label %23, !dbg !167

; <label>:23                                      ; preds = %.lr.ph, %.loopexit
  %24 = phi i8* [ %19, %.lr.ph ], [ %115, %.loopexit ]
  %beg.025 = phi i8* [ %17, %.lr.ph ], [ %113, %.loopexit ]
  %25 = load %struct.kwset** @kwset, align 8, !dbg !171, !tbaa !146
  %26 = ptrtoint i8* %24 to i64, !dbg !171
  %27 = ptrtoint i8* %beg.025 to i64, !dbg !171
  %28 = sub i64 %26, %27, !dbg !171
  %29 = call i64 @kwsexec(%struct.kwset* %25, i8* %beg.025, i64 %28, %struct.kwsmatch* %kwsmatch) #6, !dbg !171
  call void @llvm.dbg.value(metadata !{i64 %29}, i64 0, metadata !76), !dbg !171
  %30 = icmp eq i64 %29, -1, !dbg !172
  br i1 %30, label %.loopexit10, label %31, !dbg !172

; <label>:31                                      ; preds = %23
  %32 = load i64* %21, align 8, !dbg !168, !tbaa !121
  call void @llvm.dbg.value(metadata !{i64 %32}, i64 0, metadata !56), !dbg !168
  %33 = call i64 @__ctype_get_mb_cur_max() #6, !dbg !174
  %34 = icmp ugt i64 %33, 1, !dbg !174
  %35 = getelementptr inbounds i8* %beg.025, i64 %29, !dbg !174
  br i1 %34, label %36, label %._crit_edge, !dbg !174

; <label>:36                                      ; preds = %31
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !174
  %37 = load i64* %1, align 8, !dbg !174, !tbaa !121
  %38 = getelementptr inbounds i8* %.0, i64 %37, !dbg !174
  %39 = call zeroext i1 @is_mb_middle(i8** %mb_start, i8* %35, i8* %38, i64 %32) #6, !dbg !174
  br i1 %39, label %40, label %._crit_edge, !dbg !174

; <label>:40                                      ; preds = %36
  call void @llvm.dbg.declare(metadata !{%struct.__mbstate_t* %tmpcast}, metadata !79), !dbg !175
  store i64 0, i64* %s, align 8, !dbg !155
  call void @llvm.dbg.value(metadata !{i8** %mb_start}, i64 0, metadata !55), !dbg !176
  %41 = load i8** %mb_start, align 8, !dbg !176, !tbaa !146
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !176
  %42 = load i64* %1, align 8, !dbg !176, !tbaa !121
  %43 = getelementptr inbounds i8* %.0, i64 %42, !dbg !176
  %44 = ptrtoint i8* %43 to i64, !dbg !176
  %45 = ptrtoint i8* %35 to i64, !dbg !176
  %46 = sub i64 %44, %45, !dbg !176
  call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !177) #6, !dbg !178
  call void @llvm.dbg.value(metadata !{i64 %46}, i64 0, metadata !179) #6, !dbg !178
  call void @llvm.dbg.value(metadata !{%struct.__mbstate_t* %tmpcast}, i64 0, metadata !180) #6, !dbg !178
  %47 = call i64 @mbrtowc(i32* null, i8* %41, i64 %46, %struct.__mbstate_t* %tmpcast) #6, !dbg !181
  call void @llvm.dbg.value(metadata !{i64 %47}, i64 0, metadata !97), !dbg !176
  %48 = icmp eq i64 %47, -2, !dbg !183
  br i1 %48, label %.loopexit10, label %49, !dbg !183

; <label>:49                                      ; preds = %40
  call void @llvm.dbg.value(metadata !{i8** %mb_start}, i64 0, metadata !55), !dbg !185
  %50 = load i8** %mb_start, align 8, !dbg !185, !tbaa !146
  call void @llvm.dbg.value(metadata !{i8* %50}, i64 0, metadata !52), !dbg !185
  %51 = icmp eq i64 %47, -1, !dbg !186
  br i1 %51, label %.loopexit, label %52, !dbg !186

; <label>:52                                      ; preds = %49
  %53 = add i64 %47, -1, !dbg !188
  %54 = getelementptr inbounds i8* %50, i64 %53, !dbg !188
  call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !52), !dbg !188
  br label %.loopexit, !dbg !188

._crit_edge:                                      ; preds = %31, %36
  call void @llvm.dbg.value(metadata !{i8* %35}, i64 0, metadata !52), !dbg !189
  %55 = load i32* @match_words, align 4, !dbg !169, !tbaa !127
  %56 = icmp ne i32 %55, 0, !dbg !169
  %or.cond = or i1 %22, %56, !dbg !169
  br i1 %or.cond, label %57, label %.loopexit11, !dbg !169

; <label>:57                                      ; preds = %._crit_edge
  %58 = load i32* @match_lines, align 4, !dbg !190, !tbaa !127
  %59 = icmp eq i32 %58, 0, !dbg !190
  br i1 %59, label %74, label %60, !dbg !190

; <label>:60                                      ; preds = %57
  %61 = icmp ugt i8* %35, %.0, !dbg !192
  br i1 %61, label %62, label %66, !dbg !192

; <label>:62                                      ; preds = %60
  %.sum7 = add i64 %29, -1, !dbg !192
  %63 = getelementptr inbounds i8* %beg.025, i64 %.sum7, !dbg !192
  %64 = load i8* %63, align 1, !dbg !192, !tbaa !141
  %65 = icmp eq i8 %64, %2, !dbg !192
  br i1 %65, label %66, label %.loopexit, !dbg !192

; <label>:66                                      ; preds = %62, %60
  %.sum6 = add i64 %32, %29, !dbg !195
  %67 = getelementptr inbounds i8* %beg.025, i64 %.sum6, !dbg !195
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !195
  %68 = load i64* %1, align 8, !dbg !195, !tbaa !121
  %69 = getelementptr inbounds i8* %.0, i64 %68, !dbg !195
  %70 = icmp ult i8* %67, %69, !dbg !195
  br i1 %70, label %71, label %.loopexit12, !dbg !195

; <label>:71                                      ; preds = %66
  %72 = load i8* %67, align 1, !dbg !195, !tbaa !141
  %73 = icmp eq i8 %72, %2, !dbg !195
  br i1 %73, label %.loopexit12, label %.loopexit, !dbg !195

; <label>:74                                      ; preds = %57
  br i1 %56, label %.preheader, label %..loopexit12_crit_edge, !dbg !197

..loopexit12_crit_edge:                           ; preds = %74
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !199
  %.pre.pre = load i64* %1, align 8, !dbg !199, !tbaa !121
  br label %.loopexit12, !dbg !197

.preheader:                                       ; preds = %74, %109
  %try.0 = phi i8* [ %110, %109 ], [ %35, %74 ]
  %len.0 = phi i64 [ %111, %109 ], [ %32, %74 ]
  %75 = icmp ugt i8* %try.0, %.0, !dbg !201
  br i1 %75, label %76, label %87, !dbg !201

; <label>:76                                      ; preds = %.preheader
  %77 = getelementptr inbounds i8* %try.0, i64 -1, !dbg !201
  %78 = load i8* %77, align 1, !dbg !201, !tbaa !141
  %79 = zext i8 %78 to i64, !dbg !201
  %80 = call i16** @__ctype_b_loc() #1, !dbg !201
  %81 = load i16** %80, align 8, !dbg !201, !tbaa !146
  %82 = getelementptr inbounds i16* %81, i64 %79, !dbg !201
  %83 = load i16* %82, align 2, !dbg !201, !tbaa !205
  %84 = and i16 %83, 8, !dbg !201
  %85 = icmp ne i16 %84, 0, !dbg !201
  %86 = icmp eq i8 %78, 95, !dbg !201
  %or.cond8 = or i1 %85, %86, !dbg !201
  br i1 %or.cond8, label %.loopexit, label %87, !dbg !201

; <label>:87                                      ; preds = %76, %.preheader
  %88 = getelementptr inbounds i8* %try.0, i64 %len.0, !dbg !207
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !207
  %89 = load i64* %1, align 8, !dbg !207, !tbaa !121
  %90 = getelementptr inbounds i8* %.0, i64 %89, !dbg !207
  %91 = icmp ult i8* %88, %90, !dbg !207
  br i1 %91, label %92, label %112, !dbg !207

; <label>:92                                      ; preds = %87
  %93 = load i8* %88, align 1, !dbg !207, !tbaa !141
  %94 = zext i8 %93 to i64, !dbg !207
  %95 = call i16** @__ctype_b_loc() #1, !dbg !207
  %96 = load i16** %95, align 8, !dbg !207, !tbaa !146
  %97 = getelementptr inbounds i16* %96, i64 %94, !dbg !207
  %98 = load i16* %97, align 2, !dbg !207, !tbaa !205
  %99 = and i16 %98, 8, !dbg !207
  %100 = icmp ne i16 %99, 0, !dbg !207
  %101 = icmp eq i8 %93, 95, !dbg !207
  %or.cond9 = or i1 %100, %101, !dbg !207
  br i1 %or.cond9, label %102, label %112, !dbg !207

; <label>:102                                     ; preds = %92
  %103 = icmp eq i64 %len.0, 0, !dbg !209
  br i1 %103, label %.loopexit, label %104, !dbg !209

; <label>:104                                     ; preds = %102
  %105 = load %struct.kwset** @kwset, align 8, !dbg !212, !tbaa !146
  %106 = add i64 %len.0, -1, !dbg !212
  call void @llvm.dbg.value(metadata !{i64 %106}, i64 0, metadata !56), !dbg !212
  %107 = call i64 @kwsexec(%struct.kwset* %105, i8* %35, i64 %106, %struct.kwsmatch* %kwsmatch) #6, !dbg !212
  call void @llvm.dbg.value(metadata !{i64 %107}, i64 0, metadata !76), !dbg !212
  %108 = icmp eq i64 %107, -1, !dbg !213
  br i1 %108, label %.loopexit, label %109, !dbg !213

; <label>:109                                     ; preds = %104
  %.sum5 = add i64 %107, %29, !dbg !215
  %110 = getelementptr inbounds i8* %beg.025, i64 %.sum5, !dbg !215
  call void @llvm.dbg.value(metadata !{i8* %110}, i64 0, metadata !53), !dbg !215
  %111 = load i64* %21, align 8, !dbg !216, !tbaa !121
  call void @llvm.dbg.value(metadata !{i64 %111}, i64 0, metadata !56), !dbg !216
  br label %.preheader, !dbg !217

; <label>:112                                     ; preds = %92, %87
  br i1 %16, label %.loopexit11, label %.loopexit12, !dbg !218

.loopexit:                                        ; preds = %76, %102, %104, %49, %62, %71, %52
  %beg.1 = phi i8* [ %54, %52 ], [ %50, %49 ], [ %35, %62 ], [ %35, %71 ], [ %35, %104 ], [ %35, %102 ], [ %35, %76 ]
  %113 = getelementptr inbounds i8* %beg.1, i64 1, !dbg !167
  call void @llvm.dbg.value(metadata !{i8* %113}, i64 0, metadata !52), !dbg !167
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !167
  %114 = load i64* %1, align 8, !dbg !167, !tbaa !121
  %115 = getelementptr inbounds i8* %.0, i64 %114, !dbg !167
  %116 = icmp ugt i8* %113, %115, !dbg !167
  br i1 %116, label %.loopexit10, label %23, !dbg !167

.loopexit12:                                      ; preds = %71, %66, %..loopexit12_crit_edge, %112
  %117 = phi i64 [ %89, %112 ], [ %.pre.pre, %..loopexit12_crit_edge ], [ %68, %66 ], [ %68, %71 ]
  %len.1 = phi i64 [ %len.0, %112 ], [ %32, %..loopexit12_crit_edge ], [ %32, %66 ], [ %32, %71 ]
  %.sum = add i64 %len.1, %29, !dbg !199
  %118 = getelementptr inbounds i8* %beg.025, i64 %.sum, !dbg !199
  %119 = sext i8 %2 to i32, !dbg !199
  call void @llvm.dbg.value(metadata !{i64* %1}, i64 0, metadata !49), !dbg !199
  %120 = getelementptr inbounds i8* %.0, i64 %117, !dbg !199
  %121 = ptrtoint i8* %120 to i64, !dbg !199
  %122 = ptrtoint i8* %118 to i64, !dbg !199
  %123 = sub i64 %121, %122, !dbg !199
  %124 = call i8* @memchr(i8* %118, i32 %119, i64 %123) #7, !dbg !199
  call void @llvm.dbg.value(metadata !{i8* %124}, i64 0, metadata !54), !dbg !199
  %125 = icmp eq i8* %124, null, !dbg !199
  %126 = getelementptr inbounds i8* %124, i64 1, !dbg !220
  call void @llvm.dbg.value(metadata !{i8* %126}, i64 0, metadata !54), !dbg !220
  %. = select i1 %125, i8* %120, i8* %126, !dbg !199
  br label %127, !dbg !199

; <label>:127                                     ; preds = %129, %.loopexit12
  %beg.2 = phi i8* [ %35, %.loopexit12 ], [ %130, %129 ]
  %128 = icmp ult i8* %.0, %beg.2, !dbg !221
  br i1 %128, label %129, label %.critedge, !dbg !221

; <label>:129                                     ; preds = %127
  %130 = getelementptr inbounds i8* %beg.2, i64 -1, !dbg !221
  %131 = load i8* %130, align 1, !dbg !221, !tbaa !141
  %132 = icmp eq i8 %131, %2, !dbg !221
  br i1 %132, label %.critedge, label %127

.critedge:                                        ; preds = %129, %127
  %133 = ptrtoint i8* %. to i64, !dbg !222
  %134 = ptrtoint i8* %beg.2 to i64, !dbg !222
  %135 = sub i64 %133, %134, !dbg !222
  call void @llvm.dbg.value(metadata !{i64 %135}, i64 0, metadata !56), !dbg !222
  br label %.loopexit11, !dbg !222

.loopexit11:                                      ; preds = %._crit_edge, %112, %.critedge
  %len.2 = phi i64 [ %135, %.critedge ], [ %len.0, %112 ], [ %32, %._crit_edge ]
  %beg.3 = phi i8* [ %beg.2, %.critedge ], [ %35, %112 ], [ %35, %._crit_edge ]
  store i64 %len.2, i64* %match_size, align 8, !dbg !223, !tbaa !121
  %136 = ptrtoint i8* %beg.3 to i64, !dbg !224
  %137 = ptrtoint i8* %.0 to i64, !dbg !224
  %138 = sub i64 %136, %137, !dbg !224
  call void @llvm.dbg.value(metadata !{i64 %138}, i64 0, metadata !69), !dbg !224
  br label %.loopexit10, !dbg !224

.loopexit10:                                      ; preds = %23, %40, %.loopexit, %15, %.loopexit11
  %ret_val.0 = phi i64 [ %138, %.loopexit11 ], [ -1, %15 ], [ -1, %.loopexit ], [ -1, %40 ], [ -1, %23 ]
  ret i64 %ret_val.0, !dbg !225
}

declare i64 @kwsexec(%struct.kwset*, i8*, i64, %struct.kwsmatch*) #2

declare zeroext i1 @is_mb_middle(i8**, i8*, i8*, i64) #2

; Function Attrs: nounwind readnone
declare i16** @__ctype_b_loc() #4

; Function Attrs: nounwind readonly
declare i8* @memchr(i8*, i32, i64) #5

; Function Attrs: nounwind
declare i64 @mbrtowc(i32*, i8*, i64, %struct.__mbstate_t*) #3

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!114, !115}
!llvm.ident = !{!116}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)", i1 true, metadata !"", i32 0, metadata !2, metadata !22, metadata !23, metadata !109, metadata !22, metadata !""} ; [ DW_TAG_compile_unit ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c] [DW_LANG_C99]
!1 = metadata !{metadata !"kwsearch.c", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!2 = metadata !{metadata !3, metadata !7}
!3 = metadata !{i32 786436, metadata !4, null, metadata !"", i32 44, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 44, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"./system.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!5 = metadata !{metadata !6}
!6 = metadata !{i32 786472, metadata !"EXIT_TROUBLE", i64 2} ; [ DW_TAG_enumerator ] [EXIT_TROUBLE :: 2]
!7 = metadata !{i32 786436, metadata !8, null, metadata !"", i32 48, i64 32, i64 32, i32 0, i32 0, null, metadata !9, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 48, size 32, align 32, offset 0] [def] [from ]
!8 = metadata !{metadata !"/usr/include/ctype.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!9 = metadata !{metadata !10, metadata !11, metadata !12, metadata !13, metadata !14, metadata !15, metadata !16, metadata !17, metadata !18, metadata !19, metadata !20, metadata !21}
!10 = metadata !{i32 786472, metadata !"_ISupper", i64 256} ; [ DW_TAG_enumerator ] [_ISupper :: 256]
!11 = metadata !{i32 786472, metadata !"_ISlower", i64 512} ; [ DW_TAG_enumerator ] [_ISlower :: 512]
!12 = metadata !{i32 786472, metadata !"_ISalpha", i64 1024} ; [ DW_TAG_enumerator ] [_ISalpha :: 1024]
!13 = metadata !{i32 786472, metadata !"_ISdigit", i64 2048} ; [ DW_TAG_enumerator ] [_ISdigit :: 2048]
!14 = metadata !{i32 786472, metadata !"_ISxdigit", i64 4096} ; [ DW_TAG_enumerator ] [_ISxdigit :: 4096]
!15 = metadata !{i32 786472, metadata !"_ISspace", i64 8192} ; [ DW_TAG_enumerator ] [_ISspace :: 8192]
!16 = metadata !{i32 786472, metadata !"_ISprint", i64 16384} ; [ DW_TAG_enumerator ] [_ISprint :: 16384]
!17 = metadata !{i32 786472, metadata !"_ISgraph", i64 32768} ; [ DW_TAG_enumerator ] [_ISgraph :: 32768]
!18 = metadata !{i32 786472, metadata !"_ISblank", i64 1} ; [ DW_TAG_enumerator ] [_ISblank :: 1]
!19 = metadata !{i32 786472, metadata !"_IScntrl", i64 2} ; [ DW_TAG_enumerator ] [_IScntrl :: 2]
!20 = metadata !{i32 786472, metadata !"_ISpunct", i64 4} ; [ DW_TAG_enumerator ] [_ISpunct :: 4]
!21 = metadata !{i32 786472, metadata !"_ISalnum", i64 8} ; [ DW_TAG_enumerator ] [_ISalnum :: 8]
!22 = metadata !{i32 0}
!23 = metadata !{metadata !24, metadata !43, metadata !98}
!24 = metadata !{i32 786478, metadata !1, metadata !25, metadata !"Fcompile", metadata !"Fcompile", metadata !"", i32 33, metadata !26, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i64)* @Fcompile, null, null, metadata !34, i32 34} ; [ DW_TAG_subprogram ] [line 33] [def] [scope 34] [Fcompile]
!25 = metadata !{i32 786473, metadata !1}         ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!26 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !27, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!27 = metadata !{null, metadata !28, metadata !31}
!28 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !29} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!29 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!30 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!31 = metadata !{i32 786454, metadata !32, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !33} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!32 = metadata !{metadata !"/usr/local/bin/../lib/clang/3.5/include/stddef.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!33 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!34 = metadata !{metadata !35, metadata !36, metadata !37, metadata !38, metadata !39, metadata !40, metadata !41, metadata !42}
!35 = metadata !{i32 786689, metadata !24, metadata !"pattern", metadata !25, i32 16777249, metadata !28, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pattern] [line 33]
!36 = metadata !{i32 786689, metadata !24, metadata !"size", metadata !25, i32 33554465, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 33]
!37 = metadata !{i32 786688, metadata !24, metadata !"beg", metadata !25, i32 35, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 35]
!38 = metadata !{i32 786688, metadata !24, metadata !"end", metadata !25, i32 35, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 35]
!39 = metadata !{i32 786688, metadata !24, metadata !"lim", metadata !25, i32 35, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lim] [line 35]
!40 = metadata !{i32 786688, metadata !24, metadata !"err", metadata !25, i32 35, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [err] [line 35]
!41 = metadata !{i32 786688, metadata !24, metadata !"pat", metadata !25, i32 35, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pat] [line 35]
!42 = metadata !{i32 786688, metadata !24, metadata !"psize", metadata !25, i32 36, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [psize] [line 36]
!43 = metadata !{i32 786478, metadata !1, metadata !25, metadata !"Fexecute", metadata !"Fexecute", metadata !"", i32 80, metadata !44, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i8*, i64, i64*, i8*)* @Fexecute, null, null, metadata !47, i32 82} ; [ DW_TAG_subprogram ] [line 80] [def] [scope 82] [Fexecute]
!44 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !45, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!45 = metadata !{metadata !31, metadata !28, metadata !31, metadata !46, metadata !28}
!46 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !31} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!47 = metadata !{metadata !48, metadata !49, metadata !50, metadata !51, metadata !52, metadata !53, metadata !54, metadata !55, metadata !56, metadata !57, metadata !58, metadata !69, metadata !70, metadata !76, metadata !79, metadata !97}
!48 = metadata !{i32 786689, metadata !43, metadata !"buf", metadata !25, i32 16777296, metadata !28, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 80]
!49 = metadata !{i32 786689, metadata !43, metadata !"size", metadata !25, i32 33554512, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 80]
!50 = metadata !{i32 786689, metadata !43, metadata !"match_size", metadata !25, i32 50331728, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [match_size] [line 80]
!51 = metadata !{i32 786689, metadata !43, metadata !"start_ptr", metadata !25, i32 67108945, metadata !28, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start_ptr] [line 81]
!52 = metadata !{i32 786688, metadata !43, metadata !"beg", metadata !25, i32 83, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [beg] [line 83]
!53 = metadata !{i32 786688, metadata !43, metadata !"try", metadata !25, i32 83, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [try] [line 83]
!54 = metadata !{i32 786688, metadata !43, metadata !"end", metadata !25, i32 83, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 83]
!55 = metadata !{i32 786688, metadata !43, metadata !"mb_start", metadata !25, i32 83, metadata !28, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mb_start] [line 83]
!56 = metadata !{i32 786688, metadata !43, metadata !"len", metadata !25, i32 84, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 84]
!57 = metadata !{i32 786688, metadata !43, metadata !"eol", metadata !25, i32 85, metadata !30, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eol] [line 85]
!58 = metadata !{i32 786688, metadata !43, metadata !"kwsmatch", metadata !25, i32 86, metadata !59, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kwsmatch] [line 86]
!59 = metadata !{i32 786451, metadata !60, null, metadata !"kwsmatch", i32 24, i64 192, i64 64, i32 0, i32 0, null, metadata !61, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwsmatch] [line 24, size 192, align 64, offset 0] [def] [from ]
!60 = metadata !{metadata !"./kwset.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!61 = metadata !{metadata !62, metadata !64, metadata !68}
!62 = metadata !{i32 786445, metadata !60, metadata !59, metadata !"index", i32 26, i64 32, i64 32, i64 0, i32 0, metadata !63} ; [ DW_TAG_member ] [index] [line 26, size 32, align 32, offset 0] [from int]
!63 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!64 = metadata !{i32 786445, metadata !60, metadata !59, metadata !"offset", i32 27, i64 64, i64 64, i64 64, i32 0, metadata !65} ; [ DW_TAG_member ] [offset] [line 27, size 64, align 64, offset 64] [from ]
!65 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 64, i64 64, i32 0, i32 0, metadata !31, metadata !66, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 64, offset 0] [from size_t]
!66 = metadata !{metadata !67}
!67 = metadata !{i32 786465, i64 0, i64 1}        ; [ DW_TAG_subrange_type ] [0, 0]
!68 = metadata !{i32 786445, metadata !60, metadata !59, metadata !"size", i32 28, i64 64, i64 64, i64 128, i32 0, metadata !65} ; [ DW_TAG_member ] [size] [line 28, size 64, align 64, offset 128] [from ]
!69 = metadata !{i32 786688, metadata !43, metadata !"ret_val", metadata !25, i32 87, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ret_val] [line 87]
!70 = metadata !{i32 786688, metadata !71, metadata !"case_buf", metadata !25, i32 93, metadata !75, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [case_buf] [line 93]
!71 = metadata !{i32 786443, metadata !1, metadata !72, i32 92, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!72 = metadata !{i32 786443, metadata !1, metadata !73, i32 91, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!73 = metadata !{i32 786443, metadata !1, metadata !74, i32 90, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!74 = metadata !{i32 786443, metadata !1, metadata !43, i32 89, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!75 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !30} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!76 = metadata !{i32 786688, metadata !77, metadata !"offset", metadata !25, i32 103, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 103]
!77 = metadata !{i32 786443, metadata !1, metadata !78, i32 102, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!78 = metadata !{i32 786443, metadata !1, metadata !43, i32 101, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!79 = metadata !{i32 786688, metadata !80, metadata !"s", metadata !25, i32 113, metadata !82, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s] [line 113]
!80 = metadata !{i32 786443, metadata !1, metadata !81, i32 110, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!81 = metadata !{i32 786443, metadata !1, metadata !77, i32 108, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!82 = metadata !{i32 786454, metadata !83, null, metadata !"mbstate_t", i32 106, i64 0, i64 0, i64 0, i32 0, metadata !84} ; [ DW_TAG_typedef ] [mbstate_t] [line 106, size 0, align 0, offset 0] [from __mbstate_t]
!83 = metadata !{metadata !"/usr/include/wchar.h", metadata !"/home/kostas/workspace/test/grep-2.7/src"}
!84 = metadata !{i32 786454, metadata !83, null, metadata !"__mbstate_t", i32 95, i64 0, i64 0, i64 0, i32 0, metadata !85} ; [ DW_TAG_typedef ] [__mbstate_t] [line 95, size 0, align 0, offset 0] [from ]
!85 = metadata !{i32 786451, metadata !83, null, metadata !"", i32 83, i64 64, i64 32, i32 0, i32 0, null, metadata !86, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 83, size 64, align 32, offset 0] [def] [from ]
!86 = metadata !{metadata !87, metadata !88}
!87 = metadata !{i32 786445, metadata !83, metadata !85, metadata !"__count", i32 85, i64 32, i64 32, i64 0, i32 0, metadata !63} ; [ DW_TAG_member ] [__count] [line 85, size 32, align 32, offset 0] [from int]
!88 = metadata !{i32 786445, metadata !83, metadata !85, metadata !"__value", i32 94, i64 32, i64 32, i64 32, i32 0, metadata !89} ; [ DW_TAG_member ] [__value] [line 94, size 32, align 32, offset 32] [from ]
!89 = metadata !{i32 786455, metadata !83, metadata !85, metadata !"", i32 86, i64 32, i64 32, i64 0, i32 0, null, metadata !90, i32 0, null, null, null} ; [ DW_TAG_union_type ] [line 86, size 32, align 32, offset 0] [def] [from ]
!90 = metadata !{metadata !91, metadata !93}
!91 = metadata !{i32 786445, metadata !83, metadata !89, metadata !"__wch", i32 89, i64 32, i64 32, i64 0, i32 0, metadata !92} ; [ DW_TAG_member ] [__wch] [line 89, size 32, align 32, offset 0] [from unsigned int]
!92 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!93 = metadata !{i32 786445, metadata !83, metadata !89, metadata !"__wchb", i32 93, i64 32, i64 8, i64 0, i32 0, metadata !94} ; [ DW_TAG_member ] [__wchb] [line 93, size 32, align 8, offset 0] [from ]
!94 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32, i64 8, i32 0, i32 0, metadata !30, metadata !95, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from char]
!95 = metadata !{metadata !96}
!96 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 3]
!97 = metadata !{i32 786688, metadata !80, metadata !"mb_len", metadata !25, i32 115, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mb_len] [line 115]
!98 = metadata !{i32 786478, metadata !83, metadata !99, metadata !"mbrlen", metadata !"mbrlen", metadata !"", i32 396, metadata !100, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !105, i32 398} ; [ DW_TAG_subprogram ] [line 396] [def] [scope 398] [mbrlen]
!99 = metadata !{i32 786473, metadata !83}        ; [ DW_TAG_file_type ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/wchar.h]
!100 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !101, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!101 = metadata !{metadata !31, metadata !102, metadata !31, metadata !103}
!102 = metadata !{i32 786487, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !28} ; [ DW_TAG_restrict_type ] [line 0, size 0, align 0, offset 0] [from ]
!103 = metadata !{i32 786487, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !104} ; [ DW_TAG_restrict_type ] [line 0, size 0, align 0, offset 0] [from ]
!104 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !82} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from mbstate_t]
!105 = metadata !{metadata !106, metadata !107, metadata !108}
!106 = metadata !{i32 786689, metadata !98, metadata !"__s", metadata !99, i32 16777612, metadata !102, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__s] [line 396]
!107 = metadata !{i32 786689, metadata !98, metadata !"__n", metadata !99, i32 33554828, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__n] [line 396]
!108 = metadata !{i32 786689, metadata !98, metadata !"__ps", metadata !99, i32 50332044, metadata !103, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__ps] [line 396]
!109 = metadata !{metadata !110}
!110 = metadata !{i32 786484, i32 0, null, metadata !"kwset", metadata !"kwset", metadata !"", metadata !25, i32 30, metadata !111, i32 1, i32 1, %struct.kwset** @kwset, null} ; [ DW_TAG_variable ] [kwset] [line 30] [local] [def]
!111 = metadata !{i32 786454, metadata !60, null, metadata !"kwset_t", i32 34, i64 0, i64 0, i64 0, i32 0, metadata !112} ; [ DW_TAG_typedef ] [kwset_t] [line 34, size 0, align 0, offset 0] [from ]
!112 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !113} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from kwset]
!113 = metadata !{i32 786451, metadata !60, null, metadata !"kwset", i32 33, i64 0, i64 0, i32 0, i32 4, null, null, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [kwset] [line 33, size 0, align 0, offset 0] [decl] [from ]
!114 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!115 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!116 = metadata !{metadata !"clang version 3.5 (http://llvm.org/git/clang.git 9ac60551645be7a3c5f9b702159052f2f1a5b26a) (http://llvm.org/git/llvm.git 5e7eecd8509707a77a6b84c7879b947e14698ef0)"}
!117 = metadata !{i32 33, i32 0, metadata !24, null}
!118 = metadata !{i32 36, i32 0, metadata !24, null}
!119 = metadata !{i32 38, i32 0, metadata !24, null}
!120 = metadata !{i32 39, i32 0, metadata !24, null}
!121 = metadata !{metadata !122, metadata !122, i64 0}
!122 = metadata !{metadata !"long", metadata !123, i64 0}
!123 = metadata !{metadata !"omnipotent char", metadata !124, i64 0}
!124 = metadata !{metadata !"Simple C/C++ TBAA"}
!125 = metadata !{i32 41, i32 0, metadata !126, null}
!126 = metadata !{i32 786443, metadata !1, metadata !24, i32 41, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!127 = metadata !{metadata !128, metadata !128, i64 0}
!128 = metadata !{metadata !"int", metadata !123, i64 0}
!129 = metadata !{i32 42, i32 0, metadata !126, null}
!130 = metadata !{i32 53, i32 0, metadata !131, null}
!131 = metadata !{i32 786443, metadata !1, metadata !132, i32 53, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!132 = metadata !{i32 786443, metadata !1, metadata !133, i32 51, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!133 = metadata !{i32 786443, metadata !1, metadata !134, i32 50, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!134 = metadata !{i32 786443, metadata !1, metadata !24, i32 49, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!135 = metadata !{i32 47, i32 0, metadata !24, null}
!136 = metadata !{i32 48, i32 0, metadata !24, null}
!137 = metadata !{i32 50, i32 0, metadata !133, null}
!138 = metadata !{i32 52, i32 0, metadata !132, null}
!139 = metadata !{i32 55, i32 0, metadata !140, null}
!140 = metadata !{i32 786443, metadata !1, metadata !132, i32 55, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!141 = metadata !{metadata !123, metadata !123, i64 0}
!142 = metadata !{i32 57, i32 0, metadata !143, null}
!143 = metadata !{i32 786443, metadata !1, metadata !140, i32 56, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!144 = metadata !{i32 69, i32 0, metadata !145, null}
!145 = metadata !{i32 786443, metadata !1, metadata !134, i32 69, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!146 = metadata !{metadata !147, metadata !147, i64 0}
!147 = metadata !{metadata !"any pointer", metadata !123, i64 0}
!148 = metadata !{i32 70, i32 0, metadata !145, null}
!149 = metadata !{i32 71, i32 0, metadata !134, null}
!150 = metadata !{i32 72, i32 0, metadata !134, null}
!151 = metadata !{i32 75, i32 0, metadata !152, null}
!152 = metadata !{i32 786443, metadata !1, metadata !24, i32 75, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!153 = metadata !{i32 76, i32 0, metadata !152, null}
!154 = metadata !{i32 77, i32 0, metadata !24, null}
!155 = metadata !{i32 114, i32 0, metadata !80, null}
!156 = metadata !{i32 80, i32 0, metadata !43, null}
!157 = metadata !{i32 81, i32 0, metadata !43, null}
!158 = metadata !{i32 83, i32 0, metadata !43, null}
!159 = metadata !{i32 85, i32 0, metadata !43, null}
!160 = metadata !{i32 86, i32 0, metadata !43, null}
!161 = metadata !{i32 89, i32 0, metadata !74, null}
!162 = metadata !{i32 91, i32 0, metadata !72, null}
!163 = metadata !{i32 93, i32 0, metadata !71, null}
!164 = metadata !{i32 94, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !1, metadata !71, i32 94, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!166 = metadata !{i32 95, i32 0, metadata !165, null}
!167 = metadata !{i32 101, i32 0, metadata !78, null}
!168 = metadata !{i32 106, i32 0, metadata !77, null}
!169 = metadata !{i32 125, i32 0, metadata !170, null}
!170 = metadata !{i32 786443, metadata !1, metadata !77, i32 125, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!171 = metadata !{i32 103, i32 0, metadata !77, null}
!172 = metadata !{i32 104, i32 0, metadata !173, null}
!173 = metadata !{i32 786443, metadata !1, metadata !77, i32 104, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!174 = metadata !{i32 108, i32 0, metadata !81, null}
!175 = metadata !{i32 113, i32 0, metadata !80, null}
!176 = metadata !{i32 115, i32 27, metadata !80, null}
!177 = metadata !{i32 786689, metadata !98, metadata !"__s", metadata !99, i32 16777612, metadata !102, i32 0, metadata !176} ; [ DW_TAG_arg_variable ] [__s] [line 396]
!178 = metadata !{i32 396, i32 0, metadata !98, metadata !176}
!179 = metadata !{i32 786689, metadata !98, metadata !"__n", metadata !99, i32 33554828, metadata !31, i32 0, metadata !176} ; [ DW_TAG_arg_variable ] [__n] [line 396]
!180 = metadata !{i32 786689, metadata !98, metadata !"__ps", metadata !99, i32 50332044, metadata !103, i32 0, metadata !176} ; [ DW_TAG_arg_variable ] [__ps] [line 396]
!181 = metadata !{i32 399, i32 0, metadata !182, metadata !176}
!182 = metadata !{i32 786443, metadata !83, metadata !98} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src//usr/include/wchar.h]
!183 = metadata !{i32 116, i32 0, metadata !184, null}
!184 = metadata !{i32 786443, metadata !1, metadata !80, i32 116, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!185 = metadata !{i32 118, i32 0, metadata !80, null}
!186 = metadata !{i32 119, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !1, metadata !80, i32 119, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!188 = metadata !{i32 120, i32 0, metadata !187, null}
!189 = metadata !{i32 124, i32 0, metadata !77, null}
!190 = metadata !{i32 127, i32 0, metadata !191, null}
!191 = metadata !{i32 786443, metadata !1, metadata !77, i32 127, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!192 = metadata !{i32 129, i32 0, metadata !193, null}
!193 = metadata !{i32 786443, metadata !1, metadata !194, i32 129, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!194 = metadata !{i32 786443, metadata !1, metadata !191, i32 128, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!195 = metadata !{i32 131, i32 0, metadata !196, null}
!196 = metadata !{i32 786443, metadata !1, metadata !194, i32 131, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!197 = metadata !{i32 135, i32 0, metadata !198, null}
!198 = metadata !{i32 786443, metadata !1, metadata !191, i32 135, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!199 = metadata !{i32 164, i32 0, metadata !200, null}
!200 = metadata !{i32 786443, metadata !1, metadata !43, i32 164, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!201 = metadata !{i32 138, i32 0, metadata !202, null}
!202 = metadata !{i32 786443, metadata !1, metadata !203, i32 138, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!203 = metadata !{i32 786443, metadata !1, metadata !204, i32 137, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!204 = metadata !{i32 786443, metadata !1, metadata !198, i32 136, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!205 = metadata !{metadata !206, metadata !206, i64 0}
!206 = metadata !{metadata !"short", metadata !123, i64 0}
!207 = metadata !{i32 140, i32 0, metadata !208, null}
!208 = metadata !{i32 786443, metadata !1, metadata !203, i32 140, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!209 = metadata !{i32 142, i32 0, metadata !210, null}
!210 = metadata !{i32 786443, metadata !1, metadata !211, i32 142, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!211 = metadata !{i32 786443, metadata !1, metadata !208, i32 141, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!212 = metadata !{i32 144, i32 0, metadata !211, null}
!213 = metadata !{i32 145, i32 0, metadata !214, null}
!214 = metadata !{i32 786443, metadata !1, metadata !211, i32 145, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!215 = metadata !{i32 147, i32 0, metadata !211, null}
!216 = metadata !{i32 148, i32 0, metadata !211, null}
!217 = metadata !{i32 154, i32 0, metadata !203, null}
!218 = metadata !{i32 150, i32 0, metadata !219, null}
!219 = metadata !{i32 786443, metadata !1, metadata !208, i32 150, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/kostas/workspace/test/grep-2.7/src/kwsearch.c]
!220 = metadata !{i32 165, i32 0, metadata !200, null}
!221 = metadata !{i32 168, i32 0, metadata !43, null}
!222 = metadata !{i32 170, i32 0, metadata !43, null}
!223 = metadata !{i32 172, i32 0, metadata !43, null}
!224 = metadata !{i32 173, i32 0, metadata !43, null}
!225 = metadata !{i32 175, i32 0, metadata !43, null}
