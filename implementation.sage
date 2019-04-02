#!/usr/bin/env sage

entries = {}
for i in range(8):
    entries[(i,i)] = 1/5^i
p = [-60000081, 0, 70000000, -10000000, 1]
for i in range(4):
    for j in range(5):
        entries[(i+j,8+i)] = p[j]
N = 100000000
for i in range(2):
    for j in range(2):
        entries[(8+i*2+j,8+i*2+j)] = N^(i+1)
M = matrix(QQ, 12, 12, entries)
#print M

for i in range(4):
    D = identity_matrix(QQ, 12) + column_matrix(QQ, [vector([0]*12)]*(7-i) + [-M.column(11-i)] + [vector([0]*12)]*(4+i) ) + matrix(QQ, 12, 12, {(7-i,7-i):1})
    M = D*M
#print M

entries = {}
for i in range(4):
    entries[(i,i)] = 1
for i in range(4, 8):
    entries[(i,i+4)] = entries[(i+4,i)] = 1
D = matrix(QQ, 12, 12, entries)
M = D*M
#print M

Mhat = M.submatrix(0,0,8,8)
#print Mhat

print Mhat.LLL()
