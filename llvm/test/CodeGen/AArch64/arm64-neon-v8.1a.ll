; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mtriple=arm64-eabi -mattr=+rdm | FileCheck %s
; RUN: llc < %s -verify-machineinstrs -mtriple=arm64-eabi -mattr=+v8.1a | FileCheck %s

declare <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16>, <4 x i16>)
declare <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16>, <8 x i16>)
declare <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32>, <2 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32>, <4 x i32>)
declare i32 @llvm.aarch64.neon.sqrdmulh.i32(i32, i32)

declare <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16>, <4 x i16>)
declare <8 x i16> @llvm.aarch64.neon.sqadd.v8i16(<8 x i16>, <8 x i16>)
declare <2 x i32> @llvm.aarch64.neon.sqadd.v2i32(<2 x i32>, <2 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32>, <4 x i32>)
declare i32 @llvm.aarch64.neon.sqadd.i32(i32, i32)

declare <4 x i16> @llvm.aarch64.neon.sqsub.v4i16(<4 x i16>, <4 x i16>)
declare <8 x i16> @llvm.aarch64.neon.sqsub.v8i16(<8 x i16>, <8 x i16>)
declare <2 x i32> @llvm.aarch64.neon.sqsub.v2i32(<2 x i32>, <2 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32>, <4 x i32>)
declare i32 @llvm.aarch64.neon.sqsub.i32(i32, i32)

declare <4 x i16> @llvm.aarch64.neon.sqrdmlah.v4i16(<4 x i16>, <4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.sqrdmlah.v2i32(<2 x i32>, <2 x i32>, <2 x i32>)
declare <8 x i16> @llvm.aarch64.neon.sqrdmlah.v8i16(<8 x i16>, <8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.sqrdmlah.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)
declare i32 @llvm.aarch64.neon.sqrdmlah.i32(i32, i32, i32)

declare <4 x i16> @llvm.aarch64.neon.sqrdmlsh.v4i16(<4 x i16>, <4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.sqrdmlsh.v2i32(<2 x i32>, <2 x i32>, <2 x i32>)
declare <8 x i16> @llvm.aarch64.neon.sqrdmlsh.v8i16(<8 x i16>, <8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.sqrdmlsh.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)
declare i32 @llvm.aarch64.neon.sqrdmlsh.i32(i32, i32, i32)

; The sadd intrinsics in this file previously transformed into sqrdmlah where they
; shouldn't. They should produce sqrdmulh and sqadd.

;-----------------------------------------------------------------------------
; RDMA Vector
; test for SIMDThreeSameVectorSQRDMLxHTiedHS

define <4 x i16> @test_sqrdmlah_v4i16(<4 x i16> %acc, <4 x i16> %mhs, <4 x i16> %rhs) {
; CHECK-LABEL: test_sqrdmlah_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.4h, v1.4h, v2.4h
; CHECK-NEXT:    sqadd v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
   %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %mhs,  <4 x i16> %rhs)
   %retval =  call <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16> %acc,  <4 x i16> %prod)
   ret <4 x i16> %retval
}

define <8 x i16> @test_sqrdmlah_v8i16(<8 x i16> %acc, <8 x i16> %mhs, <8 x i16> %rhs) {
; CHECK-LABEL: test_sqrdmlah_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.8h, v1.8h, v2.8h
; CHECK-NEXT:    sqadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
   %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %mhs, <8 x i16> %rhs)
   %retval =  call <8 x i16> @llvm.aarch64.neon.sqadd.v8i16(<8 x i16> %acc, <8 x i16> %prod)
   ret <8 x i16> %retval
}

define <2 x i32> @test_sqrdmlah_v2i32(<2 x i32> %acc, <2 x i32> %mhs, <2 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlah_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.2s, v1.2s, v2.2s
; CHECK-NEXT:    sqadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
   %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %mhs, <2 x i32> %rhs)
   %retval =  call <2 x i32> @llvm.aarch64.neon.sqadd.v2i32(<2 x i32> %acc, <2 x i32> %prod)
   ret <2 x i32> %retval
}

define <4 x i32> @test_sqrdmlah_v4i32(<4 x i32> %acc, <4 x i32> %mhs, <4 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlah_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.4s, v1.4s, v2.4s
; CHECK-NEXT:    sqadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
   %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %mhs, <4 x i32> %rhs)
   %retval =  call <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32> %acc, <4 x i32> %prod)
   ret <4 x i32> %retval
}

