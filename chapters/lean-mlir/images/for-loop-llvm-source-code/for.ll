; ModuleID = 'for.temp.ll'
source_filename = "for.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @foo(i32 noundef %arg, i32 noundef %arg2, i32 noundef %arg3) #0 {
bb:
  br label %bb4

bb4:                                              ; preds = %bb7, %bb
  %.01 = phi i32 [ %arg3, %bb ], [ %i8, %bb7 ]
  %.0 = phi i32 [ 0, %bb ], [ %i9, %bb7 ]
  %i = icmp slt i32 %.0, %arg
  br i1 %i, label %bb6, label %bb5

bb5:                                              ; preds = %bb4
  br label %bb10

bb6:                                              ; preds = %bb4
  br label %bb7

bb7:                                              ; preds = %bb6
  %i8 = add nsw i32 %.01, %arg2
  %i9 = add nuw nsw i32 %.0, 1
  br label %bb4, !llvm.loop !5

bb10:                                             ; preds = %bb5
  ret i32 %.01
}

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nocallback nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
