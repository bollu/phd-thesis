define dso_local i32 @foo(i32 noundef %n, i32 noundef %k, i32 noundef %out)  {
loopheader:
  %outphi = phi i32 [ %out, %bb ], [ %out.next, %loopbody ]
  %tripcount = phi i32 [ 0, %bb ], [ %tripcount.next, %loopbody ]
  %cond = icmp slt i32 %tripcount, %n
  br i1 %cond, label %loopbody, label %exit


loopbody: 
  %out.next = add nsw i32 %outphi, %k
  %tripcount.next = add nuw nsw i32 %tripcount, 1
  br label %loopheader

exit:
  ret i32 %outphi
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
!4 = !{!"Ubuntu clang version 14tripcounttripcount-1ubuntu1.1"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loopheader.mustprogress"}