define <4 x i16> @test_sqrdmlsh_v4i16(<4 x i16> %acc, <4 x i16> %mhs, <4 x i16> %rhs) {
; CHECK-LABEL: test_sqrdmlsh_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.4h, v1.4h, v2.4h
; CHECK-NEXT:    sqsub v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
   %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %mhs,  <4 x i16> %rhs)
   %retval =  call <4 x i16> @llvm.aarch64.neon.sqsub.v4i16(<4 x i16> %acc, <4 x i16> %prod)
   ret <4 x i16> %retval
}

define <8 x i16> @test_sqrdmlsh_v8i16(<8 x i16> %acc, <8 x i16> %mhs, <8 x i16> %rhs) {
; CHECK-LABEL: test_sqrdmlsh_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.8h, v1.8h, v2.8h
; CHECK-NEXT:    sqsub v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
   %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %mhs, <8 x i16> %rhs)
   %retval =  call <8 x i16> @llvm.aarch64.neon.sqsub.v8i16(<8 x i16> %acc, <8 x i16> %prod)
   ret <8 x i16> %retval
}

define <2 x i32> @test_sqrdmlsh_v2i32(<2 x i32> %acc, <2 x i32> %mhs, <2 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlsh_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.2s, v1.2s, v2.2s
; CHECK-NEXT:    sqsub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
   %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %mhs, <2 x i32> %rhs)
   %retval =  call <2 x i32> @llvm.aarch64.neon.sqsub.v2i32(<2 x i32> %acc, <2 x i32> %prod)
   ret <2 x i32> %retval
}

define <4 x i32> @test_sqrdmlsh_v4i32(<4 x i32> %acc, <4 x i32> %mhs, <4 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlsh_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqrdmulh v1.4s, v1.4s, v2.4s
; CHECK-NEXT:    sqsub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
   %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %mhs, <4 x i32> %rhs)
   %retval =  call <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32> %acc, <4 x i32> %prod)
   ret <4 x i32> %retval
}

;-----------------------------------------------------------------------------
; RDMA Vector, by element
; tests for vXiYY_indexed in SIMDIndexedSQRDMLxHSDTied

define <4 x i16> @test_sqrdmlah_lane_s16(<4 x i16> %acc, <4 x i16> %x, <4 x i16> %v) {
; CHECK-LABEL: test_sqrdmlah_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-NEXT:    sqrdmulh v1.4h, v1.4h, v2.h[3]
; CHECK-NEXT:    sqadd v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i16> %v, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x, <4 x i16> %shuffle)
  %retval =  call <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16> %acc, <4 x i16> %prod)
  ret <4 x i16> %retval
}

define <8 x i16> @test_sqrdmlahq_lane_s16(<8 x i16> %acc, <8 x i16> %x, <8 x i16> %v) {
; CHECK-LABEL: test_sqrdmlahq_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v1.8h, v1.8h, v2.h[2]
; CHECK-NEXT:    sqadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x i16> %v, <8 x i16> undef, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %x, <8 x i16> %shuffle)
  %retval =  call <8 x i16> @llvm.aarch64.neon.sqadd.v8i16(<8 x i16> %acc, <8 x i16> %prod)
  ret <8 x i16> %retval
}

define <2 x i32> @test_sqrdmlah_lane_s32(<2 x i32> %acc, <2 x i32> %x, <2 x i32> %v) {
; CHECK-LABEL: test_sqrdmlah_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-NEXT:    sqrdmulh v1.2s, v1.2s, v2.s[1]
; CHECK-NEXT:    sqadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <2 x i32> %v, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %x, <2 x i32> %shuffle)
  %retval =  call <2 x i32> @llvm.aarch64.neon.sqadd.v2i32(<2 x i32> %acc, <2 x i32> %prod)
  ret <2 x i32> %retval
}

define <4 x i32> @test_sqrdmlahq_lane_s32(<4 x i32> %acc,<4 x i32> %x, <4 x i32> %v) {
; CHECK-LABEL: test_sqrdmlahq_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v1.4s, v1.4s, v2.s[0]
; CHECK-NEXT:    sqadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i32> %v, <4 x i32> undef, <4 x i32> zeroinitializer
  %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x, <4 x i32> %shuffle)
  %retval =  call <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32> %acc, <4 x i32> %prod)
  ret <4 x i32> %retval
}

