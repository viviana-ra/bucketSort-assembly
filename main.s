    # ----------------------- FUNCION MAIN ----------------------
    .globl main
main:           
    addi     sp, sp,-16         # actualiza sp
    sw       ra,16(sp)          # respalda ra
    sw       fp,12(sp)          # respalda fp
    addi     fp,sp,16           # actualiza fp
    
    # array[] = {4,6,5,1,7,2,3}
    li      tp,4
    sw      tp,0(gp)
    li      tp,6
    sw      tp,4(gp)
    li      tp,5
    sw      tp,8(gp)
    li      tp,1
    sw      tp,12(gp)
    li      tp,9
    sw      tp,16(gp)
    li      tp,2
    sw      tp,20(gp)    
    li      tp,3
    sw      tp,24(gp)
    # llamar a función bucket
    li       a1, 7              # a1 = 17
    mv       a0, gp             # a0 = *a
    jal      bucket             # llamar a funcion bucket
    
    # return 0
    li       a0, 0              # a0 = 0
    lw       ra, 16(sp)         # restaura ra
    lw       fp, 12(sp)         # restaura fp
    addi     sp, sp, 16         # libera el marco del main 
    jr       ra                 # bucle infinito

# ----------------------- FUNCION BUCKET ----------------------
    .globl bucket
bucket:
        addi     sp,sp,-48          # actualiza sp
        sw       ra,48(sp)          # respalda ra
        sw       fp,44(sp)          # respalda fp
        addi     fp,sp, 48          # actualiza fp
        jal      getMax             # llamar a función get Max

        li       t0,0x1000002C     
        lw       t1,-16(fp)        # t1 = max
        li       t2,0              # t2 = 0
        sw       t2,-20(fp)        # i = t2
PF:     lw       t2,-20(fp)        # i = 0
        bge      t2,t1,SF          # si i >= max salta a SF
        li       t3,0              # t3 = 0
        sw       t3,0(t0)          # bucket[i] = 0
        addi     t0,t0,4           # t0 = t0 (addr) + 4
        addi     t2,t2,1           # t2 = t2 + 1
        sw       t2,-20(fp)        # i++
        j        PF                # salta a PF
SF:     



      



        jr      ra                  # devuelve el control a la funcion

# ----------------------- FUNCION BUCKET ----------------------
    .globl getMax
getMax:
        lw      tp,0(a0)            # tp = a[0]
        sw      tp,-16(fp)          # max = a[0]

        li      t0,0                # t0 = 0
        sw      t0,-20(fp)          # i = t0
for:    lw      t0,-20(fp)          # cargar i
        addi    t0,t0,1             # t0 = t0 + 1
        sw      t0,-20(fp)          # i++
        slli    t0,t0,2             # t0 = t0 * 4
        add     t0,a0,t0            # t0 = a0 + 4 * t0
        lw      t0,0(t0)            # t0 = a[i]
        lw      t1,-20(fp)          # t1 = i
        bge     t1,a1,R             # si i >= n entonces salta a R
        lw      tp,-16(fp)          # cargar max
        blt     t0,tp,for           # si a[i] < max entonces salta a for 
        sw      t0,-16(fp)          # max = a[i]
        lw      t0,-16(fp)          # max = a[i]
        j       for                 # salta a jump
R:      jr      ra                  # devuelve el control a la funcion