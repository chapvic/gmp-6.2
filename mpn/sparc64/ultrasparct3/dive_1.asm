dnl  SPARC T3/T4/T5 mpn_divexact_1.

dnl  Contributed to the GNU project by Torbjörn Granlund.

dnl  Copyright 2013 Free Software Foundation, Inc.

dnl  This file is part of the GNU MP Library.

dnl  The GNU MP Library is free software; you can redistribute it and/or modify
dnl  it under the terms of the GNU Lesser General Public License as published
dnl  by the Free Software Foundation; either version 3 of the License, or (at
dnl  your option) any later version.

dnl  The GNU MP Library is distributed in the hope that it will be useful, but
dnl  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
dnl  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
dnl  License for more details.

dnl  You should have received a copy of the GNU Lesser General Public License
dnl  along with the GNU MP Library.  If not, see http://www.gnu.org/licenses/.

include(`../config.m4')

C                  cycles/limb
C UltraSPARC T3:	 ?
C UltraSPARC T4/T5:	 ?

C INPUT PARAMETERS
define(`qp',  `%i0')
define(`ap',  `%i1')
define(`n',   `%i2')
define(`d',   `%i3')

define(`dinv',`%o4')

ASM_START()
        REGISTER(%g2,#scratch)
        REGISTER(%g3,#scratch)
PROLOGUE(mpn_divexact_1)
	save	%sp, -176, %sp
	cmp	%i2, 1
	bne,pt	%xcc, L(gt1)
	 ldx	[%i1], %o5
	udivx	%o5, d, %g1
	stx	%g1, [qp]
	return	%i7+8
	 nop

L(gt1):	add	d, -1, %g1
	andn	%g1, d, %g1
	popc	%g1, %i4		C i4 = count_trailing_zeros(d)

	srlx	d, %i4, d
	srlx	d, 1, %g1
	and	%g1, 127, %g1

ifdef(`PIC',`
C	save	%sp, -192, %sp
	sethi	%hi(_GLOBAL_OFFSET_TABLE_-4), %l7
	call	L(GETPC0)
	add	%l7, %lo(_GLOBAL_OFFSET_TABLE_+4), %l7
	sethi	%hi(binvert_limb_table), %g2
	or	%g2, %lo(binvert_limb_table), %g2
	ldx	[%l7+%g2], %g2
C	restore
',`
	sethi	%hh(binvert_limb_table), %g3
	or	%g3, %hm(binvert_limb_table), %g3
	sllx	%g3, 32, %g3
	sethi	%lm(binvert_limb_table), %g2
	add	%g3, %g2, %g3
	or	%g3, %lo(binvert_limb_table), %g2
')
	ldub	[%g2+%g1], %g1
	add	%g1, %g1, %g2
	mulx	%g1, %g1, %g1
	mulx	%g1, d, %g1
	sub	%g2, %g1, %g2
	add	%g2, %g2, %g1
	mulx	%g2, %g2, %g2
	mulx	%g2, d, %g2
	sub	%g1, %g2, %g1
	add	%g1, %g1, %o7
	mulx	%g1, %g1, %g1
	mulx	%g1, d, %g1
	add	n, -2, n
	brz,pt	%i4, L(norm)
	 sub	%o7, %g1, dinv

L(unnorm):
	mov	0, %g4
	sub	%g0, %i4, %o2
	srlx	%o5, %i4, %o5
L(top_unnorm):
	ldx	[ap+8], %g3
	add	ap, 8, ap
	sllx	%g3, %o2, %g5
	or	%g5, %o5, %g5
	srlx	%g3, %i4, %o5
	subcc	%g5, %g4, %g4
	mulx	%g4, dinv, %g1
	stx	%g1, [qp]
	add	qp, 8, qp
	umulxhi(d, %g1, %g1)
	addxc(	%g1, %g0, %g4)
	brgz,pt	n, L(top_unnorm)
	 add	n, -1, n

	sub	%o5, %g4, %g4
	mulx	%g4, dinv, %g1
	stx	%g1, [qp]
	return	%i7+8
	 nop

L(norm):
	mulx	dinv, %o5, %g1
	stx	%g1, [qp]
	add	qp, 8, qp
	addcc	%g0, 0, %g4
L(top_norm):
	umulxhi(d, %g1, %g1)
	ldx	[ap+8], %g5
	add	ap, 8, ap
	addxc(	%g1, %g0, %g1)
	subcc	%g5, %g1, %g1
	mulx	%g1, dinv, %g1
	stx	%g1, [qp]
	add	qp, 8, qp
	brgz,pt	n, L(top_norm)
	 add	n, -1, n

	return	%i7+8
	 nop

ifdef(`PIC',`
L(GETPC0):
	retl
	add	%o7, %l7, %l7
')
EPILOGUE()