define <4 x i16> @test_sqrdmlsh_lane_s16(<4 x i16> %acc, <4 x i16> %x, <4 x i16> %v) {
; CHECK-LABEL: test_sqrdmlsh_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-NEXT:    sqrdmulh v1.4h, v1.4h, v2.h[3]
; CHECK-NEXT:    sqsub v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i16> %v, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x, <4 x i16> %shuffle)
  %retval =  call <4 x i16> @llvm.aarch64.neon.sqsub.v4i16(<4 x i16> %acc, <4 x i16> %prod)
  ret <4 x i16> %retval
}

define <8 x i16> @test_sqrdmlshq_lane_s16(<8 x i16> %acc, <8 x i16> %x, <8 x i16> %v) {
; CHECK-LABEL: test_sqrdmlshq_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v1.8h, v1.8h, v2.h[2]
; CHECK-NEXT:    sqsub v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x i16> %v, <8 x i16> undef, <8 x i32> <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %x, <8 x i16> %shuffle)
  %retval =  call <8 x i16> @llvm.aarch64.neon.sqsub.v8i16(<8 x i16> %acc, <8 x i16> %prod)
  ret <8 x i16> %retval
}

define <2 x i32> @test_sqrdmlsh_lane_s32(<2 x i32> %acc, <2 x i32> %x, <2 x i32> %v) {
; CHECK-LABEL: test_sqrdmlsh_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-NEXT:    sqrdmulh v1.2s, v1.2s, v2.s[1]
; CHECK-NEXT:    sqsub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <2 x i32> %v, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %x, <2 x i32> %shuffle)
  %retval =  call <2 x i32> @llvm.aarch64.neon.sqsub.v2i32(<2 x i32> %acc, <2 x i32> %prod)
  ret <2 x i32> %retval
}

define <4 x i32> @test_sqrdmlshq_lane_s32(<4 x i32> %acc,<4 x i32> %x, <4 x i32> %v) {
; CHECK-LABEL: test_sqrdmlshq_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v1.4s, v1.4s, v2.s[0]
; CHECK-NEXT:    sqsub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i32> %v, <4 x i32> undef, <4 x i32> zeroinitializer
  %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x, <4 x i32> %shuffle)
  %retval =  call <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32> %acc, <4 x i32> %prod)
  ret <4 x i32> %retval
}

;-----------------------------------------------------------------------------
; RDMA Vector, by element, extracted
; i16 tests are for vXi16_indexed in SIMDIndexedSQRDMLxHSDTied, with IR in ACLE style
; i32 tests are for   "def : Pat" in SIMDIndexedSQRDMLxHSDTied

define i16 @test_sqrdmlah_extracted_lane_s16(i16 %acc,<4 x i16> %x, <4 x i16> %v) {
; CHECK-LABEL: test_sqrdmlah_extracted_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    sqrdmulh v0.4h, v0.4h, v1.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i16> %v, <4 x i16> undef, <4 x i32> <i32 1,i32 1,i32 1,i32 1>
  %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x, <4 x i16> %shuffle)
  %acc_vec = insertelement <4 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16> %acc_vec, <4 x i16> %prod)
  %retval = extractelement <4 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i16 @test_sqrdmlahq_extracted_lane_s16(i16 %acc,<8 x i16> %x, <8 x i16> %v) {
; CHECK-LABEL: test_sqrdmlahq_extracted_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v0.8h, v0.8h, v1.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x i16> %v, <8 x i16> undef, <8 x i32> <i32 1,i32 1,i32 1,i32 1, i32 1,i32 1,i32 1,i32 1>
  %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %x, <8 x i16> %shuffle)
  %acc_vec = insertelement <8 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <8 x i16> @llvm.aarch64.neon.sqadd.v8i16(<8 x i16> %acc_vec, <8 x i16> %prod)
  %retval = extractelement <8 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i32 @test_sqrdmlah_extracted_lane_s32(i32 %acc,<2 x i32> %x, <2 x i32> %v) {
; CHECK-LABEL: test_sqrdmlah_extracted_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    sqrdmulh v0.2s, v0.2s, v1.s[0]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <2 x i32> %v, <2 x i32> undef, <2 x i32> zeroinitializer
  %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %x, <2 x i32> %shuffle)
  %extract = extractelement <2 x i32> %prod, i64 0
  %retval =  call i32 @llvm.aarch64.neon.sqadd.i32(i32 %acc, i32 %extract)
  ret i32 %retval
}

