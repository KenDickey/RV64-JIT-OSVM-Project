## abstracted from >> objdump -D immedLong.o
0000000000000000 <main>:
   0:	fe010113          	add	sp,sp,-32
   4:	00113023          	sd	ra,0(sp)
   8:	00000517          	auipc	a0,0x0
   c:	00053503          	ld	a0,0(a0) # 8 <main+0x8>
  10:	00000097          	auipc	ra,0x0
  14:	000080e7          	jalr	ra # 10 <main+0x10>
  18:	00000517          	auipc	a0,0x0
  1c:	00053503          	ld	a0,0(a0) # 18 <main+0x18>
  20:	00000617          	auipc	a2,0x0
  24:	00c63583          	ld	a1,12(a2) # 2c <main+0x2c>
  28:	01060067          	jr	16(a2)
  2c:	11111037          	lui	zero,0x11111
  30:	22222037          	lui	zero,0x22222
  34:	00000097          	auipc	ra,0x0
  38:	000080e7          	jalr	ra # 34 <main+0x34>
  3c:	00013083          	ld	ra,0(sp)
  40:	02010113          	add	sp,sp,32
44:	00008067          	ret
	
