/* AMD K7 gmp-mparam.h -- Compiler/machine parameter header file.

Copyright 1991, 1993, 1994, 2000, 2001 Free Software Foundation, Inc.

This file is part of the GNU MP Library.

The GNU MP Library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

The GNU MP Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public License
along with the GNU MP Library; see the file COPYING.LIB.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA 02111-1307, USA. */

#define BITS_PER_MP_LIMB 32
#define BYTES_PER_MP_LIMB 4


/* the low limb is ready after 4 cycles, but normally it's the high limb
   which is of interest, and that comes out after 6 cycles */
#ifndef UMUL_TIME
#define UMUL_TIME   6  /* cycles */
#endif

/* AMD doco says 40, but it measures 39 back-to-back */
#ifndef UDIV_TIME
#define UDIV_TIME   39  /* cycles */
#endif

/* A test with gcc 2.95.2 on mpn_sb_divrem_mn suggests that in practice
   udiv_qrnnd_preinv is about 5 cycles faster than plain udiv_qrnnd. */
#ifndef UDIV_NORM_PREINV_TIME
#define UDIV_NORM_PREINV_TIME   34 /* cycles */
#endif

/* using bsf */
#ifndef COUNT_TRAILING_ZEROS_TIME
#define COUNT_TRAILING_ZEROS_TIME   7  /* cycles */
#endif


/* 1400 MHz athlon, gcc 2.95.3 */

/* Generated by tuneup.c, 2001-11-28, gcc 2.95 */

#define KARATSUBA_MUL_THRESHOLD       26
#define TOOM3_MUL_THRESHOLD          202

#define BASECASE_SQR_THRESHOLD         0
#define KARATSUBA_SQR_THRESHOLD       50
#define TOOM3_SQR_THRESHOLD          226

#define SB_PREINV_THRESHOLD            0
#define DC_THRESHOLD                  92
#define POWM_THRESHOLD               142

#define GCD_ACCEL_THRESHOLD            3
#define GCDEXT_THRESHOLD              46

#define USE_PREINV_MOD_1               1  /* (native) */
#define DIVREM_2_THRESHOLD             0
#define DIVEXACT_1_THRESHOLD           0
#define MODEXACT_1_ODD_THRESHOLD       0

#define FFT_MUL_TABLE  { 816, 1696, 3456, 7680, 22528, 0 }
#define FFT_MODF_MUL_THRESHOLD       832
#define FFT_MUL_THRESHOLD           8448

#define FFT_SQR_TABLE  { 784, 1760, 3456, 7680, 18432, 40960, 0 }
#define FFT_MODF_SQR_THRESHOLD       800
#define FFT_SQR_THRESHOLD           8448