define i32 @test_sqrdmlahq_extracted_lane_s32(i32 %acc,<4 x i32> %x, <4 x i32> %v) {
; CHECK-LABEL: test_sqrdmlahq_extracted_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v0.4s, v0.4s, v1.s[0]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i32> %v, <4 x i32> undef, <4 x i32> zeroinitializer
  %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x, <4 x i32> %shuffle)
  %extract = extractelement <4 x i32> %prod, i64 0
  %retval =  call i32 @llvm.aarch64.neon.sqadd.i32(i32 %acc, i32 %extract)
  ret i32 %retval
}

define i16 @test_sqrdmlsh_extracted_lane_s16(i16 %acc,<4 x i16> %x, <4 x i16> %v) {
; CHECK-LABEL: test_sqrdmlsh_extracted_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    sqrdmulh v0.4h, v0.4h, v1.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i16> %v, <4 x i16> undef, <4 x i32> <i32 1,i32 1,i32 1,i32 1>
  %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x, <4 x i16> %shuffle)
  %acc_vec = insertelement <4 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <4 x i16> @llvm.aarch64.neon.sqsub.v4i16(<4 x i16> %acc_vec, <4 x i16> %prod)
  %retval = extractelement <4 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i16 @test_sqrdmlshq_extracted_lane_s16(i16 %acc,<8 x i16> %x, <8 x i16> %v) {
; CHECK-LABEL: test_sqrdmlshq_extracted_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v0.8h, v0.8h, v1.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x i16> %v, <8 x i16> undef, <8 x i32> <i32 1,i32 1,i32 1,i32 1, i32 1,i32 1,i32 1,i32 1>
  %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %x, <8 x i16> %shuffle)
  %acc_vec = insertelement <8 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <8 x i16> @llvm.aarch64.neon.sqsub.v8i16(<8 x i16> %acc_vec, <8 x i16> %prod)
  %retval = extractelement <8 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i32 @test_sqrdmlsh_extracted_lane_s32(i32 %acc,<2 x i32> %x, <2 x i32> %v) {
; CHECK-LABEL: test_sqrdmlsh_extracted_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    sqrdmulh v0.2s, v0.2s, v1.s[0]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <2 x i32> %v, <2 x i32> undef, <2 x i32> zeroinitializer
  %prod = call <2 x i32> @llvm.aarch64.neon.sqrdmulh.v2i32(<2 x i32> %x, <2 x i32> %shuffle)
  %extract = extractelement <2 x i32> %prod, i64 0
  %retval =  call i32 @llvm.aarch64.neon.sqsub.i32(i32 %acc, i32 %extract)
  ret i32 %retval
}

define i32 @test_sqrdmlshq_extracted_lane_s32(i32 %acc,<4 x i32> %x, <4 x i32> %v) {
; CHECK-LABEL: test_sqrdmlshq_extracted_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmulh v0.4s, v0.4s, v1.s[0]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x i32> %v, <4 x i32> undef, <4 x i32> zeroinitializer
  %prod = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x, <4 x i32> %shuffle)
  %extract = extractelement <4 x i32> %prod, i64 0
  %retval =  call i32 @llvm.aarch64.neon.sqsub.i32(i32 %acc, i32 %extract)
  ret i32 %retval
}

;-----------------------------------------------------------------------------
; RDMA Scalar
; test for "def : Pat" near SIMDThreeScalarHSTied in AArch64InstInfo.td

define i16 @test_sqrdmlah_v1i16(i16 %acc, i16 %x, i16 %y) {
; CHECK-LABEL: test_sqrdmlah_v1i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %x_vec = insertelement <4 x i16> undef, i16 %x, i64 0
  %y_vec = insertelement <4 x i16> undef, i16 %y, i64 0
  %prod_vec = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x_vec,  <4 x i16> %y_vec)
  %acc_vec = insertelement <4 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16> %acc_vec,  <4 x i16> %prod_vec)
  %retval = extractelement <4 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i32 @test_sqrdmlah_v1i32(i32 %acc, i32 %x, i32 %y) {
; CHECK-LABEL: test_sqrdmlah_v1i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %x_vec = insertelement <4 x i32> undef, i32 %x, i64 0
  %y_vec = insertelement <4 x i32> undef, i32 %y, i64 0
  %prod_vec = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x_vec,  <4 x i32> %y_vec)
  %acc_vec = insertelement <4 x i32> undef, i32 %acc, i64 0
  %retval_vec =  call <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32> %acc_vec,  <4 x i32> %prod_vec)
  %retval = extractelement <4 x i32> %retval_vec, i64 0
  ret i32 %retval
}


