;;; Segment .text (00000000000010E0)

;; _start: 00000000000010E0
_start proc
	xor	ebp,ebp
	mov	r9,rdx
	pop	rsi
	mov	rdx,rsp
	and	rsp,0F0h
	push	rax
	push	rsp
	lea	r8,[00000000000014A0]                                  ; [rip+000003AA]
	lea	rcx,[0000000000001440]                                 ; [rip+00000343]
	lea	rdi,[0000000000001244]                                 ; [rip+00000140]
	call	[0000000000003FE0]                                    ; [rip+00002ED6]
	hlt
000000000000110B                                  0F 1F 44 00 00            ..D..

;; deregister_tm_clones: 0000000000001110
;;   Called from:
;;     00000000000011A3 (in __do_global_dtors_aux)
deregister_tm_clones proc
	lea	rdi,[0000000000004098]                                 ; [rip+00002F81]
	lea	rax,[0000000000004098]                                 ; [rip+00002F7A]
	cmp	rax,rdi
	jz	1138h

l0000000000001123:
	mov	rax,[0000000000003FD8]                                 ; [rip+00002EAE]
	test	rax,rax
	jz	1138h

l000000000000112F:
	jmp	rax
0000000000001131    0F 1F 80 00 00 00 00                          .......       

l0000000000001138:
	ret
0000000000001139                            0F 1F 80 00 00 00 00          .......

;; register_tm_clones: 0000000000001140
;;   Called from:
;;     00000000000011C0 (in frame_dummy)
register_tm_clones proc
	lea	rdi,[0000000000004098]                                 ; [rip+00002F51]
	lea	rsi,[0000000000004098]                                 ; [rip+00002F4A]
	sub	rsi,rdi
	mov	rax,rsi
	shr	rsi,3Fh
	sar	rax,3h
	add	rsi,rax
	sar	rsi,1h
	jz	1178h

l0000000000001164:
	mov	rax,[0000000000003FF0]                                 ; [rip+00002E85]
	test	rax,rax
	jz	1178h

l0000000000001170:
	jmp	rax
0000000000001172       66 0F 1F 44 00 00                           f..D..       

l0000000000001178:
	ret
0000000000001179                            0F 1F 80 00 00 00 00          .......

;; __do_global_dtors_aux: 0000000000001180
__do_global_dtors_aux proc
	cmp	[00000000000040B8],0h                                  ; [rip+00002F31]
	jnz	11B8h

l0000000000001189:
	push	rbp
	cmp	[0000000000003FF8],0h                                  ; [rip+00002E66]
	mov	rbp,rsp
	jz	11A3h

l0000000000001197:
	mov	rdi,[0000000000004078]                                 ; [rip+00002EDA]
	call	10D0h

l00000000000011A3:
	call	1110h
	mov	[00000000000040B8],1h                                  ; [rip+00002F09]
	pop	rbp
	ret
00000000000011B1    0F 1F 80 00 00 00 00                          .......       

l00000000000011B8:
	ret
00000000000011B9                            0F 1F 80 00 00 00 00          .......

;; frame_dummy: 00000000000011C0
frame_dummy proc
	jmp	1140h

;; print_flag: 00000000000011C5
;;   Called from:
;;     000000000000142F (in main)
print_flag proc
	push	rbp
	mov	rbp,rsp
	sub	rsp,+110h
	lea	rsi,[0000000000002008]                                 ; [rip+00000E31]
	lea	rdi,[000000000000200A]                                 ; [rip+00000E2C]
	call	10B0h
	mov	[rbp-8h],rax
	cmp	qword ptr [rbp-8h],0h
	jnz	11FCh

l00000000000011EE:
	lea	rdi,[0000000000002013]                                 ; [rip+00000E1E]
	call	1040h
	jmp	1241h

l00000000000011FC:
	mov	rdx,[rbp-8h]
	lea	rax,[rbp-110h]
	mov	esi,100h
	mov	rdi,rax
	call	1070h
	lea	rax,[rbp-110h]
	lea	rsi,[0000000000002029]                                 ; [rip+00000E07]
	mov	rdi,rax
	call	1060h
	mov	byte ptr [rbp+rax-110h],0h
	lea	rax,[rbp-110h]
	mov	rdi,rax
	call	1040h

l0000000000001241:
	nop
	leave
	ret

