    # ----------------------- FUNCION MAIN ----------------------
    .globl main
main:           
    addi     sp, sp,-16         # actualiza sp
    sw       ra,16(sp)          # respalda ra
    sw       fp,12(sp)          # respalda fp
    addi     fp,sp,16           # actualiza fp
    
    # array[N] = {90, 80, 70, 60, 5, 4, 3, 2, 1, MAX}
    li      tp,90
    sw      tp,0(gp)
    li      tp,80
    sw      tp,4(gp)
    li      tp,70
    sw      tp,8(gp)
    li      tp,60
    sw      tp,12(gp)
    li      tp,5
    sw      tp,16(gp)
    li      tp,4
    sw      tp,20(gp)
    li      tp,3
    sw      tp,24(gp)
    li      tp,2
    sw      tp,28(gp)
    li      tp,1
    sw      tp,32(gp)

    li       tp,113
    sw       tp,36(gp)

    # llamar a función bucket
    li       a1, 10             # a1 = 10
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

    lw       tp,0(a0)           # tp = a[0]
    mv       t0,a1              # t0 = 10
    jal      getMax             # llamar a función get Max
    lw       a1,-32(fp)         # restablece a1
    lw       a0,-36(fp)         # restablece a0
    lw       t3,-16(fp)         # t3 = max

    
    


    


    jr      ra                  # devuelve el control a la funcion

# ----------------------- FUNCION BUCKET ----------------------
    .globl getMax
getMax:
        lw      tp,0(a0)            # tp = a[0]
        sw      tp,-16(fp)          # max = a[0]

        li      t0,0                # t0 = 0
        sw      t0,-24(fp)          # i = t0
for:    lw      t0,-24(fp)          # cargar i
        addi    t0,t0,1             # t0 = t0 + 1
        sw      t0,-24(fp)          # i++
        slli    t0,t0,2             # t0 = t0 * 4
        add     t0,a0,t0            # t0 = a0 + 4 * t0
        lw      t0,0(t0)            # t0 = a[i]
        lw      t1,-24(fp)          # t1 = 1
        bge     t1,a1,R             # si i >= n entonces salta a R
        lw      tp,-16(fp)          # cargar max
        blt     t0,tp,for           # si a[i] < max entonces salta a for 
        sw      t0,-16(fp)          # max = a[i]
        lw      t0,-16(fp)          # max = a[i]
        j       for                 # salta a jump
R:      jr      ra                  # devuelve el control a la funcion