define i16 @test_sqrdmlsh_v1i16(i16 %acc, i16 %x, i16 %y) {
; CHECK-LABEL: test_sqrdmlsh_v1i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %x_vec = insertelement <4 x i16> undef, i16 %x, i64 0
  %y_vec = insertelement <4 x i16> undef, i16 %y, i64 0
  %prod_vec = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x_vec,  <4 x i16> %y_vec)
  %acc_vec = insertelement <4 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <4 x i16> @llvm.aarch64.neon.sqsub.v4i16(<4 x i16> %acc_vec,  <4 x i16> %prod_vec)
  %retval = extractelement <4 x i16> %retval_vec, i64 0
  ret i16 %retval
}

define i32 @test_sqrdmlsh_v1i32(i32 %acc, i32 %x, i32 %y) {
; CHECK-LABEL: test_sqrdmlsh_v1i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %x_vec = insertelement <4 x i32> undef, i32 %x, i64 0
  %y_vec = insertelement <4 x i32> undef, i32 %y, i64 0
  %prod_vec = call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %x_vec,  <4 x i32> %y_vec)
  %acc_vec = insertelement <4 x i32> undef, i32 %acc, i64 0
  %retval_vec =  call <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32> %acc_vec,  <4 x i32> %prod_vec)
  %retval = extractelement <4 x i32> %retval_vec, i64 0
  ret i32 %retval
}

define i32 @test_sqrdmlah_i32(i32 %acc, i32 %mhs, i32 %rhs) {
; CHECK-LABEL: test_sqrdmlah_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh s0, s0, s1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %prod = call i32 @llvm.aarch64.neon.sqrdmulh.i32(i32 %mhs,  i32 %rhs)
  %retval =  call i32 @llvm.aarch64.neon.sqadd.i32(i32 %acc,  i32 %prod)
  ret i32 %retval
}

define i32 @test_sqrdmlsh_i32(i32 %acc, i32 %mhs, i32 %rhs) {
; CHECK-LABEL: test_sqrdmlsh_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w2
; CHECK-NEXT:    sqrdmulh s0, s0, s1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %prod = call i32 @llvm.aarch64.neon.sqrdmulh.i32(i32 %mhs,  i32 %rhs)
  %retval =  call i32 @llvm.aarch64.neon.sqsub.i32(i32 %acc,  i32 %prod)
  ret i32 %retval
}

;-----------------------------------------------------------------------------
; RDMA Scalar, by element
; i16 tests are performed via tests in above chapter, with IR in ACLE style
; i32 tests are for i32_indexed in SIMDIndexedSQRDMLxHSDTied

define i16 @test_sqrdmlah_extract_i16(i16 %acc, i16 %x, <4 x i16> %y_vec) {
; CHECK-LABEL: test_sqrdmlah_extract_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    sqrdmulh v0.4h, v1.4h, v0.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd v0.4h, v1.4h, v0.4h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %shuffle = shufflevector <4 x i16> %y_vec, <4 x i16> undef, <4 x i32> <i32 1,i32 1,i32 1,i32 1>
  %x_vec = insertelement <4 x i16> undef, i16 %x, i64 0
  %prod = call <4 x i16> @llvm.aarch64.neon.sqrdmulh.v4i16(<4 x i16> %x_vec, <4 x i16> %shuffle)
  %acc_vec = insertelement <4 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <4 x i16> @llvm.aarch64.neon.sqadd.v4i16(<4 x i16> %acc_vec, <4 x i16> %prod)
  %retval = extractelement <4 x i16> %retval_vec, i32 0
  ret i16 %retval
}

define i32 @test_sqrdmlah_extract_i32(i32 %acc, i32 %mhs, <4 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlah_extract_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    sqrdmulh s0, s1, v0.s[3]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqadd s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %extract = extractelement <4 x i32> %rhs, i32 3
  %prod = call i32 @llvm.aarch64.neon.sqrdmulh.i32(i32 %mhs,  i32 %extract)
  %retval =  call i32 @llvm.aarch64.neon.sqadd.i32(i32 %acc,  i32 %prod)
  ret i32 %retval
}