;; main: 0000000000001244
main proc
	push	rbp
	mov	rbp,rsp
	sub	rsp,+120h
	lea	rdi,[0000000000002030]                                 ; [rip+00000DDA]
	call	1040h
	lea	rdi,[0000000000002060]                                 ; [rip+00000DFE]
	mov	eax,0h
	call	1050h
	mov	rax,[00000000000040A0]                                 ; [rip+00002E2D]
	mov	rdi,rax
	call	10A0h
	mov	rdx,[00000000000040B0]                                 ; [rip+00002E2E]
	lea	rax,[rbp-110h]
	mov	esi,100h
	mov	rdi,rax
	call	1070h
	lea	rax,[rbp-110h]
	lea	rsi,[0000000000002029]                                 ; [rip+00000D85]
	mov	rdi,rax
	call	1060h
	mov	byte ptr [rbp+rax-110h],0h
	lea	rax,[rbp-110h]
	lea	rsi,[0000000000002080]                                 ; [rip+00000DBE]
	mov	rdi,rax
	call	1080h
	test	eax,eax
	jz	12E4h

l00000000000012CE:
	lea	rdi,[0000000000002084]                                 ; [rip+00000DAF]
	call	1040h
	mov	eax,0h
	jmp	1439h

l00000000000012E4:
	lea	rdi,[0000000000002098]                                 ; [rip+00000DAD]
	mov	eax,0h
	call	1050h
	mov	rax,[00000000000040A0]                                 ; [rip+00002DA4]
	mov	rdi,rax
	call	10A0h
	lea	rax,[rbp-114h]
	mov	rsi,rax
	lea	rdi,[00000000000020C3]                                 ; [rip+00000DAE]
	mov	eax,0h
	call	10C0h
	mov	eax,[rbp-114h]
	add	eax,58h
	imul	eax,eax,2Ah
	cmp	eax,2179556Ah
	jz	1348h

l0000000000001332:
	lea	rdi,[0000000000002084]                                 ; [rip+00000D4B]
	call	1040h
	mov	eax,0h
	jmp	1439h

l0000000000001348:
	lea	rdi,[00000000000020C8]                                 ; [rip+00000D79]
	mov	eax,0h
	call	1050h
	mov	rax,[00000000000040A0]                                 ; [rip+00002D40]
	mov	rdi,rax
	call	10A0h
	call	1090h
	mov	rdx,[00000000000040B0]                                 ; [rip+00002D3C]
	lea	rax,[rbp-110h]
	mov	esi,100h
	mov	rdi,rax
	call	1070h
	lea	rax,[rbp-110h]
	lea	rsi,[0000000000002029]                                 ; [rip+00000C93]
	mov	rdi,rax
	call	1060h
	mov	byte ptr [rbp+rax-110h],0h
	lea	rax,[rbp-110h]
	mov	[rbp-8h],rax
	jmp	13DCh

l00000000000013B3:
	mov	rax,[rbp-8h]
	movzx	eax,byte ptr [rax]
	movsx	eax,al
	mov	edx,eax
	shl	edx,4h
	add	eax,edx
	mov	ecx,[0000000000004094]                                 ; [rip+00002CCA]
	cdq
	idiv	ecx
	mov	eax,edx
	mov	edx,eax
	mov	rax,[rbp-8h]
	mov	[rax],dl
	add	qword ptr [rbp-8h],1h

l00000000000013DC:
	mov	rax,[rbp-8h]
	movzx	eax,byte ptr [rax]
	test	al,al
	jnz	13B3h

l00000000000013E7:
	mov	edi,0Ah
	call	1030h
	lea	rax,[rbp-110h]
	lea	rsi,[0000000000004080]                                 ; [rip+00002C81]
	mov	rdi,rax
	call	1080h
	test	eax,eax
	jz	141Eh

l000000000000140B:
	lea	rdi,[0000000000002084]                                 ; [rip+00000C72]
	call	1040h
	mov	eax,0h
	jmp	1439h

l000000000000141E:
	lea	rdi,[0000000000002100]                                 ; [rip+00000CDB]
	call	1040h
	mov	eax,0h
	call	11C5h
	mov	eax,0h

l0000000000001439:
	leave
	ret
000000000000143B                                  0F 1F 44 00 00            ..D..

;; __libc_csu_init: 0000000000001440
__libc_csu_init proc
	push	r15
	lea	r15,[0000000000003DE8]                                 ; [rip+0000299F]
	push	r14
	mov	r14,rdx
	push	r13
	mov	r13,rsi
	push	r12
	mov	r12d,edi
	push	rbp
	lea	rbp,[0000000000003DF0]                                 ; [rip+00002990]
	push	rbx
	sub	rbp,r15
	sub	rsp,8h
	call	1000h
	sar	rbp,3h
	jz	148Eh

l0000000000001473:
	xor	ebx,ebx
	nop	dword ptr [rax]

l0000000000001478:
	mov	rdx,r14
	mov	rsi,r13
	mov	edi,r12d
	call	qword ptr [r15+rbx*8]
	add	rbx,1h
	cmp	rbp,rbx
	jnz	1478h

l000000000000148E:
	add	rsp,8h
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
000000000000149D                                        0F 1F 00              ...

;; __libc_csu_fini: 00000000000014A0
__libc_csu_fini proc
	ret
