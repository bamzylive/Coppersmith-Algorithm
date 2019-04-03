#!/usr/bin/env sage

p = [-60000081, 0, 70000000, -10000000, 1]
N = 100000000
h = 2
d = 4
hd = h*d
X = 5
rsize = (h-1)*d
size = hd + rsize

entries = {}
for i in range(hd):
    entries[(i,i)] = 1/X^i
for i in range(rsize):
    for j in range(d+1):
        entries[(i+j,hd+i)] = p[j]
for i in range(h-1):
    for j in range(d):
        entries[(hd+i*d+j,hd+i*d+j)] = N^(i+1)
M = matrix(QQ, size, size, entries)
#print M

for i in range(rsize):
    D = identity_matrix(QQ, size) + column_matrix(QQ, [vector([0]*size)]*(hd-1-i) + [-M.column(size-1-i)] + [vector([0]*size)]*(rsize+i) ) + matrix(QQ, size, size, {(hd-1-i,hd-1-i):1})
    M = D*M
#print M

entries = {}
for i in range(rsize):
    entries[(i,i)] = 1
for i in range(rsize, rsize*2):
    entries[(i,i+rsize)] = entries[(i+rsize,i)] = 1
D = matrix(QQ, size, size, entries)
M = D*M
#print M

Mhat = M.submatrix(0,0,hd,hd)
#print Mhat

L = Mhat.LLL()
#print L

C = L.gram_schmidt()[0].row(hd-1)
#print C

lst = []
for i in range(hd):
    lst.append(x^i/X^i)
s = vector(lst)
#print s

equ = s.dot_product(C)
#print equ

solve(equ, x)