define i16 @test_sqrdmlshq_extract_i16(i16 %acc, i16 %x, <8 x i16> %y_vec) {
; CHECK-LABEL: test_sqrdmlshq_extract_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    sqrdmulh v0.8h, v1.8h, v0.h[1]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %shuffle = shufflevector <8 x i16> %y_vec, <8 x i16> undef, <8 x i32> <i32 1,i32 1,i32 1,i32 1,i32 1,i32 1,i32 1,i32 1>
  %x_vec = insertelement <8 x i16> undef, i16 %x, i64 0
  %prod = call <8 x i16> @llvm.aarch64.neon.sqrdmulh.v8i16(<8 x i16> %x_vec, <8 x i16> %shuffle)
  %acc_vec = insertelement <8 x i16> undef, i16 %acc, i64 0
  %retval_vec =  call <8 x i16> @llvm.aarch64.neon.sqsub.v8i16(<8 x i16> %acc_vec, <8 x i16> %prod)
  %retval = extractelement <8 x i16> %retval_vec, i32 0
  ret i16 %retval
}

define i32 @test_sqrdmlsh_extract_i32(i32 %acc, i32 %mhs, <4 x i32> %rhs) {
; CHECK-LABEL: test_sqrdmlsh_extract_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    sqrdmulh s0, s1, v0.s[3]
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    sqsub s0, s1, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %extract = extractelement <4 x i32> %rhs, i32 3
  %prod = call i32 @llvm.aarch64.neon.sqrdmulh.i32(i32 %mhs,  i32 %extract)
  %retval =  call i32 @llvm.aarch64.neon.sqsub.i32(i32 %acc,  i32 %prod)
  ret i32 %retval
}


;-----------------------------------------------------------------------------
; Using sqrdmlah intrinsics

define <4 x i16> @test_vqrdmlah_laneq_s16(<4 x i16> %a, <4 x i16> %b, <8 x i16> %v) {
; CHECK-LABEL: test_vqrdmlah_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlah v0.4h, v1.4h, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <8 x i16> %v, <8 x i16> poison, <4 x i32> <i32 7, i32 7, i32 7, i32 7>
  %vqrdmlah_v3.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlah.v4i16(<4 x i16> %a, <4 x i16> %b, <4 x i16> %lane) #4
  ret <4 x i16> %vqrdmlah_v3.i
}

define <2 x i32> @test_vqrdmlah_laneq_s32(<2 x i32> %a, <2 x i32> %b, <4 x i32> %v) {
; CHECK-LABEL: test_vqrdmlah_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlah v0.2s, v1.2s, v2.s[3]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <4 x i32> %v, <4 x i32> poison, <2 x i32> <i32 3, i32 3>
  %vqrdmlah_v3.i = tail call <2 x i32> @llvm.aarch64.neon.sqrdmlah.v2i32(<2 x i32> %a, <2 x i32> %b, <2 x i32> %lane) #4
  ret <2 x i32> %vqrdmlah_v3.i
}

define <8 x i16> @test_vqrdmlahq_laneq_s16(<8 x i16> %a, <8 x i16> %b, <8 x i16> %v) {
; CHECK-LABEL: test_vqrdmlahq_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlah v0.8h, v1.8h, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <8 x i16> %v, <8 x i16> poison, <8 x i32> <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %vqrdmlahq_v3.i = tail call <8 x i16> @llvm.aarch64.neon.sqrdmlah.v8i16(<8 x i16> %a, <8 x i16> %b, <8 x i16> %lane) #4
  ret <8 x i16> %vqrdmlahq_v3.i
}

define <4 x i32> @test_vqrdmlahq_laneq_s32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %v) {
; CHECK-LABEL: test_vqrdmlahq_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlah v0.4s, v1.4s, v2.s[3]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <4 x i32> %v, <4 x i32> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %vqrdmlahq_v3.i = tail call <4 x i32> @llvm.aarch64.neon.sqrdmlah.v4i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %lane) #4
  ret <4 x i32> %vqrdmlahq_v3.i
}

