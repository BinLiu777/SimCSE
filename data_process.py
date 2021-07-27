def saller(inpath, outpath):
    with open(inpath, 'r') as f:
        lines = f.readlines()
    print(len(lines))
    res = []
    with open(outpath, 'w') as f:
        for line in lines:
            text = line.strip()
            text = text.replace('。', '')
            text = text.replace('，', '')
            text = text.replace('？', '')
            text = text.replace('！', '')
            if len(text) > 5 and len(line) < 20:
                f.write(line)
                res.append(line)
    print(len(res))

def best_saller(inpath, outpath):
    with open(inpath, 'r') as f:
        lines = f.readlines()
        print(len(lines))
    res = []
    with open(outpath, 'w') as f:
        for line in lines:
            if "result_final_train" not in line:
                text, role = line.strip().split('\t')[0], line.strip().split('\t')[1]
                text_ = text.replace('。', '')
                text_ = text_.replace('，', '')
                text_ = text_.replace('？', '')
                text_ = text_.replace('！', '')
                if len(text_) > 1:
                    f.write(text + '\n')
                    res.append(line)
    print(len(res))

saller('data/saller/saler_pure_text_nocut.txt', 'data/saller/saler_pure_text_nocut_filter.txt')
# best_saller('data/best_saller/sale_asr_2000_single_poun', 'data/best_saller/sale_asr_2000_pure_text.txt')
best_saller('data/best_saller/asr_best_6k_single_0727.re', 'data/best_saller/asr_best_6k.txt')