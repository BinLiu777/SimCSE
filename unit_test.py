from scipy import stats
res = stats.spearmanr([0.3, 0.7, 0.9, 0.4, 0.8], [0, 1, 0, 0, 1])
print(res)
# import numpy as np
# def cosine(u, v):
#     return np.dot(u, v) / (np.linalg.norm(u) * np.linalg.norm(v))
#
# s1 = [1,2,3,4,5]
# s2 = [5,4,3,2,1]
# similarity = lambda s1, s2: np.nan_to_num(cosine(np.nan_to_num(s1), np.nan_to_num(s2)))
# print(similarity(s1,s2))