define i16 @test_vqrdmlahh_s16(i16 %a, i16 %b, i16 %c) {
; CHECK-LABEL: test_vqrdmlahh_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    fmov s2, w2
; CHECK-NEXT:    sqrdmlah v1.4h, v0.4h, v2.4h
; CHECK-NEXT:    umov w0, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = insertelement <4 x i16> undef, i16 %c, i64 0
  %vqrdmlahh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlah.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlahh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlahs_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_vqrdmlahs_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    fmov s2, w2
; CHECK-NEXT:    sqrdmlah s1, s0, s2
; CHECK-NEXT:    fmov w0, s1
; CHECK-NEXT:    ret
entry:
  %vqrdmlahs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlah.i32(i32 %a, i32 %b, i32 %c) #4
  ret i32 %vqrdmlahs_s32.i
}

define i16 @test_vqrdmlahh_lane_s16(i16 %a, i16 %b, <4 x i16> %c) {
; CHECK-LABEL: test_vqrdmlahh_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    sqrdmlah v2.4h, v1.4h, v0.h[3]
; CHECK-NEXT:    umov w0, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = shufflevector <4 x i16> %c, <4 x i16> undef, <4 x i32> <i32 3, i32 undef, i32 undef, i32 undef>
  %vqrdmlahh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlah.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlahh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlahs_lane_s32(i32 %a, i32 %b, <2 x i32> %c) {
; CHECK-LABEL: test_vqrdmlahs_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    sqrdmlah s2, s1, v0.s[1]
; CHECK-NEXT:    fmov w0, s2
; CHECK-NEXT:    ret
entry:
  %vget_lane = extractelement <2 x i32> %c, i64 1
  %vqrdmlahs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlah.i32(i32 %a, i32 %b, i32 %vget_lane) #4
  ret i32 %vqrdmlahs_s32.i
}

define i16 @test_vqrdmlahh_laneq_s16(i16 %a, i16 %b, <8 x i16> %c) {
; CHECK-LABEL: test_vqrdmlahh_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    sqrdmlah v2.4h, v1.4h, v0.h[7]
; CHECK-NEXT:    umov w0, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = shufflevector <8 x i16> %c, <8 x i16> undef, <4 x i32> <i32 7, i32 undef, i32 undef, i32 undef>
  %vqrdmlahh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlah.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlahh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlahs_laneq_s32(i32 %a, i32 %b, <4 x i32> %c) {
; CHECK-LABEL: test_vqrdmlahs_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    sqrdmlah s2, s1, v0.s[3]
; CHECK-NEXT:    fmov w0, s2
; CHECK-NEXT:    ret
entry:
  %vgetq_lane = extractelement <4 x i32> %c, i64 3
  %vqrdmlahs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlah.i32(i32 %a, i32 %b, i32 %vgetq_lane) #4
  ret i32 %vqrdmlahs_s32.i
}

define <4 x i16> @test_vqrdmlsh_laneq_s16(<4 x i16> %a, <4 x i16> %b, <8 x i16> %v) {
; CHECK-LABEL: test_vqrdmlsh_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlsh v0.4h, v1.4h, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <8 x i16> %v, <8 x i16> poison, <4 x i32> <i32 7, i32 7, i32 7, i32 7>
  %vqrdmlsh_v3.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlsh.v4i16(<4 x i16> %a, <4 x i16> %b, <4 x i16> %lane) #4
  ret <4 x i16> %vqrdmlsh_v3.i
}

define <2 x i32> @test_vqrdmlsh_laneq_s32(<2 x i32> %a, <2 x i32> %b, <4 x i32> %v) {
; CHECK-LABEL: test_vqrdmlsh_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlsh v0.2s, v1.2s, v2.s[3]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <4 x i32> %v, <4 x i32> poison, <2 x i32> <i32 3, i32 3>
  %vqrdmlsh_v3.i = tail call <2 x i32> @llvm.aarch64.neon.sqrdmlsh.v2i32(<2 x i32> %a, <2 x i32> %b, <2 x i32> %lane) #4
  ret <2 x i32> %vqrdmlsh_v3.i
}

define <8 x i16> @test_vqrdmlshq_laneq_s16(<8 x i16> %a, <8 x i16> %b, <8 x i16> %v) {
; CHECK-LABEL: test_vqrdmlshq_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlsh v0.8h, v1.8h, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <8 x i16> %v, <8 x i16> poison, <8 x i32> <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %vqrdmlshq_v3.i = tail call <8 x i16> @llvm.aarch64.neon.sqrdmlsh.v8i16(<8 x i16> %a, <8 x i16> %b, <8 x i16> %lane) #4
  ret <8 x i16> %vqrdmlshq_v3.i
}

define <4 x i32> @test_vqrdmlshq_laneq_s32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %v) {
; CHECK-LABEL: test_vqrdmlshq_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqrdmlsh v0.4s, v1.4s, v2.s[3]
; CHECK-NEXT:    ret
entry:
  %lane = shufflevector <4 x i32> %v, <4 x i32> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %vqrdmlshq_v3.i = tail call <4 x i32> @llvm.aarch64.neon.sqrdmlsh.v4i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %lane) #4
  ret <4 x i32> %vqrdmlshq_v3.i
}

