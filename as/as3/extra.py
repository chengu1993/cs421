from itertools import permutations

modifier = ['transient', 'synchronized', 'public', 'static', 'final']
lists = []
for i in range(6):
    lists += list(permutations(modifier, i));

for l in lists:
    print(" ".join(l))