define i16 @test_vqrdmlshh_s16(i16 %a, i16 %b, i16 %c) {
; CHECK-LABEL: test_vqrdmlshh_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    fmov s2, w2
; CHECK-NEXT:    sqrdmlsh v1.4h, v0.4h, v2.4h
; CHECK-NEXT:    umov w0, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = insertelement <4 x i16> undef, i16 %c, i64 0
  %vqrdmlshh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlsh.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlshh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlshs_s32(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test_vqrdmlshs_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    fmov s2, w2
; CHECK-NEXT:    sqrdmlsh s1, s0, s2
; CHECK-NEXT:    fmov w0, s1
; CHECK-NEXT:    ret
entry:
  %vqrdmlshs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlsh.i32(i32 %a, i32 %b, i32 %c) #4
  ret i32 %vqrdmlshs_s32.i
}

define i16 @test_vqrdmlshh_lane_s16(i16 %a, i16 %b, <4 x i16> %c) {
; CHECK-LABEL: test_vqrdmlshh_lane_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    sqrdmlsh v2.4h, v1.4h, v0.h[3]
; CHECK-NEXT:    umov w0, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = shufflevector <4 x i16> %c, <4 x i16> undef, <4 x i32> <i32 3, i32 undef, i32 undef, i32 undef>
  %vqrdmlshh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlsh.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlshh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlshs_lane_s32(i32 %a, i32 %b, <2 x i32> %c) {
; CHECK-LABEL: test_vqrdmlshs_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    sqrdmlsh s2, s1, v0.s[1]
; CHECK-NEXT:    fmov w0, s2
; CHECK-NEXT:    ret
entry:
  %vget_lane = extractelement <2 x i32> %c, i64 1
  %vqrdmlshs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlsh.i32(i32 %a, i32 %b, i32 %vget_lane) #4
  ret i32 %vqrdmlshs_s32.i
}

define i16 @test_vqrdmlshh_laneq_s16(i16 %a, i16 %b, <8 x i16> %c) {
; CHECK-LABEL: test_vqrdmlshh_laneq_s16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    sqrdmlsh v2.4h, v1.4h, v0.h[7]
; CHECK-NEXT:    umov w0, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <4 x i16> undef, i16 %a, i64 0
  %1 = insertelement <4 x i16> undef, i16 %b, i64 0
  %2 = shufflevector <8 x i16> %c, <8 x i16> undef, <4 x i32> <i32 7, i32 undef, i32 undef, i32 undef>
  %vqrdmlshh_s16.i = tail call <4 x i16> @llvm.aarch64.neon.sqrdmlsh.v4i16(<4 x i16> %0, <4 x i16> %1, <4 x i16> %2) #4
  %3 = extractelement <4 x i16> %vqrdmlshh_s16.i, i64 0
  ret i16 %3
}

define i32 @test_vqrdmlshs_laneq_s32(i32 %a, i32 %b, <4 x i32> %c) {
; CHECK-LABEL: test_vqrdmlshs_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s1, w1
; CHECK-NEXT:    fmov s2, w0
; CHECK-NEXT:    sqrdmlsh s2, s1, v0.s[3]
; CHECK-NEXT:    fmov w0, s2
; CHECK-NEXT:    ret
entry:
  %vgetq_lane = extractelement <4 x i32> %c, i64 3
  %vqrdmlshs_s32.i = tail call i32 @llvm.aarch64.neon.sqrdmlsh.i32(i32 %a, i32 %b, i32 %vgetq_lane) #4
  ret i32 %vqrdmlshs_s32.i
}